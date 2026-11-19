import duckdb
import streamlit as st

DB_PATH = "olist/olist.duckdb"

st.set_page_config(page_title="Olist Analytics", layout="wide")
st.title("Olist E-commerce Analytics")
st.caption("Built from the dbt marts: fct_order_items, fct_orders, dim_sellers")


@st.cache_data(ttl=300)
def run_query(sql: str):
    # Open the database only for the query, then close it,
    # so the app never blocks dbt from writing later.
    con = duckdb.connect(DB_PATH, read_only=True)
    try:
        return con.execute(sql).df()
    finally:
        con.close()


MONTHLY_REVENUE = """
select strftime(purchase_date_key, '%Y-%m') as year_month,
       round(sum(price), 2) as revenue
from main.fct_order_items
where order_status <> 'canceled'
group by 1
order by 1
"""

LATE_BY_SELLER = """
select s.seller_id,
       count(distinct oi.order_id) as orders,
       round(count(distinct case when o.is_late = 1 then oi.order_id end) * 1.0
             / count(distinct oi.order_id), 3) as late_rate
from main.fct_order_items oi
join main.fct_orders o using (order_id)
join main.dim_sellers s using (seller_key)
where o.is_late is not null
group by 1
having count(distinct oi.order_id) >= 30
order by late_rate desc
limit 20
"""

REPEAT_RATE = """
with c as (
    select customer_key, count(*) as n
    from main.fct_orders
    where order_status = 'delivered'
    group by 1
)
select round(avg(case when n > 1 then 1.0 else 0 end), 4) as repeat_rate,
       count(*) as customers
from c
"""

# 1. Monthly revenue
st.subheader("Monthly revenue")
revenue = run_query(MONTHLY_REVENUE)
st.line_chart(revenue.set_index("year_month"))

# 2. Late delivery rate by seller
st.subheader("Late delivery rate by seller (sellers with 30+ orders)")
late = run_query(LATE_BY_SELLER)
left, right = st.columns(2)
with left:
    st.dataframe(late, use_container_width=True)
with right:
    st.bar_chart(late.set_index("seller_id")["late_rate"])

# 3. Repeat purchase rate
st.subheader("Repeat purchase rate")
repeat = run_query(REPEAT_RATE)
rate = float(repeat["repeat_rate"].iloc[0])
customers = int(repeat["customers"].iloc[0])
c1, c2 = st.columns(2)
c1.metric("Customers with 2+ delivered orders", f"{rate:.2%}")
c2.metric("Customers with a delivered order", f"{customers:,}")