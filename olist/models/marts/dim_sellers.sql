select
    {{ dbt_utils.generate_surrogate_key(['seller_id']) }} as seller_key,
    seller_id,
    seller_zip_code_prefix as zip_code_prefix,
    seller_city            as city,
    seller_state           as state
from {{ ref('stg_sellers') }}