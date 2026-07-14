{{ config(
    materialized='view'
) }}

with source_data as (
    select * from {{ source('databricks_tables', 'coffee_shop_silver') }}
)

select
    -- We bring the standardized key columns
    unique_row_id,
    transaction_id,
    transaction_date,
    transaction_time,
    
    -- Sales metrics
    quantity_sold,
    unit_price,
    total_revenue,
    
    -- Store (or Location) data
    store_id,
    store_location,

    -- Product data
    product_id,
    product_category,
    product_type,
    product_detail,
    
    -- Audit timestamp
    silver_processed_at,
    current_timestamp() as staging_processed_at

from source_data