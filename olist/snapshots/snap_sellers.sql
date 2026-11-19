{% snapshot snap_sellers %}
{{ config(
    target_schema='snapshots',
    unique_key='seller_id',
    strategy='check',
    check_cols=['seller_city', 'seller_state']
) }}
select * from {{ ref('stg_sellers') }}
{% endsnapshot %}