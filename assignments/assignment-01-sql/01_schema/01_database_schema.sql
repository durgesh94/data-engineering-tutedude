/*
===============================================================================
Assignment 1 - Olist E-Commerce Analytics Schema
Target: MySQL 8.0+
Purpose: 3NF-style analytics schema for the eight Olist dataset tables
Questions Covered: 1, 3
Supporting Role: Provides foundation for Q23 through the optional product_category_hierarchy table
===============================================================================
*/

CREATE DATABASE IF NOT EXISTS shophub_analytics;
USE shophub_analytics;

DROP TABLE IF EXISTS order_reviews;
DROP TABLE IF EXISTS order_payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS geolocation;
DROP TABLE IF EXISTS product_category_hierarchy;

CREATE TABLE geolocation (
    geolocation_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    geolocation_zip_code_prefix INT NOT NULL,
    geolocation_lat DECIMAL(10, 7) NOT NULL,
    geolocation_lng DECIMAL(10, 7) NOT NULL,
    geolocation_city VARCHAR(100) NOT NULL,
    geolocation_state CHAR(2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_geo_zip_state (geolocation_zip_code_prefix, geolocation_state)
) COMMENT='Normalized geolocation reference built from Olist geolocation dataset';

CREATE TABLE customers (
    customer_id CHAR(32) PRIMARY KEY,
    customer_unique_id CHAR(32) NOT NULL,
    customer_email VARCHAR(255) NULL,
    customer_zip_code_prefix INT NOT NULL,
    customer_city VARCHAR(100) NOT NULL,
    customer_state CHAR(2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_customer_state CHECK (CHAR_LENGTH(customer_state) = 2),
    INDEX idx_customer_unique (customer_unique_id),
    INDEX idx_customer_geo (customer_zip_code_prefix, customer_state),
    INDEX idx_customer_email (customer_email)
) COMMENT='Customer-level dimension table. Email is optional extension data.';

CREATE TABLE sellers (
    seller_id CHAR(32) PRIMARY KEY,
    seller_zip_code_prefix INT NOT NULL,
    seller_city VARCHAR(100) NOT NULL,
    seller_state CHAR(2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_seller_state CHECK (CHAR_LENGTH(seller_state) = 2),
    INDEX idx_seller_geo (seller_zip_code_prefix, seller_state)
) COMMENT='Seller dimension table';

CREATE TABLE products (
    product_id CHAR(32) PRIMARY KEY,
    product_category_name VARCHAR(255) NULL,
    product_name_length INT NULL,
    product_description_length INT NULL,
    product_photos_qty INT NULL,
    product_weight_g DECIMAL(10, 2) NULL,
    product_length_cm DECIMAL(10, 2) NULL,
    product_height_cm DECIMAL(10, 2) NULL,
    product_width_cm DECIMAL(10, 2) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_product_dims CHECK (
        product_weight_g IS NULL OR product_weight_g >= 0
    ),
    INDEX idx_product_category (product_category_name)
) COMMENT='Product dimension table';

CREATE TABLE orders (
    order_id CHAR(32) PRIMARY KEY,
    customer_id CHAR(32) NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    order_purchase_timestamp DATETIME NOT NULL,
    order_approved_at DATETIME NULL,
    order_delivered_carrier_date DATETIME NULL,
    order_delivered_customer_date DATETIME NULL,
    order_estimated_delivery_date DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON UPDATE CASCADE,
    INDEX idx_order_customer_date (customer_id, order_purchase_timestamp),
    INDEX idx_order_status_date (order_status, order_purchase_timestamp)
) COMMENT='Order fact header table';

CREATE TABLE order_items (
    order_id CHAR(32) NOT NULL,
    order_item_id INT NOT NULL,
    product_id CHAR(32) NOT NULL,
    seller_id CHAR(32) NOT NULL,
    shipping_limit_date DATETIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    freight_value DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id, order_item_id),
    CONSTRAINT fk_items_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_items_product FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON UPDATE CASCADE,
    CONSTRAINT fk_items_seller FOREIGN KEY (seller_id)
        REFERENCES sellers(seller_id)
        ON UPDATE CASCADE,
    CONSTRAINT chk_item_amounts CHECK (price >= 0 AND freight_value >= 0),
    INDEX idx_item_product (product_id),
    INDEX idx_item_seller (seller_id),
    INDEX idx_item_order_value (order_id, price, freight_value)
) COMMENT='Order line item fact table';

CREATE TABLE order_payments (
    order_id CHAR(32) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(30) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id, payment_sequential),
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_payment_values CHECK (payment_installments >= 0 AND payment_value >= 0),
    INDEX idx_payment_type (payment_type),
    INDEX idx_payment_value (payment_value)
) COMMENT='Payment fact table';

CREATE TABLE order_reviews (
    review_id CHAR(32) NOT NULL,
    order_id CHAR(32) NOT NULL,
    review_score INT NOT NULL,
    review_comment_title VARCHAR(255) NULL,
    review_comment_message TEXT NULL,
    review_creation_date DATETIME NOT NULL,
    review_answer_timestamp DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (review_id, order_id),
    CONSTRAINT fk_reviews_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_review_score CHECK (review_score BETWEEN 1 AND 5),
    INDEX idx_review_score (review_score),
    INDEX idx_review_date (review_creation_date)
) COMMENT='Customer review fact table';

CREATE TABLE product_category_hierarchy (
    category_name VARCHAR(255) PRIMARY KEY,
    parent_category_name VARCHAR(255) NULL,
    level_no INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_category_parent FOREIGN KEY (parent_category_name)
        REFERENCES product_category_hierarchy(category_name)
        ON UPDATE CASCADE,
    CONSTRAINT chk_level_no CHECK (level_no >= 1)
) COMMENT='Optional helper table for recursive category hierarchy analysis';
