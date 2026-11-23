-- Transformación Silver de empleados: modificar aquí los casts y textos.
SELECT
    TRY_CAST(NULLIF(TRIM(id), '') AS INTEGER) AS id,
    NULLIF(TRIM(nombre), '') AS nombre,
    NULLIF(TRIM(departamento), '') AS departamento,
    TRY_CAST(NULLIF(TRIM(salario), '') AS DECIMAL(10, 2)) AS salario,
    TRY_CAST(NULLIF(TRIM(fecha_contratacion), '') AS DATE) AS fecha_contratacion,
    _ingested_at,
    _source_file
FROM empleados_bronze;
