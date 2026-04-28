# Assignment 1: SQL Mastery - The E-Commerce Analytics Challenge

This folder contains a complete starter solution structure for the Olist Brazilian E-Commerce dataset assignment. The scripts are written for MySQL 8.0 and are organized to match the required deliverables.

## Dataset

- Source: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
- Alternative: https://github.com/olist/brazilian-ecommerce
- Core files: customers, orders, order_items, products, sellers, order_payments, order_reviews, geolocation

## Folder Structure

- `02_data_cleaning/00_csv_to_base_tables_load.sql`: loads the eight raw Olist CSV files into the created base tables
- `01_schema/01_database_schema.sql`: normalized schema, constraints, and helper tables
- `01_schema/02_data_dictionary.md`: business definitions for the schema
- `02_data_cleaning/01_data_quality_assessment.sql`: checks for nulls, duplicates, and orphan records
- `02_data_cleaning/02_deduplication_and_load.sql`: transaction-based load and customer deduplication flow
- `02_data_cleaning/03_data_quality_findings.md`: 10+ likely quality issues to document during profiling
- `03_queries/01_analytics_queries.sql`: questions 7 to 28 grouped by topic
- `03_queries/02_stored_procedures.sql`: stored procedure for dynamic discount and helper procedure ideas
- `04_optimization/01_index_strategy.sql`: indexes and EXPLAIN workflow for slow-query tuning
- `04_optimization/02_performance_optimization_report.md`: report template for before/after tuning evidence

## Assumptions

- SQL dialect: MySQL 8.0+
- Raw CSVs are loaded first into staging tables or directly into the analytics schema.
- The Olist dataset does not provide a native product category hierarchy. Question 23 is solved with an optional helper table.
- The dataset does not contain customer email in the original eight files. Question 7 is handled with an optional extension column or a supplemental CRM feed.

## Recommended Workflow

1. Create the schema using `01_schema/01_database_schema.sql`.
2. Load raw CSV data using `02_data_cleaning/00_csv_to_base_tables_load.sql`.
3. Run the profiling checks in `02_data_cleaning/01_data_quality_assessment.sql`.
4. Apply cleanup and deduplication logic from `02_data_cleaning/02_deduplication_and_load.sql`.
5. Execute the analytical queries from `03_queries/01_analytics_queries.sql`.
6. Create the stored procedure from `03_queries/02_stored_procedures.sql`.
7. Benchmark and tune using `04_optimization/01_index_strategy.sql`.

## Deliverables Checklist

- [x] SQL scripts organized by folder
- [x] ERD assets present in assignment root
- [x] Data quality findings report scaffold
- [x] Performance optimization report scaffold
- [x] Video walkthrough
