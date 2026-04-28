/*
===============================================================================
Assignment 1 - Analytics Queries
Questions covered: 9 to 28 except stored procedure question 29
Target: MySQL 8.0+
===============================================================================
*/

USE shophub_analytics;

-- 9. Customers who registered but never placed an order
SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_state, c.customer_city;

-- 11. Monthly revenue with Month-over-Month growth
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS revenue_month,
        ROUND(SUM(op.payment_value), 2) AS revenue
    FROM orders o
    JOIN order_payments op ON o.order_id = op.order_id
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01')
)
SELECT
    revenue_month,
    revenue,
    LAG(revenue) OVER (ORDER BY revenue_month) AS previous_month_revenue,
    CASE
        WHEN LAG(revenue) OVER (ORDER BY revenue_month) IS NULL THEN NULL
        WHEN LAG(revenue) OVER (ORDER BY revenue_month) = 0 THEN NULL
        ELSE ROUND(
            (revenue - LAG(revenue) OVER (ORDER BY revenue_month))
            / LAG(revenue) OVER (ORDER BY revenue_month) * 100,
            2
        )
    END AS mom_growth_pct
FROM monthly_revenue
ORDER BY revenue_month;

-- 12. Top 10 products by revenue in each category
WITH product_revenue AS (
    SELECT
        p.product_category_name,
        oi.product_id,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue,
        DENSE_RANK() OVER (
            PARTITION BY p.product_category_name
            ORDER BY SUM(oi.price + oi.freight_value) DESC
        ) AS category_rank
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_category_name, oi.product_id
)
SELECT *
FROM product_revenue
WHERE category_rank <= 10
ORDER BY product_category_name, category_rank, revenue DESC;

-- 13. Customer Lifetime Value with segmentation
WITH customer_clv AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS clv
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_payments op ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
)
SELECT
    customer_unique_id,
    clv,
    CASE
        WHEN clv >= 1000 THEN 'Gold'
        WHEN clv >= 300 THEN 'Silver'
        ELSE 'Bronze'
    END AS clv_segment
FROM customer_clv
ORDER BY clv DESC;

-- 14. Sales report with daily, monthly, yearly rollups
SELECT
    YEAR(o.order_purchase_timestamp) AS sales_year,
    MONTH(o.order_purchase_timestamp) AS sales_month,
    DATE(o.order_purchase_timestamp) AS sales_day,
    ROUND(SUM(op.payment_value), 2) AS revenue
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp), DATE(o.order_purchase_timestamp) WITH ROLLUP;

-- 15. Seasonal patterns by category and month
SELECT
    MONTH(o.order_purchase_timestamp) AS sales_month,
    p.product_category_name,
    COUNT(*) AS units_sold,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY MONTH(o.order_purchase_timestamp), p.product_category_name
ORDER BY sales_month, revenue DESC;

-- 16. Customer 360-degree view joining 5+ tables
SELECT
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(op.payment_value), 2) AS total_spent,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(DISTINCT oi.product_id) AS unique_products_bought,
    MIN(o.order_purchase_timestamp) AS first_order_at,
    MAX(o.order_purchase_timestamp) AS last_order_at
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
LEFT JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_unique_id, c.customer_city, c.customer_state;

-- 17. Customers who bought electronics but never books
SELECT DISTINCT c.customer_unique_id
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_category_name = 'electronics'
  AND c.customer_unique_id NOT IN (
      SELECT DISTINCT c2.customer_unique_id
      FROM customers c2
      JOIN orders o2 ON c2.customer_id = o2.customer_id
      JOIN order_items oi2 ON o2.order_id = oi2.order_id
      JOIN products p2 ON oi2.product_id = p2.product_id
      WHERE p2.product_category_name = 'books'
  );

-- 18. Sellers and their best-selling product in each category
WITH seller_product_sales AS (
    SELECT
        s.seller_id,
        p.product_category_name,
        oi.product_id,
        COUNT(*) AS units_sold,
        ROW_NUMBER() OVER (
            PARTITION BY s.seller_id, p.product_category_name
            ORDER BY COUNT(*) DESC, oi.product_id
        ) AS rn
    FROM sellers s
    JOIN order_items oi ON s.seller_id = oi.seller_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY s.seller_id, p.product_category_name, oi.product_id
)
SELECT seller_id, product_category_name, product_id, units_sold
FROM seller_product_sales
WHERE rn = 1
ORDER BY seller_id, product_category_name;

-- 19. Products frequently bought together using self-join
SELECT
    a.product_id AS product_a,
    b.product_id AS product_b,
    COUNT(*) AS times_bought_together
FROM order_items a
JOIN order_items b
    ON a.order_id = b.order_id
   AND a.product_id < b.product_id
GROUP BY a.product_id, b.product_id
HAVING COUNT(*) >= 5
ORDER BY times_bought_together DESC, product_a, product_b;

-- 20. Shipping delays with customer and seller info
SELECT
    o.order_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    s.seller_id,
    s.seller_city,
    s.seller_state,
    o.order_estimated_delivery_date,
    o.order_delivered_customer_date,
    TIMESTAMPDIFF(DAY, o.order_estimated_delivery_date, o.order_delivered_customer_date) AS delay_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN sellers s ON oi.seller_id = s.seller_id
