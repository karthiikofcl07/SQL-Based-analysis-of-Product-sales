<div align="center">

# SQL Sales Analytics Engine
### Transforming Raw Transactions into Strategic Business Intelligence

[![SQL](https://img.shields.io/badge/SQL-SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://www.sqlite.org/)
[![License](https://img.shields.io/badge/License-MIT-e94560?style=for-the-badge)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-00d4aa?style=for-the-badge)]()
[![Queries](https://img.shields.io/badge/Queries-4%20Analytical%20Modules-7c3aed?style=for-the-badge)]()
[![Window Functions](https://img.shields.io/badge/Window%20Functions-RANK%20%7C%20PARTITION-f59e0b?style=for-the-badge)]()
[![Dataset](https://img.shields.io/badge/Dataset-Chinook%20DB-0ea5e9?style=for-the-badge)]()
[![Tool](https://img.shields.io/badge/IDE-VS%20Code-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white)]()

<br/>

> **"Transforming 11 relational tables into actionable revenue intelligence — through precision SQL engineering"**

</div>

---

## 📌 Table of Contents

| # | Section |
|---|---------|
| 01 | [Project Overview](#-project-overview) |
| 02 | [Business Problem Statement](#-business-problem-statement) |
| 03 | [Database Architecture](#️-database-architecture) |
| 04 | [Analytical Modules](#-analytical-modules) |
| 05 | [Key Insights & Findings](#-key-insights--findings) |
| 06 | [SQL Concepts Demonstrated](#-sql-concepts-demonstrated) |
| 07 | [Project Structure](#-project-structure) |
| 08 | [Tools & Technologies](#️-tools--technologies) |
| 09 | [Skills Demonstrated](#-skills-demonstrated) |
| 10 | [Conclusion](#-conclusion) |

---

## 🎯 Project Overview

<table>
<tr>
<td width="60%">

This project delivers a **production-grade SQL analytics pipeline** built on the Chinook SQLite database — a realistic simulation of a digital media retail store. The analysis moves far beyond basic data retrieval, applying advanced SQL engineering to surface decision-ready intelligence across four critical business dimensions:

- 📦 **Product performance** at the track level
- 🌍 **Geographic revenue distribution** across global markets
- 📆 **Temporal trends** for forecasting and planning
- 🏆 **Localized rankings** using window functions

The result is a repeatable, scalable analytical framework that mirrors real-world BI workflows used in data-driven enterprises.

</td>
<td width="40%" align="center">

```
┌─────────────────────────┐
│   RAW TRANSACTIONS      │
│   (InvoiceLine data)    │
└────────────┬────────────┘
             │  SQL Pipeline
             ▼
┌─────────────────────────┐
│   MULTI-TABLE JOINS     │
│   + AGGREGATIONS        │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│  ACTIONABLE INSIGHTS    │
│  Revenue · Rank · Trend │
└─────────────────────────┘
```

</td>
</tr>
</table>

---

## 💼 Business Problem Statement

> *A digital media company needs to understand where revenue comes from, which products drive it, and how to replicate success across regions. Raw transactional data alone cannot answer these questions.*

This analysis was designed to answer **four high-priority business questions**:

```
╔══════════════════════════════════════════════════════════════════╗
║  Q1 ▸ Which tracks generate the most revenue?                   ║
║  Q2 ▸ Which countries are our highest-value markets?            ║
║  Q3 ▸ How does monthly revenue trend over time?                 ║
║  Q4 ▸ What tracks dominate sales within each country?           ║
╚══════════════════════════════════════════════════════════════════╝
```

Each question maps directly to a standalone SQL module, enabling modular reuse and independent stakeholder reporting.

---

## 🗄️ Database Architecture

**Dataset:** [Chinook SQLite Database](https://github.com/lerocha/chinook-database) — an industry-standard practice database modelling a digital music retailer with 11 interconnected tables.

```
                        ┌──────────────┐
                        │   Artist     │
                        └──────┬───────┘
                               │ 1:N
                        ┌──────▼───────┐
                        │    Album     │
                        └──────┬───────┘
                               │ 1:N
              ┌────────────────▼──────────────────┐
              │              Track                │
              │  TrackId · Name · UnitPrice · ...  │
              └────────────────┬──────────────────┘
                               │ 1:N
              ┌────────────────▼──────────────────┐
              │           InvoiceLine             │  ◄── Core transaction table
              │  InvoiceLineId · Quantity · Price  │
              └────────────────┬──────────────────┘
                               │ N:1
              ┌────────────────▼──────────────────┐
              │             Invoice               │
              │  InvoiceId · Date · Total · ...    │
              └────────────────┬──────────────────┘
                               │ N:1
              ┌────────────────▼──────────────────┐
              │            Customer               │
              │  CustomerId · Country · City · ... │
              └───────────────────────────────────┘
```

**Full Schema Inventory:**

| Table | Description | Role in Analysis |
|-------|-------------|-----------------|
| `Track` | Product catalog with pricing | Revenue calculation |
| `InvoiceLine` | Line-level sales transactions | Core fact table |
| `Invoice` | Invoice headers with dates | Time-series analysis |
| `Customer` | Customer geography | Regional segmentation |
| `Album` | Album-track relationships | Product metadata |
| `Artist` | Artist-album relationships | Product metadata |
| `Genre` | Music genre classification | Product grouping |
| `MediaType` | Media format data | Product attributes |
| `Employee` | Sales rep data | (Available for extension) |
| `Playlist` | Curated track lists | (Available for extension) |
| `PlaylistTrack` | Playlist-track mappings | (Available for extension) |

---

## 📊 Analytical Modules

### Module 1 — Top-Selling Tracks by Revenue

**Business Question:** *Which individual tracks generate the most revenue across all transactions?*

```sql
SELECT
    t.Name                           AS Track_Name,
    SUM(il.UnitPrice * il.Quantity)  AS Total_Revenue
FROM InvoiceLine il
INNER JOIN Track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY Total_Revenue DESC
LIMIT 10;
```

**Techniques Applied:**
- `INNER JOIN` across `InvoiceLine` and `Track`
- Revenue computed as `UnitPrice × Quantity` at line level
- `GROUP BY` for track-level aggregation
- `ORDER BY ... DESC` with `LIMIT` for top-N reporting

---

### Module 2 — Revenue Distribution by Country

**Business Question:** *Which countries represent our highest-value geographic markets?*

```sql
SELECT
    c.Country,
    ROUND(SUM(i.Total), 2) AS Total_Revenue,
    COUNT(DISTINCT i.InvoiceId) AS Total_Orders
FROM Invoice i
INNER JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY c.Country
ORDER BY Total_Revenue DESC;
```

**Techniques Applied:**
- Multi-table `JOIN` linking invoices to customer geography
- `SUM()` for revenue aggregation at country level
- `COUNT(DISTINCT)` for order volume alongside revenue
- Enables market prioritisation and regional resource allocation

---

### Module 3 — Monthly Revenue Trend Analysis

**Business Question:** *How does revenue flow change month-over-month?*

```sql
SELECT
    strftime('%Y-%m', InvoiceDate) AS Month,
    ROUND(SUM(Total), 2)           AS Monthly_Revenue,
    COUNT(InvoiceId)               AS Transaction_Count
FROM Invoice
GROUP BY Month
ORDER BY Month ASC;
```

**Techniques Applied:**
- `strftime()` for date-part extraction and period grouping
- Time-series aggregation for trend identification
- Dual metrics: revenue *and* transaction volume per period
- Powers forecasting models and seasonal planning

---

### Module 4 — Top Tracks per Country (Window Function)

**Business Question:** *What are the top 5 best-selling tracks within each individual country?*

```sql
WITH Country_Track_Sales AS (
    SELECT
        c.Country,
        t.Name                        AS Track_Name,
        SUM(il.Quantity)              AS Total_Sold,
        RANK() OVER (
            PARTITION BY c.Country
            ORDER BY SUM(il.Quantity) DESC
        )                             AS Country_Rank
    FROM InvoiceLine il
    INNER JOIN Invoice i   ON il.InvoiceId  = i.InvoiceId
    INNER JOIN Customer c  ON i.CustomerId  = c.CustomerId
    INNER JOIN Track t     ON il.TrackId    = t.TrackId
    GROUP BY c.Country, t.TrackId, t.Name
)
SELECT * FROM Country_Track_Sales
WHERE Country_Rank <= 5
ORDER BY Country, Country_Rank;
```

**Techniques Applied:**
- `RANK() OVER (PARTITION BY ...)` for country-scoped rankings without collapsing global data
- CTE (`WITH` clause) for query modularity and readability
- 4-table join chain linking transactions to geography and product
- Reveals regional demand variation for localised marketing strategy

---

## 💡 Key Insights & Findings

<table>
<tr>
<td width="50%">

### 📍 Revenue Concentration
> A **small subset of tracks** accounts for a disproportionately large share of total revenue — consistent with the Pareto principle in product sales. Inventory and promotion strategy should prioritise this high-value tier.

</td>
<td width="50%">

### 🌍 Geographic Skew
> Revenue distribution is **heavily uneven across regions**, with a small number of countries generating the majority of sales volume. These markets warrant priority investment in customer retention and acquisition.

</td>
</tr>
<tr>
<td width="50%">

### 📅 Consistent Transaction Flow
> Monthly performance analysis reveals **steady transactional cadence** with identifiable peaks, suggesting opportunities for promotion timing aligned to high-activity periods.

</td>
<td width="50%">

### 🎯 Localised Preferences
> Top-track rankings **vary significantly by country**, confirming that customer preferences are geographically segmented. One-size-fits-all product strategies will underperform against localised approaches.

</td>
</tr>
</table>

---

## 🧠 SQL Concepts Demonstrated

```
┌──────────────────────────────────────────────────────────────────┐
│                    SQL SKILL MATRIX                              │
├──────────────────────────┬───────────────────────────────────────┤
│ CONCEPT                  │ APPLICATION                           │
├──────────────────────────┼───────────────────────────────────────┤
│ INNER JOIN               │ Multi-table relationship traversal    │
│ GROUP BY                 │ Dimensional aggregation               │
│ SUM() / COUNT()          │ Revenue and volume metrics            │
│ ORDER BY + LIMIT         │ Top-N result ranking                  │
│ strftime()               │ Date-part extraction for time series  │
│ RANK() OVER()            │ Window-based ordinal ranking          │
│ PARTITION BY             │ Scoped ranking within categories      │
│ CTE (WITH clause)        │ Modular, readable query composition   │
│ ROUND()                  │ Financial precision formatting        │
│ COUNT(DISTINCT)          │ Deduplication in aggregations         │
└──────────────────────────┴───────────────────────────────────────┘
```

---

## 📁 Project Structure

```
📦 sql-sales-analysis/
├── 📂 queries/
│   ├── 01_top_selling_tracks.sql          # Revenue by product
│   ├── 02_revenue_by_country.sql          # Geographic segmentation
│   ├── 03_monthly_revenue_trend.sql       # Time-series analysis
│   └── 04_top_tracks_per_country.sql      # Window function ranking
│
├── 📂 results/
│   ├── top_selling_tracks.csv             # Query output exports
│   ├── revenue_by_country.csv
│   ├── monthly_revenue.csv
│   └── top_tracks_per_country.csv
│
├── 📂 database/
│   └── chinook.db                         # SQLite source database
│
└── 📄 README.md                           # Project documentation
```

---

## 🛠️ Tools & Technologies

| Tool | Purpose | Version |
|------|---------|---------|
| ![SQLite](https://img.shields.io/badge/SQLite-003B57?style=flat&logo=sqlite&logoColor=white) | Query engine and database runtime | 3.x |
| ![VS Code](https://img.shields.io/badge/VS%20Code-007ACC?style=flat&logo=visualstudiocode&logoColor=white) | Development IDE | Latest |
| SQLite Extension (VS Code) | Interactive query execution and result preview | — |
| Markdown | Structured project documentation | — |
| CSV Export | Persistent result storage for downstream use | — |

---

## 🏆 Skills Demonstrated

```
DATA ENGINEERING         ANALYTICAL THINKING       PROFESSIONAL PRACTICE
─────────────────────    ──────────────────────    ────────────────────────
✔ Relational modelling   ✔ Business question       ✔ Modular query design
✔ Multi-table JOINs        translation             ✔ Readable code structure
✔ Aggregation pipelines  ✔ KPI definition          ✔ Documented methodology
✔ Window functions       ✔ Segmentation logic      ✔ Reproducible outputs
✔ Date/time processing   ✔ Geographic analysis     ✔ CSV result persistence
✔ CTE composition        ✔ Trend identification    ✔ Stakeholder-ready framing
```

---

## ✅ Conclusion

This project demonstrates how **structured SQL engineering translates raw transactional data into strategic business intelligence**. By constructing four modular analytical queries — from simple aggregations to advanced window functions — the analysis addresses real stakeholder questions around product performance, regional revenue, temporal trends, and localised market dynamics.

The methodology reflects practices expected in **data analytics, business intelligence, and data engineering roles** at enterprise scale: disciplined query design, clear business framing, and reproducible outputs that support decision-making.

---

<div align="center">

**Built with precision SQL · Documented for impact · Ready for enterprise review**

[![GitHub](https://img.shields.io/badge/View%20on%20GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com)
[![LinkedIn](https://img.shields.io/badge/Connect%20on%20LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com)

</div>
