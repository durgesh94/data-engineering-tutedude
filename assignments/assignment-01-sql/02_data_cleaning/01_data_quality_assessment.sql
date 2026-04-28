/*
===============================================================================
Assignment 1 - Data Quality Assessment
Questions covered: 2, 7, 8, 10
===============================================================================
*/

USE shophub_analytics;

-- 1. Null checks on important business columns
SELECT 'customers.customer_unique_id' AS check_name, COUNT(*) AS issue_count
FROM customers
WHERE customer_unique_id IS NULL
UNION ALL
SELECT 'orders.order_purchase_timestamp', COUNT(*)
FROM orders
WHERE order_purchase_timestamp IS NULL
UNION ALL
SELECT 'order_items.product_id', COUNT(*)
FROM order_items
WHERE product_id IS NULL
UNION ALL
SELECT 'order_payments.payment_value', COUNT(*)
FROM order_payments
WHERE payment_value IS NULL;

-- 2. Duplicate customer IDs
SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 3. Duplicate customer_unique_id with conflicting address info
SELECT
    customer_unique_id,
    COUNT(DISTINCT CONCAT(customer_city, '|', customer_state, '|', customer_zip_code_prefix)) AS distinct_address_count,
    COUNT(*) AS record_count
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1
   AND COUNT(DISTINCT CONCAT(customer_city, '|', customer_state, '|', customer_zip_code_prefix)) > 1;

-- 4. Question 7: same email but different names or addresses
-- Only applicable if customer_email and supplemental name fields are loaded.
SELECT
    customer_email,
    COUNT(*) AS record_count,
    COUNT(DISTINCT customer_unique_id) AS unique_customers,
    COUNT(DISTINCT CONCAT(customer_city, '|', customer_state, '|', customer_zip_code_prefix)) AS distinct_addresses
FROM customers
WHERE customer_email IS NOT NULL
GROUP BY customer_email
HAVING COUNT(DISTINCT customer_unique_id) > 1
    OR COUNT(DISTINCT CONCAT(customer_city, '|', customer_state, '|', customer_zip_code_prefix)) > 1;

-- 5. Question 8: orphan order_items pointing to missing orders or products
SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    CASE WHEN o.order_id IS NULL THEN 'Missing Order' END AS order_issue,
    CASE WHEN p.product_id IS NULL THEN 'Missing Product' END AS product_issue
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE o.order_id IS NULL OR p.product_id IS NULL;

-- 6. Orphan payments and reviews
SELECT 'order_payments' AS source_table, op.order_id
FROM order_payments op
LEFT JOIN orders o ON op.order_id = o.order_id
WHERE o.order_id IS NULL
UNION ALL
SELECT 'order_reviews', r.order_id
FROM order_reviews r
LEFT JOIN orders o ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 7. Orders with impossible timestamps
SELECT order_id, order_purchase_timestamp, order_approved_at, order_delivered_customer_date, order_estimated_delivery_date
FROM orders
WHERE order_approved_at < order_purchase_timestamp
   OR order_delivered_customer_date < order_purchase_timestamp;

-- 8. Invalid monetary values
SELECT order_id, order_item_id, price, freight_value
FROM order_items
WHERE price < 0 OR freight_value < 0
UNION ALL
SELECT order_id, payment_sequential, payment_value, NULL
FROM order_payments
WHERE payment_value < 0;

-- 9. Products with missing category or dimensions
SELECT product_id, product_category_name, product_weight_g, product_length_cm, product_height_cm, product_width_cm
FROM products
WHERE product_category_name IS NULL
   OR product_weight_g IS NULL
   OR product_length_cm IS NULL
   OR product_height_cm IS NULL
   OR product_width_cm IS NULL;

-- 10. Duplicate geolocation rows by ZIP and coordinates
SELECT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    COUNT(*) AS duplicate_count
FROM geolocation
GROUP BY geolocation_zip_code_prefix, geolocation_lat, geolocation_lng
HAVING COUNT(*) > 1;

-- 11. Question 10: payment mismatch vs order total
WITH order_totals AS (
    SELECT order_id, ROUND(SUM(price + freight_value), 2) AS item_total
    FROM order_items
    GROUP BY order_id
),
payment_totals AS (
    SELECT order_id, ROUND(SUM(payment_value), 2) AS payment_total
    FROM order_payments
    GROUP BY order_id
)
SELECT
    o.order_id,
    ot.item_total,
    pt.payment_total,
    ROUND(COALESCE(pt.payment_total, 0) - COALESCE(ot.item_total, 0), 2) AS payment_gap
FROM orders o
LEFT JOIN order_totals ot ON o.order_id = ot.order_id
LEFT JOIN payment_totals pt ON o.order_id = pt.order_id
WHERE ROUND(COALESCE(pt.payment_total, 0), 2) <> ROUND(COALESCE(ot.item_total, 0), 2)
ORDER BY ABS(payment_gap) DESC;
