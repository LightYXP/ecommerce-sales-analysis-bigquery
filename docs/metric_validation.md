# Metric validation notes

These are review flags, **not corrections** already applied to the original SQL. The queries preserve the calculations visible in the supplied screenshots.

## Revenue by city
- `SUM(totalTransactionRevenue) / 1000000` is displayed in scientific notation for large values.
- Confirm the underlying revenue scale, currency, and whether repeated rows duplicate session-level revenue.
- Avoid describing this as validated city revenue until checking transaction or session grain.

## Cart without checkout
- Action codes `3` and `5` are used as cart and checkout markers.
- The SQL groups by `fullVisitorId`, not unique visitor-session combinations.
- It identifies visitors with cart activity but no checkout activity in the queried records; it does **not** calculate a confirmed abandonment rate.
- Raw visitor IDs should not be distributed with the project.

## Transaction-session percentage
- The screenshot result is `4.48`, based on distinct `visitId` values.
- Check whether `visitId` is unique across users; a composite visitor/session key may be needed.
- Check that `transactions = 1 AND eCommerceAction_type = '6'` captures all intended purchase sessions.

## Traffic channel conversion
- Screenshot results include Referral `11.89`, Direct `6.54`, and Organic Search `1.56`.
- Large `SUM(transactions)` values relative to distinct visits suggest possible overcounting on repeated source rows.
- Treat the percentages as unvalidated outputs under the existing query definition.

## Top 10 products
- A results screenshot was supplied, but not the original SQL. No SQL query was fabricated.
- Visible results include Maze Pen (17,983 units) and Google 22 oz Water Bottle (16,221 units).
- Verify how units sold were aggregated.

## Looker Studio
- The supplied images show BigQuery query editor/output, not Looker Studio report pages.
- Dashboard evidence has not yet been published.
