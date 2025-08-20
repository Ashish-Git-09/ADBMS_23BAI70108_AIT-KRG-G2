use DB_DEMO
/*
EXPERIMENT 3: SUB QUERIES
DEF : SUB-QUERIES / NESTED QUERIES
Q1(Q2(Q3)) ---> EXECUTION ORDER = Q3 -> Q2 -> Q1
MAIN OPERATIONS : 0. =
				  1. IN : Used to compare multiple values
				  2. NOT IN
				  3. ANY
				  4. ALL

TYPES OF SUBQUERIES:
	1. SCALAR SQ : Returns only one value -> 8, ashish, 99.9
			Operators: <, >, <=, >= != (<>)
	2. MULTI - VALUED / MULTI-ROW SQ : WHICH RETURNS MULTIPLE ROWS
			Operators: IN, NOT IN, ANY(OR), ALL(AND)
	3. SELF - CONTAINED SQ: SQ WHICH HAVE NO DEPENDENCY ON MAIN QUERY
			Q1 (Q2) -> Q2 doesnt have dependency on Q1
	4. CO - RELATED SQ: INNER QUERY WILL BE DEPENDENT ON OUTER QUERY
			Q1 (Q2)

PLACEMENT OF SUBQUERIES:
	1. We can use SQ with the where clause
	2. SQ with select command
	3. SQ in from clause
*/
--------------------------------------------------------------------
CREATE TABLE MyEmployees (
    EmpId INT PRIMARY KEY IDENTITY(1,1),
    EmpName VARCHAR(50),
    Gender VARCHAR(10),
    Salary INT,
    City VARCHAR(50),
    Dept_id INT
);
INSERT INTO MyEmployees (EmpName, Gender, Salary, City, Dept_id)
VALUES
('Amit', 'Male', 50000, 'Delhi', 2),
('Priya', 'Female', 60000, 'Mumbai', 1),
('Rajesh', 'Male', 45000, 'Agra', 3),
('Sneha', 'Female', 55000, 'Delhi', 4),
('Anil', 'Male', 52000, 'Agra', 2),
('Sunita', 'Female', 48000, 'Mumbai', 1),
('Vijay', 'Male', 47000, 'Agra', 3),
('Ritu', 'Female', 62000, 'Mumbai', 2),
('Alok', 'Male', 51000, 'Delhi', 1),
('Neha', 'Female', 53000, 'Agra', 4),
('Simran', 'Female', 33000, 'Agra', 3);
----------------------------------------------------------------------

create table dept(
	id int unique not null, 
	Dept_Name varchar(20) not null
)

insert into dept values(1, 'Accounts');
insert into dept values(2, 'HR');
insert into dept values(3, 'Admin');
insert into dept values(4, 'Counselling');
----------------------------------------------------------------------------
SELECT *FROM MyEmployees
-- FIND THE SECOND HIGHEST SALARY FROM EMP RELATION
--1. FIND THE MAX SALARY - 78000
--2. FIND THE MAX SALARY : (NOT INCLUDE 78000)

--AGG FUN: AVG, SUM , COUNT, MIN, MAX
SELECT MAX(SALARY) AS [2ND_HIGHEST] FROM MyEmployees WHERE SALARY !=
(SELECT MAX(SALARY) FROM MyEmployees) --62000

SELECT *FROM MyEmployees
SELECT *FROM DEPT
----------------------------------------------------------------------------
--SCALER SUB-QUERY (REPLACEMENT ON JOIN) --JOIN 2 TABLES BY SQ

--1. SQ IN WHERE CLAUSE
--2. SQ IN SELECT COMMAND
--3. SQ IN FROM CLAUSE

