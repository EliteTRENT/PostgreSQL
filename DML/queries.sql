Q1 insert into staff(employee_id,first_name,last_name,salary)values(1,'Aryan','Negi',30000);
   insert into staff(employee_id,first_name,last_name,salary)values(2,'Aalekh','Modgil',10000);
   insert into staff(employee_id,first_name,last_name,salary)values(3,'Aman','Sharma',5000);
-> INSERT 0 1
   INSERT 0 1
   INSERT 0 1

Q2 select * from staff;
-> 
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           1 | Aryan      | Negi      |  30000
           2 | Aalekh     | Modgil    |  10000
           3 | Aman       | Sharma    |   5000
(3 rows)

Q3 select first_name,last_name from staff;
-> 
 first_name | last_name 
------------+-----------
 Aryan      | Negi
 Aalekh     | Modgil
 Aman       | Sharma
(3 rows)

Q4 update staff set salary = 50000 where employee_id = 1;
-> UPDATE 1
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           2 | Aalekh     | Modgil    |  10000
           3 | Aman       | Sharma    |   5000
           1 | Aryan      | Negi      |  50000
(3 rows)

Q5 delete from staff where employee_id = 3;
-> DELETE 1
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           2 | Aalekh     | Modgil    |  10000
           1 | Aryan      | Negi      |  50000
(2 rows)

Q6 select * from staff where salary > 40000;
->
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           1 | Aryan      | Negi      |  50000
(1 row)

Q7 insert into products(product_id,product_name,price)values(1,'IPhone 15', 112000);
   insert into products(product_id,product_name,price)values(2,'PS5', 85000);
   insert into products(product_id,product_name,price)values(3,'Bracelet', 45000);
   insert into products(product_id,product_name,price)values(4,'Tuxedo', 9500);
   insert into products(product_id,product_name,price)values(5,'Blazer', 11500);
-> INSERT 0 1
   INSERT 0 1
   INSERT 0 1
   INSERT 0 1
   INSERT 0 1
 product_id | product_name | price  
------------+--------------+--------
          1 | IPhone 15    | 112000
          2 | PS5          |  85000
          3 | Bracelet     |  45000
          4 | Tuxedo       |   9500
          5 | Blazer       |  11500
(5 rows)

Q8 update products set price = 11000 where product_id = 4;
-> UPDATE 1
 product_id | product_name | price  
------------+--------------+--------
          1 | IPhone 15    | 112000
          2 | PS5          |  85000
          3 | Bracelet     |  45000
          5 | Blazer       |  11500
          4 | Tuxedo       |  11000
(5 rows)

Q9 select * from products where price between 20000 and 100000;
->
 product_id | product_name | price 
------------+--------------+-------
          2 | PS5          | 85000
          3 | Bracelet     | 45000
(2 rows)

Q10 delete from products where price < 20000;
-> DELETE 2
 product_id | product_name | price  
------------+--------------+--------
          1 | IPhone 15    | 112000
          2 | PS5          |  85000
          3 | Bracelet     |  45000
(3 rows)

