-- Transformación Silver de categorías: modificar aquí los casts y textos.
SELECT
    TRY_CAST(NULLIF(TRIM(id), '') AS INTEGER) AS id,
    NULLIF(TRIM(nombre), '') AS nombre,
    NULLIF(TRIM(descripcion), '') AS descripcion,
    _ingested_at,
    _source_file
FROM categorias_bronze;
