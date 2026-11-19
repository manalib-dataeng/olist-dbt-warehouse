import duckdb, pathlib

con = duckdb.connect("olist/olist.duckdb")
con.execute("CREATE SCHEMA IF NOT EXISTS raw")

for f in sorted(pathlib.Path("data").glob("*.csv")):
    name = f.stem.replace("olist_", "").replace("_dataset", "")
    con.execute(f"""
        CREATE OR REPLACE TABLE raw.{name} AS
        SELECT *, current_timestamp AS _loaded_at
        FROM read_csv_auto('{f.as_posix()}')
    """)
    n = con.execute(f"SELECT count(*) FROM raw.{name}").fetchone()[0]
    print(f"raw.{name}: {n} rows")
con.close()