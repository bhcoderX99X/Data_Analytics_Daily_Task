CREATE DATABASE IF NOT EXISTS university_DB;
USE university_DB;

-- 1. DEPARTMENT
CREATE TABLE department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget DECIMAL(12, 2)
);

-- 2. INSTRUCTOR
CREATE TABLE instructor (
    ID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dept_name VARCHAR(50),
    salary DECIMAL(10, 2),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) 
);

-- 3. COURSE
CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    dept_name VARCHAR(50),
    credits INT CHECK (credits > 0),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

-- 4. SECTION
CREATE TABLE section (
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10) CHECK (semester IN ('Fall', 'Spring', 'Summer')),
    year INT CHECK (year > 2000),
    building VARCHAR(50),
    room_number VARCHAR(10),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id) 
);

-- 5. STUDENT
CREATE TABLE student (
    ID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dept_name VARCHAR(50),
    tot_cred INT DEFAULT 0,
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) 
);

-- 6. TAKES (Enrollment)
CREATE TABLE takes (
    ID VARCHAR(10),
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES student(ID) ,
    FOREIGN KEY (course_id, sec_id, semester, year) 
        REFERENCES section(course_id, sec_id, semester, year)
);

-- 7. ADVISOR
CREATE TABLE advisor (
    s_ID VARCHAR(10) PRIMARY KEY,
    i_ID VARCHAR(10),
    FOREIGN KEY (s_ID) REFERENCES student(ID) ,
    FOREIGN KEY (i_ID) REFERENCES instructor(ID)
);

-- 1. Insert Departments
INSERT INTO department (dept_name, building, budget) VALUES
('Comp. Sci.', 'Taylor', 100000.00),
('Biology', 'Watson', 90000.00),
('Elec. Eng.', 'Taylor', 85000.00),
('Physics', 'Painter', 70000.00),
('Finance', 'Painter', 120000.00),
('History', 'Painter', 50000.00),
('Music', 'Packard', 80000.00);

-- 2. Insert Instructors
INSERT INTO instructor (ID, name, dept_name, salary) VALUES
('10101', 'Srinivasan', 'Comp. Sci.', 65000.00),
('12121', 'Wu', 'Finance', 90000.00),
('15151', 'Mozart', 'Music', 40000.00),
('22222', 'Einstein', 'Physics', 95000.00),
('32343', 'El Said', 'History', 60000.00),
('33456', 'Gold', 'Physics', 87000.00),
('45565', 'Katz', 'Comp. Sci.', 75000.00),
('58583', 'Califieri', 'History', 62000.00),
('76543', 'Singh', 'Finance', 80000.00),
('76766', 'Crick', 'Biology', 72000.00),
('83821', 'Brandt', 'Comp. Sci.', 92000.00),
('98345', 'Kim', 'Elec. Eng.', 80000.00);

