-- ===============================================================
-- Telco Customer Churn Analysis
-- Query 03: Multi-Dimensional Segmentation (CTEs)
-- Segments customers by Monthly Charges, Tenure, and Tech Support
-- Author: Akhilesh Pedduri
-- ===============================================================

-- STEP 1: BASE DATA CTE
;WITH CTE_Base_Data AS
(
    SELECT
        B.customerID,
        B.MonthlyCharges,
        B.Churn,
        S.tenure,
        S.TechSupport
    FROM Billing_and_Churn AS B
    INNER JOIN Services AS S ON B.customerID = S.customerID
)

-- STEP 2: CHARGE SEGMENTATION
, CTE_Charge_Segmentation AS
(
    SELECT
        customerID,
        CASE 
            WHEN MonthlyCharges < 40 THEN '1. Low (< $40)'
            WHEN MonthlyCharges BETWEEN 40 AND 70 THEN '2. Medium ($40 - $70)'
            ELSE '3. High (> $70)'
        END AS ChargeRange,
        CASE 
            WHEN MonthlyCharges < 40 THEN 3
            WHEN MonthlyCharges BETWEEN 40 AND 70 THEN 2
            ELSE 1
        END AS ChargeSortRank
    FROM CTE_Base_Data
)

-- STEP 3: TENURE SEGMENTATION
, CTE_Tenure_Segmentation AS
(
    SELECT
        customerID,
        CASE 
            WHEN tenure <= 12 THEN '1. 0-1 Year (High Risk)'
            WHEN tenure <= 24 THEN '2. 1-2 Years'
            WHEN tenure <= 48 THEN '3. 2-4 Years'
            ELSE '4. 4+ Years (Loyal)'
        END AS TenureGroup,
        CASE 
            WHEN tenure <= 12 THEN 1
            WHEN tenure <= 24 THEN 2
            WHEN tenure <= 48 THEN 3
            ELSE 4
        END AS TenureSortRank
    FROM CTE_Base_Data
)

-- STEP 4: TECH SUPPORT SEGMENTATION
, CTE_TechSupport_Segmentation AS
(
    SELECT
        customerID,
        TechSupport AS TechSupportGroup,
        CASE TechSupport
            WHEN 'Yes' THEN 1
            WHEN 'No' THEN 2
            ELSE 3
        END AS TechSupportSortRank
    FROM CTE_Base_Data
)

-- FINAL AGGREGATION
SELECT
    CS.ChargeRange,
    TS.TenureGroup,
    TSUP.TechSupportGroup,
    COUNT(B.customerID) AS Total_Customers,
    SUM(CASE WHEN B.Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(
        SUM(CASE WHEN B.Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(B.customerID)
        AS DECIMAL(10, 2)
    ) AS Churn_Rate_Percent
FROM CTE_Base_Data AS B
INNER JOIN CTE_Charge_Segmentation AS CS ON B.customerID = CS.customerID
INNER JOIN CTE_Tenure_Segmentation AS TS ON B.customerID = TS.customerID
INNER JOIN CTE_TechSupport_Segmentation AS TSUP ON B.customerID = TSUP.customerID
GROUP BY
    CS.ChargeRange,
    TS.TenureGroup,
    TSUP.TechSupportGroup,
    CS.ChargeSortRank,
    TS.TenureSortRank,
    TSUP.TechSupportSortRank
ORDER BY
    CS.ChargeSortRank ASC,
    TS.TenureSortRank ASC,
    TSUP.TechSupportSortRank ASC;
