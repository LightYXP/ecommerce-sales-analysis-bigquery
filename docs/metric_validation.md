# Metric definitions and validation

This document describes the current SQL metrics and the checks needed before interpreting them as final business KPIs. The SQL files retain the original exploratory calculations.

## 1. Revenue by city

**Current expression:** `SUM(totalTransactionRevenue) / 1000000`

- Confirm the field's original monetary unit and currency.
- Check whether session-level revenue repeats across multiple source rows, which could inflate a row-level sum.
- Verify whether the aggregation should occur at a session or transaction grain before grouping by city.
- Scientific notation in BigQuery is a display convention, not a calculation error.

## 2. Cart activity without checkout

**Current method:** Counts distinct `visitId` values by `fullVisitorId` and filters visitors with action `'3'` but no action `'5'`.

- Confirm the meaning of the `eCommerceAction_type` values.
- Verify whether `visitId` uniquely identifies a session or must be combined with `fullVisitorId`.
- This is a visitor-level list of qualifying activity, not a confirmed abandoned-cart percentage.
- Only the aggregate result (**28,149 qualifying visitor records**) is public; the visitor-ID export is excluded.

## 3. Transaction-session percentage

**Current method:** Distinct `visitId` values with `transactions = 1` and `eCommerceAction_type = '6'`, divided by all distinct `visitId` values.

- The query output is **4.48%** under this definition.
- Validate session uniqueness and whether sessions with multiple transactions should count.
- Verify that action type `'6'` represents the intended purchase event.
- Compare against a session-level count before treating this as a standard conversion rate.

## 4. Traffic-channel conversion

**Current method:** Groups by `channelGrouping`, sums `transactions`, and computes a distinct-`visitId` percentage.

- Repeated transaction values on multiple product/event rows may overstate `SUM(transactions)`.
- Use a consistent visitor-session key when validating conversion.
- Confirm attribution and channel grouping semantics.
- The exported rates are exploratory: Referral **11.89%**, Direct **6.54%**, Organic Search **1.56%**.

## 5. Top products by units sold

**Current method:** `SUM(productQuantity)` grouped by `v2ProductName` for rows with action type `'6'`.

- Confirm that quantity values are not duplicated across repeated rows.
- Validate that the action type corresponds to the desired completed-purchase definition.
- Exported leaders include Maze Pen (**17,983**) and Google 22 oz Water Bottle (**16,221**) reported units.

## Validation status

The provided SQL scripts and exported results have been documented, but the queries were not independently rerun or reconciled against source-table grain during repository preparation. The visualizations show the exported outputs rather than validated financial or conversion KPIs.

**Next technical improvement:** Build a session-level base table using an appropriate composite session identifier, validate source field definitions, and recompute the revenue and conversion measures before updating the charts.
