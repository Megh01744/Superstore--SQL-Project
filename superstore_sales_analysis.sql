-- Superstore Sales Analysis Project
-- Author: Meghna Dey
-- Objective: Analyze Superstore data to find sales trends by category, region, customer, and time.
-- Dataset Source: Kaggle (Superstore Sales dataset)

USE superstore_db;

-- 1. Total sales in a Dataset
SELECT 
ROUND(SUM(Sales),2) AS Total_sales
FROM superstore_sales;

-- 2. Sales by Category and Sub-category
SELECT Category,
       Sub_Category,
       ROUND(SUM(Sales),2) AS Total_sales
       FROM superstore_sales
       GROUP BY Category, Sub_Category
       ORDER BY total_sales DESC;			
       
-- 3. Sales by region and State
SELECT Region,
        State,
        ROUND(SUM(Sales),2) AS Total_sales
        FROM superstore_sales
        GROUP BY Region , State
        ORDER BY total_sales;
        
        
 -- 4. Monthly sales Trend
 SELECT 
       DATE_FORMAT(Order_Date, '%Y-%m') AS Order_month,
       ROUND(SUM(Sales),2) AS Monthly_sales
       FROM superstore_sales
		GROUP BY order_month
        ORDER BY order_month;
        
        
 -- 5. Top 10 selling cities
 SELECT 
        City,
		State,
        ROUND(SUM(Sales),2 ) AS City_sales
        FROM superstore_sales
        GROUP BY city, State
        ORDER BY city_sales DESC
        LIMIT 10;
        
-- 6. Top 10 Customer by Sales
SELECT Customer_Name,
       ROUND(SUM(Sales), 2) AS Total_sales
       FROM superstore_sales
       GROUP BY Customer_Name
       ORDER BY total_sales DESC
       LIMIT 10;
       
-- 7. Sales by Year
SELECT 
      YEAR(Order_Date) AS order_year,
      ROUND(SUM(Sales),2) AS Total_sales
      FROM superstore_sales
      GROUP BY order_year
      ORDER BY order_year;
      
      
-- 8. Sales by Category Overtime
SELECT 
  DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
  Category,
  ROUND(SUM(Sales), 2) AS Monthly_Sales
FROM superstore_sales
GROUP BY Category , Month
ORDER BY Category, Month;
	
-- 9. Number of Orders by Region
SELECT 
  Region,
  COUNT(DISTINCT Order_ID) AS Number_of_orders
FROM superstore_sales
GROUP BY Region
ORDER BY Number_of_orders DESC;   

-- 10. Repeat Customers
SELECT customer_name,
        COUNT(DISTINCT Order_ID) AS Number_of_orders
        FROM superstore_sales
        GROUP BY Customer_Name
        HAVING COUNT(DISTINCT Order_ID) >1
        ORDER BY Number_of_orders DESC
        LIMIT 10;
        
-- 11. Sales by shipping mode
SELECT 
  Ship_Mode,
  ROUND(SUM(Sales), 2) AS Total_Sales,
  COUNT(DISTINCT Order_ID) AS Order_Count
FROM superstore_sales
GROUP BY Ship_Mode
ORDER BY Total_Sales DESC;
        
-- 12. Top 10 states by sales
SELECT 
  State,
  ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales
GROUP BY State
ORDER BY Total_sales DESC
LIMIT 10;

-- 13. Most popular sub-categories
SELECT 
  Sub_Category,
  COUNT(*) AS Total_Items_Sold,
  ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales
GROUP BY Sub_Category
ORDER BY Total_Items_Sold DESC;

-- 14. Average order size per customer
-- shows how much each customer spends per order --
SELECT 
  Customer_Name,
  COUNT(DISTINCT Order_ID) AS Total_orders,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Avg_Order_Value
FROM superstore_sales
GROUP BY Customer_Name
ORDER BY Avg_Order_Value DESC
LIMIT 10;

-- 15. Sales by postal code
-- Understand where most sales are coming from geographically --
SELECT 
  Postal_Code,
  ROUND(SUM(Sales), 2) AS Total_Sales,
  COUNT(DISTINCT Order_ID) AS Orders
FROM superstore_sales
GROUP BY Postal_Code
ORDER BY Total_Sales DESC
LIMIT 10;

-- 16. First-time Vs repeat customer
-- compare revenue from new vs returning customers --

WITH first_orders AS (
  SELECT Customer_ID, MIN(Order_Date) AS First_Order
  FROM superstore_sales
  GROUP BY Customer_ID
) SELECT 
  CASE 
    WHEN s.Order_Date = f.First_Order THEN 'First-Time Customer'
    ELSE 'Repeat Customer'
  END AS customer_type,
  ROUND(SUM(s.Sales), 2) AS Total_Sales,
  COUNT(DISTINCT s.Order_ID) AS Number_of_Orders
FROM superstore_sales s
JOIN first_orders f ON s.Customer_ID = f.Customer_ID
GROUP BY customer_type;

-- 17. Delivery delay analysis
SELECT 
      Order_ID,
      datediff(Ship_Date, Order_Date) AS Delivery_days
      FROM superstore_sales
      ORDER BY delivery_days DESC
      LIMIT 20;

		
       
	
        
        
        
        