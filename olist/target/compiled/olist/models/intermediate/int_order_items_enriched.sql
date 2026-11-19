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
from "olist"."main"."stg_order_items" i
left join "olist"."main"."stg_products" p
    on i.product_id = p.product_id
left join "olist"."main"."stg_category_translation" t
    on p.product_category_name = t.product_category_name
left join "olist"."main"."stg_orders" o
    on i.order_id = o.order_id