
    

    create  table
      "olist"."main"."dim_sellers__dbt_tmp"
  
    
    as (
      select
    md5(cast(coalesce(cast(seller_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as seller_key,
    seller_id,
    seller_zip_code_prefix as zip_code_prefix,
    seller_city            as city,
    seller_state           as state
from "olist"."main"."stg_sellers"
    );
    
  