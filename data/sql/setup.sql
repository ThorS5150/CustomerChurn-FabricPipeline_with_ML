-- AdventureWorksDW2022 Setup Script
-- Purpose: Verify database, create views, and prepare for Fabric ingestion

USE AdventureWorksDW2022;
GO

-- ============================================
-- PART 1: VERIFY DATABASE STRUCTURE
-- ============================================

PRINT '--- PART 1: Database Verification ---';

IF DB_ID('AdventureWorksDW2022') IS NOT NULL
    PRINT 'Database AdventureWorksDW2022 exists and is accessible.'
ELSE
    PRINT 'ERROR: Database not found!'
GO

-- List all tables
PRINT 'Tables in AdventureWorksDW2022:';
SELECT
    SCHEMA_NAME(SCHEMA_ID) AS SchemaName,
    NAME AS TableName,
    (SELECT COUNT(*) FROM sys.columns c WHERE c.object_id = t.object_id) AS ColumnCount
FROM sys.tables t
ORDER BY SchemaName, TableName;
GO

-- ============================================
-- PART 2: TABLE ROW COUNTS
-- ============================================

PRINT '';
PRINT '--- PART 2: Table Row Counts ---';

SELECT 'FactInternetSales' AS TableName, COUNT(*) AS RowCount FROM FactInternetSales
UNION ALL
SELECT 'FactReturns', COUNT(*) FROM FactReturns
UNION ALL
SELECT 'DimProduct', COUNT(*) FROM DimProduct
UNION ALL
SELECT 'DimCustomer', COUNT(*) FROM DimCustomer
UNION ALL
SELECT 'DimDate', COUNT(*) FROM DimDate
UNION ALL
SELECT 'DimSalesTerritory', COUNT(*) FROM DimSalesTerritory
ORDER BY TableName;
GO

-- ============================================
-- PART 3: DATA QUALITY CHECKS
-- ============================================

PRINT '';
PRINT '--- PART 3: Data Quality Checks ---';

-- Check for NULL values in key columns
PRINT 'NULL values in FactInternetSales:';
SELECT
    'ProductKey' AS ColumnName, COUNT(*) AS NullCount FROM FactInternetSales WHERE ProductKey IS NULL
UNION ALL
SELECT 'CustomerKey', COUNT(*) FROM FactInternetSales WHERE CustomerKey IS NULL
UNION ALL
SELECT 'OrderDateKey', COUNT(*) FROM FactInternetSales WHERE OrderDateKey IS NULL
UNION ALL
SELECT 'SalesAmount', COUNT(*) FROM FactInternetSales WHERE SalesAmount IS NULL;
GO

-- Check date range
PRINT '';
PRINT 'Date Range in FactInternetSales:';
SELECT
    MIN(d.FullDate) AS FirstDate,
    MAX(d.FullDate) AS LastDate,
    DATEDIFF(YEAR, MIN(d.FullDate), MAX(d.FullDate)) AS YearSpan
FROM FactInternetSales fs
INNER JOIN DimDate d ON fs.OrderDateKey = d.DateKey;
GO

-- ============================================
-- PART 4: CREATE VIEWS FOR FABRIC INGESTION
-- ============================================

PRINT '';
PRINT '--- PART 4: Creating Views for Fabric ---';

-- Sales Analysis View
CREATE OR ALTER VIEW vw_SalesAnalysis AS
SELECT
    fs.SalesOrderNumber,
    fs.SalesOrderLineNumber,
    fs.OrderDateKey,
    d.FullDate AS OrderDate,
    d.CalendarYear,
    fs.ProductKey,
    p.EnglishProductName AS ProductName,
    pc.EnglishProductCategoryName AS CategoryName,
    fs.CustomerKey,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    st.SalesTerritoryKey,
    st.SalesTerritoryRegion,
    fs.SalesAmount,
    fs.OrderQuantity,
    fs.TotalProductCost,
    fs.SalesAmount - fs.TotalProductCost AS Profit
FROM dbo.FactInternetSales fs
INNER JOIN dbo.DimDate d ON fs.OrderDateKey = d.DateKey
INNER JOIN dbo.DimProduct p ON fs.ProductKey = p.ProductKey
INNER JOIN dbo.DimProductCategory pc ON p.ProductCategoryKey = pc.ProductCategoryKey
INNER JOIN dbo.DimCustomer c ON fs.CustomerKey = c.CustomerKey
INNER JOIN dbo.DimSalesTerritory st ON fs.SalesTerritoryKey = st.SalesTerritoryKey;
GO

-- Customer Lifetime Value View
CREATE OR ALTER VIEW vw_CustomerLifetimeValue AS
SELECT
    c.CustomerKey,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.EmailAddress,
    c.City,
    COUNT(DISTINCT fs.SalesOrderNumber) AS TotalOrders,
    ROUND(SUM(fs.SalesAmount), 2) AS TotalLifetimeValue,
    ROUND(AVG(fs.SalesAmount), 2) AS AvgOrderValue
FROM dbo.DimCustomer c
LEFT JOIN dbo.FactInternetSales fs ON c.CustomerKey = fs.CustomerKey
LEFT JOIN dbo.DimDate d ON fs.OrderDateKey = d.DateKey
GROUP BY
    c.CustomerKey,
    c.FirstName,
    c.LastName,
    c.EmailAddress,
    c.City;
GO

PRINT 'Views created successfully!';
GO

-- ============================================
-- PART 5: SAMPLE ANALYTICAL QUERIES
-- ============================================

PRINT '';
PRINT '--- PART 5: Sample Queries ---';

-- Top 10 products by revenue
PRINT 'Top 10 Products by Revenue:';
SELECT TOP 10
    p.EnglishProductName AS ProductName,
    ROUND(SUM(fs.SalesAmount), 2) AS TotalRevenue,
    SUM(fs.OrderQuantity) AS TotalQuantitySold
FROM FactInternetSales fs
INNER JOIN DimProduct p ON fs.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
ORDER BY TotalRevenue DESC;
GO

-- Sales by territory
PRINT '';
PRINT 'Sales by Territory:';
SELECT
    st.SalesTerritoryRegion,
    COUNT(*) AS TransactionCount,
    ROUND(SUM(fs.SalesAmount), 2) AS TotalRevenue,
    ROUND(AVG(fs.SalesAmount), 2) AS AvgTransactionValue
FROM FactInternetSales fs
INNER JOIN DimSalesTerritory st ON fs.SalesTerritoryKey = st.SalesTerritoryKey
GROUP BY st.SalesTerritoryRegion
ORDER BY TotalRevenue DESC;
GO

PRINT '';
PRINT 'Setup completed successfully!';
