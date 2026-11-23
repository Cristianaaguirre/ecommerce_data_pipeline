-- Transformación Silver de vendedores: modificar aquí los casts y textos.
SELECT
    TRY_CAST(NULLIF(TRIM(id), '') AS INTEGER) AS id,
    NULLIF(TRIM(nombre), '') AS nombre,
    NULLIF(TRIM(equipo), '') AS equipo,
    NULLIF(TRIM(categoria), '') AS categoria,
    TRY_CAST(NULLIF(TRIM(ventas), '') AS DECIMAL(10, 2)) AS ventas,
    _ingested_at,
    _source_file
FROM vendedores_bronze;
