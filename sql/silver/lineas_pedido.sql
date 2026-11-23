-- Transformación Silver de líneas: modificar aquí los casts y textos.
SELECT
    TRY_CAST(NULLIF(TRIM(id), '') AS INTEGER) AS id,
    TRY_CAST(NULLIF(TRIM(pedido_id), '') AS INTEGER) AS pedido_id,
    TRY_CAST(NULLIF(TRIM(producto_id), '') AS INTEGER) AS producto_id,
    TRY_CAST(NULLIF(TRIM(cantidad), '') AS INTEGER) AS cantidad,
    TRY_CAST(NULLIF(TRIM(precio_unitario), '') AS DECIMAL(10, 2)) AS precio_unitario,
    _ingested_at,
    _source_file
FROM lineas_pedido_bronze;
