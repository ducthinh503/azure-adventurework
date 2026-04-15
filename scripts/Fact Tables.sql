-- Fact Sales Table
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE t.name = 'FactSales' and s.name = 'gold')
CREATE EXTERNAL TABLE gold.FactSales
WITH
(
    LOCATION = 'FactSales',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT 
    f.OrderNumber,
    f.OrderLineItem,
    f.OrderQuantity,
    f.multiply AS SalesAmount,
    p.ProductKey,
    c.CustomerKey,
    t.SalesTerritoryKey AS TerritoryKey,
    d1.DateKey AS OrderDateKey
FROM 
    gold.sales f LEFT JOIN 
    gold.DimCustomer c ON f.CustomerKey = c.CustomerKey LEFT JOIN 
    gold.DimProduct p ON f.ProductKey = p.ProductKey LEFT JOIN 
    gold.DimTerritories t ON f.TerritoryKey = t.SalesTerritoryKey LEFT JOIN 
    gold.DimCalender d1 ON CAST(f.OrderDate AS DATE) = d1.Date 

-- Fact Sales Table
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE t.name = 'FactReturns' and s.name = 'gold')
CREATE EXTERNAL TABLE gold.FactReturns
WITH
(
    LOCATION = 'FactReturns',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
    SELECT
        f.ReturnQuantity,
        t.SalesTerritoryKey AS TerritoryKey,
        p.ProductKey,
        d1.DateKey AS ReturnDateKey
    FROM 
        gold.returns f LEFT JOIN 
        gold.DimTerritories t ON f.TerritoryKey = t.SalesTerritoryKey LEFT JOIN 
        gold.DimProduct p ON f.ProductKey = p.ProductKey LEFT JOIN 
        gold.DimCalender d1 ON CAST(f.ReturnDate AS DATE) = d1.Date 


