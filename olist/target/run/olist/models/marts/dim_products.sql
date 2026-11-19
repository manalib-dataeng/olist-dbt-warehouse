
    

    create  table
      "olist"."main"."dim_products__dbt_tmp"
  
    
    as (
      select
    md5(cast(coalesce(cast(p.product_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_key,
    p.product_id,
    coalesce(
        t.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) as category_name,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
from "olist"."main"."stg_products" p
left join "olist"."main"."stg_category_translation" t
    on p.product_category_name = t.product_category_name
    );
    
  