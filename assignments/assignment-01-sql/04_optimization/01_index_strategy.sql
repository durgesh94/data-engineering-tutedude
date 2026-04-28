/*
===============================================================================
Assignment 1 - Query Optimization and Index Strategy
Question covered: 30
===============================================================================
*/

USE shophub_analytics;

-- How to use this file for Question 30:
-- 1. Run the three baseline EXPLAIN ANALYZE queries below and save the output.
-- 2. Create the candidate indexes in the next section.
-- 3. Re-run the same EXPLAIN ANALYZE queries and compare timing, scans, and row counts.

-- ===========================================================================
-- Baseline plans before adding new indexes
-- ===========================================================================

-- Query 1 candidate: monthly revenue growth
EXPLAIN ANALYZE
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS revenue_month,
    ROUND(SUM(op.payment_value), 2) AS revenue
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01');

-- Query 2 candidate: customer 360 view
EXPLAIN ANALYZE
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(op.payment_value), 2) AS total_spent,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(DISTINCT oi.product_id) AS unique_products_bought
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
LEFT JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_unique_id;

-- Query 3 candidate: seller revenue ranking by state
EXPLAIN ANALYZE
WITH seller_revenue AS (
    SELECT
        s.seller_state,
        s.seller_id,
        SUM(oi.price + oi.freight_value) AS revenue,
        DENSE_RANK() OVER (
            PARTITION BY s.seller_state
            ORDER BY SUM(oi.price + oi.freight_value) DESC
        ) AS revenue_rank
    FROM sellers s
    JOIN order_items oi ON s.seller_id = oi.seller_id
    GROUP BY s.seller_state, s.seller_id
)
SELECT seller_state, seller_id, revenue
FROM seller_revenue
WHERE revenue_rank <= 3;

-- ===========================================================================
-- Indexes to test
-- ===========================================================================

CREATE INDEX idx_orders_purchase_customer ON orders(order_purchase_timestamp, customer_id);
CREATE INDEX idx_orders_customer_order ON orders(customer_id, order_id);
CREATE INDEX idx_order_items_order_product_seller ON order_items(order_id, product_id, seller_id);
CREATE INDEX idx_order_items_seller_order ON order_items(seller_id, order_id);
CREATE INDEX idx_order_payments_order_value ON order_payments(order_id, payment_value);
CREATE INDEX idx_order_reviews_order_score ON order_reviews(order_id, review_score);
CREATE INDEX idx_customers_state_unique ON customers(customer_state, customer_unique_id);
CREATE INDEX idx_sellers_state_seller ON sellers(seller_state, seller_id);

-- ===========================================================================
-- Optimized plans after adding indexes
-- ===========================================================================

EXPLAIN ANALYZE
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS revenue_month,
    ROUND(SUM(op.payment_value), 2) AS revenue
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01');

EXPLAIN ANALYZE
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(op.payment_value), 2) AS total_spent,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(DISTINCT oi.product_id) AS unique_products_bought
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
LEFT JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_unique_id;

EXPLAIN ANALYZE
WITH seller_revenue AS (
    SELECT
        s.seller_state,
        s.seller_id,
        SUM(oi.price + oi.freight_value) AS revenue,
        DENSE_RANK() OVER (
            PARTITION BY s.seller_state
            ORDER BY SUM(oi.price + oi.freight_value) DESC
        ) AS revenue_rank
    FROM sellers s
    JOIN order_items oi ON s.seller_id = oi.seller_id
    GROUP BY s.seller_state, s.seller_id
)
SELECT seller_state, seller_id, revenue
FROM seller_revenue
WHERE revenue_rank <= 3;
