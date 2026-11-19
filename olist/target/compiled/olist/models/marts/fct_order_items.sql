select
    md5(cast(coalesce(cast(order_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(order_item_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as order_item_key,
    order_id,
    order_item_id,
    md5(cast(coalesce(cast(product_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_key,
    md5(cast(coalesce(cast(seller_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))  as seller_key,
    cast(purchased_at as date) as purchase_date_key,
    order_status,
    category_name,
    price,
    freight_value,
    price + freight_value as item_total
from "olist"."main"."int_order_items_enriched"