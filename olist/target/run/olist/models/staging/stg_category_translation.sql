
  
  create view "olist"."main"."stg_category_translation__dbt_tmp" as (
    select
    product_category_name,
    product_category_name_english
    
from "olist"."raw"."product_category_name_translation"
  );
