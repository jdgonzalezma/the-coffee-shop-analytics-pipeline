-- Notebook en databricks
-- Crear o reemplazar la tabla en la capa Plata (Silver)
CREATE OR REPLACE TABLE default.coffee_shop_silver AS
SELECT
    -- 1. Generamos un ID único universal combinando columnas clave (Estándar de dbt)
    sha2(concat(transaction_id, transaction_date, product_id, store_id), 256) AS unique_row_id,
    
    CAST(transaction_id AS BIGINT) AS transaction_id,
    
    -- 2. Limpieza de Fechas y Tiempos
    CAST(transaction_date AS DATE) AS transaction_date,
    CAST(transaction_time AS STRING) AS transaction_time,
    
    -- 3. Métricas de Ventas básicas
    CAST(transaction_qty AS INT) AS quantity_sold,
    CAST(unit_price AS DECIMAL(10, 2)) AS unit_price,
    CAST((transaction_qty * unit_price) AS DECIMAL(10, 2)) AS total_revenue,
    
    -- 4. Datos de la tienda y localización
    CAST(store_id AS INT) AS store_id,
    TRIM(store_location) AS store_location,
    
    -- 5. Datos detallados del producto vendido
    CAST(product_id AS INT) AS product_id,
    TRIM(product_category) AS product_category,
    TRIM(product_type) AS product_type,
    TRIM(product_detail) AS product_detail,
    
    -- 6. Auditoría: Cuándo se procesó esta fila
    current_timestamp() AS silver_processed_at
FROM default.coffee_shop_raw;
