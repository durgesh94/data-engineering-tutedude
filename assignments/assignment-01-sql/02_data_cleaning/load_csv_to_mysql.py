#!/usr/bin/env python3
"""
Assignment 1 - CSV to MySQL Loader (Alternative to LOAD DATA LOCAL INFILE)
Purpose: Load all 8 Olist CSV files directly into MySQL using Python, bypassing
         local_infile restrictions that MySQL Workbench may enforce.

Usage:
    python load_csv_to_mysql.py
    
Prerequisites:
    - MySQL server running with shophub_analytics database created
    - Schema already created via 01_database_schema.sql
    - mysql-connector-python installed: pip install mysql-connector-python
"""

import csv
import sys
from pathlib import Path
from decimal import Decimal
import mysql.connector
from mysql.connector import Error

# MySQL Connection Configuration
MYSQL_HOST = 'localhost'
MYSQL_USER = 'root'
MYSQL_PASSWORD = ''  # UPDATE THIS if different
MYSQL_DATABASE = 'shophub_analytics'

# Base path to olist-data folder
BASE_DIR = Path(__file__).parent.parent / 'olist-data'

def get_connection():
    """Establish MySQL connection."""
    try:
        conn = mysql.connector.connect(
            host=MYSQL_HOST,
            user=MYSQL_USER,
            password=MYSQL_PASSWORD,
            database=MYSQL_DATABASE
        )
        return conn
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        sys.exit(1)

def load_csv(conn, csv_file, table_name, column_names, batch_size=5000, csv_column_mapping=None):
    """Load a single CSV file into a table in batches.
    
    Args:
        csv_column_mapping: dict mapping CSV column names to database column names
                           e.g., {'product_name_lenght': 'product_name_length'}
    """
    csv_path = BASE_DIR / csv_file
    
    if not csv_path.exists():
        print(f"❌ File not found: {csv_path}")
        return 0
    
    try:
        # Skip header row and read data
        with open(csv_path, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            rows = list(reader)
        
        if not rows:
            print(f"⚠️  {table_name}: No data rows found")
            return 0
        
        # Apply CSV column name mapping if provided
        if csv_column_mapping:
            for row in rows:
                for csv_col, db_col in csv_column_mapping.items():
                    if csv_col in row:
                        row[db_col] = row.pop(csv_col)
        
        # Prepare INSERT statement
        placeholders = ','.join(['%s'] * len(column_names))
        insert_sql = f"INSERT INTO {table_name} ({','.join(column_names)}) VALUES ({placeholders})"
        
        # Convert rows to tuples, handling blank values as NULL
        data_tuples = []
        for row in rows:
            values = []
            for col in column_names:
                val = row.get(col, '')
                # Convert blank strings to None (NULL in SQL)
                if val == '':
                    values.append(None)
                else:
                    values.append(val)
            data_tuples.append(tuple(values))
        
        # Batch insert to avoid max_allowed_packet errors
        total_inserted = 0
        for i in range(0, len(data_tuples), batch_size):
            batch = data_tuples[i:i + batch_size]
            cursor = conn.cursor()
            try:
                cursor.executemany(insert_sql, batch)
                conn.commit()
                total_inserted += cursor.rowcount
            except Error as e:
                conn.rollback()
                print(f"❌ Error in batch {i//batch_size + 1} for {table_name}: {e}")
                raise
            finally:
                cursor.close()
        
        print(f"✓ {table_name}: {total_inserted} rows inserted")
        return total_inserted
        
    except Error as e:
        print(f"❌ Error loading {table_name}: {e}")
        return 0

def main():
    """Load all 8 CSV files into the database."""
    conn = get_connection()
    
    try:
        # Disable foreign key checks for faster loading
        cursor = conn.cursor()
        cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
        
        # Truncate all tables
        tables = ['order_reviews', 'order_payments', 'order_items', 'orders', 
                  'products', 'sellers', 'customers', 'geolocation']
        for table in tables:
            cursor.execute(f"TRUNCATE TABLE {table}")
        
        cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
        conn.commit()
        cursor.close()
        
        print("\n=== Loading Olist Data ===\n")
        
        total = 0
        
        # 1. Load geolocation
        total += load_csv(conn, 'olist_geolocation_dataset.csv', 'geolocation',
                         ['geolocation_zip_code_prefix', 'geolocation_lat', 
                          'geolocation_lng', 'geolocation_city', 'geolocation_state'])
        
        # 2. Load customers
        total += load_csv(conn, 'olist_customers_dataset.csv', 'customers',
                         ['customer_id', 'customer_unique_id', 'customer_zip_code_prefix',
                          'customer_city', 'customer_state'])
        
        # 3. Load sellers
        total += load_csv(conn, 'olist_sellers_dataset.csv', 'sellers',
                         ['seller_id', 'seller_zip_code_prefix', 'seller_city', 'seller_state'])
        
        # 4. Load products
        total += load_csv(conn, 'olist_products_dataset.csv', 'products',
                         ['product_id', 'product_category_name', 'product_name_length',
                          'product_description_length', 'product_photos_qty', 'product_weight_g',
                          'product_length_cm', 'product_height_cm', 'product_width_cm'],
                         csv_column_mapping={
                             'product_name_lenght': 'product_name_length',
                             'product_description_lenght': 'product_description_length'
                         })
        
        # 5. Load orders
        total += load_csv(conn, 'olist_orders_dataset.csv', 'orders',
                         ['order_id', 'customer_id', 'order_status', 'order_purchase_timestamp',
                          'order_approved_at', 'order_delivered_carrier_date',
                          'order_delivered_customer_date', 'order_estimated_delivery_date'])
        
        # 6. Load order items
        total += load_csv(conn, 'olist_order_items_dataset.csv', 'order_items',
                         ['order_id', 'order_item_id', 'product_id', 'seller_id',
                          'shipping_limit_date', 'price', 'freight_value'])
        
        # 7. Load order payments
        total += load_csv(conn, 'olist_order_payments_dataset.csv', 'order_payments',
                         ['order_id', 'payment_sequential', 'payment_type',
                          'payment_installments', 'payment_value'])
        
        # 8. Load order reviews
        total += load_csv(conn, 'olist_order_reviews_dataset.csv', 'order_reviews',
                         ['review_id', 'order_id', 'review_score', 'review_comment_title',
                          'review_comment_message', 'review_creation_date', 'review_answer_timestamp'])
        
        print(f"\n✓ Total rows loaded: {total:,}")
        
        # Validation counts
        cursor = conn.cursor()
        cursor.execute("""
            SELECT 'geolocation' AS table_name, COUNT(*) AS count FROM geolocation
            UNION ALL SELECT 'customers', COUNT(*) FROM customers
            UNION ALL SELECT 'sellers', COUNT(*) FROM sellers
            UNION ALL SELECT 'products', COUNT(*) FROM products
            UNION ALL SELECT 'orders', COUNT(*) FROM orders
            UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
            UNION ALL SELECT 'order_payments', COUNT(*) FROM order_payments
            UNION ALL SELECT 'order_reviews', COUNT(*) FROM order_reviews
        """)
        
        print("\n=== Validation Counts ===\n")
        for table_name, count in cursor.fetchall():
            print(f"{table_name:20} {count:>10,} rows")
        
        cursor.close()
        
    finally:
        conn.close()
        print("\n✓ Done!")

if __name__ == '__main__':
    main()
