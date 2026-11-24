-- Question: Which visitors had a cart action but no checkout action?
-- Visitor-level exploration, not a validated cart-abandonment rate.
SELECT
    fullVisitorId,
    COUNT(DISTINCT visitId) AS total_visits,
    COUNT(DISTINCT CASE WHEN eCommerceAction_type = '3' THEN visitId END) AS Cart,
    COUNT(DISTINCT CASE WHEN eCommerceAction_type = '5' THEN visitId END) AS checkout_visits
FROM `data-to-insights.ecommerce.all_sessions`
GROUP BY fullVisitorId
HAVING
    COUNT(DISTINCT CASE WHEN eCommerceAction_type = '3' THEN visitId END) > 0
    AND COUNT(DISTINCT CASE WHEN eCommerceAction_type = '5' THEN visitId END) = 0;
