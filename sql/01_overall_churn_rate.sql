-- ===============================================================
-- Telco Customer Churn Analysis
-- Query 01: Overall Churn Rate
-- Calculates total customers, churned customers, and churn %
-- Author: Akhilesh Pedduri
-- ===============================================================

SELECT
    COUNT(B.customerid) AS totalcustomercount,
    SUM(CASE WHEN B.Churn = 'Yes' THEN 1 ELSE 0 END) AS churnedcustomers,
    CAST(
        SUM(CASE WHEN B.Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(B.customerid)
        AS DECIMAL(10,2)
    ) AS overallchurnrate
FROM Billing_and_Churn AS B;
