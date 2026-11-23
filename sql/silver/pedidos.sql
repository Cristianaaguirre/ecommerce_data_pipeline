-- Transformación Silver de pedidos: modificar aquí casts y campos normalizados.
SELECT
    TRY_CAST(id AS INTEGER) AS id,
    TRY_CAST(cliente_id AS INTEGER) AS cliente_id,
    TRY_CAST(producto_id AS INTEGER) AS producto_id,
    TRY_CAST(cantidad AS INTEGER) AS cantidad,
    TRY_CAST(fecha AS DATE) AS fecha,
    TRY_CAST(importe AS DECIMAL) AS importe,
    estado,
    _ingested_at,
    _source_file
FROM pedidos_bronze;