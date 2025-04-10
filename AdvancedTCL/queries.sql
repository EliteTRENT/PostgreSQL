--Problem 1: Transactional Insert With Error Simulation & Rollback

I/P: 
BEGIN;

INSERT INTO students ("Gender", "Caste", "coaching", "Class_ten_education", "twelve_education", "medium", "Class_X_Percentage", "Class_XII_Percentage", "Father_occupation", "Mother_occupation", "time", "Performance")
VALUES ('Female', 'OBC', 'Yes', 'CBSE', 'CBSE', 'English', 85.0, 90.2, 'Doctor', 'Teacher', 3, 'Pass');

select count(*) from students;

SELECT 1/0;

COMMIT;

select count(*) from students;

O/P: 
BEGIN

INSERT 0 1

count
-------
   667
(1 row)

ROLLBACK

ERROR:  division by zero

count
-------
   666
(1 row)


--Problem 2: Use of SAVEPOINT and ROLLBACK TO for Partial Undo

I/P:
BEGIN;

SAVEPOINT before_first;

INSERT INTO students ("Gender", "Caste", "coaching", "Class_ten_education", "twelve_education", "medium", "Class_X_Percentage", "Class_XII_Percentage", "Father_occupation", "Mother_occupation", "time", "Performance")
VALUES ('Male', 'SC', 'No', 'State Board', 'CBSE', 'Hindi', 76.0, 82.5, 'Farmer', 'Homemaker', 5, 'Pass');

SAVEPOINT after_first;


INSERT INTO students VALUES ('??', '??', '??', '??', '??', '??', -999, -999, '??', '??', 0, '??');

ROLLBACK TO after_first;


INSERT INTO students ("Gender", "Caste", "coaching", "Class_ten_education", "twelve_education", "medium", "Class_X_Percentage", "Class_XII_Percentage", "Father_occupation", "Mother_occupation", "time", "Performance")
VALUES ('Male', 'GEN', 'Yes', 'CBSE', 'CBSE', 'English', 91.5, 94.0, 'Engineer', 'Engineer', 4, 'Pass');

COMMIT;

O/P:
BEGIN

SAVEPOINT

INSERT 0 1

SAVEPOINT

ERROR:  invalid input syntax for type integer: "??"
LINE 1: INSERT INTO students VALUES ('??', '??', '??', '??', '??', '...')

ROLLBACK

INSERT 0 1

COMMIT

--Problem 3: Read only transaction

I/P 
BEGIN TRANSACTION READ ONLY;

SELECT "Gender", COUNT(*) 
FROM students 
GROUP BY "Gender";

COMMIT;

O/P
BEGIN

Gender | count
--------+-------
 female |   311
 Male   |     2
 male   |   355
(3 rows)

--Problem 4: Nested SAVEPOINTs With Stepwise Rollback

I/P
BEGIN;

SAVEPOINT s1;

INSERT INTO students ("Gender", "Caste", "coaching", "Class_ten_education", "twelve_education","medium", "Class_X_Percentage", "Class_XII_Percentage", "Father_occupation", "Mother_occupation", "time", "Performance"
) VALUES ('Female', 'General', 'Yes', 'CBSE', 'CBSE', 'English', 92, 95, 'Government Job', 'Teacher', 4, 'Good');

SAVEPOINT s2;

INSERT INTO students (
    "Gender", "Caste", "coaching", "Class_ten_education", "twelve_education",
    "medium", "Class_X_Percentage", "Class_XII_Percentage",
    "Father_occupation", "Mother_occupation", "time", "Performance"
) VALUES (
    'X', 'X', 'X', 'X', 'X',
    'X', -1, -1, 'X', 'X', 0, 'X'
);

ROLLBACK TO s2;

SAVEPOINT s3;

INSERT INTO students (
    "Gender", "Caste", "coaching", "Class_ten_education", "twelve_education",
    "medium", "Class_X_Percentage", "Class_XII_Percentage",
    "Father_occupation", "Mother_occupation", "time", "Performance"
) VALUES (
    'Male', 'SC', 'No', 'State Board', 'CBSE',
    'Hindi', 78, 81, 'Farmer', 'Homemaker', 2, 'Average'
);

COMMIT;

O/P
BEGIN

SAVEPOINT

INSERT 0 1

SAVEPOINT

INSERT 0 1

ROLLBACK

SAVEPOINT

INSERT 0 1

COMMIT

--Problem 5: Aborting Stale Transactions Using ROLLBACK Timeout (manually)

I/P
BEGIN;

SELECT 'Query completed after a 15-second delay' AS message, current_timestamp AS timestamp
WHERE pg_sleep(5) IS NOT NULL;

ROLLBACK;

O/P
BEGIN

 message                 |            timestamp
-----------------------------------------+----------------------------------
 Query completed after a 5-second delay | 2025-04-10 14:26:56.445843+05:30
(1 row)

ROLLBACK

--Problem 6: Transfer Concept: Move Students to 'Alumni' Table, Then Commit

I/P
BEGIN;

INSERT INTO alumni 
SELECT * FROM students 
WHERE "Performance" = 'Pass';

DELETE FROM students 
WHERE "Performance" = 'Pass';

COMMIT;

O/P
BEGIN

INSERT 0 2

DELETE 2

COMMIT


 select * from alumni;
 id  | Gender | Caste | coaching | Class_ten_education | twelve_education | medium  | Class_X_Percentage | Class_XII_Percentage | Father_occupation | Mother_occupation | time | Performance
-----+--------+-------+----------+---------------------+------------------+---------+--------------------+----------------------+-------------------+-------------------+------+-------------
 670 | Male   | SC    | No       | State Board         | CBSE             | Hindi   | 76.0               | 82.5                 | Farmer            | Homemaker         | 5    | Pass
 671 | Male   | GEN   | Yes      | CBSE                | CBSE             | English | 91.5               | 94.0                 | Engineer          | Engineer          | 4    | Pass
(2 rows)




 


