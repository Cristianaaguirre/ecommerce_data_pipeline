-- Transformación Silver de clientes: modificar aquí casts y campos normalizados.
SELECT
    TRY_CAST(id AS INTEGER) AS id,
    NULLIF(TRIM(nombre), '') AS nombre,
    NULLIF(TRIM(email), '') AS email,
    NULLIF(TRIM(ciudad), '') AS ciudad,
    TRY_CAST(NULLIF(TRIM(fecha_registro), '') AS DATE) AS fecha_registro,
    NULLIF(TRIM(canal_adquisicion), '') AS canal_adquisicion,
    TRY_CAST(NULLIF(TRIM(es_vip), '') AS BOOLEAN) AS es_vip,
    _ingested_at,
    _source_file
FROM clientes_bronze;