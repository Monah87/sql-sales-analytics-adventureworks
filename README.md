# SQL Portfolio Project — Sales Order Analytics View (AdventureWorks)

## Overview
This project creates a reusable, **order-level analytics dataset** in Microsoft SQL Server using the AdventureWorks sample database.  
The core deliverable is a view (`analytics.vw_SalesOrderAnalytics`) that standardizes customer identity (Person vs Store), adds business-friendly labels (order size), and includes window-function rankings for “Top-N per customer” analysis.

**Grain:** 1 row = 1 Sales Order (`SalesOrderID`)

---

## Business Questions This Supports
- **Sales trends** by year/month (revenue + order counts)
- **Order segmentation**: Small / Medium / Large orders
- **Top orders per customer** (by value)
- **Customer activity analysis** and reporting-ready datasets (filter by date range safely)

---

## Tech / Skills Demonstrated
- `JOIN` vs `LEFT JOIN` (preserving rows and handling missing relationships)
- Customer identity resolution using `COALESCE` (Person + Store)
- Business rules using `CASE WHEN`
- Window functions:
  - `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)`
- Safe date filtering using **range filters** (index-friendly)
- Data quality validation checks (grain & key integrity)

---

## Requirements
- Microsoft SQL Server (Express is fine)
- SQL Server Management Studio (SSMS)
- AdventureWorks OLTP database (e.g., AdventureWorks2022)

---

## Installation / Setup
1. Restore AdventureWorks (e.g., `AdventureWorks2022`) in SQL Server.
2. Open SSMS and connect to your SQL Server instance.
3. Run the script in the following order:
   - Create schema `analytics`
   - Create or alter the view `analytics.vw_SalesOrderAnalytics`
   - Run QA checks and sample queries

---

## 1) Create Schema (optional but recommended)
```sql
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'analytics')
BEGIN
    EXEC('CREATE SCHEMA analytics AUTHORIZATION dbo;');
END
GO

