-- creating tables

USE universitysql;

CREATE TABLE Students (
student_id INT PRIMARY KEY,
first_name VARCHAR(50), 
last_name VARCHAR(50),
email VARCHAR(50), 
birthdate DATE, 
major VARCHAR(50)
);


CREATE TABLE Courses (
course_id INT PRIMARY KEY,
course_name VARCHAR(50),
department VARCHAR(50),
credits INT 
);

USE universitysql;

CREATE TABLE enrollments (
enrollment_id INT PRIMARY KEY,
student_id INT,
course_id INT,
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id),
enrollment_date DATE,
grade FLOAT
);

-- giving some data to the tables 

INSERT INTO Students(student_id, first_name, last_name, email, birthdate, major)
VALUES (1, 'John', 'Brown', 'jbrown@gmail.com', '2000-09-28', 'Computer Science'),
(2, 'Andrew', 'Trump', 'andtr@outlook.com', '1998-02-13', 'Economics'),
(3, 'Laura', 'Cambridge', 'laubridge@gmail.com', '2003-05-21', 'Medicine'),
(4, 'Andrea', 'Tompson', 'andreson@yahoo.com', '2006-06-03', 'Arts'),
(5, 'Sammit', 'Gallywood', 'sammys@gmail.com', '2002-03-28', 'Computer Science');

INSERT INTO Students(student_id, first_name, last_name, email, birthdate, major)
VALUES (6, 'Margot', 'Robinson', 'margoro@hotmail.com', '1999-02-28', ' ');

INSERT INTO Courses(course_id, course_name, department, credits)
VALUES(1, 'Intro Python', 'Science', 2),
(2, 'Painting', 'Art', 2),
(3, 'Writing', 'Art', 2),
(4, 'Business Intelligence', 'Economics', 2),
(5, 'Anatomy', 'Medicine', 2);

INSERT INTO Enrollments(enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES (1, 2, 1, "2023-07-03", 3.0),
(2, 1, 5, "2023-07-15", 3.0),
(3, 3, 3, "2023-07-07", 3.0),
(4, 5, 2, "2023-07-03", 3.0),
(5, 4, 4, "2023-06-29", 3.0);

INSERT INTO Enrollments(enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES(6, 6, NULL, NULL, NULL);

-- Write a SQL query to retrieve the first and last names of all students along with their majors.

SELECT first_name, last_name, major
FROM universitysql.students;

-- Write a SQL query to retrieve the course name, department, and the number of enrolled students for each course.

SELECT courses.course_name,
courses.department, 
COUNT(enrollments.student_id) AS 'Number of enrolled Students'
FROM universitysql.courses
INNER JOIN universitysql.enrollments ON courses.course_id=enrollments.course_id
GROUP BY courses.course_name, courses.department;

-- Write a SQL query to retrieve the names of students who have not enrolled in any courses.

SELECT students.first_name, students.last_name
FROM universitysql.students
INNER JOIN universitysql.enrollments ON students.student_id = enrollments.student_id
WHERE enrollments.course_id IS NULL;

-- Write a SQL query to retrieve the names of students who have enrolled in at least one course, along with the total 
-- number of courses they have taken.

SELECT students.student_id, students.first_name, students.last_name, COUNT(enrollments.student_id) AS total_courses_taken
FROM universitysql.students
INNER JOIN universitysql.enrollments ON students.student_id = enrollments.student_id
GROUP BY students.student_id, students.first_name, students.last_name;

-- Write a SQL query to retrieve the average grade for each course. Exclude courses with no grades.

SELECT AVG(enrollments.grade) AS average_grade
FROM universitysql.enrollments
WHERE enrollments.grade IS NOT NULL;

-- Write a SQL query to retrieve the student name and the course name for all enrollments along with the enrollment date and grade (if available).

SELECT students.first_name, students.last_name, course_name, enrollments.enrollment_date
FROM universitysql.enrollments
INNER JOIN universitysql.students ON students.student_id = enrollments.student_id
INNER JOIN universitysql.courses ON courses.course_id = enrollments.course_id;

-- Write a SQL query to update the grade for a specific enrollment, given the enrollment_id.

SELECT * 
FROM universitysql.enrollments;

UPDATE universitysql.enrollments
SET grade = 3.3
WHERE student_id = 2;

SELECT students.first_name, students.last_name, students.major
FROM universitysql.students
WHERE student_id = 2;

-- Write a SQL query to delete all enrollments for a specific student, given the student_id.

DELETE FROM universitysql.enrollments WHERE student_id = 1;

SELECT *
FROM universitysql.enrollments;


