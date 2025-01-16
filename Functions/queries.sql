Q1
`Functions:
Must return a value (scalar, table, or other types).
Can be used in SQL queries, SELECT statements, or other functions.
Side effects (like modifying data) are generally not recommended but possible using VOLATILE functions.
Stored Procedures:
Do not return a value but allow output parameters.
Designed for executing procedural code, including transaction control (e.g., COMMIT/ROLLBACK).
Called using the CALL statement.`

Q2
create function add_numbers(a int, b int) returns int language plpgsql as $$
begin
    return a + b;
end;
$$;
CREATE FUNCTION
select add_numbers(5, 10);
 add_numbers
-------------
          15
(1 row)

Q3 create function square_number(x int) returns int language plpgsql as $$
begin
    return x * x;
end;
$$;
CREATE FUNCTION
select square_number(4);
 square_number
---------------
            16
(1 row)

Q4 
`Yes, functions can have side effects, such as modifying data in the database, but this is discouraged unless absolutely necessary. 
Side effects are allowed by defining the function as VOLATILE.`

Q5 
`Common Data Types That Can Be Returned by a Function
Functions in PostgreSQL can return:

1) Scalar types (e.g., int, text, boolean).
2) Composite types (e.g., table rows or custom types).
3) Tables (using RETURNS TABLE).
4) Arrays or JSON.`

Q6 create function calculate_tax(amount numeric) returns numeric language plpgsql as $$
begin
    return amount * 0.18;
end;
$$;
CREATE FUNCTION
select calculate_tax(1000);
 calculate_tax
---------------
        180.00
(1 row)

Q7 create function calculate_bonus(salary numeric, years int) returns numeric language plpgsql as $$
begin
    if years > 10 then
        return salary * 0.20;
    else
        return salary * 0.10;
    end if;
end;
$$;
CREATE FUNCTION
select calculate_bonus(50000, 12);
 calculate_bonus
-----------------
        10000.00
(1 row)

Q8 
`Performance Considerations When Using Functions
1) Avoid using functions in large datasets within WHERE clauses, as this can lead to poor performance.
2) Use IMMUTABLE or STABLE attributes for functions when applicable to allow caching.
3) Inline functions (language sql) are faster for simple calculations.`

Q9 create function calculate_discount(price numeric, customer_type text) returns numeric language plpgsql as $$
begin
    if customer_type = 'premium' then
        return price * 0.80; -- 20% discount
    else
        return price;
    end if;
end;
$$;
CREATE FUNCTION
select calculate_discount(1000, 'premium');
 calculate_discount
--------------------
             800.00
(1 row)

Q10 
`Examples of Built-in Functions in PostgreSQL`
select upper('hello world');
    upper
-------------
 HELLO WORLD
(1 row)


select length('hello');
 length
--------
      5
(1 row)

select round(3.14159, 2);
 round
-------
  3.14
(1 row)

select sqrt(16);
 sqrt
------
    4
(1 row)





