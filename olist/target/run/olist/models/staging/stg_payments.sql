
  
  create view "olist"."main"."stg_payments__dbt_tmp" as (
    select
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    cast(payment_value as double) as payment_value
from "olist"."raw"."order_payments"
  );
