# Metric Definitions and Interpretation

**Dataset:** `data-to-insights.ecommerce.all_sessions`  
**Platform:** Google BigQuery (Standard SQL)

This document describes the calculations used in the e-commerce analysis and how to interpret their results.

## Revenue by city

**SQL measure:** `SUM(totalTransactionRevenue) / 1000000`

Revenue values are grouped by `city` and ranked from highest to lowest. The charts show the top ten cities; the SQL query includes all available cities.

Because the source table can contain multiple records per visit, the measure represents a sum across source rows. Revenue units and repeated values should be checked before treating these totals as final transaction-level revenue.

## Cart activity without checkout

**SQL method:** Group by `fullVisitorId`, count distinct `visitId` values, and filter for cart activity (`eCommerceAction_type = '3'`) without checkout activity (`eCommerceAction_type = '5'`).

The output lists visitors matching the query's criteria. It does **not** calculate an overall cart-abandonment rate.

The export contained **28,149 visitor records**. Only the aggregate count and a chart with anonymized labels are included publicly; visitor identifiers are not shared.

## Transaction-session percentage

**SQL measure:** Distinct `visitId` values satisfying `transactions = 1` and `eCommerceAction_type = '6'`, divided by all distinct `visitId` values, multiplied by 100.

The query returned **4.48%**.

This percentage uses `visitId` as its distinct-count key. If the identifier is reused across visitors, a composite visitor-session identifier would change the count. Sessions containing more than one transaction may also fall outside the query's current condition.

## Traffic-channel conversion

**SQL measures:**
- `SUM(transactions)` by `channelGrouping`
- `COUNT(DISTINCT visitId)` by channel
- Percentage of qualifying transaction visits under the same conditional definition as above

Selected output percentages:

| Channel | Calculated rate |
| --- | ---: |
| Referral | 11.89% |
| Direct | 6.54% |
| Organic Search | 1.56% |

These are the rates produced by the supplied query. Repeated transaction values across source rows and the distinct-session key can affect their interpretation.

## Top products by reported units sold

**SQL measure:** `SUM(productQuantity)` by `v2ProductName`, filtered to `eCommerceAction_type = '6'`, sorted in descending order, limited to ten products.

The top two products in the exported results were:

| Product | Reported units |
| --- | ---: |
| Maze Pen | 17,983 |
| Google 22 oz Water Bottle | 16,221 |

The calculation sums product quantities from rows matching the purchase-action filter. Counts depend on the source record structure and whether quantities repeat across rows.

## Data and chart conventions

The repository provides SQL scripts, exported result summaries, and SVG charts built from those results. The analyses are exploratory and the figures reflect the calculations in the supplied SQL, rather than independently reconciled financial or conversion KPIs. Session and transaction definitions should be considered when comparing these results with other reports.
