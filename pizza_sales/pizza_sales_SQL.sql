--checking orders table
select *
from orders
limit 5;


--finding the top 5 ordered pizzas(name, quantity of orders)
SELECT name, SUM(quantity)
FROM order_details AS o
JOIN pizzas as pi
ON o.pizza_id = pi.pizza_id
JOIN pizza_types AS p
ON pi.pizza_type_id = p.pizza_type_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


--finding top 5 highest total order in one day (sum, quantity)
SELECT date, SUM(quantity) AS num_of_orders
FROM orders AS o
JOIN order_details AS details
ON o.order_id = details.order_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


--finding sale in april, may and june
WITH total_orders AS(
  SELECT o.order_id, pi.pizza_id,
CAST(date as date), quantity, price
FROM orders AS o
JOIN order_details AS details
ON o.order_id = details.order_id
JOIN pizzas AS pi
ON details.pizza_id = pi.pizza_id
WHERE date BETWEEN '2015-04-01' AND '2015-06-30')

SELECT pizza_id,
CASE 
    WHEN EXTRACT(MONTH FROM date) = 4 THEN 'April'
    WHEN EXTRACT(MONTH FROM date) = 5 THEN 'May'
    WHEN EXTRACT(MONTH FROM date) = 6 THEN 'June'
    END AS month, SUM(quantity) AS num_of_order, SUM(price) AS revenue
FROM total_orders
GROUP BY 1,2
order by 2,4 DESC;


--finding the order of the last day of the year
WITH end_year_order AS (
select 
	o.order_id,
    price
from orders AS o
JOIN order_details AS details
ON o.order_id = details.order_id
JOIN pizzas AS pi 
on details.pizza_id = pi.pizza_id
WHERE CAST(date AS VARCHAR) LIKE('2015-12-31'))

SELECT order_id, SUM(price)
FROM end_year_order
GROUP BY 1
ORDER BY 2 DESC;