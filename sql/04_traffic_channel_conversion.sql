-- Traffic channel breakdown as shown in screenshot.
-- SUM(transactions) may overcount transactions if repeated across multiple source rows.
SELECT
    channelGrouping,
    SUM(transactions) AS Total_transaction,
    COUNT(DISTINCT visitId) AS total_visits,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN transactions = 1 AND eCommerceAction_type = '6'
            THEN visitId
        END) / COUNT(DISTINCT visitId) * 100,
        2
    ) AS conversion_rate
FROM `data-to-insights.ecommerce.all_sessions`
GROUP BY channelGrouping;
