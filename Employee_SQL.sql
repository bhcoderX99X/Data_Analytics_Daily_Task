-- create
CREATE TABLE EMPLOYEE (
  empId INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  w_dept TEXT NOT NULL
);

CREATE TABLE DEPARTMENT (
  D_Id INTEGER,
  D_name TEXT NOT NULL,
  D_address TEXT NOT NULL,
  empId INT, 
  FOREIGN KEY (empId) REFERENCES 
EMPLOYEE(empId)
);
-- insert employees first because DEPARTMENT.empId references EMPLOYEE.empId
INSERT INTO EMPLOYEE VALUES 
       (10001, 'Aman Singh', 'Sales'),
       (10002, 'Komal Upadhyay', 'Accounting'),
       (10003, 'Rohit Kumar', 'Sales'),
       (10004, 'Aman', 'IT'),
       (10005, 'Alice Ben', 'Accounting'),
       (10006, 'Sam Altman', 'IT');

INSERT INTO DEPARTMENT VALUES
       (911, 'IT', 'First Floor', 10001),
       (922, 'Sales', 'Third Floor', 10002 ),
       (933, 'IT', 'First Floor', 10003),
       
       (966, 'Sales', 'Third Floor', 10006);

-- fetch 
SELECT * FROM EMPLOYEE ;

ALTER TABLE EMPLOYEE ADD salary int;

UPDATE EMPLOYEE
SET salary = CASE empId 
  WHEN 10001 THEN 12000
  WHEN 10002 THEN 25000
  WHEN 10003 THEN 18000
  WHEN 10004 THEN 16000
  WHEN 10005 THEN 22000
  WHEN 10006 THEN 18000
END;

SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE ORDER BY name;

SELECT * FROM EMPLOYEE ORDER BY salary DESC;
-- SELECT * FROM EMPLOYEE ;

SELECT * FROM EMPLOYEE
WHERE name LIKE 'A%';

SELECT empId, name, w_dept 
FROM EMPLOYEE 
WHERE w_dept IN ('IT');

SELECT * FROM EMPLOYEE
WHERE salary BETWEEN 15000 AND 24000;

SELECT *FROM DEPARTMENT ;

SELECT 
  e.empId,
  e.name AS employee_name,
  e.w_dept AS employee_dept,
  e.salary,
  d.D_Id,
  d.D_name AS Dept_name,
  d.D_address
FROM EMPLOYEE e
INNER JOIN DEPARTMENT d
ON e.empId = d.empId;


SELECT 
  e.empId,
  e.name AS employee_name,
  e.w_dept AS employee_dept,
  e.salary,
  d.D_Id,
  d.D_name AS dept_table_name,
  d.D_address
FROM EMPLOYEE e
LEFT JOIN DEPARTMENT d
ON e.empId = d.empId;



SELECT 
    e.empId,
    e.name AS employee_name,
    e.w_dept AS employee_dept,
    e.salary,
    d.D_Id,
    d.D_name AS dept_table_name,
    d.D_address
FROM EMPLOYEE e
RIGHT JOIN DEPARTMENT d
ON e.empId = d.empId;
