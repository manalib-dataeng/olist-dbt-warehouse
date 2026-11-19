import duckdb

con = duckdb.connect("olist/olist.duckdb")

# Find the most recent order
oid, old_status = con.execute("""
    select order_id, order_status
    from raw.orders
    order by order_purchase_timestamp desc
    limit 1
""").fetchone()

new_status = "canceled" if old_status != "canceled" else "unavailable"

con.execute(
    "update raw.orders set order_status = ? where order_id = ?",
    [new_status, oid],
)
con.close()

print(f"Order: {oid}")
print(f"Status changed: {old_status} -> {new_status}")