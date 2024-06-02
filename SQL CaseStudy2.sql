/////////////////////////////////////////////////////////////SQL CASE STUDY 2 ///////////////////////////////////////////////////////////////////////

--Create the following table:

LOCATION,DEPARTMENT,JOB,EMPLOYEE

Solution-->
CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);
INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);


CREATE TABLE JOB1
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOB1 VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')

CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB1(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

--View Tables
SELECT * FROM LOCATION
SELECT * FROM DEPARTMENT
SELECT * FROM JOB1
SELECT * FROM EMPLOYEE

Simple Queries:

--1. List all the employee details.
Solution-->
SELECT * FROM EMPLOYEE

--2. List all the department details.
Solution-->
SELECT * FROM DEPARTMENT

--3. List all job details. 
Solution-->
SELECT * FROM JOB1

--4. List all the locations. 
Solution-->
SELECT * FROM LOCATION

--5. List out the First Name, Last Name, Salary, Commission for all Employees. 
Solution-->
SELECT First_Name, Last_Name, Salary, Comm 
FROM EMPLOYEE

--6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee", Last Name as 
--"Name of the Employee", Department ID as "Dep_id".
Solution-->
SELECT EMPLOYEE_ID AS "ID of the Employee",
LAST_NAME AS "Name of the Employee",
Department_ID as "Dep_id"
FROM EMPLOYEE

--7. List out the annual salary of the employees with their names only.
Solution-->
SELECT FIRST_NAME,SALARY FROM EMPLOYEE


WHERE Condition:

--1. List the details about "Smith". 
Solution-->
SELECT * FROM EMPLOYEE 
WHERE 
LAST_NAME = 'Smith'

--2. List out the employees who are working in department 20. 
Solution-->
SELECT * FROM EMPLOYEE 
WHERE
DEPARTMENT_ID = 20

--3. List out the employees who are earning salaries between 3000 and 4500. 
Solution-->
SELECT * FROM EMPLOYEE 
WHERE
SALARY BETWEEN 3000 AND 4500

--4. List out the employees who are working in department 10 or 20. 
Solution-->
SELECT * FROM EMPLOYEE 
WHERE
DEPARTMENT_ID IN (10,20)

--5. Find out the employees who are not working in department 10 or 30. 
Solution-->
SELECT *
FROM Employee
WHERE Department_Id NOT IN (10, 30);

--6. List out the employees whose name starts with 'S'.
Solution-->
SELECT *
FROM Employee
WHERE First_Name LIKE 'S%'

--7. List out the employees whose name starts with 'S' and ends with'H'. 
Solution-->
SELECT *
FROM Employee
WHERE Last_Name LIKE 'S%H'

--8. List out the employees whose name length is 4 and start with 'S'. 
Solution-->
SELECT *
FROM Employee
WHERE LEN(Last_Name) = 4 AND Last_Name LIKE 'S%'

--9. List out employees who are working in department 10 and draw salaries more than 3500. 
Solution-->
SELECT *
FROM Employee
WHERE Department_Id = 10 AND Salary > 3500

--10. List out the employees who are not receiving commission. 
Solution-->
SELECT *
FROM Employee
WHERE Comm is null


ORDER BY Clause:

--1. List out the Employee ID and Last Name in ascending order based on the Employee ID. 
Solution-->
SELECT Employee_ID, Last_Name
FROM Employee
ORDER BY Employee_ID ASC

--2. List out the Employee ID and Name in descending order based on salary. 
Solution-->
SELECT Employee_ID, First_Name
FROM Employee
ORDER BY Salary DESC

--3. List out the employee details according to their Last Name in ascending-order.
Solution-->
SELECT *
FROM Employee
ORDER BY Last_Name ASC

--4. List out the employee details according to their Last Name in ascendingorder and then Department ID in descending order. 
Solution-->
SELECT *
FROM Employee
ORDER BY Last_Name ASC, Department_ID DESC

GROUP BY and HAVING Clause:

--1. How many employees are in different departments in the organization?
Solution-->
SELECT Department_ID, COUNT(Employee_ID) AS EmployeeCount
FROM Employee
GROUP BY Department_ID

--2. List out the department wise maximum salary, minimum salary and average salary of the employees. 
Solution-->
SELECT Department_ID, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Department_ID

--3. List out the job wise maximum salary, minimum salary and average salary of the employees. 
Solution-->
SELECT Job_Id, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Job_Id

--4. List out the number of employees who joined each month in ascending order.
Solution-->
SELECT MONTH(HIRE_DATE) AS JoiningMonth, COUNT(*) AS EmployeesCount
FROM Employee
GROUP BY MONTH(HIRE_DATE)
ORDER BY Employeescount ASC

--5. List out the number of employees for each month and year in ascending order based on the year and month.
Solution-->
SELECT YEAR(Hire_Date) AS JoinYear, MONTH(Hire_Date) AS JoinMonth, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY YEAR(Hire_Date),MONTH(Hire_Date)
ORDER BY Employeecount ASC

--6. List out the Department ID having at least four employees. 
Solution-->
SELECT Department_ID, COUNT(Employee_ID) AS EmployeeCount
FROM Employee
GROUP BY Department_ID
HAVING COUNT(Employee_ID) >= 4

--7. How many employees joined in the month of January?
Solution-->
SELECT COUNT(Employee_ID) AS JanuaryJoinCount
FROM Employee
WHERE MONTH(Hire_Date) = 1

--8. How many employees joined in the month of January or September?
Solution-->
SELECT COUNT(Employee_ID) AS JanuaryOrSeptemberJoinCount
FROM Employee
WHERE MONTH(Hire_Date) IN (1, 9)

--9. How many employees joined in 1985?
Solution-->
SELECT COUNT(Employee_ID) AS JoinCount1985
FROM Employee
WHERE YEAR(Hire_Date) = 1985

--10. How many employees joined each month in 1985?
Solution-->
SELECT MONTH(Hire_Date) AS JoinMonth, COUNT(Employee_ID) AS JoinCount
FROM Employee
WHERE YEAR(Hire_Date) = 1985
GROUP BY MONTH(Hire_Date)

--11. How many employees joined in March 1985?
Solution-->
SELECT COUNT(Employee_ID) AS MarchJoinCount
FROM Employee
WHERE MONTH(Hire_Date) = 3 AND YEAR(Hire_Date) = 1985

--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
Solution-->
SELECT Department_ID, COUNT(Employee_ID) AS AprilJoinCount
FROM Employee
WHERE MONTH(Hire_Date) = 4 AND YEAR(Hire_Date) = 1985
GROUP BY Department_ID
HAVING COUNT(Employee_ID) >= 3


Joins:

--1. List out employees with their department names. 
Solution-->
SELECT E.LAST_NAME AS Employee_LastName, E.FIRST_NAME AS Employee_FirstName, D.Name AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id

--2. Display employees with their designations. 
Solution-->
SELECT E.LAST_NAME AS Employee_LastName, E.FIRST_NAME AS Employee_FirstName, J.Designation AS Employee_Designation
FROM EMPLOYEE E
JOIN JOB1 J ON E.JOB_ID = J.JOB_ID;

--3. Display the employees with their department names and regional groups. 
Solution-->
SELECT E.First_Name, D.Department_Id, L.Location_Id
FROM Employee AS E
JOIN Department AS D ON E.Department_ID = D.Department_ID
JOIN Location AS L ON D.Location_Id =  L.Location_Id

--4. How many employees are working in different departments? Display with department names.
Solution-->
SELECT D.Department_Id, COUNT(E.Employee_ID) AS EmployeeCount
FROM Employee AS E
JOIN Department AS D ON E.Department_ID = D.Department_ID
GROUP BY D.Department_Id

--5. How many employees are working in the sales department?
Solution-->
SELECT COUNT(Employee_ID) AS SalesEmployeeCount
FROM Employee
WHERE Department_ID = (SELECT Department_ID FROM Department WHERE Name = 'Sales')

--6. Which is the department having greater than or equal to 4 employees? Display the department names in ascending order. 
Solution-->
SELECT D.Name
FROM Department AS D
JOIN (
    SELECT Department_ID, COUNT(Employee_ID) AS EmployeeCount
    FROM Employee
    GROUP BY Department_ID
    HAVING COUNT(Employee_ID) >= 4
) AS EmployeeCounts ON D.Department_ID = EmployeeCounts.Department_ID
ORDER BY D.Name ASC

--7. How many jobs are there in the organization? Display with designations. 
Solution-->
SELECT COUNT(DISTINCT JOB_ID) AS JobCount, Designation
FROM Job1
GROUP BY Designation

--8. How many employees are working in "New York"?
Solution-->
SELECT COUNT(E.EMPLOYEE_ID) AS EmployeesInNewYork
FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION AS L ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York'

--9. Display the employee details with salary grades. Use conditional statement to create a grade column. 
Solution-->
SELECT *,
    CASE
        WHEN Salary >= 2000 AND Salary <= 3000 THEN 'Grade A'
        WHEN Salary > 3000 AND Salary <= 4000 THEN 'Grade B'
        WHEN Salary > 4000 AND Salary <= 5000 THEN 'Grade C'
        ELSE 'Grade D'
    END AS SalaryGrade
FROM Employee

--10. List out the number of employees grade wise. Use conditional statement to create a grade column. 
Solution-->
SELECT SalaryGrade,COUNT(Employee_ID) AS EmployeeCount
FROM (
    SELECT Employee_ID,
        CASE
            WHEN Salary BETWEEN 2000 AND 3000 THEN 'Grade A'
            WHEN Salary BETWEEN 3001 AND 4000 THEN 'Grade B'
            WHEN Salary BETWEEN 4001 AND 5000 THEN 'Grade C'
            ELSE 'Grade D'
        END AS SalaryGrade
    FROM Employee
) AS EmployeeWithGrades
GROUP BY SalaryGrade;

--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
Solution-->
SELECT SalaryGrade, COUNT(Employee_ID) AS EmployeeCount
FROM (
    SELECT Employee_ID,
        CASE
            WHEN Salary BETWEEN 2000 AND 3000 THEN 'Grade A'
            WHEN Salary BETWEEN 3001 AND 4000 THEN 'Grade B'
            WHEN Salary BETWEEN 4001 AND 5000 THEN 'Grade C'
            ELSE 'Grade D'
        END AS SalaryGrade
    FROM Employee
    WHERE Salary BETWEEN 2000 AND 5000
) AS EmployeeWithGrades
GROUP BY SalaryGrade

--12. Display all employees in sales or operation departments.
Solution-->
SELECT E.First_Name, D.Name
FROM Employee AS E
JOIN Department AS D ON D.Department_ID = E.Department_Id
WHERE Name IN ('Sales', 'Operations')
select * from location

SET Operators:

--1. List out the distinct jobs in sales and operations departments. 
Solution-->
SELECT DISTINCT J.DESIGNATION
FROM EMPLOYEE E
JOIN JOB1 J ON E.JOB_ID = J.JOB_ID
WHERE E.DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name IN ('Sales', 'operations'))

