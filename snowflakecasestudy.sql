CREATE or replace database casestudy;


CREATE OR REPLACE STAGE azure_stagee
URL = 'azure://snowflakecasestudy.blob.core.windows.net/casestudy'
CREDENTIALS=(AZURE_SAS_TOKEN='sp=rwl&st=2025-10-22T09:18:49Z&se=2025-10-22T17:33:49Z&spr=https&sv=2024-11-04&sr=c&sig=zRFtPbxHlQwrLuaxleu8B96fBfLhiKKFYVGDtPsNQxI%3D');

LIST @azure_stagee;

CREATE OR REPLACE TABLE monthly_sales (
    OrderID         STRING,
    OrderDate       DATE,
    MonthOfSale     STRING,
    CustomerID      STRING,
    CustomerName    STRING,
    Country         STRING,
    Region          STRING,
    City            STRING,
    Category        STRING,
    Subcategory     STRING,
    Quantity        INTEGER,
    Discount        FLOAT,
    Sales           FLOAT,
    Profit          FLOAT
);


CREATE OR REPLACE FILE FORMAT csv_file_format
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1;

copy into monthly_sales
from @azure_stagee/Retail_Sales__500_rows__Preview.csv
file_format = csv_file_format;


select * from monthly_sales;


CREATE OR REPLACE TABLE monthly_sales_db (
    OrderID         STRING,
    OrderDate       DATE,
    MonthOfSale     STRING,
    CustomerID      STRING,
    CustomerName    STRING,
    Country         STRING,
    Region          STRING,
    City            STRING,
    Category        STRING,
    Subcategory     STRING,
    Quantity        INTEGER,
    Discount        FLOAT,
    Sales           FLOAT,
    Profit          FLOAT
);


select * from monthly_sales_db;
