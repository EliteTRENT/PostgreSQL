Q1 select c.cust_id, c.cust_name, o.order_id from customers c left join orders o on c.cust_id = o.cust_id;
-> cust_id | cust_name | order_id 
---------+-----------+----------
       1 | Aryan     |        1
       1 | Aryan     |        2
       2 | Aalekh    |        3
       3 | Aman      |        4
       5 | Aaria     |         
       4 | Priyansh  |         
(6 rows)

Q2 select p.product_id, p.product_name from products p left join inventories i ON p.product_id = i.product_id where i.product_id is null OR i.quantity = 0;
-> product_id | product_name 
------------+--------------
          3 | Product C
          4 | Product D
(2 rows)

Q3 select d.department_name, SUM(s.sale_amount) as total_sales from departments d inner join employees e on d.department_id = e.department_id 
   inner join sales s ON e.employee_id = s.employee_id group by d.department_name order by total_sales desc limit 1;
-> department_name | total_sales 
-----------------+-------------
 Sales           |     1200.00
(1 row)

Q4 select u.user_id, u.username from users u left join sessions s on u.user_id = s.user_id where s.session_id is null;
-> user_id | username 
---------+----------
       3 | charlie
(1 row)

Q5 select p.post_id, p.content, COUNT(l.like_id) as like_count from posts p inner join likes l on p.post_id = l.post_id group by p.post_id, p.content
   order by like_count desc limit 1;
-> post_id |      content      | like_count 
---------+-------------------+------------
       2 | Bob awesome post! |          2
(1 row)

