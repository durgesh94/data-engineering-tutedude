<!--
===============================================================================
Assignment 1 - ShopHub Analytics Data Dictionary
Purpose: Document each table, column, data type, and business meaning
Questions Covered: 5
===============================================================================
-->

# Data Dictionary - ShopHub Analytics

## `geolocation`

| Column | Type | Meaning |
|---|---|---|
| `geolocation_id` | `BIGINT` | Surrogate key for the normalized geolocation row |
| `geolocation_zip_code_prefix` | `INT` | Brazilian ZIP prefix |
| `geolocation_lat` | `DECIMAL(10,7)` | Latitude of the ZIP centroid |
| `geolocation_lng` | `DECIMAL(10,7)` | Longitude of the ZIP centroid |
| `geolocation_city` | `VARCHAR(100)` | City associated with the ZIP prefix |
| `geolocation_state` | `CHAR(2)` | Brazilian state code |

## `customers`

| Column | Type | Meaning |
|---|---|---|
| `customer_id` | `CHAR(32)` | Order-system customer key |
| `customer_unique_id` | `CHAR(32)` | Real-world customer identity across multiple orders |
| `customer_email` | `VARCHAR(255)` | Optional CRM email field for data-quality checks |
| `customer_zip_code_prefix` | `INT` | ZIP prefix from customer record |
| `customer_city` | `VARCHAR(100)` | Customer city |
| `customer_state` | `CHAR(2)` | Customer state |

## `sellers`

| Column | Type | Meaning |
|---|---|---|
| `seller_id` | `CHAR(32)` | Seller identifier |
| `seller_zip_code_prefix` | `INT` | Seller ZIP prefix |
| `seller_city` | `VARCHAR(100)` | Seller city |
| `seller_state` | `CHAR(2)` | Seller state |

## `products`

| Column | Type | Meaning |
|---|---|---|
| `product_id` | `CHAR(32)` | Product identifier |
| `product_category_name` | `VARCHAR(255)` | Product category |
| `product_name_length` | `INT` | Number of characters in product name |
| `product_description_length` | `INT` | Number of characters in description |
| `product_photos_qty` | `INT` | Product photo count |
| `product_weight_g` | `DECIMAL(10,2)` | Weight in grams |
| `product_length_cm` | `DECIMAL(10,2)` | Length in centimeters |
| `product_height_cm` | `DECIMAL(10,2)` | Height in centimeters |
| `product_width_cm` | `DECIMAL(10,2)` | Width in centimeters |

## `orders`

| Column | Type | Meaning |
|---|---|---|
| `order_id` | `CHAR(32)` | Order identifier |
| `customer_id` | `CHAR(32)` | Customer who placed the order |
| `order_status` | `VARCHAR(30)` | Lifecycle status |
| `order_purchase_timestamp` | `DATETIME` | Purchase timestamp |
| `order_approved_at` | `DATETIME` | Payment approval timestamp |
| `order_delivered_carrier_date` | `DATETIME` | Carrier handoff timestamp |
| `order_delivered_customer_date` | `DATETIME` | Actual delivery timestamp |
| `order_estimated_delivery_date` | `DATETIME` | Estimated delivery timestamp |

## `order_items`

| Column | Type | Meaning |
|---|---|---|
| `order_id` | `CHAR(32)` | Related order |
| `order_item_id` | `INT` | Line number within order |
| `product_id` | `CHAR(32)` | Ordered product |
| `seller_id` | `CHAR(32)` | Seller fulfilling the line |
| `shipping_limit_date` | `DATETIME` | Shipping SLA cutoff |
| `price` | `DECIMAL(10,2)` | Product sale price |
| `freight_value` | `DECIMAL(10,2)` | Freight charge |

## `order_payments`

| Column | Type | Meaning |
|---|---|---|
| `order_id` | `CHAR(32)` | Related order |
| `payment_sequential` | `INT` | Sequence number for split payments |
| `payment_type` | `VARCHAR(30)` | Payment method |
| `payment_installments` | `INT` | Number of installments |
| `payment_value` | `DECIMAL(10,2)` | Payment amount |

## `order_reviews`

| Column | Type | Meaning |
|---|---|---|
| `review_id` | `CHAR(32)` | Review identifier |
| `order_id` | `CHAR(32)` | Related order |
| `review_score` | `INT` | Score from 1 to 5 |
| `review_comment_title` | `VARCHAR(255)` | Optional review title |
| `review_comment_message` | `TEXT` | Optional review comment |
| `review_creation_date` | `DATETIME` | Review creation timestamp |
| `review_answer_timestamp` | `DATETIME` | Marketplace response timestamp |

## `product_category_hierarchy`

Note: This table is not present in the original Olist dataset or the assignment source files. It was added as an optional custom helper table to support Q23, because the provided dataset does not include a native parent-child product category hierarchy.

| Column | Type | Meaning |
|---|---|---|
| `category_name` | `VARCHAR(255)` | Child category |
| `parent_category_name` | `VARCHAR(255)` | Parent category |
| `level_no` | `INT` | Depth of hierarchy |