-- 3. Insert Courses
INSERT INTO course (course_id, title, dept_name, credits) VALUES
('BIO-101', 'Intro. to Biology', 'Biology', 4),
('BIO-301', 'Genetics', 'Biology', 4),
('BIO-399', 'Computational Biology', 'Biology', 3),
('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4),
('CS-190', 'Game Design', 'Comp. Sci.', 4),
('CS-315', 'Robotics', 'Comp. Sci.', 3),
('CS-319', 'Image Processing', 'Comp. Sci.', 3),
('CS-347', 'Database System Concepts', 'Comp. Sci.', 3),
('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3),
('FIN-201', 'Financial Accounting', 'Finance', 3),
('HIS-351', 'World History', 'History', 3),
('MU-199', 'Music Video Production', 'Music', 3),
('PHY-101', 'Physical Principles', 'Physics', 4);

-- 4. Insert Sections
INSERT INTO section (course_id, sec_id, semester, year, building, room_number) VALUES
('BIO-101', '1', 'Summer', 2024, 'Painter', '514'),
('BIO-301', '1', 'Summer', 2024, 'Painter', '514'),
('CS-101', '1', 'Fall', 2024, 'Packard', '101'),
('CS-101', '1', 'Spring', 2025, 'Packard', '101'),
('CS-190', '1', 'Spring', 2025, 'Taylor', '3128'),
('CS-315', '1', 'Spring', 2025, 'Watson', '120'),
('CS-319', '1', 'Spring', 2025, 'Watson', '100'),
('CS-347', '1', 'Fall', 2024, 'Taylor', '3128'),
('EE-181', '1', 'Spring', 2025, 'Taylor', '3128'),
('FIN-201', '1', 'Spring', 2025, 'Packard', '101'),
('HIS-351', '1', 'Spring', 2025, 'Painter', '514'),
('MU-199', '1', 'Spring', 2025, 'Packard', '101'),
('PHY-101', '1', 'Fall', 2024, 'Watson', '100');

-- 5. Insert Students
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES
('00128', 'Zhang', 'Comp. Sci.', 102),
('12345', 'Shankar', 'Comp. Sci.', 32),
('19991', 'Brandt', 'History', 80),
('23121', 'Chavez', 'Finance', 110),
('44553', 'Peltier', 'Physics', 56),
('45678', 'Levy', 'Physics', 46),
('54321', 'Williams', 'Comp. Sci.', 54),
('55739', 'Sanchez', 'Music', 38),
('70557', 'Snow', 'Physics', 0),
('76543', 'Brown', 'Comp. Sci.', 58),
('76653', 'Aoi', 'Elec. Eng.', 60),
('98765', 'Bourikas', 'Elec. Eng.', 98),
('98988', 'Tanaka', 'Biology', 120);

-- 6. Insert Course Enrollments (takes)
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES
('00128', 'CS-101', '1', 'Fall', 2024, 'A'),
('00128', 'CS-347', '1', 'Fall', 2024, 'A-'),
('12345', 'CS-101', '1', 'Fall', 2024, 'C'),
('12345', 'CS-190', '1', 'Spring', 2025, 'A'),
('12345', 'CS-315', '1', 'Spring', 2025, 'A'),
('19991', 'HIS-351', '1', 'Spring', 2025, 'B'),
('23121', 'FIN-201', '1', 'Spring', 2025, 'C+'),
('44553', 'PHY-101', '1', 'Fall', 2024, 'B-'),
('45678', 'CS-101', '1', 'Fall', 2024, 'F'),
('45678', 'CS-101', '1', 'Spring', 2025, 'B+'),
('54321', 'CS-101', '1', 'Fall', 2024, 'A-'),
('55739', 'MU-199', '1', 'Spring', 2025, 'A'),
('76543', 'CS-101', '1', 'Fall', 2024, 'A'),
('76543', 'CS-319', '1', 'Spring', 2025, 'A'),
('76653', 'EE-181', '1', 'Spring', 2025, 'C'),
('98765', 'CS-101', '1', 'Fall', 2024, 'C-'),
('98765', 'CS-315', '1', 'Spring', 2025, 'B');

-- 7. Insert Advisor Relationships
INSERT INTO advisor (s_ID, i_ID) VALUES
('00128', '45565'),
('12345', '10101'),
('23121', '76543'),
('44553', '22222'),
('45678', '22222'),
('76543', '45565'),
('76653', '98345'),
('98765', '98345'),
('98988', '76766');

SELECT * 
FROM instructor 
WHERE dept_name = 'Comp. Sci.';

SELECT dept_name, budget 
FROM department 
WHERE budget > 80000;

SELECT 
    s.ID AS student_id, 
    s.name AS student_name, 
    i.name AS advisor_name
FROM student s
LEFT JOIN advisor a ON s.ID = a.s_ID
LEFT JOIN instructor i ON a.i_ID = i.ID;


SELECT 
    s.name AS student_name, 
    c.title AS course_title, 
    t.semester, 
    t.year, 
    t.grade
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id;


SELECT 
    s.name AS student_name, 
    c.title AS course_title, 
    t.semester, 
    t.year, 
    t.grade
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id;


SELECT 
    dept_name, 
    AVG(salary) AS avg_salary, 
    COUNT(*) AS total_instructors
FROM instructor
GROUP BY dept_name;


SELECT 
    course_id, 
    sec_id, 
    semester, 
    year, 
    COUNT(ID) AS enrolled_students
FROM takes
GROUP BY course_id, sec_id, semester, year;


SELECT name, salary 
FROM instructor 
WHERE salary > (SELECT AVG(salary) FROM instructor);


SELECT ID, name 
FROM student s
WHERE NOT EXISTS (
    SELECT 1 
    FROM takes t 
    WHERE t.ID = s.ID
);
