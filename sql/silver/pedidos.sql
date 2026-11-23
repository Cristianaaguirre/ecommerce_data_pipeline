-- Transformación Silver de pedidos: modificar aquí casts y campos normalizados.
SELECT
    TRY_CAST(NULLIF(TRIM(id), '') AS INTEGER) AS id,
    TRY_CAST(NULLIF(TRIM(cliente_id), '') AS INTEGER) AS cliente_id,
    TRY_CAST(NULLIF(TRIM(producto_id), '') AS INTEGER) AS producto_id,
    TRY_CAST(NULLIF(TRIM(cantidad), '') AS INTEGER) AS cantidad,
    TRY_CAST(NULLIF(TRIM(fecha), '') AS DATE) AS fecha,
    TRY_CAST(NULLIF(TRIM(importe), '') AS DECIMAL(10, 2)) AS importe,
    NULLIF(TRIM(estado), '') AS estado,
    _ingested_at,
    _source_file
FROM pedidos_bronze;