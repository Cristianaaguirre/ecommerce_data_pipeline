-- Transformación Silver de ventas mensuales: modificar aquí los casts.
SELECT
    TRY_CAST(NULLIF(TRIM(fecha), '') AS DATE) AS fecha,
    TRY_CAST(NULLIF(TRIM(importe), '') AS DECIMAL(10, 2)) AS importe,
    _ingested_at,
    _source_file
FROM ventas_mensuales_bronze;
