SELECT p.prod_category,
       COALESCE(Sum(c.unit_price), 0) AS total_sales_amount
FROM   sh.products p
       LEFT JOIN sh.sales s
              ON p.prod_id = s.prod_id
                 AND s.time_id BETWEEN '1999-01-01' AND '1999-06-06'
       LEFT JOIN sh.costs c
              ON p.prod_id = c.prod_id
GROUP  BY p.prod_category; 


SELECT c.country_region     AS region,
       Avg(s.quantity_sold) AS average_sales_quantity
FROM   sh.sales s
       JOIN sh.products p
         ON s.prod_id = p.prod_id
       JOIN sh.channels ch
         ON s.channel_id = ch.channel_id
       JOIN sh.customers cust
         ON s.cust_id = cust.cust_id
       JOIN sh.countries c
         ON cust.country_id = c.country_id
WHERE  p.prod_id = 123  
GROUP  BY c.country_region; 

WITH customersales AS
(
         SELECT   c.cust_id,
                  c.cust_first_name,
                  c.cust_last_name,
                  Sum(s.amount_sold) AS total_sales_amount
         FROM     sh.sales s
         JOIN     sh.customers c
         ON       s.cust_id = c.cust_id
         GROUP BY c.cust_id,
                  c.cust_first_name,
                  c.cust_last_name )
SELECT   cust_id,
         cust_first_name,
         cust_last_name,
         total_sales_amount
FROM     customersales
ORDER BY total_sales_amount DESC limit 5;