--2. List out all the jobs in sales and accounting departments. 
Solution-->
SELECT J.DESIGNATION
FROM EMPLOYEE E
JOIN JOB1 J ON E.JOB_ID = J.JOB_ID
WHERE E.DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name IN ('Sales', 'Accounting'))

--3. List out the common jobs in research and accounting departments in ascending order. 
Solution-->
SELECT J.DESIGNATION
FROM EMPLOYEE E
JOIN JOB1 J ON E.JOB_ID = J.JOB_ID
WHERE E.DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Research')
INTERSECT
SELECT J.DESIGNATION
FROM EMPLOYEE E
JOIN JOB1 J ON E.JOB_ID = J.JOB_ID
WHERE E.DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Accounting')


Subqueries:

--1. Display the employees list who got the maximum salary.
Solution-->
SELECT *
FROM Employee
WHERE SALARY = (SELECT MAX(SALARY) FROM Employee)

--2. Display the employees who are working in the sales department.
Solution-->
SELECT *
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Sales')

--3. Display the employees who are working as 'Clerk'. 
Solution-->
SELECT *
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID FROM JOB1 WHERE DESIGNATION = 'Clerk')

--4. Display the list of employees who are living in "Dallas". 
Solution-->
SELECT *
FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION AS L ON D.Location_Id = L.Location_ID
WHERE L.City = 'DALLAS'

