Q1 select * from agents where agent_salary > (select AVG(agent_salary) from agents);
 agent_name | agent_role | agent_salary
------------+------------+--------------
 Neon       | Duelist    |        75000
 Chamber    | Sentinel   |       120000
 Sage       | Sentinel   |        50000
(3 rows)

Q2 
`EXISTS: Checks if a subquery returns any rows. It returns TRUE if at least one row exists in the subquery. 
It is typically used for correlated subqueries and can be more efficient when the subquery is large.
IN: Checks if a value matches any value in a list or returned by a subquery. 
It is used when comparing a value against multiple possible values and is usually more straightforward for non-correlated subqueries.`

select * from employees e where exists (select 1 from departments d where e.dept_id = d.dept_id);
emp_id | emp_name  | dept_id
--------+-----------+---------
      6 | Aryan     |     101
      7 | Aalekh    |     105
      8 | Aman      |     103
      9 | Priyanshu |     102
     10 | Vishal    |     104
(5 rows)

select * from employees where dept_id in(select dept_id from departments);
 emp_id | emp_name  | dept_id
--------+-----------+---------
      6 | Aryan     |     101
      7 | Aalekh    |     105
      8 | Aman      |     103
      9 | Priyanshu |     102
     10 | Vishal    |     104
(5 rows)

Q3 select * from customers where cust_id = (select cust_id from orders group by cust_id order by count(order_id) desc limit 1);
 cust_id | cust_name
---------+-----------
       1 | Aryan
(1 row)

Q4 
select e.emp_name, e.emp_id, e.salary
from employees e, (select dept_id, avg(salary) as avg_salary from employees group by dept_id) as avg_salaries where e.dept_id = avg_salaries.dept_id 
and e.salary > avg_salaries.avg_salary;
 emp_name  | emp_id | salary
-----------+--------+--------
 Priyanshu |      9 |  89000
 Vishal    |     10 |  45000
(2 rows)

Q5 select * from departments where dept_id = (select dept_id from employees group by dept_id order by avg(salary) desc limit 1);
dept_id | dept_name
---------+-----------
     102 | Sales
(1 row)

Q6 
`Common performance issues with subqueries include:
1) Redundant Execution: Subqueries in WHERE or SELECT clauses may execute multiple times for each row of the outer query, leading to inefficiency.
2) Inefficient Nested Queries: Subqueries in the FROM or SELECT clause can be slow, especially with large datasets or complex operations.`

Q7 
`To optimize subqueries for better performance:
1) Use EXISTS Instead of IN: EXISTS is more efficient for correlated subqueries as it stops once a match is found.
2) Convert Subqueries to Joins: Replace subqueries in WHERE clauses with JOIN to avoid redundant execution.`

Q8 select emp_id, emp_name, salary from employees where salary > (select avg(salary) from employees where dept_id = (select dept_id from employees where emp_id = 6));
emp_id | emp_name  | salary
--------+-----------+--------
      9 | Priyanshu |  89000
(1 row)

Q9 select * from employees where emp_name in(select emp_name from employees group by emp_name having count(emp_name) > 1);
emp_id | emp_name | dept_id | salary
--------+----------+---------+--------
      6 | Aryan    |     101 |  50000
      7 | Aalekh   |     105 |  10000
     11 | Aryan    |     102 |  20000
     12 | Aalekh   |     104 |      5
(4 rows)

Q10 
`Some real-world examples are:
1) Customer Data Analysis: A subquery can be used to find customers with the highest total purchase amounts 
by first calculating individual customer totals in a subquery and then selecting the customer records with the highest totals.
2)Employee Performance: A subquery can identify employees who have exceeded performance targets. 
For example, finding employees whose sales are higher than the department's average sales.`

