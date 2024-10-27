-- Active: 1729688182101@@127.0.0.1@5432@university_db
DROP Table students

DROP Table students

DROP Table students


-- Creating the "students" table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(10) DEFAULT null
);

-- Inserting data into the "students" table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

-- Creating the "courses" table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT
);

-- Inserting data into the "courses" table
INSERT INTO courses (course_name, credits) VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);

-- Creating the "enrollment" table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
);

-- Inserting data into the "enrollment" table
INSERT INTO enrollment (student_id, course_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 4),
(6, 2);


SELECT * FROM students

SELECT * FROM courses

SELECT * FROM enrollment



-- Query 2:Retrieve the names of all students who are enrolled in the course titled 'Next.js'.

SELECT student_name FROM enrollment
JOIN students USING(student_id)
JOIN courses USING(course_id)
WHERE course_name = 'Next.js'



-- Query 3:Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.

UPDATE students
SET "status" = 'Awarded'
WHERE student_id = (SELECT student_id FROM students
ORDER BY (backend_mark + frontend_mark) DESC
LIMIT 1 OFFSET 0)


--! todo this query 
-- Query 4:Delete all courses that have no students enrolled.








-- Query 5:Retrieve the names of students using a limit of 2, starting from the 3rd student.

SELECT * FROM students
ORDER BY student_id  
LIMIT 2 OFFSET 2


-- Query 6:Retrieve the course names and the number of students enrolled in each course.

SELECT course_name, count(*) as students_enrolled FROM enrollment
JOIN "courses" USING(course_id)
GROUP BY course_name


-- Query 7:Calculate and display the average age of all students.

SELECT Round(avg(age),2) as average_age FROM students


-- Query 8:Retrieve the names of students whose email addresses contain 'example.com'.

SELECT student_name FROM students
WHERE email ILIKE('%example.com%')