--5. Find out the number of employees working in the sales department. 
Solution-->
SELECT COUNT(*) 
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Sales')

--6. Update the salaries of employees who are working as clerks on the basis of 10%. 
Solution-->
UPDATE EMPLOYEE
SET SALARY = SALARY * 0.10
WHERE JOB_ID = (SELECT JOB_ID FROM JOB1 WHERE DESIGNATION = 'Clerk')

--7. Delete the employees who are working in the accounting department. 
Solution-->
DELETE FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Accounting')

--8. Display the second highest salary drawing employee details. 
Solution-->
SELECT *
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE))

--9. Display the nth highest salary drawing employee details. 
Solution-->
--- replace n with the desired position
SELECT *
FROM EMPLOYEE
WHERE SALARY = (
    SELECT DISTINCT TOP 1 SALARY
    FROM (
        SELECT DISTINCT TOP  n SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
    ) AS SalarySubquery
    ORDER BY SALARY ASC
)

--10. List out the employees who earn more than every employee in department 30.
Solution-->
SELECT *
FROM EMPLOYEE
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEE WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE Name = '30'))

--11. List out the employees who earn more than the lowest salary in department.Find out whose department has no employees. 
Solution-->
SELECT *
FROM employee e1
WHERE salary > (SELECT MIN(salary) FROM employee e2 WHERE e1.department_id = e2.department_id)

--12. Find out which department has no employees. 
Solution-->
SELECT D.Name AS Department_Name
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.Department_Id = E.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID IS NULL

--13. Find out the employees who earn greater than the average salary for their department.
Solution-->
SELECT E.*
FROM EMPLOYEE E
WHERE E.SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT_ID = E.DEPARTMENT_ID)


////////////////////////////////////////////////////// THANK YOU //////////////////////////////////////////////////////////////////////////
