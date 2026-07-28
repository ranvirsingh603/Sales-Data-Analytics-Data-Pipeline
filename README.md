# SALES DATA ANALYTICS & DATA PIPELINE

This project is documented in Overview, Stages, and Conclusion, following the exact order in which I completed it. Below is the complete workflow of the project:

![Project Flow](images/project_flow.png)

---

## OVERVIEW

[Insert your Overview text here: Google Sheets ERP operating at capacity, the need for a Sales Overview dashboard, why Power BI was chosen over Looker Studio, and using BigQuery as the bridge.]

---

## STAGE 1: RAW DATA LAYER & SOURCE ANALYSIS

[Insert your Stage 1 text here: Custom ERP in Google Sheets, Forms, Apps Scripts, and the operational limits of live sheets.]

![Stage 1 Raw Data Setup](images/stage1_raw_data.png)

---

## STAGE 2: BIGQUERY CONNECTION & DATA STRUCTURING

[Insert your Stage 2 text here: Connecting Sheets to BigQuery, unpivoting wide horizontal data into vertical relational formats, and automatic syncing.]

![Stage 2 BigQuery Bridge](images/stage2_bigquery.png)

🔗 **View SQL Code:** [01_raw_to_vertical.sql](sql/01_raw_to_vertical.sql)

---

## STAGE 3: DATA TRANSFORMATION & CREATING FINAL TABLES

[Insert your Stage 3 text here: Cleaning data, handling duplicates, calculating metrics using SQL, and materializing into 5 scheduled tables using `CREATE OR REPLACE TABLE`.]

![Stage 3 Data Transformation](images/stage3_sql_transform.png)

🔗 **View SQL Queries:** [02_conversion_ratio.sql](sql/02_conversion_ratio.sql) | [03_final_5_tables.sql](sql/03_final_5_tables.sql)

---

## STAGE 4: LOADING DATA TO POWER BI & PERFORMANCE OPTIMIZATION

[Insert your Stage 4 text here: Troubleshooting table visibility in Power BI, diagnosing DirectQuery latency (2–4 min wait times), and switching to Import Mode for instant performance.]

![Stage 4 Power BI Configuration](images/stage4_powerbi_load.png)

---

## STAGE 5: POWER BI DASHBOARD (CRR SALES OVERVIEW)

[Insert your Stage 5 text here: Metrics designed like Conversion Ratio, Max Inquiries Before Order, Average Follow-ups per Client, and Pipeline Status.]

![Stage 5 Dashboard Preview](images/stage5_dashboard.png)

---

## CONCLUSION

[Insert your Conclusion text here: Skills enhanced (problem-solving, complex SQL queries, performance tuning), project presentation learnings, and next steps for Phase 2.]
