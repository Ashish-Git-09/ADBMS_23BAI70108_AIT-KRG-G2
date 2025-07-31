USE DB_DEMO
-- Step 1: Create Department Table

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Step 2: Create Course Table with Foreign Key to Department
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Step 3: Insert Data into Department Table
INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Electrical Engineering'),
(4, 'Mathematics'),
(5, 'Civil Engineering');

-- Step 4: Insert Data into Course Table
INSERT INTO Course (course_id, course_name, dept_id) VALUES
(101, 'Data Structures', 1),
(102, 'Operating Systems', 1),
(103, 'Database Systems', 1),
(104, 'Thermodynamics', 2),
(105, 'Fluid Mechanics', 2),
(106, 'Circuits and Systems', 3),
(107, 'Electromagnetics', 3),
(108, 'Linear Algebra', 4),
(109, 'Calculus', 4),
(110, 'Structural Engineering', 5);

-- Step 5: Query to Get Departments Offering More Than 2 Courses
SELECT dept_name
FROM Department
WHERE dept_id IN (
    SELECT dept_id
    FROM Course
    GROUP BY dept_id
    HAVING COUNT(course_id) > 2
);



