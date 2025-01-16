 item_id | order_id | product_name | product_price | quantity
---------+----------+--------------+---------------+----------
       1 |      101 | Laptop       |      75000.00 |        1
       2 |      101 | Mouse        |        500.00 |        2
       3 |      102 | Keyboard     |       1500.00 |        1
       4 |      103 | Monitor      |      12000.00 |        1
       5 |      103 | Webcam       |       4000.00 |        1
(5 rows)

Q1 select order_id, sum(product_price*quantity) as total_sales from order_items group by order_id;
 order_id | total_sales
----------+-------------
      101 |    76000.00
      103 |    16000.00
      102 |     1500.00


 cust_id |     name
---------+---------------
       1 | John Doe
       2 | Jane Smith
       3 | Alice Johnson
       4 | Bob Brown
       5 | Charlie Davis
(5 rows)

 order_id | cust_id | order_date
----------+---------+------------
      101 |       1 | 2025-01-10
      102 |       2 | 2025-01-11
      103 |       3 | 2025-01-12
      104 |       4 | 2025-01-13
      105 |       5 | 2025-01-14
      106 |       1 | 2025-02-12
      107 |       3 | 2025-03-01
      108 |       4 | 2025-04-08
(8 rows)

Q2 select c.cust_id,c.name,o.order_id from customers c inner join orders o on c.cust_id = o.cust_id where (CURRENT_DATE-o.order_date) <= 30 and o.order_date <= CURRENT_DATE;

 cust_id |     name      | order_id
---------+---------------+----------
       1 | John Doe      |      101
       2 | Jane Smith    |      102
       3 | Alice Johnson |      103
       4 | Bob Brown     |      104
       5 | Charlie Davis |      105
(5 rows)
