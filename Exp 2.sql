use DB_DEMO
/*
EXP-2 : Joins
Minimum number of tables requird for join = 1
Necessory condition : 
		- Atleast one common table should be there

Types of JOINS:
	1. INNER JOIN:
		(common data/ matching records)
	2. LEFT OUTER JOIN/ LEFT JOIN
		(left table whole data + common data)
	3. RIGHT OUTER JOIN/ RIGHT JOIN
		(right table whole data + common data)
	4. FULL OUTER JOIN
		(L + R + common data)
	5. 
*/

select* from TBL_AUTHOR
select* from BOOK

--INNER JOIN--
SELECT A.*, B.*
FROM TBL_AUTHOR AS A
INNER JOIN
BOOK AS B
ON
A.AUTHOR_ID = B.AUTHORID

--LEFT OUTR JOIN--
SELECT A.*, B.*
FROM TBL_AUTHOR AS A
LEFT OUTER JOIN
BOOK AS B
ON
A.AUTHOR_ID = B.AUTHORID

--RIGHT OUTR JOIN--
SELECT A.*, B.*
FROM TBL_AUTHOR AS A
RIGHT OUTER JOIN
BOOK AS B
ON
A.AUTHOR_ID = B.AUTHORID

--FULL OUTER JOIN--
SELECT A.*, B.*
FROM TBL_AUTHOR AS A
FULL OUTER JOIN
BOOK AS B
ON
A.AUTHOR_ID = B.AUTHORID

--MEDIUM LEVEL QUES--
CREATE TABLE EMPLOYEE_TBL (
    EMP_ID INT PRIMARY KEY,
    ENAME VARCHAR(10),
    DEPT VARCHAR(10),
    MANAGER_ID INT
);

ALTER TABLE EMPLOYEE_TBL 
ADD CONSTRAINT FK_EMPLOYEE_TBL 
FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEE_TBL(EMP_ID);

INSERT INTO EMPLOYEE_TBL (EMP_ID, ENAME, DEPT, MANAGER_ID) VALUES
(1, 'RAHUL', 'HR', NULL),
(2, 'RAM', 'IT', NULL),
(3, 'AMAN', 'IT', 2),
(4, 'PRIYA', 'HR', 1),
(5, 'SOMESH', 'IT', 2);

select* from EMPLOYEE_TBL

--NPV QUES--
CREATE TABLE Year_tbl (
    ID INT,
    YEAR INT,
    NPV INT
);

-- Create Queries table (requested values)
CREATE TABLE Queries (
    ID INT,
    YEAR INT
);

-- Insert data into Year_tbl
INSERT INTO Year_tbl (ID, YEAR, NPV)
VALUES
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

-- Insert data into Queries
INSERT INTO Queries (ID, YEAR)
VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

--solution--
SELECT Q.ID, Q.YEAR, ISNULL(Y.NPV, 0)
FROM Queries AS Q
LEFT OUTER JOIN 
Year_tbl AS Y
ON
Q.ID = Y.ID
AND
Q.YEAR = Y.YEAR
