
-- Student Management System

CREATE DATABASE student_management_system;

USE student_management_system;

-- Create Tables


CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(45)
);


CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(45),
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
);


CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(45),
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
);


CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(45),
    credits INT,
    department_id INT,
    faculty_id INT,
    FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),
    FOREIGN KEY (faculty_id)
        REFERENCES Faculty(faculty_id)
);


CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    enrollment_date DATETIME,
    grade VARCHAR(2),
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),
    FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
);

-- Add Sample data

INSERT INTO Departments (department_id, department_name)
VALUES
    (1, 'Computer Science'),
    (2, 'Biology'),
    (3, 'Engineering');


INSERT INTO Faculty
    (faculty_id, first_name, last_name, email, department_id)
VALUES
    (98756, 'James', 'Carter', 'jcarter@essex.email.edu', 3),
    (98562, 'Linda', 'Moore', 'lmoore@essex.email.edu', 1),
    (98741, 'Robert', 'Davis', 'rdavis@essex.email.edu', 2);


INSERT INTO Students
    (student_id, first_name, last_name, email, department_id)
VALUES
    (46552, 'Jessica', 'Brantley', 'jbrantley@essex.email.edu', 1),
    (48633, 'Michael', 'Johnson', 'mjohnson@essex.email.edu', 3),
    (49875, 'Sarah', 'Lee', 'slee@essex.email.edu', 2);


INSERT INTO Courses
    (course_id, course_name, credits, department_id, faculty_id)
VALUES
    (231, 'Database Systems', 3, 1, 98756),
    (142, 'Biology 101', 4, 2, 98562),
    (106, 'Intro to Engineering', 3, 3, 98741);


INSERT INTO Enrollment
    (enrollment_id, enrollment_date, grade, student_id, course_id)
VALUES
    (1, '2026-04-01 09:00:00', 'A', 46552, 231),
    (2, '2026-04-01 10:00:00', 'B', 49875, 106),
    (3, '2026-04-01 11:00:00', 'A', 48633, 142);


SELECT * FROM Departments;
SELECT * FROM Faculty;
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollment;


-- RETRIEVE STUDENTS BY DEPARTMENT


SELECT
    s.first_name,
    s.last_name,
    d.department_name
FROM Students s
JOIN Departments d
    ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';


-- STUDENT COURSE AND GRADE INFORMATION


SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    DATE_FORMAT(e.enrollment_date, '%m/%d/%Y') AS enrollment_date,
    e.grade
FROM Enrollment e
JOIN Students s
    ON e.student_id = s.student_id
JOIN Courses c
    ON e.course_id = c.course_id;


-- ENROLL A STUDENT IN A COURSE


INSERT INTO Enrollment
    (enrollment_id, enrollment_date, grade, student_id, course_id)
VALUES
    (5, NOW(), NULL, 46552, 142);


-- ASSIGN / UPDATE A GRADE


UPDATE Enrollment
SET grade = 'A'
WHERE student_id = 46552
  AND course_id = 142;


-- DELETE AN ENROLLMENT

DELETE FROM Enrollment
WHERE enrollment_id = 5;


-- Count students/enrollments in each course

SELECT
    course_id,
    COUNT(*) AS total_students
FROM Enrollment
GROUP BY course_id;
