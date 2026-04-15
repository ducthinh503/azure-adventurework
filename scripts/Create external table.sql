-- Create external data source 
-- Step 1: create master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Ducthinh5*heheheee'

-- Step 2: Create database scoped credential (grant access permission)
CREATE DATABASE SCOPED CREDENTIAL cred_thinh
WITH IDENTITY = 'Managed Identity'

-- Step 3: Create External Data Source 
CREATE EXTERNAL DATA SOURCE source_silver
WITH (
    LOCATION = 'https://awstoragedatalake2026.blob.core.windows.net/silver',
    CREDENTIAL = cred_thinh
)

CREATE EXTERNAL DATA SOURCE source_gold
WITH (
    LOCATION = 'https://awstoragedatalake2026.blob.core.windows.net/gold',
    CREDENTIAL = cred_thinh
)

-- Create external file format
CREATE EXTERNAL FILE FORMAT format_parquet
WITH 
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)




