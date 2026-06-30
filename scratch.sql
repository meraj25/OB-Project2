##LW201-Practiced the core statements such as  SELECT, INSERT, UPDATE, DELETE, and the WHERE, ORDER BY, and LIMIT clauses##


CREATE DATABASE scratch;
--CREATE DATABASE

\c scratch
--You are now connected to database "scratch" as user "postgres"

CREATE TABLE student (name varchar(80), age int, address varchar(80), class varchar(10));
--CREATE TABLE

DROP TABLE student;
--DROP TABLE

INSERT INTO student VALUES ('Meraj Devapriya', 23, '108/2 Peradeniya', '11-E');
--INSERT 0 1

INSERT INTO student (name,age,class) VALUES ('Pasan Bandara', 22, '10-E');
--INSERT 0 1
--I added more data later

SELECT * FROM student;
--      name       | age |     address      | class
-------------------+-----+------------------+-------
-- Meraj Devapriya |  23 | 108/2 Peradeniya | 11-E
-- Pasan Bandara   |  22 |                  | 10-E
--(2 rows)

SELECT name,address,class FROM student;
--      name       |     address      | class
-------------------+------------------+-------
-- Meraj Devapriya | 108/2 Peradeniya | 11-E
-- Pasan Bandara   |                  | 10-E
--(2 rows)

SELECT * FROM student WHERE name = 'Meraj Devapriya' AND age = 23;
--      name       | age |     address      | class
-------------------+-----+------------------+-------
-- Meraj Devapriya |  23 | 108/2 Peradeniya | 11-E
--(1 row)

SELECT * FROM student ORDER BY age;
--      name       | age |     address      | class
-------------------+-----+------------------+-------
-- Pasan Bandara   |  22 |                  | 10-E
-- Meraj Devapriya |  23 | 108/2 Peradeniya | 11-E
--(2 rows)

SELECT DISTINCT name FROM STUDENT;
--       name
--------------------
-- Dhamika Liyanage
-- Meraj Devapriya
-- Pasan Bandara
-- Kasun Rathnayaka
--(4 rows)

SELECT DISTINCT name FROM student ORDER BY name ;
--       name
------------------
-- Dhamika Liyanage
-- Kasun Rathnayaka
-- Meraj Devapriya
-- Pasan Bandara
--(4 rows)

SELECT * FROM student JOIN grades on student.class = grades.class;
--      name       | age |       address       | class | class | total_students
--------------------+-----+---------------------+-------+-------+----------------
-- Meraj Devapriya  |  23 | 108/2 Godagandeniya | 11-E  | 11-E  |             50
-- Meraj Devapriya  |  23 | 108/2 Peradeniya    | 11-E  | 11-E  |             50
-- Dhamika Liyanage |  21 | 11/A Pilimathalawa  | 9-A   | 9-A   |             52
-- Pasan Bandara    |  22 |                     | 10-E  | 10-E  |             50
--(4 rows)

SELECT * FROM student LEFT OUTER JOIN grades ON student.class = grades.class;

--    name       | age |       address       | class | class | total_students
--------------------+-----+---------------------+-------+-------+----------------
-- Meraj Devapriya  |  23 | 108/2 Godagandeniya | 11-E  | 11-E  |             50
-- Meraj Devapriya  |  23 | 108/2 Peradeniya    | 11-E  | 11-E  |             50
--Dhamika Liyanage |  21 | 11/A Pilimathalawa  | 9-A   | 9-A   |             52
-- Pasan Bandara    |  22 |                     | 10-E  | 10-E  |             50
-- Kasun Rathnayaka |  23 | 32/B Digana         | 11-B  |       |
--(5 rows)

SELECT * FROM student RIGHT OUTER JOIN grades ON student.class = grades.class;

--       name       | age |       address       | class | class | total_students
--------------------+-----+---------------------+-------+-------+----------------
-- Meraj Devapriya  |  23 | 108/2 Godagandeniya | 11-E  | 11-E  |             50
-- Meraj Devapriya  |  23 | 108/2 Peradeniya    | 11-E  | 11-E  |             50
-- Dhamika Liyanage |  21 | 11/A Pilimathalawa  | 9-A   | 9-A   |             52
--                  |     |                     |       | 12-A  |             49
-- Pasan Bandara    |  22 |                     | 10-E  | 10-E  |             50
--(5 rows)

SELECT max(age) FROM student;
--max
-------
--  23
--(1 row)

SELECT name FROM student WHERE age = (SELECT max(age) FROM student);
--    name
--------------------
-- Meraj Devapriya
-- Meraj Devapriya
-- Kasun Rathnayaka
--(3 rows)

SELECT name FROM student WHERE age = (SELECT min(age) FROM student);
--       name
--------------------
-- Dhamika Liyanage
--(1 row)


UPDATE student SET age = age+1 WHERE name = 'Meraj Devapriya';
--UPDATE 2

SELECT * FROM student;
--       name       | age |       address       | class
--------------------+-----+---------------------+-------
--Pasan Bandara    |  22 |                     | 10-E
--Dhamika Liyanage |  21 | 11/A Pilimathalawa  | 9-A
--Kasun Rathnayaka |  23 | 32/B Digana         | 11-B
--Meraj Devapriya  |  24 | 108/2 Peradeniya    | 11-E
--Meraj Devapriya  |  24 | 108/2 Godagandeniya | 11-E
--(5 rows)


SELECT * FROM student ORDER BY age LIMIT 2;
--      name       | age |      address       | class
--------------------+-----+--------------------+-------
--Dhamika Liyanage |  21 | 11/A Pilimathalawa | 9-A
--Pasan Bandara    |  22 |                    | 10-E
--(2 rows)

DELETE FROM student WHERE name='Meraj Devapriya' AND address = '108/2 Peradeniya';
--DELETE 1

