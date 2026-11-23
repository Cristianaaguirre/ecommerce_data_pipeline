-- Transformación Silver de productos: modificar aquí casts y campos normalizados.
SELECT
    TRY_CAST(id AS INTEGER) AS id,
    nombre,
    TRY_CAST(id AS INTEGER) AS categoria_id,
    TRY_CAST(precio AS DECIMAL) AS precio,
    TRY_CAST(stock AS INTEGER) AS stock
FROM productos_bronze;