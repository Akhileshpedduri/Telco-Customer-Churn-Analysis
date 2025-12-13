📊 Telecom Customer Churn Analysis | SQL + Power BI
A full end-to-end data analytics project analyzing 7,043 telecom customers to understand why customers churn, measure revenue loss, and deliver strategic recommendations that reduce churn and improve profitability.

“End-to-end churn analytics project identifying high-risk customer segments and quantifying revenue loss using SQL + Power BI.”

🎯 1. Business Problem
Telecom companies invest heavily in customer acquisition, yet lose a significant portion of revenue to churn (customers leaving the service).
This project answers key business questions:
•	What is the overall churn rate?
•	Which customer segments are most at risk?
•	How do contract type, tenure, payments, and services influence churn?
•	How much Monthly Recurring Revenue (MRR) is being lost?
•	Which actions can reduce churn and improve retention?

🛠 2. Tools & Technologies Used
Tool	Purpose
SQL (SQL Server)	- Data cleaning, joins, aggregations, KPIs, segmentation using CTEs
Power BI -Data modeling, DAX measures, dashboards, insights & recommendations
Excel-Initial dataset review and quality checks
GitHub-Version control & project documentation

🧪 3. Data Preparation & Modeling
Step 1 — Data Cleaning
•	Standardized columns (Yes/No, contract names, payment methods)
•	Converted churn field to consistent format
•	Removed blank rows & duplicates
•	Checked distributions and outliers

Step 2 — SQL Analysis
The dataset was split into three relational tables:
•	Customers
•	Services
•	Billing_and_Churn

Key SQL concepts applied:
✔ CTEs (Common Table Expressions)
✔ INNER JOIN / LEFT JOIN
✔ GROUP BY aggregations
✔ CASE WHEN segmentation
✔ CAST() / CONVERT() for numeric KPIs
✔ Ranking logic for segmentation labels

Core SQL Outputs:
•	Overall churn rate
•	Churn by contract type
•	Churn by monthly charges
•	Churn by tenure group
•	Lost MRR analysis
•	Multi-dimensional segmentation (Tenure × Charges × Tech Support)

📈 4. Power BI Dashboard
The SQL output was loaded into Power BI, where the following objects were built:
•	KPI Cards
•	Total Customers
•	Total Churned Customers
•	Churn Rate %
•	Lost Monthly Recurring Revenue (MRR)
•	Visuals Created
•	Churn by Customer Tenure Lifecycle
•	Churn by Contract Type
•	Churn by Internet Service
•	Churn by Payment Method
•	Churn by Tech Support
•	Lost MRR by Monthly Charges
•	Retention value if churn reduced by 10%

DAX Measures
•	Key measures include:
•	Avg MRR (Churned) =
AVERAGEX (
FILTER (Billing_and_Churn, Billing_and_Churn[Churn] = "Yes"),Billing_and_Churn[MonthlyCharges]) Save_If_Churn_Drops_10% =[Lost MRR] * 0.10

🔍 5. Key Insights
📌 Overall Churn Rate: 26.54%
📌 Monthly Revenue Lost: ~$139K
📌 Savings if churn reduces by 10%: ~$13.9K per month

High-Risk Segments Identified
•	0–1 Year Tenure customers (highest churn risk)
•	Month-to-Month contract users (6.3× more likely to churn)
•	High-MRR customers (> $70/month) — majority of revenue loss
•	Customers without Tech Support
•	Electronic Check payment customers

These segments represent priority groups for retention.

🧭 6. Strategic Recommendations
✔ Convert Month-to-Month users to longer contracts with loyalty pricing
✔ Improve 0–90 day onboarding experience
✔ Offer Tech Support incentives (free trial or discounted plans)
✔ Promote Auto-Pay to reduce churn-prone Electronic Check payments
✔ Target high-value customers (> $70 MRR) with personalized retention workflows
✔ Create early-tenure engagement campaigns

➡️ Implementing these insights could reduce churn by 10% and retain ~$13.9K in monthly recurring revenue.

📂 7. Repository Structure
Telco-Customer-Churn-Analysis/
│
├── data/
│   └── telco_churn_cleaned.csv
│
├── sql/
│   ├── churn_analysis_queries.sql
│   └── segmentation_cte.sql
│
├── powerbi/
│   └── Telco_Churn_Dashboard.pbix
│
├── images/
│   ├── dashboard_overview.png
│   ├── churn_segmentation.png
│   ├── revenue_loss.png
│   └── recommendations_page.png
│
└── README.md

📎 8. Deliverables
✔ SQL scripts used for analysis
✔ Power BI interactive dashboard
✔ Visualized insights & recommendations
✔ End-to-end documentation (this README)

👤 9. Author
Akhilesh Pedduri
Data Analyst | SQL • Power BI • Python • Excel
📩 Feel free to reach out for collaboration or feedback!

