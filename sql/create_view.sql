CREATE OR ALTER VIEW analytics.vw_SalesOrderAnalytics
AS
/*
Purpose
-------
Reusable order-level dataset for reporting and analysis.

Notes
-----
- Grain: one row per SalesOrderID
- CustomerName:
    - Person customers -> Person.Person (FirstName LastName)
    - Store customers  -> Sales.Store (Name)
    - Fallback -> 'Unknown'
*/
SELECT
    soh.SalesOrderID,
    soh.OrderDate,
    YEAR(soh.OrderDate)  AS OrderYear,
    MONTH(soh.OrderDate) AS OrderMonth,
    soh.CustomerID,
    COALESCE(p.FirstName + ' ' + p.LastName, s.Name, 'Unknown') AS CustomerName,
    soh.TotalDue,

    CASE
        WHEN soh.TotalDue < 1000 THEN 'Small'
        WHEN soh.TotalDue < 5000 THEN 'Medium'
        ELSE 'Large'
    END AS OrderSize,

    -- Rank orders by value within each customer (all time)
    ROW_NUMBER() OVER (
        PARTITION BY soh.CustomerID
        ORDER BY soh.TotalDue DESC, soh.OrderDate DESC, soh.SalesOrderID DESC
    ) AS OrderRankWithinCustomerByValue,

    -- Rank orders by value within each customer-year (useful for yearly top-order reporting)
    ROW_NUMBER() OVER (
        PARTITION BY soh.CustomerID, YEAR(soh.OrderDate)
        ORDER BY soh.TotalDue DESC, soh.OrderDate DESC, soh.SalesOrderID DESC
    ) AS OrderRankWithinCustomerYearByValue

FROM Sales.SalesOrderHeader AS soh
JOIN Sales.Customer AS c
    ON soh.CustomerID = c.CustomerID
LEFT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store AS s
    ON c.StoreID = s.BusinessEntityID;
GO
