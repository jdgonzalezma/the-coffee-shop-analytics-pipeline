{{ config(
    materialized='table'
) }}

with staging_sales as (
    select * from {{ ref('stg_coffee_shop_sales') }}
)

select
    unique_row_id,
    transaction_id,
    transaction_date,
    transaction_time,
    
    -- Keys to connect with dimensions
    store_id,
    product_id,
    
    -- Metrics
    quantity_sold,
    unit_price,
    total_revenue,
    
    -- Audit Metadata
    staging_processed_at as sales_processed_at
from staging_sales