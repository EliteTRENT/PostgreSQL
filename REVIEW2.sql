                          Table "public.students"
     Column      |          Type          | Collation | Nullable | Default
-----------------+------------------------+-----------+----------+---------
 student_id      | integer                |           | not null |
 first_name      | character varying(50)  |           |          |
 last_name       | character varying(50)  |           |          |
 enrollment_date | date                   |           |          |
 email           | character varying(100) |           |          |
Indexes:
    "students_pkey" PRIMARY KEY, btree (student_id)
    "students_email_key" UNIQUE CONSTRAINT, btree (email)
Referenced by:
    TABLE "enrollments" CONSTRAINT "enrollments_student_id_fkey" FOREIGN KEY (student_id) REFERENCES students(student_id)


                         Table "public.courses"
   Column    |          Type          | Collation | Nullable | Default
-------------+------------------------+-----------+----------+---------
 course_id   | integer                |           | not null |
 course_name | character varying(100) |           |          |
 credits     | integer                |           |          |
Indexes:
    "courses_pkey" PRIMARY KEY, btree (course_id)
Referenced by:
    TABLE "enrollments" CONSTRAINT "enrollments_course_id_fkey" FOREIGN KEY (course_id) REFERENCES courses(course_id)

                  Table "public.enrollments"
    Column     |     Type     | Collation | Nullable | Default
---------------+--------------+-----------+----------+---------
 enrollment_id | integer      |           | not null |
 student_id    | integer      |           |          |
 course_id     | integer      |           |          |
 grade         | numeric(3,2) |           |          |
Indexes:
    "enrollments_pkey" PRIMARY KEY, btree (enrollment_id)
Foreign-key constraints:
    "enrollments_course_id_fkey" FOREIGN KEY (course_id) REFERENCES courses(course_id)
    "enrollments_student_id_fkey" FOREIGN KEY (student_id) REFERENCES students(student_id)

             Table "public.coursestatistics"
    Column     |  Type   | Collation | Nullable | Default
---------------+---------+-----------+----------+---------
 course_id     | integer |           | not null |
 student_count | integer |           |          | 0
Indexes:
    "coursestatistics_pkey" PRIMARY KEY, btree (course_id)


Q1 
create procedure enrollstudent(en_id int, stu_id int,co_id int,p_grade decimal(3,2)) language plpgsql as $$ 
begin
    if not exists(select 1 from enrollments where student_id = stu_id and course_id = co_id) then
        insert into enrollments(enrollment_id,student_id, course_id, grade)values(en_id, stu_id, co_id, p_grade);
    else
        if p_grade is not null then
            update enrollments
            set grade = p_grade
            where student_id = stu_id and course_id = co_id;
        end if;
    end if;
end $$;
CREATE PROCEDURE
call enrollstudent(5004,3,102,4.77);
CALL
select * from enrollments;
 enrollment_id | student_id | course_id | grade
---------------+------------+-----------+-------
          5001 |          1 |       101 |  4.33
          5002 |          2 |       103 |  2.22
          5003 |          1 |       103 |  3.00
          5004 |          3 |       102 |  4.77
(4 rows)

Q2
create or replace function update_student_count()
returns trigger as $$
begin
if TG_OP = 'INSERT' then
update coursestatistics
set student_count = student_count+1
where NEW.course_id = course_id;
elsif TG_OP = 'DELETE' then
update coursestatistics
set student_count = student_count-1
where OLD.course_id = course_id;
end if;
return null;
end;
$$ language plpgsql;
CREATE FUNCTION

create trigger update_count_trigger
after insert or delete on enrollments
for each row execute function update_student_count();
CREATE TRIGGER

Q3
select * from students where student_id = (select student_id from enrollments group by student_id having count(course_id) >= 3);
 student_id | first_name | last_name | enrollment_date |       email
------------+------------+-----------+-----------------+--------------------
          1 | Aryan      | Negi      | 2025-01-01      | aryan123@gmail.com
(1 row)

select * from students where student_id = (select student_id from enrollments group by student_id having avg(grade) >= 8);
 student_id | first_name | last_name | enrollment_date | email
------------+------------+-----------+-----------------+-------
(0 rows)
`Result shows 0 rows because the following table defines the avg of every enrolled student`
` select avg(grade) from enrollments group by student_id;
        avg
--------------------
 4.1100000000000000
 4.7700000000000000
 2.2200000000000000
(3 rows)`

Q4 
create index idx_student_course on enrollments(student_id,course_id);
CREATE INDEX
select * from enrollments where student_id = 1 and course_id = 102;
 enrollment_id | student_id | course_id | grade
---------------+------------+-----------+-------
          5005 |          1 |       102 |  5.00
(1 row)
`Making a composite index is efficient because if we make two individual indexes for the same, psql would have to retrieve the data, merge
and then present it, which would be inefficient and time taking.`


create or replace function update_student_count()
returns trigger as $$
begin
if TG_OP = 'INSERT' then
update coursestatistics
set student_count = student_count+1
where NEW.course_id = course_id;
elsif TG_OP = 'DELETE' then
update coursestatistics
set student_count = student_count-1
where OLD.course_id = course_id;
end if;
return null;
end;
$$ language plpgsql;





