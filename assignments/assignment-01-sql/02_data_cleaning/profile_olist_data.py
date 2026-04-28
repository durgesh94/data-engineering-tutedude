"""
===============================================================================
Assignment 1 - Olist Raw Data Profiler
Purpose: Profile the raw CSV files in `olist-data` and generate actual counts for
nulls, duplicates, orphan references, payment mismatches, and data consistency
issues.
Questions Supported: 2 primarily, with supporting evidence for 7, 8, and 10

Use of This File:
- Run this script before documenting the data quality findings report.
- Use the printed key=value output as evidence for `03_data_quality_findings.md`.
- Re-run it whenever the raw CSV files change, so the report stays aligned with
    the source dataset.

Run Command:
`python 02_data_cleaning/profile_olist_data.py`
===============================================================================
"""

from __future__ import annotations

import csv
from collections import Counter, defaultdict
from datetime import datetime
from decimal import Decimal
from pathlib import Path


BASE_DIR = Path(__file__).resolve().parent.parent / "olist-data"


def read_csv(name: str):
    path = BASE_DIR / name
    with path.open("r", encoding="utf-8", newline="") as handle:
        yield from csv.DictReader(handle)


def is_blank(value: str | None) -> bool:
    return value is None or value.strip() == ""


def main() -> None:
    results: dict[str, object] = {}

    customers = list(read_csv("olist_customers_dataset.csv"))
    geolocation = list(read_csv("olist_geolocation_dataset.csv"))
    order_items = list(read_csv("olist_order_items_dataset.csv"))
    payments = list(read_csv("olist_order_payments_dataset.csv"))
    reviews = list(read_csv("olist_order_reviews_dataset.csv"))
    orders = list(read_csv("olist_orders_dataset.csv"))
    products = list(read_csv("olist_products_dataset.csv"))
    sellers = list(read_csv("olist_sellers_dataset.csv"))

    customer_ids = Counter(row["customer_id"] for row in customers)
    customer_unique_ids = Counter(row["customer_unique_id"] for row in customers)
    results["customers_total"] = len(customers)
    results["customer_id_duplicates"] = sum(1 for count in customer_ids.values() if count > 1)
    results["customer_unique_repeated_ids"] = sum(1 for count in customer_unique_ids.values() if count > 1)
    results["customer_unique_repeated_rows"] = sum(count - 1 for count in customer_unique_ids.values() if count > 1)

    geo_exact_rows = Counter(
        (
            row["geolocation_zip_code_prefix"],
            row["geolocation_lat"],
            row["geolocation_lng"],
            row["geolocation_city"],
            row["geolocation_state"],
        )
        for row in geolocation
    )
    zip_prefix_city_state = defaultdict(set)
    zip_prefix_states = defaultdict(set)
    for row in geolocation:
        zip_prefix = row["geolocation_zip_code_prefix"]
        zip_prefix_city_state[zip_prefix].add((row["geolocation_city"], row["geolocation_state"]))
        zip_prefix_states[zip_prefix].add(row["geolocation_state"])
    results["geolocation_total"] = len(geolocation)
    results["geolocation_exact_duplicate_rows"] = sum(count - 1 for count in geo_exact_rows.values() if count > 1)
    results["zip_prefix_multiple_city_state"] = sum(1 for values in zip_prefix_city_state.values() if len(values) > 1)
    results["zip_prefix_multiple_states"] = sum(1 for values in zip_prefix_states.values() if len(values) > 1)

    results["products_total"] = len(products)
    for column in [
        "product_category_name",
        "product_name_lenght",
        "product_description_lenght",
        "product_photos_qty",
        "product_weight_g",
        "product_length_cm",
        "product_height_cm",
        "product_width_cm",
    ]:
        results[f"{column}_blank"] = sum(is_blank(row[column]) for row in products)
    results["product_zero_weight"] = sum(
        not is_blank(row["product_weight_g"]) and Decimal(row["product_weight_g"]) == 0 for row in products
    )

    seller_ids = {row["seller_id"] for row in sellers}
    product_ids = {row["product_id"] for row in products}
    order_ids = {row["order_id"] for row in orders}
    customer_id_set = {row["customer_id"] for row in customers}

    results["orders_total"] = len(orders)
    results["orders_missing_customer_ref"] = sum(row["customer_id"] not in customer_id_set for row in orders)
    results["orders_approved_blank"] = sum(is_blank(row["order_approved_at"]) for row in orders)
    results["orders_delivered_carrier_blank"] = sum(is_blank(row["order_delivered_carrier_date"]) for row in orders)
    results["orders_delivered_customer_blank"] = sum(is_blank(row["order_delivered_customer_date"]) for row in orders)

    ts_format = "%Y-%m-%d %H:%M:%S"
    results["orders_delivered_before_purchase"] = 0
    results["orders_estimated_before_purchase"] = 0
    for row in orders:
        purchase_ts = datetime.strptime(row["order_purchase_timestamp"], ts_format)
        if not is_blank(row["order_delivered_customer_date"]):
            delivered_ts = datetime.strptime(row["order_delivered_customer_date"], ts_format)
            if delivered_ts < purchase_ts:
                results["orders_delivered_before_purchase"] += 1
        if not is_blank(row["order_estimated_delivery_date"]):
            estimated_ts = datetime.strptime(row["order_estimated_delivery_date"], ts_format)
            if estimated_ts < purchase_ts:
                results["orders_estimated_before_purchase"] += 1

    results["order_items_total"] = len(order_items)
    results["order_items_missing_order_ref"] = sum(row["order_id"] not in order_ids for row in order_items)
    results["order_items_missing_product_ref"] = sum(row["product_id"] not in product_ids for row in order_items)
    results["order_items_missing_seller_ref"] = sum(row["seller_id"] not in seller_ids for row in order_items)
    results["order_items_zero_price"] = sum(Decimal(row["price"]) == 0 for row in order_items)

    results["payments_total"] = len(payments)
    results["payments_missing_order_ref"] = sum(row["order_id"] not in order_ids for row in payments)
    results["payment_zero_value"] = sum(Decimal(row["payment_value"]) == 0 for row in payments)
    results["payment_zero_installments"] = sum(int(row["payment_installments"]) == 0 for row in payments)

    review_ids = Counter(row["review_id"] for row in reviews)
    results["reviews_total"] = len(reviews)
    results["reviews_missing_order_ref"] = sum(row["order_id"] not in order_ids for row in reviews)
    results["review_id_repeated_ids"] = sum(1 for count in review_ids.values() if count > 1)
    results["review_id_repeated_rows"] = sum(count - 1 for count in review_ids.values() if count > 1)
    results["review_title_blank"] = sum(is_blank(row["review_comment_title"]) for row in reviews)
    results["review_message_blank"] = sum(is_blank(row["review_comment_message"]) for row in reviews)
    results["review_both_blank"] = sum(
        is_blank(row["review_comment_title"]) and is_blank(row["review_comment_message"]) for row in reviews
    )

    item_totals = defaultdict(lambda: Decimal("0.00"))
    payment_totals = defaultdict(lambda: Decimal("0.00"))
    for row in order_items:
        item_totals[row["order_id"]] += Decimal(row["price"]) + Decimal(row["freight_value"])
    for row in payments:
        payment_totals[row["order_id"]] += Decimal(row["payment_value"])
    all_order_ids = set(item_totals) | set(payment_totals)
    results["orders_payment_mismatch"] = sum(
        1
        for order_id in all_order_ids
        if item_totals[order_id].quantize(Decimal("0.01")) != payment_totals[order_id].quantize(Decimal("0.01"))
    )

    geo_city_state = {(row["geolocation_city"], row["geolocation_state"]) for row in geolocation}
    results["customer_city_state_not_in_geo"] = sum(
        (row["customer_city"], row["customer_state"]) not in geo_city_state for row in customers
    )
    results["seller_city_state_not_in_geo"] = sum(
        (row["seller_city"], row["seller_state"]) not in geo_city_state for row in sellers
    )

    for key in sorted(results):
        print(f"{key}={results[key]}")


if __name__ == "__main__":
    main()