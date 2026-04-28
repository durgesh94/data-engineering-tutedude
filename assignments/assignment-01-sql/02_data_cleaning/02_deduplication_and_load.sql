/*
===============================================================================
Assignment 1 - Transactions, Deduplication, and Clean Loading
Questions covered: 4, 6
===============================================================================
*/

USE shophub_analytics;

-- Example staging table for raw customer ingestion.
CREATE TABLE IF NOT EXISTS staging_customers_raw (
    ingest_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    customer_id CHAR(32) NOT NULL,
    customer_unique_id CHAR(32) NOT NULL,
    customer_email VARCHAR(255) NULL,
    customer_zip_code_prefix INT NULL,
    customer_city VARCHAR(100) NULL,
    customer_state CHAR(2) NULL,
    source_updated_at DATETIME NOT NULL,
    INDEX idx_staging_customer_id (customer_id),
    INDEX idx_staging_unique_id (customer_unique_id)
);

-- Question 4: detect duplicate customers and keep the most recent row.
WITH ranked_customers AS (
    SELECT
        ingest_id,
        customer_id,
        customer_unique_id,
        source_updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY customer_unique_id
            ORDER BY source_updated_at DESC, ingest_id DESC
        ) AS rn
    FROM staging_customers_raw
)
SELECT *
FROM ranked_customers
WHERE rn > 1;

-- Delete duplicates while keeping the newest row.
DELETE scr
FROM staging_customers_raw scr
JOIN (
    SELECT ingest_id
    FROM (
        SELECT
            ingest_id,
            ROW_NUMBER() OVER (
                PARTITION BY customer_unique_id
                ORDER BY source_updated_at DESC, ingest_id DESC
            ) AS rn
        FROM staging_customers_raw
    ) ranked
    WHERE rn > 1
) dupes ON scr.ingest_id = dupes.ingest_id;

-- Question 6: transaction-based load with rollback example.
START TRANSACTION;

INSERT INTO customers (
    customer_id,
    customer_unique_id,
    customer_email,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT
    customer_id,
    customer_unique_id,
    customer_email,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM staging_customers_raw;

-- Validation checkpoint: if this returns issues, run ROLLBACK instead of COMMIT.
SELECT customer_state, COUNT(*) AS invalid_rows
FROM customers
WHERE customer_state IS NULL OR CHAR_LENGTH(customer_state) <> 2
GROUP BY customer_state;

-- Example success path
COMMIT;

-- Example failure scenario to demonstrate rollback.
START TRANSACTION;

INSERT INTO customers (
    customer_id,
    customer_unique_id,
    customer_email,
    customer_zip_code_prefix,
    customer_city,
    customer_state
) VALUES (
    'duplicate-customer-id-demo',
    'duplicate-customer-id-demo',
    'bad-state@demo.com',
    12345,
    'Sao Paulo',
    'SAO'
);

-- This row violates the state length business rule and should be discarded.
ROLLBACK;
