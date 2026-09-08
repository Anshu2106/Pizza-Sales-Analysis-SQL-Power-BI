--DROP TABLE IF EXISTS Pizza_Sales;

CREATE TABLE Pizza_Sales(
            Pizza_id INTEGER PRIMARY KEY,
			Order_id INTEGER,
			Pizza_name_id TEXT,
			Quantity INTEGER,
			Order_date DATE,
			Order_time	TIME,
			Unit_price	NUMERIC(10,2),
            Total_price NUMERIC(10,2),  
			Pizza_size	VARCHAR(10),
			Pizza_category VARCHAR(50),
			Pizza_name	TEXT,
			Pizza_ingredients TEXT
);

SELECT *FROM Pizza_Sales;


                                     --KPI
									 
--1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM Pizza_Sales;

--2. Total Number of Orders made
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM Pizza_Sales;

--3. Average Order Value
SELECT CAST(CAST(SUM(total_price)AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
AS Average_Order FROM Pizza_Sales;

--4. Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sale FROM Pizza_Sales;

--5. Average Pizzas per order
SELECT SUM(quantity)/COUNT(DISTINCT order_id) 
AS AVG_pizza_per_order 
FROM Pizza_Sales;

SELECT *FROM Pizza_Sales;
                                   
								   --ANALYSIS

--1. Monthly trend for total revenue
SELECT TO_CHAR(order_date,'Month')AS Month, SUM(total_price)
AS Monthly_Trend FROM Pizza_Sales 
GROUP BY TO_CHAR(order_date,'Month');

--2.Daily trend for total orders
SELECT TO_CHAR(order_date,'DAY')AS DAY, COUNT(DISTINCT order_id)
AS Daily_Trend FROM Pizza_Sales 
GROUP BY TO_CHAR(order_date,'DAY');

--3.Percentage of Pizza Sales by category
SELECT pizza_category, Sum(total_price),
CAST(SUM(total_price)*100/ 
(SELECT SUM(total_price) FROM Pizza_Sales) 
AS DECIMAL(10,2)) AS Pizza_Sales_Per_by_cat
FROM Pizza_Sales
GROUP BY pizza_category;

--5. Total Pizza Sold by Pizza Size and Category
SELECT pizza_size, SUM(quantity) AS total_pizza_sold
FROM Pizza_Sales
GROUP BY pizza_size;

SELECT pizza_category, SUM(quantity) AS total_pizza_sold
FROM Pizza_Sales
GROUP BY pizza_category;

--4. Percentage of Pizza sales by Pizza Size
SELECT pizza_size, Sum(total_price),
CAST(SUM(total_price)*100/ 
(SELECT SUM(total_price) FROM Pizza_Sales) 
AS DECIMAL(10,2)) AS Pizza_Sales_Per_by_size
FROM Pizza_Sales
GROUP BY pizza_size;

--. Revenue by Pizza Name
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;

                        
						--TOP AND BOTTOM ANALYSIS
SELECT *FROM Pizza_Sales;

--1.Top Pizza by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 10;

--2. Worst Pizza by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 10;

--3. Top Pizza by Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_orders 
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY Total_orders DESC
LIMIT 10;

--4. Worst Pizza by Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_orders 
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY Total_orders ASC
LIMIT 10;

--5. Top Pizza by Quantity sold
SELECT pizza_name, SUM(quantity)  AS quantity_sold 
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC
LIMIT 10;

--6. Worst Pizza by Quantity Sold
SELECT pizza_name, SUM(quantity) AS quantity_sold 
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 10;


