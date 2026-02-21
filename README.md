# SQL-Based-analysis-of-Product-sales
📌 Project Overview

This project focuses on analyzing product sales data using SQL on the Chinook Database sourced from Kaggle. The objective of this project is to extract meaningful business insights from a relational database by writing structured SQL queries. The analysis demonstrates how raw transactional data can be transformed into actionable insights through joins, aggregations, and business logic implementation.

The Chinook database simulates a digital music store and contains multiple related tables such as customers, invoices, invoice items, tracks, albums, and artists. By connecting these tables using SQL JOIN operations, comprehensive sales analysis was performed.

🛠 Tools and Technologies Used

The project was implemented using SQL within a Python environment. SQLite was used as the database engine, though the queries are compatible with PostgreSQL, MySQL, or BigQuery with minimal adjustments. Python was used for executing queries and managing database connections, while SQL was used for data retrieval, filtering, aggregation, and ranking.

🧮 Business Questions Addressed

The analysis answers important business questions such as identifying top-selling products, calculating total revenue per region, and evaluating monthly sales performance trends. SQL aggregations including SUM, COUNT, GROUP BY, and ORDER BY were used to compute revenue metrics and sales summaries.

JOIN operations were implemented to combine related tables such as invoice items with products and customers to ensure accurate revenue calculations. This demonstrates a strong understanding of relational database structures and foreign key relationships.

A window function such as ROW_NUMBER or RANK was applied to rank top-selling products based on revenue, providing advanced analytical capability beyond basic aggregation.

📊 Key Insights

The analysis identifies high-performing products, revenue distribution across different regions, and seasonal trends in sales. Monthly performance evaluation highlights fluctuations in revenue and purchasing behavior. Ranking functions help determine best-selling products within specific categories or regions.

💼 Business Value

This project demonstrates practical SQL skills required for data analyst roles, including writing complex queries, applying joins, performing aggregations, and implementing business logic from raw relational data. It showcases the ability to extract strategic insights directly from structured databases and supports data-driven decision-making.
