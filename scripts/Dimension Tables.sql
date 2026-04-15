------------------ 
-- Dim Customers
-------------------
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE t.name = 'DimCustomer' and s.name = 'gold')
CREATE EXTERNAL TABLE gold.DimCustomer
WITH
(
    LOCATION = 'DimCustomer',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS SELECT *
    FROM (
    SELECT DISTINCT 
        CustomerKey,
        FullName,
        BirthDate,
        MaritalStatus,
        Gender,
        EmailAddress,
        AnnualIncome,
        TotalChildren,
        EducationLevel,
        Occupation,
        HomeOwner
    FROM gold.customer
    ) t

------------------ 
-- Dim Territories
-------------------
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE t.name = 'DimTerritories' and s.name = 'gold')
CREATE EXTERNAL TABLE gold.DimTerritories
WITH
(
    LOCATION = 'DimTerritories',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS 
    SELECT DISTINCT 
       SalesTerritoryKey,
       Region,
       Country,
       Continent
    FROM gold.territories

------------------ 
-- Dim Product
-------------------
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE t.name = 'DimProduct' and s.name = 'gold')
CREATE EXTERNAL TABLE gold.DimProduct
WITH
(
    LOCATION = 'DimProduct',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS SELECT *
    FROM (
    SELECT DISTINCT 
        p.ProductKey,
        p.ProductName,
        ps.SubcategoryName,
        ps.ProductSubcategoryKey,
        p.ProductSKU,
        p.ModelName,
        p.ProductDescription,
        p.ProductSize,
        p.ProductStyle,
        p.ProductCost,
        p.ProductPrice
    FROM gold.products p LEFT JOIN 
         gold.productSubCategories ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
    ) t

------------------ 
-- Dim Calender
-------------------
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE t.name = 'DimCalender' and s.name = 'gold')
CREATE EXTERNAL TABLE gold.DimCalender
WITH
(
    LOCATION = 'DimCalender',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
    SELECT DISTINCT 
        Date, 
        MONTH(Date) AS 'Month',
        YEAR(Date) AS 'Year',
        DAY(Date) AS 'Day',
        DATEPART(QUARTER, Date) AS 'Quarter',
        CAST(FORMAT(Date, 'yyyyMMdd') AS INT) AS DateKey
    FROM gold.calander




