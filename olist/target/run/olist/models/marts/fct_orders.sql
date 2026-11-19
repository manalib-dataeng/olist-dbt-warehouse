
        
            delete from "olist"."main"."fct_orders"
            where (
                order_id) in (
                select (order_id)
                from "fct_orders__dbt_tmp20261119161456871879"
            );

        
    

    insert into "olist"."main"."fct_orders" ("order_id", "customer_key", "purchase_date_key", "order_status", "purchased_at", "delivered_at", "estimated_delivery_at", "payment_total", "items_total", "freight_total", "item_count", "review_score", "delivery_delay_days", "is_late")
    (
        select "order_id", "customer_key", "purchase_date_key", "order_status", "purchased_at", "delivered_at", "estimated_delivery_at", "payment_total", "items_total", "freight_total", "item_count", "review_score", "delivery_delay_days", "is_late"
        from "fct_orders__dbt_tmp20261119161456871879"
    )
  