Q1 create procedure add_employee(name varchar, salary int) language plpgsql as $$
begin
    insert into employees (emp_name,salary)
    values (name, salary);
end;
$$;
CREATE PROCEDURE
 List of functions
 Schema |     Name     | Result data type |       Argument data types       | Type
--------+--------------+------------------+---------------------------------+------
 public | add_employee |                  | IN name varchar, IN salary int | proc
(1 row)

Q2 call add_employee('john doe', 50000);
CALL
 emp_id | emp_name  | dept_id | salary
--------+-----------+---------+--------
      6 | Aryan     |     101 |  50000
      7 | Aalekh    |     105 |  10000
      8 | Aman      |     103 |   5000
      9 | Priyanshu |     102 |  89000
     10 | Vishal    |     104 |  45000
     11 | Aryan     |     102 |  20000
     12 | Aalekh    |     104 |      5
     13 | john doe  |         |  50000
(8 rows)

Q3 create function get_employees() returns table(id int, name varchar, salary int) language plpgsql as $$
begin
    return query select employees.emp_id, employees.emp_name, employees.salary from employees;
end;
$$;
CREATE FUNCTION
select * from get_employees();
 id |   name    | salary
----+-----------+--------
  6 | Aryan     |  50000
  7 | Aalekh    |  10000
  8 | Aman      |   5000
  9 | Priyanshu |  89000
 10 | Vishal    |  45000
 11 | Aryan     |  20000
 12 | Aalekh    |      5
 13 | john doe  |  50000
(8 rows)

Q4 
`Benefits of using stored procedures
1) Reduces network latency for repeated operations
2) Enables bulk operations and transaction management
3) Encapsulates business logic for reusability
4) Improves security by restricting direct table access
5) Centralizes maintenance of business logic`

Q5 
`Drawbacks of using stored procedures
1) Complex to debug and maintain
2) Database-specific code limits portability
3) Harder to test and integrate with version control
4) Can cause database bottlenecks if not optimized`

Q6 
`1)Using RAISE Statements:
The RAISE statement, such as RAISE NOTICE, can be used to print messages during procedure execution. 
It allows you to display variable values or messages at different points in the procedure. For example, inserting RAISE NOTICE 'Processing step %', step_variable; helps trace the flow of the procedure.
2) Exception Handling:
Encapsulating code within 
BEGIN ... EXCEPTION blocks enables error capturing. The WHEN OTHERS clause can be used to catch any unexpected errors and log them using RAISE NOTICE or RAISE EXCEPTION.`

Q7 grant execute on procedure add_employee to postgres;
GRANT

Q8 
`Using stored procedures to improve application performance
1) Reduces network overhead by batching database interactions
2) Ensures efficient execution of complex operations
3) Encapsulates optimized queries for better performance`

Q9 
`Common use cases for stored procedures
1) Enforcing business rules
2) Auditing data changes
3) Executing scheduled jobs
4) Managing large data operations`

Q10 
create procedure safe_add_employee(name text, salary numeric) language plpgsql as $$
begin
    insert into employees (employee_name, employee_salary)
    values (name, salary);
exception
    when others then
        raise notice 'error: %', sqlerrm;
end;
$$;
CREATE PROCEDURE

