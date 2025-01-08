Q1 grant select on staff to postgres;
GRANT
create user Aryan;
create user Aalekh;
create user Aman;
CREATE ROLE
CREATE ROLE
CREATE ROLE
Q2 grant insert on staff to Aryan,Aalekh,Aman;
GRANT
Q3 revoke update on staff from Aryan;
REVOKE
Q4 grant all privileges on products to Aryan;
GRANT
Q5 revoke delete on products from public;
REVOKE
Q6 grant select,insert on departments to Aryan;
GRANT
            List of relations
 Schema |    Name     | Type  |  Owner   
--------+-------------+-------+----------
 public | departments | table | postgres
 public | products    | table | postgres
 public | staff       | table | postgres
(3 rows)

Q7 revoke all privileges on departments from Aryan;
REVOKE
Q8 create schema sales;
grant usage on schema sales to Aryan;
CREATE SCHEMA
GRANT
Q9 revoke usage on schema sales from Aryan, Aalekh, Aman;
REVOKE
Q10 grant connect on database company to Aryan;
GRANT
