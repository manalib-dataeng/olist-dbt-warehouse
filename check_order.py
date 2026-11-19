import sys
import duckdb

order_id = sys.argv[1]
con = duckdb.connect("olist/olist.duckdb", read_only=True)

rows = con.execute(
    "select order_id, order_status, purchased_at from main.fct_orders where order_id = ?",
    [order_id],
).fetchall()
print(rows)
con.close()