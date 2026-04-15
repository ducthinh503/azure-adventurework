-- Create calander view 
CREATE VIEW gold.calander
AS 
    SELECT *
    FROM OPENROWSET(
        BULK 'https://awstoragedatalake2026.blob.core.windows.net/silver/Calender/',
        FORMAT = 'PARQUET'
    ) AS query1

-- Create customer view 
CREATE VIEW gold.customer
AS 
    SELECT *
    FROM OPENROWSET(
        BULK 'https://awstoragedatalake2026.blob.core.windows.net/silver/Customers/',
        FORMAT = 'PARQUET'
    ) AS query1

-- Create Product Sub Categories view
CREATE VIEW gold.productSubCategories
AS 
    SELECT *
    FROM OPENROWSET(
        BULK 'https://awstoragedatalake2026.blob.core.windows.net/silver/ProductSubCategories/',
        FORMAT = 'PARQUET'
    ) AS query1

-- Create Products view
CREATE VIEW gold.products
AS 
    SELECT *
    FROM OPENROWSET(
        BULK 'https://awstoragedatalake2026.blob.core.windows.net/silver/Products/',
        FORMAT = 'PARQUET'
    ) AS query1

-- Create Returns view
CREATE VIEW gold.returns
AS 
    SELECT *
    FROM OPENROWSET(
        BULK 'https://awstoragedatalake2026.blob.core.windows.net/silver/Returns/',
        FORMAT = 'PARQUET'
    ) AS query1

-- Create Sales view
CREATE VIEW gold.sales
AS 
    SELECT *
    FROM OPENROWSET(
        BULK 'https://awstoragedatalake2026.blob.core.windows.net/silver/Sales/',
        FORMAT = 'PARQUET'
    ) AS query1

-- Create territories view
CREATE VIEW gold.territories
AS 
    SELECT *
    FROM OPENROWSET(
        BULK 'https://awstoragedatalake2026.blob.core.windows.net/silver/Territories/',
        FORMAT = 'PARQUET'
    ) AS query1