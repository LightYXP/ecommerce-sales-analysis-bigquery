-- Top 10 products by reported units sold.
-- Transcribed from the supplied BigQuery SQL editor screenshot.
-- Validate productQuantity grain to avoid potential duplicate counting.
SELECT
    v2ProductName,
    SUM(productQuantity) AS Total_unit_sold
FROM `data-to-insights.ecommerce.all_sessions`
WHERE eCommerceAction_type = '6'
GROUP BY v2ProductName
ORDER BY Total_unit_sold DESC
LIMIT 10;
