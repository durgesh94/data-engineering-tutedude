# Data Quality Findings - Olist Dataset

This report documents the actual profiling results from the raw CSV files stored in `assignments/assignment-01-sql/olist-data`.

## Dataset Profiled

| File | Rows | Notes |
|---|---:|---|
| `olist_customers_dataset.csv` | 99,441 | Customer master records |
| `olist_geolocation_dataset.csv` | 1,000,163 | Largest file, contains repeated ZIP-level location rows |
| `olist_order_items_dataset.csv` | 112,650 | Order line items |
| `olist_order_payments_dataset.csv` | 103,886 | Split payments included |
| `olist_order_reviews_dataset.csv` | 99,224 | Reviews and optional comments |
| `olist_orders_dataset.csv` | 99,441 | Order lifecycle timestamps |
| `olist_products_dataset.csv` | 32,951 | Product catalog with missing attributes |
| `olist_sellers_dataset.csv` | 3,095 | Seller dimension |

## Profiling Method

- Raw CSV profiling was executed from `02_data_cleaning/profile_olist_data.py`.
- Counts below are based on the source files exactly as added to `olist-data`.
- The original Olist dataset does not contain customer email, so email-based checks require an external CRM enrichment file.

## Actual Findings

| # | Finding | Affected Rows | Business Impact | Recommendation |
|---|---|---:|---|---|
| 1 | `products` has missing category and descriptive fields: `product_category_name`, `product_name_lenght`, `product_description_lenght`, and `product_photos_qty` are blank together | 610 | Category analytics, search quality, and merchandising reports become incomplete | Keep rows, but classify them as `Unknown Category` during reporting and flag for enrichment |
| 2 | Product dimension fields are missing for a small set of products: weight, length, height, and width are blank | 2 | Freight and fulfillment models can be distorted | Keep rows and exclude from size-sensitive logistics calculations until fixed |
| 3 | Some products have zero weight | 4 | Indicates invalid or placeholder physical attributes | Treat as invalid master data and review before logistics use |
| 4 | Geolocation contains exact duplicate rows | 261,831 | Inflates location counts and can distort ZIP-level aggregations | Deduplicate on all five geolocation columns before loading analytics tables |
| 5 | A ZIP prefix maps to multiple city-state combinations | 8,559 ZIP prefixes | Creates ambiguity in geographic normalization and city-level joins | Build a canonical ZIP mapping rule before joining to customer or seller geography |
| 6 | A ZIP prefix maps to multiple states | 8 ZIP prefixes | Severe location inconsistency for downstream state analytics | Review manually and define canonical state by highest occurrence |
| 7 | `customer_unique_id` repeats across multiple `customer_id` rows | 2,997 repeated identities, 3,345 extra rows | The same real customer can appear multiple times, which affects CLV and retention analysis | Aggregate customer behavior at `customer_unique_id` level instead of `customer_id` |
| 8 | Orders have missing approval timestamps | 160 | Payment funnel and order lifecycle metrics may be incomplete | Keep rows but treat as approval-stage exceptions |
| 9 | Orders have missing delivered-to-carrier timestamps | 1,783 | Shipping pipeline analysis can undercount carrier handoff events | Use caution in carrier SLA reporting |
| 10 | Orders have missing delivered-to-customer timestamps | 2,965 | Delivery completion metrics may be overstated if nulls are ignored | Filter by delivered orders when measuring completed delivery performance |
| 11 | No orders were found with delivery date before purchase date | 0 | Good data integrity signal for core delivery timing | No action needed |
| 12 | No orders were found with estimated delivery before purchase date | 0 | Good date logic consistency | No action needed |
| 13 | `order_items` has no orphan references to missing orders, products, or sellers | 0 | Referential quality is strong in raw item data | Preserve relationship integrity during load |
| 14 | `order_payments` has no orphan references to missing orders | 0 | Payment records align cleanly with order headers | No action needed |
| 15 | `order_reviews` has no orphan references to missing orders | 0 | Review data aligns cleanly with order headers | No action needed |
| 16 | Payment total does not match item total plus freight for some orders | 1,349 orders | Revenue reconciliation and fraud checks can be affected | Investigate payment splits, vouchers, and rounding before treating as fraud |
| 17 | Some payment rows have zero installments | 2 | Can cause installment analysis errors | Review as anomalous payment records |
| 18 | Some payment rows have zero payment value | 9 | May represent vouchers, adjustments, or bad source values | Exclude from revenue totals until business meaning is confirmed |
| 19 | Reviews frequently have no title | 87,658 | NLP or text-quality analysis on titles alone is weak | Use review score and message text instead of title-only analysis |
| 20 | Reviews frequently have no message | 58,274 | Text mining coverage is limited | Use only nonblank review text for sentiment or theme extraction |
| 21 | Reviews with both title and message blank are common | 56,537 | Many reviews are score-only feedback | Separate score-only reviews from comment-based reviews |
| 22 | `review_id` is not unique by itself in raw review data | 789 repeated review IDs, 814 extra rows | A single-column primary key on `review_id` would be unsafe | Use a composite key such as `(review_id, order_id)` |
| 23 | Some customer city-state pairs do not appear in geolocation | 76 | Geographic standardization is imperfect across files | Standardize city strings before geo matching |
| 24 | Some seller city-state pairs do not appear in geolocation | 103 | Seller geography joins may miss a subset of records | Use ZIP prefix matching before exact city-state matching |

## Assignment-Specific Notes

### Q2: Document 10+ Data Quality Issues

This requirement is satisfied. The raw files show more than 10 concrete issues or data caveats, including missing attributes, duplicate rows, ambiguous geographies, repeated customer identities, payment mismatches, and sparse review text.

### Q7: Same Email with Different Names or Addresses

This check cannot be performed from the provided raw Olist CSVs because the original dataset does not include customer email or customer name fields. To answer Q7 exactly, you need one of the following:

1. A CRM or marketing export with customer email.
2. A custom enrichment column added during preprocessing.
3. A revised question based on `customer_unique_id` and address inconsistency instead of email.

## Evidence Source

| Evidence | Source |
|---|---|
| Raw file counts | `olist-data/*.csv` |
| Profiling script | `02_data_cleaning/profile_olist_data.py` |
| SQL validation queries | `02_data_cleaning/01_data_quality_assessment.sql` |

## Cleanup Decisions

- Deduplicate geolocation before loading dimension-style geographic tables.
- Model customer behavior using `customer_unique_id` for lifetime and retention analysis.
- Keep null-heavy product records, but label them as incomplete master data.
- Preserve orders with missing lifecycle timestamps, but exclude them from affected SLA metrics.
- Treat payment mismatches as investigation items rather than automatic fraud labels.
- Use `(review_id, order_id)` instead of `review_id` alone as the review key.
