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
