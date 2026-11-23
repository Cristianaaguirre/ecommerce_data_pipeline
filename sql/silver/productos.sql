-- Transformación Silver de productos: modificar aquí casts y campos normalizados.
SELECT
    TRY_CAST(NULLIF(TRIM(id), '') AS INTEGER) AS id,
    NULLIF(TRIM(nombre), '') AS nombre,
    TRY_CAST(NULLIF(TRIM(categoria_id), '') AS INTEGER) AS categoria_id,
    TRY_CAST(NULLIF(TRIM(precio), '') AS DECIMAL(10, 2)) AS precio,
    TRY_CAST(NULLIF(TRIM(stock), '') AS INTEGER) AS stock,
    _ingested_at,
    _source_file
FROM productos_bronze;