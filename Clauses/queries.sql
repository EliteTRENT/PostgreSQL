Q1 select * from customers where city = 'New York';
->  cust_id | cust_name |        email        |   city   
---------+-----------+---------------------+----------
       1 | Aryan     | aryannegi@gmail.com | New York
       3 | Aman      | Aman@gmail.com      | New York
(2 rows)

Q2 select * from orders where order_date > '2025-01-12';
->  order_id | cust_id | order_date 
----------+---------+------------
        3 |       2 | 2025-01-13
        4 |       3 | 2025-01-25
(2 rows)

Q3 select * from products where price between 50 and 10000;
->  product_id | product_name | price 
------------+--------------+-------
          1 | IPhone 15    |  1400
(1 row)

Q4 select * from products order by price desc;
->  product_id | product_name | price 
------------+--------------+-------
          2 | PS5          | 85000
          3 | Bracelet     | 45000
          1 | IPhone 15    |  1400
         10 | Aalu         |    20
(4 rows)

Q5 select * from customers limit 2;
->  cust_id | cust_name |        email        |    city    
---------+-----------+---------------------+------------
       1 | Aryan     | aryannegi@gmail.com | New York
       2 | Aalekh    | aalumod@gmail.com   | Sonagacchi
(2 rows)

