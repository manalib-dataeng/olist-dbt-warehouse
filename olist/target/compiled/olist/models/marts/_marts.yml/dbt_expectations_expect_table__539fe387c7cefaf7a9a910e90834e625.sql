



    with grouped_expression as (
    select
        
        
    
  
( 1=1 and count(*) >= 90000 and count(*) <= 110000
)
 as expression


    from "olist"."main"."fct_orders"
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors





