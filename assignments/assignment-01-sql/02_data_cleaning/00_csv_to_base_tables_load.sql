/*
===============================================================================
Assignment 1 - Raw CSV to Base Tables Load
Purpose: Load the eight raw Olist CSV files from `olist-data` into the created
base tables in `shophub_analytics`.
Questions Covered: 6
Supporting Role: Provides raw data population required before profiling,
cleaning, joins, aggregations, subqueries, window functions, and optimization.

Use of This File:
1. Run `01_schema/01_database_schema.sql` first to create the target tables.
2. Run this file to load raw CSV data into those tables.
3. Run `02_deduplication_and_load.sql` and the other assignment scripts after
   the base tables are populated.

Important:
- This script uses `LOAD DATA LOCAL INFILE`, so `local_infile` must be enabled.
- The file paths below point to the current workspace location of `olist-data`.
- Re-running this script truncates and reloads the base tables.
===============================================================================
*/

USE shophub_analytics;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE order_reviews;
TRUNCATE TABLE order_payments;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
TRUNCATE TABLE products;
TRUNCATE TABLE sellers;
TRUNCATE TABLE customers;
TRUNCATE TABLE geolocation;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. Load geolocation
LOAD DATA LOCAL INFILE '/Users/durgesh.tambe/Documents/Learnings/python-learning/data-engineering-tutedude/assignments/assignment-01-sql/olist-data/olist_geolocation_dataset.csv'
INTO TABLE geolocation
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
);

-- 2. Load customers
LOAD DATA LOCAL INFILE '/Users/durgesh.tambe/Documents/Learnings/python-learning/data-engineering-tutedude/assignments/assignment-01-sql/olist-data/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
);

-- 3. Load sellers
LOAD DATA LOCAL INFILE '/Users/durgesh.tambe/Documents/Learnings/python-learning/data-engineering-tutedude/assignments/assignment-01-sql/olist-data/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
);

-- 4. Load products
LOAD DATA LOCAL INFILE '/Users/durgesh.tambe/Documents/Learnings/python-learning/data-engineering-tutedude/assignments/assignment-01-sql/olist-data/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    product_id,
    @product_category_name,
    @product_name_lenght,
    @product_description_lenght,
    @product_photos_qty,
    @product_weight_g,
    @product_length_cm,
    @product_height_cm,
    @product_width_cm
)
SET
    product_category_name = NULLIF(@product_category_name, ''),
    product_name_length = NULLIF(@product_name_lenght, ''),
    product_description_length = NULLIF(@product_description_lenght, ''),
    product_photos_qty = NULLIF(@product_photos_qty, ''),
    product_weight_g = NULLIF(@product_weight_g, ''),
    product_length_cm = NULLIF(@product_length_cm, ''),
    product_height_cm = NULLIF(@product_height_cm, ''),
    product_width_cm = NULLIF(@product_width_cm, '');

-- 5. Load orders
LOAD DATA LOCAL INFILE '/Users/durgesh.tambe/Documents/Learnings/python-learning/data-engineering-tutedude/assignments/assignment-01-sql/olist-data/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    order_id,
    customer_id,
    order_status,
    @order_purchase_timestamp,
    @order_approved_at,
    @order_delivered_carrier_date,
    @order_delivered_customer_date,
    @order_estimated_delivery_date
)
SET
    order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
    order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');

-- 6. Load order items
LOAD DATA LOCAL INFILE '/Users/durgesh.tambe/Documents/Learnings/python-learning/data-engineering-tutedude/assignments/assignment-01-sql/olist-data/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
);

-- 7. Load order payments
LOAD DATA LOCAL INFILE '/Users/durgesh.tambe/Documents/Learnings/python-learning/data-engineering-tutedude/assignments/assignment-01-sql/olist-data/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
);

-- 8. Load order reviews
LOAD DATA LOCAL INFILE '/Users/durgesh.tambe/Documents/Learnings/python-learning/data-engineering-tutedude/assignments/assignment-01-sql/olist-data/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    review_id,
    order_id,
    review_score,
    @review_comment_title,
    @review_comment_message,
    review_creation_date,
    @review_answer_timestamp
)
SET
    review_comment_title = NULLIF(@review_comment_title, ''),
    review_comment_message = NULLIF(@review_comment_message, ''),
    review_answer_timestamp = NULLIF(@review_answer_timestamp, '');

-- Quick validation counts after load
SELECT 'geolocation' AS table_name, COUNT(*) AS row_count FROM geolocation
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews;
