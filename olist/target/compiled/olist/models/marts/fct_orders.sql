

select
    order_id,
    md5(cast(coalesce(cast(customer_unique_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as customer_key,
    cast(purchased_at as date) as purchase_date_key,
    order_status,
    purchased_at, delivered_at, estimated_delivery_at,
    payment_total, items_total, freight_total, item_count,
    review_score, delivery_delay_days, is_late
from "olist"."main"."int_orders_enriched"


where purchased_at >= (select max(purchased_at) - interval 30 day from "olist"."main"."fct_orders")