WHERE o.order_delivered_customer_date > o.order_estimated_delivery_date
ORDER BY delay_days DESC;

-- 21. Customers who spent more than their state average
SELECT
    customer_unique_id,
    customer_state,
    total_spent
FROM (
    SELECT
        c.customer_unique_id,
        c.customer_state,
        ROUND(SUM(op.payment_value), 2) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_payments op ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id, c.customer_state
) cs
WHERE total_spent > (
    SELECT AVG(state_customer_total)
    FROM (
        SELECT
            c2.customer_unique_id,
            ROUND(SUM(op2.payment_value), 2) AS state_customer_total
        FROM customers c2
        JOIN orders o2 ON c2.customer_id = o2.customer_id
        JOIN order_payments op2 ON o2.order_id = op2.order_id
        WHERE c2.customer_state = cs.customer_state
        GROUP BY c2.customer_unique_id
    ) state_avg
)
ORDER BY customer_state, total_spent DESC;

-- 22. Second highest revenue-generating product in each category
WITH category_product_revenue AS (
    SELECT
        p.product_category_name,
        oi.product_id,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue,
        DENSE_RANK() OVER (
            PARTITION BY p.product_category_name
            ORDER BY SUM(oi.price + oi.freight_value) DESC
        ) AS revenue_rank
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_category_name, oi.product_id
)
SELECT product_category_name, product_id, revenue
FROM category_product_revenue
WHERE revenue_rank = 2
ORDER BY product_category_name;

-- 23. Recursive CTE for optional category hierarchy
WITH RECURSIVE category_tree AS (
    SELECT category_name, parent_category_name, level_no, CAST(category_name AS CHAR(1000)) AS hierarchy_path
    FROM product_category_hierarchy
    WHERE parent_category_name IS NULL
    UNION ALL
    SELECT
        child.category_name,
        child.parent_category_name,
        child.level_no,
        CONCAT(parent.hierarchy_path, ' > ', child.category_name) AS hierarchy_path
    FROM product_category_hierarchy child
    JOIN category_tree parent
        ON child.parent_category_name = parent.category_name
)
SELECT *
FROM category_tree
ORDER BY hierarchy_path;

-- 24. Customers with purchases in 3+ consecutive months
WITH monthly_customer_orders AS (
    SELECT DISTINCT
        c.customer_unique_id,
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS order_month
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
),
sequenced_months AS (
    SELECT
        customer_unique_id,
        order_month,
        ROW_NUMBER() OVER (PARTITION BY customer_unique_id ORDER BY order_month) AS rn
    FROM monthly_customer_orders
),
month_groups AS (
    SELECT
        customer_unique_id,
        order_month,
        DATE_SUB(order_month, INTERVAL rn MONTH) AS grp_key
    FROM sequenced_months
)
SELECT customer_unique_id, MIN(order_month) AS streak_start, MAX(order_month) AS streak_end, COUNT(*) AS consecutive_months
FROM month_groups
GROUP BY customer_unique_id, grp_key
HAVING COUNT(*) >= 3
ORDER BY consecutive_months DESC, customer_unique_id;

-- 25. Seven-day moving average of daily order count
WITH daily_orders AS (
    SELECT DATE(order_purchase_timestamp) AS order_date, COUNT(*) AS order_count
    FROM orders
    GROUP BY DATE(order_purchase_timestamp)
)
SELECT
    order_date,
    order_count,
    ROUND(AVG(order_count) OVER (
        ORDER BY order_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_7d
FROM daily_orders
ORDER BY order_date;

-- 26. Gap in days between consecutive orders per customer
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        LAG(o.order_purchase_timestamp) OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        ) AS previous_order_ts
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
)
SELECT
    customer_unique_id,
    order_id,
    order_purchase_timestamp,
    previous_order_ts,
    TIMESTAMPDIFF(DAY, previous_order_ts, order_purchase_timestamp) AS gap_days
FROM customer_orders
ORDER BY customer_unique_id, order_purchase_timestamp;

-- 27. Top 3 sellers by revenue within each state
WITH seller_revenue AS (
    SELECT
        s.seller_state,
        s.seller_id,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue,
        DENSE_RANK() OVER (
            PARTITION BY s.seller_state
            ORDER BY SUM(oi.price + oi.freight_value) DESC
        ) AS revenue_rank
    FROM sellers s
    JOIN order_items oi ON s.seller_id = oi.seller_id
    GROUP BY s.seller_state, s.seller_id
)
SELECT seller_state, seller_id, revenue, revenue_rank
FROM seller_revenue
WHERE revenue_rank <= 3
ORDER BY seller_state, revenue_rank, revenue DESC;

-- 28. Running total of revenue by date and share of grand total
WITH daily_revenue AS (
    SELECT DATE(o.order_purchase_timestamp) AS revenue_date, ROUND(SUM(op.payment_value), 2) AS revenue
    FROM orders o
    JOIN order_payments op ON o.order_id = op.order_id
    GROUP BY DATE(o.order_purchase_timestamp)
)
SELECT
    revenue_date,
    revenue,
    ROUND(SUM(revenue) OVER (ORDER BY revenue_date), 2) AS running_total_revenue,
    ROUND(revenue / SUM(revenue) OVER () * 100, 2) AS pct_of_grand_total
FROM daily_revenue
ORDER BY revenue_date;
