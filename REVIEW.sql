create database library;
CREATE DATABASE
\c library
`DDL`
Q1
create table books(book_id serial primary key, title varchar, author varchar, publication_year date, genre varchar);
CREATE TABLE
Table "public.books"
      Column      |       Type        | Collation | Nullable |                Default
------------------+-------------------+-----------+----------+----------------------------------------
 book_id          | integer           |           | not null | nextval('books_book_id_seq'::regclass)
 title            | character varying |           |          |
 author           | character varying |           |          |
 publication_year | date              |           |          |
 genre            | character varying |           |          |
Indexes:
    "books_pkey" PRIMARY KEY, btree (book_id)

Q2
create table members(member_id serial primary key, name varchar, address varchar, contact_number decimal);
CREATE TABLE

Table "public.members"
     Column     |       Type        | Collation | Nullable |                  Default
----------------+-------------------+-----------+----------+--------------------------------------------
 member_id      | integer           |           | not null | nextval('members_member_id_seq'::regclass)
 name           | character varying |           |          |
 address        | character varying |           |          |
 contact_number | numeric           |           |          |
Indexes:
    "members_pkey" PRIMARY KEY, btree (member_id)

Q3
create table borrowings(borrowing_id serial primary key, book_id int, member_id int, borrow_date date, due_date date, returned_date date, foreign key(book_id) references books(book_id), foreign key(member_id) references members(member_id));
CREATE TABLE

Table "public.borrowings"
    Column     |  Type   | Collation | Nullable |                     Default
---------------+---------+-----------+----------+--------------------------------------------------
 borrowing_id  | integer |           | not null | nextval('borrowings_borrowing_id_seq'::regclass)
 book_id       | integer |           |          |
 member_id     | integer |           |          |
 borrow_date   | date    |           |          |
 due_date      | date    |           |          |
 returned_date | date    |           |          |
Indexes:
    "borrowings_pkey" PRIMARY KEY, btree (borrowing_id)
Foreign-key constraints:
    "borrowings_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(book_id)
    "borrowings_member_id_fkey" FOREIGN KEY (member_id) REFERENCES members(member_id)


`DML`
insert into books(title,author,publication_year,genre)values('Book A','Author A','2025-01-10','Thriller');
INSERT 0 1
insert into books(title,author,publication_year,genre)values('Book B','Author B','2025-01-20','Thriller');
INSERT 0 1
insert into books(title,author,publication_year,genre)values('Book C','Author C','2025-01-20','Action');
INSERT 0 1
insert into books(title,author,publication_year,genre)values('Book D','Author D','2025-01-04','Adventure');
INSERT 0 1
insert into books(title,author,publication_year,genre)values('Book E','Author E','2025-01-08','Action');
INSERT 0 1

select * from books;
 book_id | title  |  author  | publication_year |   genre
---------+--------+----------+------------------+-----------
       1 | Book A | Author A | 2025-01-10       | Thriller
       2 | Book B | Author B | 2025-01-20       | Thriller
       3 | Book C | Author C | 2025-01-20       | Action
       4 | Book D | Author D | 2025-01-04       | Adventure
       5 | Book E | Author E | 2025-01-08       | Action
(5 rows)

insert into members(name,address,contact_number)values('Aryan','Ludhiana',7087077809);
INSERT 0 1
insert into members(name,address,contact_number)values('Aalekh','Una',7087067809);
INSERT 0 1
insert into members(name,address,contact_number)values('Aman','HP',8487067809);
INSERT 0 1
insert into members(name,address,contact_number)values('Ayush','GJ',7287067809);
INSERT 0 1
insert into members(name,address,contact_number)values('Agrim','JK',9887067809);
INSERT 0 1

select * from members;
 member_id |  name  | address  | contact_number
-----------+--------+----------+----------------
         1 | Aryan  | Ludhiana |     7087077809
         2 | Aalekh | Una      |     7087067809
         3 | Aman   | HP       |     8487067809
         4 | Ayush  | GJ       |     7287067809
         5 | Agrim  | JK       |     9887067809
(5 rows)


insert into borrowings(book_id,member_id,borrow_date,due_date,returned_date)values(1,1,'2026-01-01','2026-01-25','2026-01-24');
INSERT 0 1
insert into borrowings(book_id,member_id,borrow_date,due_date,returned_date)values(1,2,'2026-01-02','2026-01-30','2026-01-15');
INSERT 0 1
insert into borrowings(book_id,member_id,borrow_date,due_date,returned_date)values(2,5,'2026-01-05','2026-01-20','2026-01-10');
INSERT 0 1
insert into borrowings(book_id,member_id,borrow_date,due_date,returned_date)values(3,4,'2026-01-10','2026-01-12','2026-01-15');
INSERT 0 1
insert into borrowings(book_id,member_id,borrow_date,due_date,returned_date)values(4,5,'2026-01-10','2026-01-12','2026-01-20');
INSERT 0 1

