from pathlib import Path

import duckdb as db


BASE_DIR = Path(__file__).resolve().parent.parent
BRONZE_DIR = BASE_DIR / "data" / "bronze"
SILVER_DIR = BASE_DIR / "data" / "silver"
SQL_DIR = BASE_DIR / "sql" / "silver"

TRANSFORMATIONS = (
    ("clientes", "cliente.sql"),
    ("pedidos", "pedidos.sql"),
    ("productos", "productos.sql"),
)


def sql_path(path: Path) -> str:
    return path.resolve().as_posix().replace("'", "''")


def main() -> None:
    con = db.connect()
    try:
        SILVER_DIR.mkdir(parents=True, exist_ok=True)

        for table, sql_file in TRANSFORMATIONS:
            bronze_path = BRONZE_DIR / f"{table}.parquet"
            sql_file_path = SQL_DIR / sql_file
            silver_path = SILVER_DIR / f"{table}.parquet"

            bronze_view = f"{table}_bronze"
            silver_view = f"{table}_silver"

            con.execute(
                f"CREATE OR REPLACE TEMP VIEW {bronze_view} AS "
                f"SELECT * FROM read_parquet('{sql_path(bronze_path)}')"
            )

            query = sql_file_path.read_text(encoding="utf-8")
            con.execute(f"CREATE OR REPLACE TEMP VIEW {silver_view} AS {query}")

            con.execute(
                f"COPY (SELECT * FROM {silver_view}) "
                f"TO '{sql_path(silver_path)}' "
                "(FORMAT PARQUET, COMPRESSION ZSTD)"
            )
    except Exception as error:
        raise RuntimeError(f"Falló la transformación de Bronze a Silver: {error}") from error
    finally:
        con.close()


if __name__ == "__main__":
    main()
