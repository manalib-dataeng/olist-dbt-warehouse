select oi.order_item_key
from {{ ref('fct_order_items') }} oi
left join {{ ref('fct_orders') }} o using (order_id)
where o.order_id is null