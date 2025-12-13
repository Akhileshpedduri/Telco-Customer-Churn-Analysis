-- ===============================================================
-- Telco Customer Churn Analysis
-- Query 02: Churn by Contract Type
-- Determines how contract type affects churn rate
-- Author: Akhilesh Pedduri
-- ===============================================================

SELECT
    s.Contract,
    COUNT(b.customerID) AS totalcustomers,
    SUM(CASE WHEN b.churn = 'Yes' THEN 1 ELSE 0 END) AS totalchurncustomers,
    CAST(
        SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(b.customerID)
        AS DECIMAL(10,2)
    ) AS churnratepercent
FROM dbo.Billing_and_Churn AS b
INNER JOIN dbo.Services AS s
    ON b.customerID = s.customerID
GROUP BY s.Contract
ORDER BY churnratepercent DESC;
