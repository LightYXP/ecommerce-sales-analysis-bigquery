-- Share of distinct visitId values matching the query's transaction criteria.
-- Reported output: 4.48%. Validate the session key and transaction definition.
SELECT
    ROUND(
        COUNT(DISTINCT CASE
            WHEN transactions = 1 AND eCommerceAction_type = '6'
            THEN visitId
        END) / COUNT(DISTINCT visitId) * 100,
        2
    ) AS transaction_session_percentage
FROM `data-to-insights.ecommerce.all_sessions`;