select * from borrowings;
 borrowing_id | book_id | member_id | borrow_date |  due_date  | returned_date
--------------+---------+-----------+-------------+------------+---------------
            1 |       1 |         1 | 2026-01-01  | 2026-01-25 | 2026-01-24
            2 |       1 |         2 | 2026-01-02  | 2026-01-30 | 2026-01-15
            3 |       2 |         5 | 2026-01-05  | 2026-01-20 | 2026-01-10
            4 |       3 |         4 | 2026-01-10  | 2026-01-12 | 2026-01-15
            5 |       4 |         5 | 2026-01-10  | 2026-01-12 | 2026-01-20
(5 rows)

`DQL`
Q1 
select * from books where author = 'Author A';
 book_id | title  |  author  | publication_year |  genre
---------+--------+----------+------------------+----------
       1 | Book A | Author A | 2025-01-10       | Thriller
(1 row)

Q2
select m.name,b.title from borrowings bo inner join members m on bo.member_id = m.member_id inner join books b on b.book_id = bo.book_id where bo.
book_id = 1;
name  | title
--------+--------
 Aryan  | Book A
 Aalekh | Book A
(2 rows)

Q3
select b.book_id, b.title from books b inner join borrowings bo on b.book_id = bo.book_id where bo.returned_date > bo.due_date;
 book_id | title
---------+--------
       3 | Book C
       4 | Book D
(2 rows)

Q4
select m.name, count(book_id) from members m inner join borrowings bo on m.member_id = bo.member_id group by m.name;
  name  | count
--------+-------
 Aalekh |     1
 Aryan  |     1
 Ayush  |     1
 Agrim  |     2
(4 rows)

`TCL`
Q1
begin;
BEGIN
select * from borrowings;
 borrowing_id | book_id | member_id | borrow_date |  due_date  | returned_date
--------------+---------+-----------+-------------+------------+---------------
            1 |       1 |         1 | 2026-01-01  | 2026-01-25 | 2026-01-24
            2 |       1 |         2 | 2026-01-02  | 2026-01-30 | 2026-01-15
            3 |       2 |         5 | 2026-01-05  | 2026-01-20 | 2026-01-10
            4 |       3 |         4 | 2026-01-10  | 2026-01-12 | 2026-01-15
            5 |       4 |         5 | 2026-01-10  | 2026-01-12 | 2026-01-20
(5 rows)
insert into borrowings(book_id,member_id,borrow_date,due_date)values(5,2,2026-01-20,2026-01-25);
ERROR:  column "borrow_date" is of type date but expression is of type integer
rollback;
ROLLBACK
 select * from borrowings;
 borrowing_id | book_id | member_id | borrow_date |  due_date  | returned_date
--------------+---------+-----------+-------------+------------+---------------
            1 |       1 |         1 | 2026-01-01  | 2026-01-25 | 2026-01-24
            2 |       1 |         2 | 2026-01-02  | 2026-01-30 | 2026-01-15
            3 |       2 |         5 | 2026-01-05  | 2026-01-20 | 2026-01-10
            4 |       3 |         4 | 2026-01-10  | 2026-01-12 | 2026-01-15
            5 |       4 |         5 | 2026-01-10  | 2026-01-12 | 2026-01-20
(5 rows)

begin;
BEGIN
select * from members;
 member_id |  name  | address  | contact_number
-----------+--------+----------+----------------
         1 | Aryan  | Ludhiana |     7087077809
         2 | Aalekh | Una      |     7087067809
         3 | Aman   | HP       |     8487067809
         4 | Ayush  | GJ       |     7287067809
         5 | Agrim  | JK       |     9887067809
(5 rows)
insert into members(name,address,contact_number)values('Aalu','UP',7087088765);
INSERT 0 1
commit;
COMMIT
select * from members;
 member_id |  name  | address  | contact_number
-----------+--------+----------+----------------
         1 | Aryan  | Ludhiana |     7087077809
         2 | Aalekh | Una      |     7087067809
         3 | Aman   | HP       |     8487067809
         4 | Ayush  | GJ       |     7287067809
         5 | Agrim  | JK       |     9887067809
         6 | Aalu   | UP       |     7087088765
(6 rows)

`JOINS`
Q1
select m.name,b.title,bo.borrow_date from borrowings bo inner join members m on bo.member_id = m.member_id inner join books b on bo.book_id = b.bo
ok_id;
  name  | title  | borrow_date
--------+--------+-------------
 Aryan  | Book A | 2026-01-01
 Aalekh | Book A | 2026-01-02
 Agrim  | Book B | 2026-01-05
 Ayush  | Book C | 2026-01-10
 Agrim  | Book D | 2026-01-10
(5 rows)

