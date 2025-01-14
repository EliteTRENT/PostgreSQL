Q1 alter table products add constraint price_check check(price > 0);
ALTER TABLE
                      Table "public.products"
    Column    |       Type        | Collation | Nullable | Default 
--------------+-------------------+-----------+----------+---------
 product_id   | integer           |           |          | 
 product_name | character varying |           |          | 
 price        | numeric           |           |          | 
Check constraints:
    "price_check" CHECK (price > 0::numeric)

Q2 alter table customers add constraint uniq_email unique(email);
ALTER TABLE
                                     Table "public.customers"
  Column   |       Type        | Collation | Nullable |                  Default                   
-----------+-------------------+-----------+----------+--------------------------------------------
 cust_id   | integer           |           | not null | nextval('customers_cust_id_seq'::regclass)
 cust_name | character varying |           |          | 
 email     | character varying |           |          | 
Indexes:
    "uniq_email" UNIQUE CONSTRAINT, btree (email)

Q3 alter table employees add constraint age_check check(age between 18 and 65);
ALTER TABLE
                     Table "public.employees"
   Column    |       Type        | Collation | Nullable | Default 
-------------+-------------------+-----------+----------+---------
 employee_id | integer           |           |          | 
 first_name  | character varying |           |          | 
 last_name   | character varying |           |          | 
 salary      | numeric           |           |          | 
 age         | integer           |           |          | 
Check constraints:
    "age_check" CHECK (age >= 18 AND age <= 65)

Q4 create table orders(order_id serial primary key, cust_id int references customers(cust_id) on delete restrict);
CREATE TABLE
insert into customers(cust_name,email)values('Aryan','aryannegi@gmail.com');
insert into customers(cust_name,email)values('Aalekh','aalumod@gmail.com');
insert into orders(cust_id)values(1);
INSERT 0 1
INSERT 0 1
INSERT 0 1
delete from customers where cust_id = 1;
ERROR:  update or delete on table "customers" violates foreign key constraint "orders_cust_id_fkey" on table "orders"
DETAIL:  Key (cust_id)=(1) is still referenced from table "orders".
