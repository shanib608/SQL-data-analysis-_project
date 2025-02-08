	

1)	Retrieve the total numbers order placed 
Ans)

       use pizzahuat;

select count( order_id) as total_order from orderss;

2)	Calculate the total revenue generated from pizza sales
Ans)
            SELECT 
            ROUND(SUM(order_details1.quantity * pizzas1.price),
                        2) AS total_sales
        FROM
            order_details1
                JOIN
            pizzas1 ON order_details1.pizza_id = pizzas1.pizza_id;
            
3)	Identify the highest prize pizza
Ans) 
        SELECT 
    pizza_types.name, pizzas1.price
FROM
    pizza_types
        JOIN
    pizzas1 ON pizza_types.pizza_type_id = pizzas1.pizza_type_id
ORDER BY pizzas1.price DESC
LIMIT 1;


4)	Identify the most common pizza size ordered

Ans) 
          SELECT 
    pizzas1.size,
    COUNT(order_details1.order_details_id) AS order_count
FROM
    pizzas1
        JOIN
    order_details1 ON pizzas1.pizza_id = order_details1.pizza_id
GROUP BY pizzas1.size
ORDER BY order_count DESC;

5)	List the top 5 most ordered pizza type along with quantit
Ans)
      SELECT 
    pizza_types.name, SUM(order_details1.quantity) AS quatity
FROM
    pizza_types
        JOIN
    pizzas1 ON pizza_types.pizza_type_id = pizzas1.pizza_type_id
        JOIN
    order_details1 ON order_details1.pizza_id = pizzas1.pizza_id
GROUP BY pizza_types.name
ORDER BY quatity DESC
LIMIT 5;

6)	Find the necessary table to find the total quantity of each pizza category orderd
Ans) 
    use pizzahat;
SELECT 
    pizza_types.category,
    SUM(order_details1.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas1 ON pizza_types.pizza_type_id = pizzas1.pizza_type_id
        JOIN
    order_details1 ON order_details1.pizza_id = pizzas1.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

7)	 Determine the distribution of orders by hour of the day
Ans)
            SELECT 
    HOUR(order_time) AS hhh, COUNT(order_id) AS order_count
FROM
    orderss
GROUP BY HOUR(order_time);

8)	Joint the relevant table to find the category wise distribution of pizza
Ans) 
           SELECT category, count(name) as nos FROM pizza_types
GROUP BY category;

9)	Group the orders by date and calculate the average numbers of pizza ordered per day
Ans) 
            





SELECT 
    AVG(quantity)
FROM
    (SELECT 
        orderss.order_date, SUM(order_details1.quantity) AS quantity
    FROM
        orderss
    JOIN order_details1 ON orderss.order_id = order_details1.order_id
    GROUP BY orderss.order_date);


10)	Determine the top 3 most ordered pizza type based on revenue
Ans) 
            
use pizzahuat;


SELECT 
    pizza_types.name,
    SUM(order_details1.quantity * pizzas1.price) AS revanue
FROM
    pizza_types
        JOIN
    pizzas1 ON pizza_types.pizza_type_id = pizzas1.pizza_type_id
        JOIN
    order_details1 ON order_details1.pizza_id = pizzas1.pizza_id
GROUP BY pizza_types.name
ORDER BY revanue DESC
LIMIT 3;
11)	Calculate the percentage contribution of each pizza type to total revenue
Ans)  
           SELECT 
    pizza_types.category,
    round(SUM(order_details1.quantity * pizzas1.price) / (SELECT 
            ROUND(SUM(order_details1.quantity * pizzas1.price),
                        2) AS total_sales
        FROM
            order_details1
                JOIN
            pizzas1 ON order_details1.pizza_id = pizzas1.pizza_id) * 100,2) AS revanue
FROM
    pizza_types
        JOIN
    pizzas1 ON pizza_types.pizza_type_id = pizzas1.pizza_type_id
        JOIN
    order_details1 ON order_details1.pizza_id = pizzas1.pizza_id
GROUP BY pizza_types.category
ORDER BY revanue DESC;
12)	Analyse the cumulative revenue generated over time
Ans) 
         



SELECT order_date,
sum(revanue) OVER(ORDER BY order_date) as cum_revenue
FROM


(SELECT orderss.order_date,
sum(order_details1.quantity * pizzas1.price) as revanue
FROM order_details1 JOIN pizzas1
on order_details1.pizza_id = pizzas1.pizza_id
JOIN orderss
on orderss.order_id = order_details1.order_id
GROUP BY orderss.order_date) as sales;
13)	Determine the top 3 most ordered pizza type based on revenue for each pizza category
Ans)
            
SELECT name, revanue FROM
(SELECT category, name, revanue,
rank() over (PARTITION BY category ORDER BY revanue DESC) as WOWOO
 from

(SELECT pizza_types.category, pizza_types.name,
sum(order_details1.quantity * pizzas1.price) as revanue
from pizza_types JOIN pizzas1
on pizza_types.pizza_type_id = pizzas1.pizza_type_id
JOIN order_details1
on order_details1.pizza_id = pizzas1.pizza_id
GROUP BY pizza_types.category, pizza_types.name) as tt)as b
WHERE wowoo <= 3; 

          
