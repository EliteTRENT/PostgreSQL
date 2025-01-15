Q6. select 
    least(oi1.product_id, oi2.product_id) AS product_id_1,
    greatest(oi1.product_id, oi2.product_id) AS product_id_2,
    count(*) as pair_count
   from
       order_items oi1
   inner join 
       order_items oi2 
       on oi1.order_id = oi2.order_id and oi1.product_id < oi2.product_id
   group by 
       LEAST(oi1.product_id, oi2.product_id),
       GREATEST(oi1.product_id, oi2.product_id)
   order by 
       product_id_1, product_id_2;


 product_id | product_id | pair_count 
------------+------------+------------
          3 |          4 |          1
          1 |          2 |          1
          2 |          5 |          1
(3 rows)
Q7 select c.cust_id, c.cust_name, a.account_id, t.transaction_id, t.transaction_amount, t.transaction_date from customers c inner join accounts a on c.cust_id = a.cust_id 
   inner join transactions t on a.account_id = t.account_id where t.transaction_amount >= 5000;
-> cust_id | cust_name | account_id | transaction_id | transaction_amount |  transaction_date   
---------+-----------+------------+----------------+--------------------+---------------------
       2 | Aalekh    |          2 |              3 |           15000.00 | 2025-01-11 15:00:00
       3 | Aman      |          3 |              4 |            5000.00 | 2025-01-12 09:45:00
(2 rows)

Q8 select p.patient_id, p.name from patients p left join appointments a on p.patient_id = a.patient_id 
   and a.appointment_date >= current_date - interval '1 year' where a.appointment_id is null;
-> patient_id |    name    
------------+------------
          1 | Aryan Negi
(1 row)

Q9 select s.student_id, s.name, c.course_name, g.grade from students s inner join grades g on s.student_id = g.student_id 
   inner join courses c on g.course_id = c.course_id where g.grade < 50;
-> student_id |     name     | course_name | grade 
------------+--------------+-------------+-------
          1 | John Doe     | Mathematics |    45
          3 | Alex Johnson | English     |    40
          2 | Jane Smith   | Science     |    35
(3 rows)

Q10 select s.supplier_id, s.supplier_name from suppliers s left join orders o on s.supplier_id = o.supplier_id and o.order_date >= current_date - interval '3 months'
    where o.order_id is null;
-> supplier_id | supplier_name 
-------------+---------------
           2 | Supplier B
           1 | Supplier A
           3 | Supplier C
(3 rows)

