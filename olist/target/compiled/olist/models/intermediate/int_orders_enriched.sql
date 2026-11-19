with payments as (
    select order_id, sum(payment_value) as payment_total
    from "olist"."main"."stg_payments"
    group by 1
),
items as (
    select order_id,
           count(*)           as item_count,
           sum(price)         as items_total,
           sum(freight_value) as freight_total
    from "olist"."main"."stg_order_items"
    group by 1
),
reviews as (
    select order_id, avg(review_score) as review_score
    from "olist"."main"."stg_reviews"
    group by 1
)
select
    o.*,
    c.customer_unique_id,
    p.payment_total,
    i.item_count, i.items_total, i.freight_total,
    r.review_score,
    date_diff('day', o.estimated_delivery_at, o.delivered_at) as delivery_delay_days,
    case when o.delivered_at is null then null
         when o.delivered_at > o.estimated_delivery_at then 1
         else 0 end as is_late
from "olist"."main"."stg_orders" o
left join "olist"."main"."stg_customers" c using (customer_id)
left join payments p using (order_id)
left join items i using (order_id)
left join reviews r using (order_id)