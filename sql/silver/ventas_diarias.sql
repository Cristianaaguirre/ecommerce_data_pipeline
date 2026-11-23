-- Transformación Silver de ventas diarias: modificar aquí los casts.
SELECT
    TRY_CAST(NULLIF(TRIM(fecha), '') AS DATE) AS fecha,
    TRY_CAST(NULLIF(TRIM(importe_diario), '') AS DECIMAL(10, 2)) AS importe_diario,
    _ingested_at,
    _source_file
FROM ventas_diarias_bronze;
