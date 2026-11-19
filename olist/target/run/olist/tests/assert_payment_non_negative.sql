
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select order_id from "olist"."main"."fct_orders"
where payment_total < 0
  
  
      
    ) dbt_internal_test