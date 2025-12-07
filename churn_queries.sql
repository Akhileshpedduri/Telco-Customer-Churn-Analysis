--1 OVERALL CHURN RATE
--calculate the total customer count, the number of customers  who churned, and the overall churn percentage.

select
	count(B.customerid) as totalcustomercount,
	sum(case when B.Churn = 'Yes' then 1
		else 0
	end) AS churnedcustomers,
	CAST(sum(case when B.Churn = 'Yes' then 1 
		else 0 end) * 100.0 / count(B.customerid) as decimal(10,2)) as overallchurnrate
from Billing_and_Churn as B;

--2 CHURN BY CONTRACT TYPE
--Determine how contract type affects churn. This is a critical insight often highlighting Month-to-month contracts as a major churn driver.

select
	s.Contract,
	count(b.customerID) as totalcustomers,
	sum(case when churn ='yes' then 1
		else 0
	end) as totalchurncustomers,
	cast(sum(case when churn ='yes' then 1
		else 0
	end) *100.0 / count(b.customerID) as decimal(10,2)) as churnratepercent
FROM dbo.Billing_and_Churn as b
INNER join dbo.Services as s
on b.customerID = s.customerID
group by s.Contract
order by churnratepercent desc;

-- 3 churn by monthly charges (high paying customers churn more)
--Segment customers by their monthly spending and calculate the churn rate for each segment. This addresses the hypothesis that high-paying customers may churn more.

-- STEP 1: BASE DATA - Collects the raw customer data needed for segmentations
;WITH CTE_Base_Data AS
(
    SELECT
        B.customerID,
        B.MonthlyCharges,
        B.Churn,
        S.tenure,
        S.TechSupport -- ADDED: TechSupport for 3rd dimension analysis
    FROM
        Billing_and_Churn AS B
    INNER JOIN
        Services AS S ON B.customerID = S.customerID
)
-- STEP 2: SEGMENT BY MONTHLY CHARGES (Customer-level output)
, CTE_Charge_Segmentation AS
(
    SELECT
        customerID,
        -- Monthly Charge Segmentation Label
        CASE 
            WHEN MonthlyCharges < 40 THEN '1. Low (< $40)'
            WHEN MonthlyCharges BETWEEN 40 AND 70 THEN '2. Medium ($40 - $70)'
            ELSE '3. High (> $70)'
        END AS ChargeRange,
        
        -- Charge Sort Rank (1=High, 3=Low)
        CASE 
            WHEN MonthlyCharges < 40 THEN 3
            WHEN MonthlyCharges BETWEEN 40 AND 70 THEN 2
            ELSE 1
        END AS ChargeSortRank
    FROM
        CTE_Base_Data
)
-- STEP 3: SEGMENT BY TENURE (Customer-level output)
, CTE_Tenure_Segmentation AS
(
    SELECT
        customerID,
        -- Tenure Segmentation Label
        CASE 
            WHEN tenure <= 12 THEN '1. 0-1 Year (High Risk)'
            WHEN tenure <= 24 THEN '2. 1-2 Years'
            WHEN tenure <= 48 THEN '3. 2-4 Years'
            ELSE '4. 4+ Years (Loyal)'
        END AS TenureGroup,
        
        -- Tenure Sort Rank (1=New, 4=Loyal)
        CASE 
            WHEN tenure <= 12 THEN 1
            WHEN tenure <= 24 THEN 2
            WHEN tenure <= 48 THEN 3
            ELSE 4
        END AS TenureSortRank
    FROM
        CTE_Base_Data
)
-- STEP 4: SEGMENT BY TECH SUPPORT (Customer-level output)
, CTE_TechSupport_Segmentation AS
(
    SELECT
        customerID,
        TechSupport AS TechSupportGroup,
        -- Tech Support Sort Rank (Yes = 1, No = 2, No Internet = 3)
        CASE TechSupport
            WHEN 'Yes' THEN 1
            WHEN 'No' THEN 2
            ELSE 3 -- 'No internet service'
        END AS TechSupportSortRank
    FROM
        CTE_Base_Data
)
-- MAIN QUERY: Joins the segmentations and performs the final aggregation (GROUP BY)
SELECT
    CS.ChargeRange,
    TS.TenureGroup,
    TSUP.TechSupportGroup, 
    
    COUNT(B.customerID) AS Total_Customers,
    SUM(CASE WHEN B.Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(
        (SUM(CASE WHEN B.Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) /
        COUNT(B.customerID)
    AS DECIMAL(10, 2)) AS Churn_Rate_Percent
    
FROM
    CTE_Base_Data AS B -- Start with the base data for core metrics (Churn)
INNER JOIN
    CTE_Charge_Segmentation AS CS
    ON B.customerID = CS.customerID
INNER JOIN
    CTE_Tenure_Segmentation AS TS
    ON B.customerID = TS.customerID
INNER JOIN
    CTE_TechSupport_Segmentation AS TSUP
    ON B.customerID = TSUP.customerID
    
GROUP BY
    CS.ChargeRange,
    TS.TenureGroup,
    TSUP.TechSupportGroup, 
    CS.ChargeSortRank,
    TS.TenureSortRank,
    TSUP.TechSupportSortRank 
    
ORDER BY
    CS.ChargeSortRank ASC,      -- Order by Charge: High to Low
    TS.TenureSortRank ASC,      -- Order by Tenure: New to Loyal
    TSUP.TechSupportSortRank ASC; -- Order by Tech Support: Yes to No

--5 REVENUE LOSS DUE TO CHURN
--Calculate the total monthly recurring revenue lost due to customers who have churned

SELECT
cast(sum(CASE 
	when b.Churn = 'Yes' then b.MonthlyCharges
	else 0
end) as decimal(10,2)) as Lost_Recurring_Monthly_Revenue 
FROM DBO.Billing_and_Churn as b;