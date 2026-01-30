# SQL Analytics Project

## Overview
Portfolio-ready SQL analytics project built on the AdventureWorks2022 sample database.

This project demonstrates:
- Clean analytical view design
- Window functions for ranking
- Customer segmentation
- Reusable SQL for reporting and BI tools

## Core Asset
**analytics.vw_SalesOrderAnalytics**

Grain: one row per SalesOrderID

Includes:
- Customer resolution (Person / Store)
- Order size classification
- Ranking within customer and year
- Date attributes for trending

## Example Business Questions Answered
- Which customers place the highest-value orders?
- Who are VIP customers by lifetime value?
- Monthly sales trends
- Top N orders per customer
- Data quality validation checks

## Files
- `sql/create_view.sql` – deployable analytics view
- `sql/example_queries.sql` – business queries & QA checks

## Tech Stack
- SQL Server 2022
- AdventureWorks2022 sample database

## Notes
All SQL is production-safe, readable, and reusable for BI tools.


