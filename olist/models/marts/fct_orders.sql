{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='delete+insert'
) }}

select
    order_id,
    {{ dbt_utils.generate_surrogate_key(['customer_unique_id']) }} as customer_key,
    cast(purchased_at as date) as purchase_date_key,
    order_status,
    purchased_at, delivered_at, estimated_delivery_at,
    payment_total, items_total, freight_total, item_count,
    review_score, delivery_delay_days, is_late
from {{ ref('int_orders_enriched') }}

{% if is_incremental() %}
where purchased_at >= (select max(purchased_at) - interval 30 day from {{ this }})
{% endif %}