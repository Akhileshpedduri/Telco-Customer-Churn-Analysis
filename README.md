# Customer Churn Analysis Using SQL & Power BI

An end-to-end data analytics project analyzing customer churn in a telecom company using SQL and Power BI.

## Business Problem
A telecom company is losing customers each month. The goal is to identify why customers churn, which segments are at highest risk, and recommend actions to reduce churn.

## Dataset
The dataset includes customer demographics, subscription details, monthly charges, tenure, contract type, payment method, and churn label (Yes/No).

## Tools
- **SQL (BigQuery/PostgreSQL/MySQL)** – Data cleaning, modeling, and analysis
- **Power BI** – Dashboards and visual analytics
- **Excel** – Basic dataset review
- **GitHub** – Version control

## Project Workflow
1. Data cleaning & transformation using SQL
2. Exploratory Data Analysis (churn rates, customer segments)
3. Feature creation (tenure group, charge group, senior citizen flag)
4. Power BI dashboard with key KPIs and visuals
5. Insights & recommendations

## Key Insights
- Month-to-month contract customers churn 3x more
- Customers using electronic cheques have the highest churn
- Tenure < 12 months is high risk
- Higher monthly charges strongly correlate with churn

## Recommendations
- Offer discounts to month-to-month customers
- Promote auto-pay options
- Improve service reliability for fiber-optic users
- Onboard new customers (<12 months) proactively

## Project Structure
customer-churn-analysis/
├── README.md
├── data/telecom_churn.csv
├── sql/cleaning.sql
├── sql/analysis.sql
├── powerbi/churn_dashboard.pbix
└── insights/final_report.pdf


