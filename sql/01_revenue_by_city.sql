-- Question: Which cities generated the highest reported revenue?
-- Transcribed from a BigQuery screenshot; not independently rerun.
-- Revenue calculation may need deduplication at the transaction grain.
SELECT
    city,
    SUM(totalTransactionRevenue) / 1000000 AS total_revenue
FROM `data-to-insights.ecommerce.all_sessions`
WHERE city != 'not available in demo dataset'
GROUP BY city
ORDER BY total_revenue DESC;
