






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and review_score >= 1 and review_score <= 5
)
 as expression


    from "olist"."main"."fct_orders"
    where
        review_score is not null
    
    

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







