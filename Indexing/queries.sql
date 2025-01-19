 order_id | customer_name | order_date | total_amount
----------+---------------+------------+--------------
        1 | John Doe      | 2025-01-01 |       250.00
        2 | Jane Smith    | 2025-01-05 |       500.50
        3 | Alice Brown   | 2025-01-07 |       125.00
        4 | Bob White     | 2025-01-03 |       300.00
        5 | Charlie Black | 2025-01-10 |       150.75
(5 rows)

Q1
create index idx_customer_name on customer_orders (customer_name);
CREATE INDEX
create index idx_order_date on customer_orders (order_date);
CREATE INDEX
select * from customer_orders where customer_name = 'Bob White';
 order_id | customer_name | order_date | total_amount
----------+---------------+------------+--------------
        4 | Bob White     | 2025-01-03 |       300.00
(1 row)





 product_id | product_name |             product_description              | price
------------+--------------+----------------------------------------------+--------
          1 | Product A    | High-quality leather jacket for men.         | 150.00
          2 | Product B    | Stylish cotton T-shirt with graphic design.  |  25.00
          3 | Product C    | Comfortable sneakers for everyday wear.      |  60.00
          4 | Product D    | Classic wool scarf for cold weather.         |  40.00
          5 | Product E    | Durable hiking boots for outdoor adventures. | 120.00
(5 rows)

Q2 
create index idx_product_description on products using gin(to_tsvector('english', product_description));
CREATE INDEX
select * from products where to_tsvector('english', product_description) @@ to_tsquery('english', 'leather');
 product_id | product_name |         product_description          | price
------------+--------------+--------------------------------------+--------
          1 | Product A    | High-quality leather jacket for men. | 150.00
(1 row)
