-- Transformación Silver de clientes: modificar aquí casts y campos normalizados.
SELECT 
    TRY_CAST(id AS INTEGER) AS id,
    nombre,
    email,
    ciudad,
    TRY_CAST(fecha_registro AS DATE) AS fecha_registro,
    canal_adquisicion, 
    TRY_CAST(es_vip AS BOOLEAN) AS es_vip,
    _ingested_at,
    _source_file
FROM clientes_bronze;