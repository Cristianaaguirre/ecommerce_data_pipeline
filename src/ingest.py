from datetime import datetime, timezone
from pathlib import Path
import duckdb as db

# 1. Rutas dinámicas
BASE_DIR = Path(__file__).resolve().parent.parent
RAW_DIR = BASE_DIR / "data" / "raw"
BRONZE_DIR = BASE_DIR / "data" / "bronze"
BRONZE_DIR.mkdir(parents=True, exist_ok=True)

# 2. Capturar un único timestamp UTC para todo el lote (batch)
batch_ingested_at = datetime.now(timezone.utc).isoformat()

lista_csv = [
    'categorias', 'clientes', 'empleados', 'lineas_pedido', 
    'pedidos', 'productos', 'vendedores', 'ventas_diarias', 'ventas_mensuales'
]

con = db.connect()

try:
    for tabla in lista_csv:
        origen = RAW_DIR / f"{tabla}.csv"
        destino = BRONZE_DIR / f"{tabla}.parquet"
        
        con.sql(f"""
            COPY (
                SELECT 
                    *,
                    '{batch_ingested_at}'::TIMESTAMPTZ AS _ingested_at,
                    '{origen.name}' AS _source_file
                FROM read_csv('{origen.as_posix()}', all_varchar=true)
            ) 
            TO '{destino.as_posix()}' (FORMAT parquet, COMPRESSION zstd);
        """)
        
        # Corregido: .fetchall()[0][0] en lugar de .fetchone()[0]
        filas_guardadas = con.sql(f"SELECT COUNT(*) FROM '{destino.as_posix()}'").fetchall()[0][0]
        print(f"{tabla}: {filas_guardadas} filas")

except Exception as e:
    print(f"Error durante la ingesta de '{tabla}': {e}")
    raise

finally:
    con.close()
  
