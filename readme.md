# SQL-Based Product Sales Analysis

**Level 2 – Data Analytics Task**

---

## 📌 Introduction

This project presents a structured SQL-based analysis of product sales using the Chinook SQLite database. The objective is to transform raw transactional data into meaningful business insights through relational joins, aggregations, and analytical window functions.

Rather than simply retrieving data, this analysis focuses on answering practical business questions related to revenue performance, regional sales distribution, and product-level demand patterns.

The project demonstrates applied SQL proficiency in a real-world retail simulation environment.

---

## 🗂 Dataset Overview

**Database:** Chinook SQLite Database

The Chinook database simulates a digital media store and contains multiple related tables, including:

- Customers
- Invoices
- InvoiceLine
- Tracks
- Albums
- Artists
- Employee
- Genre
- Invoice
- Invoiceline
- Media type
- Playlist
- Playlist track
- Track

The relational structure enables multi-table joins to derive aggregated and segmented business insights.

---

## 🛠 Tools & Technologies

- SQL (SQLite)
- Visual Studio Code
- SQLite Extension
- Markdown Documentation
- CSV Export for Result Storage

---

## 🎯 Business Objectives

The analysis addresses the following key questions:

1. What are the top-selling tracks by revenue?
2. Which countries generate the highest total revenue?
3. How does revenue trend on a monthly basis?
4. What are the top-performing tracks within each country?

---

## 📊 Analytical Approach

### 1️⃣ Top-Selling Tracks

Revenue was calculated by aggregating unit price and quantity sold at the track level.  
JOIN operations were used to connect transactional data (`InvoiceLine`) with product metadata (`Track`).

**SQL Concepts Applied:**

- INNER JOIN
- GROUP BY
- SUM()
- ORDER BY
- LIMIT

---

### 2️⃣ Revenue by Region

Total revenue was aggregated at the country level by joining customer and invoice data.  
This enables geographic performance analysis.

**SQL Concepts Applied:**

- JOIN (Invoice ↔ Customer)
- Aggregation
- Grouped Reporting

---

### 3️⃣ Monthly Performance Analysis

Revenue trends were evaluated by extracting year-month values from invoice dates and grouping transactions accordingly.

**SQL Concepts Applied:**

- Date Formatting (strftime)
- Aggregation
- Time-Series Grouping

---

### 4️⃣ Top Tracks per Country (Window Function)

A ranking analysis was performed to identify the top 5 tracks within each country.  
This was achieved using a window function to partition results by country and rank tracks based on total quantity sold.

**SQL Concept Applied:**

- `RANK() OVER (PARTITION BY Country ORDER BY Total_Sold DESC)`

This approach enables localized performance analysis without collapsing global rankings.

---

---

## 🧠 Key Insights

- Revenue distribution is uneven across regions, with certain countries contributing disproportionately to total sales.
- A small subset of tracks accounts for a significant share of total revenue.
- Monthly performance trends indicate consistent transaction flow with identifiable peaks.
- Customer preferences vary by region, reinforcing the importance of localized marketing strategies.

---

## 💼 Skills Demonstrated

- Relational database querying
- Multi-table JOIN operations
- Aggregation and grouped reporting
- Time-based revenue analysis
- Window functions for segmented ranking
- Structured documentation and project organization

---

## ✅ Conclusion

This project illustrates the practical application of SQL in extracting actionable business insights from relational databases. By combining structured query techniques with analytical reasoning, the analysis moves beyond data retrieval to performance evaluation and decision-support insights.

The project reflects proficiency in core SQL concepts and demonstrates readiness for data analytics and business intelligence roles requiring structured database analysis.

---
