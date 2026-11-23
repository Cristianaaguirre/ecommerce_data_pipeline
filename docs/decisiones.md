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
- **Clientes (5004 filas):** hay 202 emails, 375 ciudades, 557 canales de adquisición y 162 valores de `es_vip` nulos. `id` no tiene nulos ni valores que fallen al convertir a entero. Una fecha de registro no se puede convertir: es la del cliente `5004`, que tampoco tiene email, ciudad, canal de adquisición ni valor para `es_vip`.
- **Productos (200 filas):** no hay nulos en las columnas de negocio. Hay cinco categorías, con 40 productos por categoría. El precio va de 6,24 a 1718,48 y el stock de 0 a 498 (promedio aproximado 244,74).
- **Pedidos (20003 filas):** hay 1 `cliente_id`, 1 `producto_id`, 1 `cantidad`, 207 `importe` y 241 `estado` nulos. Los estados registrados son `completado` (16199), `cancelado` (2373), `devuelto` (1190) y nulo (241). Los conteos de nulos son por columna; pueden coincidir en una misma fila.
- **Decisión provisional:** en este perfilado y en las transformaciones actuales no se excluyen filas. Los vacíos se convierten en `NULL` al tipar; no se inventan valores para `es_vip`, ciudad o canal. Antes de cerrar Silver se revisará qué campos obligatorios ameritan excluir filas, en particular la fecha faltante del cliente `5004`.
