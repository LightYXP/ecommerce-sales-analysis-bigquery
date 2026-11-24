-- Revenue distribution by city using the dataset's reported transaction revenue.
-- Validate monetary units and duplicate revenue values at the source-row grain.
SELECT
    city,
    SUM(totalTransactionRevenue) / 1000000 AS total_revenue
FROM `data-to-insights.ecommerce.all_sessions`
WHERE city != 'not available in demo dataset'
GROUP BY city
ORDER BY total_revenue DESC;
