
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select oi.order_item_key
from "olist"."main"."fct_order_items" oi
left join "olist"."main"."fct_orders" o using (order_id)
where o.order_id is null
  
  
      
    ) dbt_internal_test