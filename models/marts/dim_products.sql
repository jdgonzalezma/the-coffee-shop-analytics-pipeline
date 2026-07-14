{{ config(
    materialized='table'
) }}

with staging_sales as (
    select * from {{ ref('stg_coffee_shop_sales') }}
),

unique_products as (
    select distinct
        product_id,
        product_category,
        product_type,
        product_detail
    from staging_sales
)

select * from unique_products