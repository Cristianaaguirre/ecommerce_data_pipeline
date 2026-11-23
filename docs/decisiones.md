# Decisiones y hallazgos

## Hallazgos de calidad (profiling inicial)

| Tabla | Hallazgo |
|---|---|
| `clientes` | Nulos en `email` (202), `ciudad` (375), `canal_adquisicion` (557) y `es_vip` (162). El id 5004 está casi vacío. |
| `pedidos` | Nulos en `estado` (241) e `importe` (207). Los ids 20001 a 20003 son filas anómalas (sin producto, sin estado o sin cliente). |
| `lineas_pedido` | Solo cubre los pedidos 1 a 15000: 5000 pedidos no tienen detalle. |
| `pedidos` vs `productos` | `importe` casi nunca coincide con `cantidad × precio` del producto. |
| `pedidos` vs `lineas_pedido` | `importe` casi nunca coincide con la suma de sus líneas. |
| `lineas_pedido` vs `productos` | `precio_unitario` difiere del `precio` del catálogo. |
| `vendedores`, `empleados` | No se relacionan con pedidos. |

Integridad referencial: no hay huérfanos (todos los `cliente_id` y `producto_id` existen).

## Decisiones

### DE-001: Bronze con todo como texto
- **Decisión:** leer los CSV con `all_varchar=true`.
- **Por qué:** bronze debe ser un espejo fiel del origen. Si DuckDB infiere tipos, ya está interpretando los datos. Los tipos se asignan en Silver.
- **Alternativa descartada:** dejar que DuckDB infiera los tipos. Es más cómodo, pero puede ocultar valores que no convierten bien.
- **Detalle:** `_ingested_at` es un único timestamp UTC por corrida, para que todas las tablas del lote compartan la misma marca.

### DE-002: Perfilado y criterios preliminares para Silver
- **Base del perfilado:** los conteos de esta sección se obtuvieron sobre los Parquet de `data/bronze/`.
- **Clientes (5004 filas):** hay 202 emails, 375 ciudades, 557 canales de adquisición, 162 valores de `es_vip` y una fecha de registro nulos. `id` no tiene nulos ni valores no convertibles. El cliente `5004` no tiene fecha de registro ni datos opcionales.
- **Productos (200 filas):** no hay nulos en las columnas de negocio. Hay cinco categorías, con 40 productos por categoría. El precio va de 6,24 a 1718,48 y el stock de 0 a 498 (promedio aproximado 244,74).
- **Pedidos (20003 filas):** hay 1 `cliente_id`, 1 `producto_id`, 1 `cantidad`, 207 `importe` y 241 `estado` nulos. Los estados registrados son `completado` (16199), `cancelado` (2373), `devuelto` (1190) y nulo (241). Los conteos de nulos son por columna; pueden coincidir en una misma fila.
- **Decisión:** los valores nulos del origen se conservan en Silver. Los vacíos tampoco se rellenan con valores inventados. No se cuarentena una fila solamente porque contenga un nulo.

### DE-003: Controles de calidad y cuarentena
- **Campos con nulos observados que se mantienen:** en `clientes`, `email`, `ciudad`, `canal_adquisicion`, `es_vip` y `fecha_registro`; en `pedidos`, `cliente_id`, `producto_id`, `cantidad`, `importe` y `estado`. En las demás columnas y tablas no se observaron nulos en el perfilado actual. Que un campo tenga nulos observados no significa que se completen o que cada nulo sea un error.
- **Reglas que generan cuarentena:** un valor no vacío de Bronze que no se convierte al tipo definido en Silver; un ID convertido que aparece más de una vez; o una clave foránea no nula y convertible que no encuentra su registro padre (`pedidos` → `clientes`/`productos`; `lineas_pedido` → `pedidos`/`productos`). Los nulos y vacíos se omiten en estas reglas.
- **Trazabilidad y repetición:** se conserva el registro original de Bronze, junto con `_tabla_origen`, `_motivo_cuarentena`, `_ingested_at` y `_source_file`, en `data/quarantine/<tabla>_rechazados.parquet`. Se sobrescribe el resultado de cada tabla en cada ejecución. Si un registro incumple más de una regla, aparece una vez por cada motivo.
- **Resultado del perfilado actual:** no se encontraron valores no vacíos que fallen las conversiones, IDs duplicados ni referencias huérfanas. Los nulos observados se mantienen en Silver y no se envían a cuarentena por sí solos.
