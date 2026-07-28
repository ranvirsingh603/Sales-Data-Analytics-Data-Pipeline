# SALES DATA ANALYTICS & DATA PIPELINE

This project is documented in Overview, Stages, and Conclusion, following the exact order in which I completed it. Below is the complete workflow of the project:

![Project Flow](Screenshots%20&%20Images/Project%20Flow.png)

---

## OVERVIEW
Our CRR Sales ERP system is built inside Google Sheets. Because the raw data is spread across multiple sheets, it was very difficult to get a clear overview of each customer and make quick business decisions. To solve this, I decided to build a dedicated **"CRR Sales Overview Dashboard."**

To build this dashboard, the raw data needed to be reformatted, cleaned, and processed into new calculated tables. However, these heavy operations could not be done directly inside Google Sheets. The sheet was already running at full capacity—handling daily workflows with heavy formulas, Google Forms, and Apps Scripts—and adding extra calculations would risk crashing or slowing down the ERP system.

### Why Power BI over Looker Studio?
While Looker Studio works well for simple, single-table reports, its data blending feature struggles when connecting multiple tables using complex relationships. Power BI was selected because its dedicated Tabular Modeling Engine (DAX and Relationship Manager) easily handles complex, multi-table relationships while keeping calculations accurate.

### The Solution: Google BigQuery
Power BI also lacks a direct connector for live Google Sheets. Google BigQuery solved both problems at once: it handled all the heavy data transformations off the spreadsheet and acted as a high-performance bridge between Google Sheets and Power BI.

Below is the step-by-step workflow of how the project was completed:

1. **Creating Sales Metrics**
2. **Input ERP Raw Data**
3. **BigQuery Connection & Data Reformatting**
4. **Final Output Data for Dashboard**
5. **Importing Data to Power BI**
6. **Dashboard Creation**
---

## STAGE 1: CREATING SALES METRICS

Before jumping into Google Sheets or writing SQL in BigQuery, it was essential to define key sales metrics that deliver actionable insights for the business. Defining these metrics upfront guided the data transformation process and determined what calculated columns and aggregate tables needed to be built.

Below are the core sales metrics designed for each client:

* **Conversion Ratio (Inquiry to Order):** Total Orders divided by Total Inquiries per client, measuring overall sales efficiency.
* **Total Inquiries:** The total count of inquiries received per client.
* **No. of Orders:** The total count of successfully converted orders per client.
* **Total Order Value:** The total monetary value (sum) of all orders placed per client.
* **Max Inquiries Before Yes:** The highest number of inquiries submitted by a client before converting their first order.
* **Average Days from Inquiry to Order:** The average time (in days) it takes for a client to convert from an initial inquiry into a confirmed order.
* **Inquiries Closed with No:** The count of inquiries that were officially closed without securing an order.
* **Average No. of Follow-ups:** The average number of follow-ups required per inquiry for a client.
* **Max No. of Follow-ups:** The maximum number of follow-ups recorded on a single inquiry for a client.
* **Closed Inquiries:** The total number of completed inquiries (both successful orders and lost deals).
* **Pending Inquiries:** The number of active inquiries currently awaiting client response or closure.
* **No. of Follow-ups per Inquiry:** The total count of follow-ups conducted for active/pending inquiries per client.

---

## STAGE 2: INPUT ERP RAW DATA

The raw input data comes from a custom Google Sheets ERP system. The system runs on multiple Google Forms, Apps Scripts, complex formulas, and conditional formatting spread across several sheets. For daily operations, the ERP works smoothly and handles the company's workflow perfectly.

The specific data used for this project is the sales dataset, which is split across multiple sheet tabs following the operational workflow from **Inquiry Received** to **Accepting Purchase Order**

Because clients move step-by-step through these separate sheets, a single client has records spread across multiple tabs. While this layout is ideal for daily business operations, it is completely unformatted and unoptimized for data analysis and dashboard creation.

### ERP System Screenshots

#### ERP System Overview 1
![ERP System Overview 1](Screenshots%20&%20Images/ERP%20System%20Screenshot%201)

#### ERP System Overview 2
![ERP System Overview 2](Screenshots%20&%20Images/ERP%20System%20Screenshot%202)

---

## STAGE 3: BIGQUERY CONNECTION & DATA REFORMATTING

Since we cannot perform heavy data transformations inside Google Sheets and Power BI lacks a direct connector for Google Sheets, Google BigQuery was chosen to solve both challenges.

BigQuery serves two main purposes in this pipeline:
1. **High-Performance Data Engine:** It transforms wide, pivoted data spread across multiple sheet tabs into a clean, unpivoted vertical format using advanced SQL techniques.
2. **Automated Cloud Bridge:** It connects Google Sheets directly to Power BI with automatic sync enabled. Whenever new entries are added or updated in Google Sheets, the data updates automatically inside BigQuery.

### SQL Transformation Code
Click below to open the complete SQL file in the repository:

📄 [Raw to vertical Query](SQL/01_raw_to_vertical.sql)

---

## STAGE 4: DATA CLEANING & FINAL TABLE CREATION

Although the raw ERP data was successfully unpivoted in the previous stage, it was still uncleaned transactional data. Before feeding it into Power BI, it required thorough cleaning and processing—fixing inconsistent data types, eliminating duplicate records, and enforcing standard formatting.

After cleaning, the next step was to build dedicated summary tables tailored specifically to our sales metrics. By offloading all heavy SQL aggregations to BigQuery, we transformed the raw data into 5 optimized, production-ready tables for dashboard creation:

---

### 1. CRR Sales Final Table
The core cleaned, unpivoted fact table containing complete timeline and status tracking.
* **Columns:** `Client No.`, `Inq. No.`, `Planned Time`, `Actual Time`, `Status`, `Step`

---

### 2. Client Conversion Ratio, Avg. Inquiries Before Yes & Total Order Value
Aggregates sales performance and conversion efficiency per client.
* **Columns:** `Client No.`, `Conversion Ratio (Inquiry to Order)`, `Maximum Inquiries before Yes`, `Total Order value`
* 📄 **View Query:** [Click here](SQL/02_conversion_ratio.sql)

---

### 3. Client Closed vs. Pending Inquiries
Tracks the current inquiry status breakdown per client.
* **Columns:** `Client No.`, `Closed Inquiries`, `Pending Inquiries`
* 📄 **View Query:** [Click here](SQL/03_closed_vs_pending.sql)

---

### 4. Inquiry Follow-ups Breakdown (Current, Average & Max)
Measures the effort and touchpoints required per inquiry and per client.
* **Columns:** `Client No.`, `Inq. No.`, `No. of Inquiry Followups`, `Average Followups by Client`, `Maximum Followups by Client`
* 📄 **View Query:** [Click here](SQL/04_followups_breakdown.sql)

---

### 5. Average Inquiry to Order Days
Calculates the average velocity from initial client contact to confirmed sale.
* **Columns:** `Client No.`, `Average Days from Inquiry to Order closure`
* 📄 **View Query:** [Click here](SQL/05_avg_inquiry_days.sql)

---
