-- Table schema for Superstore Sales SQL Project

CREATE TABLE superstore_sales (
  Row_ID INT,
  Order_ID VARCHAR(20),
  Order_Date DATE,
  Ship_Date DATE,
  Ship_Mode VARCHAR(50),
  Customer_ID VARCHAR(20),
  Customer_Name VARCHAR(100),
  Segment VARCHAR(50),
  Country VARCHAR(50),
  City VARCHAR(50),
  State VARCHAR(50),
  Postal_Code VARCHAR(20),
  Region VARCHAR(20),
  Product_ID VARCHAR(50),
  Category VARCHAR(50),
  Sub_Category VARCHAR(50),
  Product_Name TEXT,
  Sales DECIMAL(10,2)
);
