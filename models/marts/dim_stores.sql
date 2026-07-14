{{ config(
    materialized='table'
) }}

with staging_sales as (
    select * from {{ ref('stg_coffee_shop_sales') }}
),

unique_stores as (
    select distinct
        store_id,
        store_location
    from staging_sales
)

select * from unique_stores