-- Rank products by the reported quantities on purchase-action rows.
-- Check product-quantity grain before interpreting these as final sales units.
SELECT
    v2ProductName,
    SUM(productQuantity) AS Total_unit_sold
FROM `data-to-insights.ecommerce.all_sessions`
WHERE eCommerceAction_type = '6'
GROUP BY v2ProductName
ORDER BY Total_unit_sold DESC
LIMIT 10;
