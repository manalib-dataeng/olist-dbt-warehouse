select
    md5(cast(coalesce(cast(customer_unique_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as customer_key,
    customer_unique_id,
    any_value(customer_city)  as city,
    any_value(customer_state) as state
from "olist"."main"."stg_customers"
group by customer_unique_id