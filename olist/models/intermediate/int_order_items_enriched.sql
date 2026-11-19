select
    i.order_id,
    i.order_item_id,
    i.product_id,
    i.seller_id,
    i.shipping_limit_at,
    i.price,
    i.freight_value,
    o.purchased_at,
    o.order_status,
    coalesce(
        t.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) as category_name
from {{ ref('stg_order_items') }} i
left join {{ ref('stg_products') }} p
    on i.product_id = p.product_id
left join {{ ref('stg_category_translation') }} t
    on p.product_category_name = t.product_category_name
left join {{ ref('stg_orders') }} o
    on i.order_id = o.order_id