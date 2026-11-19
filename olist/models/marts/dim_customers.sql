select
    {{ dbt_utils.generate_surrogate_key(['customer_unique_id']) }} as customer_key,
    customer_unique_id,
    any_value(customer_city)  as city,
    any_value(customer_state) as state
from {{ ref('stg_customers') }}
group by customer_unique_id