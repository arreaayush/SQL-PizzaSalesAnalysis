-- Intermediate
#1 Join the necessary tables to find the total quantity of each pizza category ordered.
------------------------------------------------------------------------------------------

SELECT 
    SUM(order_details.quantity) AS Total_quantity,
    pizza_types.category
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY Total_quantity DESC; 

#2 Determine the distribution of orders by hour of the day.
------------------------------------------------------------

SELECT 
    HOUR(order_time) AS HoursOfTheDay, COUNT(order_id)
FROM
    orders
GROUP BY HoursOfTheDay;

#3 Join relevant tables to find the category-wise distribution of pizzas.
-------------------------------------------------------------------------

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

#4 Group the orders by date and calculate the average number of pizzas ordered per day.
-----------------------------------------------------------------------------------------

SELECT 
    ROUND(AVG(Quantity), 0) AS avg_pizza_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS Quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS data;

#5 Determine the top 3 most ordered pizza types based on revenue.
--------------------------------------------------------------------

SELECT 
    pizza_types.name,
    SUM(pizzas.price * order_details.quantity) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC
LIMIT 3;