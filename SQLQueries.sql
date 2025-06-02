CREATE DATABASE RetailSalesData;
USE RetailSalesData;

CREATE TABLE Sales_Data_Transaction (
customer_id varchar(255),
trans_date VARCHAR(255),
tran_amount INT);

DROP TABLE Sales_Data_Transaction

CREATE TABLE Sales_Data_Response (
customer_id varchar(255) PRIMARY KEY,
response INT);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Retail_Data_Transactions.csv'
INTO TABLE Sales_Data_Transaction
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE INDEX idx_id ON Sales_Data_Transaction(CUSTOMER_ID)

EXPLAIN SELECT * FROM Sales_Data_Transaction WHERE Customer_ID= 'CS5295';