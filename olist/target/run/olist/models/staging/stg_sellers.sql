
  
  create view "olist"."main"."stg_sellers__dbt_tmp" as (
    select
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
from "olist"."raw"."sellers"
  );
