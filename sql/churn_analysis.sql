-- Customer Churn Analysis

-- 1. Overall churn rate
SELECT
    COUNT(*) AS customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn;

-- 2. Churn rate by contract type
SELECT
    contract_type,
    COUNT(*) AS customers,
    ROUND(100.0 * AVG(CASE WHEN churned = 'Yes' THEN 1.0 ELSE 0 END), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY contract_type
ORDER BY churn_rate_pct DESC;

-- 3. Churn rate by tenure group
SELECT
    CASE
        WHEN tenure_months <= 12 THEN '0-12 months'
        WHEN tenure_months <= 24 THEN '13-24 months'
        WHEN tenure_months <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    COUNT(*) AS customers,
    ROUND(100.0 * AVG(CASE WHEN churned = 'Yes' THEN 1.0 ELSE 0 END), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY 1
ORDER BY 1;

-- 4. Support-ticket comparison
SELECT
    CASE WHEN support_tickets >= 4 THEN '4+ tickets' ELSE '0-3 tickets' END AS support_group,
    COUNT(*) AS customers,
    ROUND(100.0 * AVG(CASE WHEN churned = 'Yes' THEN 1.0 ELSE 0 END), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY 1
ORDER BY churn_rate_pct DESC;
