-- ===============================================================
-- Telco Customer Churn Analysis
-- Query 04: Revenue Loss Due to Churn
-- Calculates total Monthly Recurring Revenue lost from churned users
-- Author: Akhilesh Pedduri
-- ===============================================================

SELECT
    CAST(
        SUM(
            CASE WHEN b.Churn = 'Yes' 
                THEN b.MonthlyCharges
                ELSE 0 
            END
        ) AS DECIMAL(10,2)
    ) AS Lost_Recurring_Monthly_Revenue
FROM dbo.Billing_and_Churn AS b;
