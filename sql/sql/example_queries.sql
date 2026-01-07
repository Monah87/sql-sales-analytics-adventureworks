SELECT *
FROM analytics.vw_SalesOrderAnalytics
WHERE OrderDate >= '2014-01-01'
  AND OrderDate <  '2015-01-01'
ORDER BY OrderDate DESC;
--2014 Orders

SELECT
    OrderYear,
    OrderMonth,
    SUM(TotalDue) AS TotalSales,
    COUNT(*)      AS OrderCount
FROM analytics.vw_SalesOrderAnalytics
GROUP BY OrderYear, OrderMonth
ORDER BY OrderYear, OrderMonth;
--Monthly Sales Trend

SELECT
    CustomerID, CustomerName, SalesOrderID, OrderDate, TotalDue, OrderSize
FROM analytics.vw_SalesOrderAnalytics
WHERE OrderRankWithinCustomerByValue <= 2
ORDER BY CustomerID, TotalDue DESC;
--Top 2 Orders per Customer

WITH CustomerSpend AS (
    SELECT
        CustomerID,
        MAX(CustomerName) AS CustomerName,
        SUM(TotalDue) AS TotalSpent
    FROM analytics.vw_SalesOrderAnalytics
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    CustomerName,
    TotalSpent,
    CASE
        WHEN TotalSpent >= 20000 THEN 'VIP'
        WHEN TotalSpent >= 5000  THEN 'Regular'
        ELSE 'Low'
    END AS CustomerType
FROM CustomerSpend
ORDER BY TotalSpent DESC;
--Customer Segmentation (VIP / Regular / Low)
