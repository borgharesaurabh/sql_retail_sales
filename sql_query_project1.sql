Select * from retail_sales

select COUNT(*) from retail_sales


--Q1. Write a SQL Query to retrieve all columns for sales mode on '2022-11-05'.

SELECT * 
FROM  retail_sales
WHERE sale_date = '2022-11-05'

--Q2.Write a SQL Query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT 
*
FROM retail_sales
WHERE
     category = 'Clothing'
	 AND
	 TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	 AND
	 quantiy >= 4

	 


-- Q3. Write a SQL query to calculate the total sales for each category.

SELECT
    category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

-- Q4. Write a SQL Query to find the average age of customers who puchased items from the 'Beauty' category.

Select
  AVG(age) as avg_age
from retail_sales
where category = 'Beauty'

--Q5. Write a SQL Query to find all transactions where the total sales is greater than 1000.

SELECT * FROM retail_sales where total_sale >1000

--Q6. Write a SQL Query to find the total no. of transactions (transaction_id) made by each gender in each category.

SELECT
     category,
	 gender,
	 COUNT(*) as total_trans
	 from retail_sales
	 group by category,
	 gender
ORDER BY 1

--Q7. Write a SQL Query to calculate the average sale of each month. Find out best selling month in each year.

SELECT 
    year,
	month,
	avg_sale
FROM
(
SELECT
EXTRACT(YEAR FROM sale_date) as year,
EXTRACT(MONTH FROM sale_date) as MONTH,
  AVG(total_sale) as avg_sale,
  RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) as rank
  
FROM retail_sales
GROUP BY 1,2) 
as t1 
WHERE rank = 1

-- ORDER BY 1,3 DESC;

--Q8. Write a SQL query to find the top 5 customers based on the highest total sales

SELECT
  customer_id,
  SUM(total_sale) as total_sales 
from retail_sales
group by 1
order by 2 desc
LIMIT 5;

--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
   category,
   COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

--Q10. Write a SQL Query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
	  WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	  ELSE 'Evening'
	 END as shift
FROM retail_sales
)

SELECT
COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

SELECT EXTRACT(HOUR FROM CURRENT_TIME)

-- End of Project ---




	 