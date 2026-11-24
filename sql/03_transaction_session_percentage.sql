-- Original screenshot output: 4.48.
-- Validate whether visitId is unique across visitors before treating this as a session KPI.
SELECT
    ROUND(
        COUNT(DISTINCT CASE
            WHEN transactions = 1 AND eCommerceAction_type = '6'
            THEN visitId
        END) / COUNT(DISTINCT visitId) * 100,
        2
    ) AS transaction_session_percentage
FROM `data-to-insights.ecommerce.all_sessions`;