SELECT *FROM MyEmployees
WHERE DEPT_ID IN 
(SELECT ID FROM DEPT WHERE DEPT_NAME = 'Accounts')
----------------------------------------------------------------------------
--MULTI-ROW / MULTI-VALUED SQ:
SELECT *FROM MyEmployees
WHERE EMPNAME IN
(SELECT EMPNAME FROM MyEmployees WHERE GENDER ='Female')
----------------------------------------------------------------------------
--CO-RELATED SQ
/*
	1. ALIAS ARE VERY MUCH USED WITH CO-RELATED SQ
	2. IT IS NOT MUCH USED, AS IT HAS A LOT OF OVERHEAD
	
*/
SELECT *FROM MyEmployees AS E
WHERE E.DEPT_ID IN
(SELECT D.ID FROM DEPT AS D WHERE E.GENDER ='Female')
-------------------------------------------------------------------------------
--ANY AND ALL OPERATOR WITH SUB-QUERIES
-- [ANY OPERATOR] - its like OR
select *from MyEmployees 
where Salary < ANY
(Select Salary from MyEmployees where EmpName = 'Amit' or EmpName = 'Anil') --result (50000, 54000)
--eg: it returns 50000,54000, now it will compare from both the output of SQ one by one.
--will return all rows where salary is less then 50000 or salary is less than 54000
----------------------------------------------------------------------------------------------------------
-- [ALL OPERATOR] - its like AND
select *from MyEmployees 
where Salary < ALL
(Select Salary from MyEmployees where EmpName = 'Amit' or EmpName = 'Anil') --result (50000, 54000)
----------------------------------------------------------------------------------------------------------

----------------EXPERIMENT 3: EASY-----------------
CREATE TABLE Employee (
    id INT
);

INSERT INTO Employee (id) VALUES
(2),
(4),
(4),
(6),
(6),
(7),
(8),
(8);

SELECT MAX(id) AS max_unique_id
FROM Employee WHERE id IN (
    SELECT id
    FROM Employee
    GROUP BY id
    HAVING COUNT(id) = 1
);
------------------------------------------------------------------------------------

-------------------------------PRACTISE_SET----------------------------------
CREATE TABLE TBL_PRODUCTS
(
	ID INT PRIMARY KEY IDENTITY,
	[NAME] NVARCHAR(50),
	[DESCRIPTION] NVARCHAR(250) 
)

CREATE TABLE TBL_PRODUCTSALES
(
	ID INT PRIMARY KEY IDENTITY,
	PRODUCTID INT FOREIGN KEY REFERENCES TBL_PRODUCTS(ID),
	UNITPRICE INT,
	QUALTITYSOLD INT
)

INSERT INTO TBL_PRODUCTS VALUES ('TV','52 INCH BLACK COLOR LCD TV')
INSERT INTO TBL_PRODUCTS VALUES ('LAPTOP','VERY THIIN BLACK COLOR ACER LAPTOP')
INSERT INTO TBL_PRODUCTS VALUES ('DESKTOP','HP HIGH PERFORMANCE DESKTOP')

INSERT INTO TBL_PRODUCTSALES VALUES (3,450,5)
INSERT INTO TBL_PRODUCTSALES VALUES (2,250,7)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,4)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,9)

SELECT *FROM TBL_PRODUCTS
SELECT *FROM TBL_PRODUCTSALES

--Q1: fetch id , name , description of product which has not been sold for atleast once
SELECT ID, NAME, DESCRIPTION
FROM TBL_PRODUCTS
WHERE ID NOT IN (
    SELECT PRODUCTID
    FROM TBL_PRODUCTSALES
);
--Q2: find the names of product along with quanitites sold sum
-- output -> name sum(qty_sold)
SELECT NAME, (SELECT SUM(QUALTITYSOLD) 
FROM TBL_PRODUCTSALES AS s
WHERE s.PRODUCTID = p.ID) AS total_qty_sold
FROM TBL_PRODUCTS AS p;

------------------------Medium Level------------------------------------------------------

CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


-- Insert into Department Table
INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

-- Insert into Employee Table
INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HEN', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

SELECT D.dept_name,E.NAME,E.SALARY
FROM 
employee AS E
INNER JOIN 
DEPARTMENT AS D
ON E.DEPARTMENT_ID = D.ID
WHERE SALARY IN
(
    SELECT MAX(E2.SALARY)
    FROM EMPLOYEE AS E2
    WHERE E2.department_id= E.department_id`
)
ORDER BY D.dept_name
-----------------------------------------------------------------------------------------
-----------------------------------hard level -------------------------------------------
create table A(
	EmpId int primary key,
	Ename varchar(50),
	Salary int
)
insert into A (EmpId, Ename, Salary) values 
(1, 'AA', 1000),
(2, 'BB', 300);

create table B(
	EmpId int primary key,
	Ename varchar(50),
	Salary int
)
insert into B (EmpId, Ename, Salary) values 
(3, 'BB', 400),
(3, 'CC', 100);

select empid, min