select order_id from {{ ref('fct_orders') }}
where payment_total < 0