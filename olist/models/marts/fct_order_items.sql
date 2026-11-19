select
    {{ dbt_utils.generate_surrogate_key(['order_id', 'order_item_id']) }} as order_item_key,
    order_id,
    order_item_id,
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
    {{ dbt_utils.generate_surrogate_key(['seller_id']) }}  as seller_key,
    cast(purchased_at as date) as purchase_date_key,
    order_status,
    category_name,
    price,
    freight_value,
    price + freight_value as item_total
from {{ ref('int_order_items_enriched') }}