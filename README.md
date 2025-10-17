---
# 🧮 SQL Case Studies — Comprehensive Repository

A collection of **three practical SQL case studies** designed to strengthen SQL skills in **data analysis, database management, and business insights**.  
Each case study includes real-world scenarios, schema creation, dataset details, and query-based problem-solving using **T-SQL** (SQL Server).

---

## 📚 Case Study Overview

| Case Study | Theme | Key Focus | Tables Used |
|-------------|--------|------------|--------------|
| **Case Study 1** | Sales & Profit Analysis | Sales, marketing, profit, COGS, budgets | Fact, Product, Location |
| **Case Study 2** | Employee & Department Management | HR analytics, salary data, job hierarchy | Employee, Department, Job, Location |
| **Case Study 3** | Banking Transactions | Customer transactions, auditing, triggers, stored procedures | Customer, Transaction, Continent |

---

# 🧩 Case Study 1 — *Sales and Profit Analysis*

### 🎯 Problem Statement
As a **Database Administrator**, analyze customer and product sales data to derive insights about:
- Sales and profit from various states  
- Marketing spend effectiveness  
- Cost of Goods Sold (COGS)  
- Budgeted vs actual performance  

### 🗂️ Datasets

| Table | Description | Key Columns |
|--------|--------------|--------------|
| **Fact1** | Transaction and budget data | Date, ProductID, Profit, Sales, COGS, Marketing, Area_Code |
| **Product** | Product details | Product_Type, Product, ProductID, Type |
| **Location** | State and market data | Area_Code, State, Market, Market_Size |

### 🧠 Key SQL Concepts Used
- Aggregations (`SUM`, `AVG`, `MIN`, `MAX`)
- Conditional logic using `CASE`
- `GROUP BY` with `HAVING`
- `DENSE_RANK()` for ranking
- Joins across multiple tables
- Stored Procedures & User-Defined Functions
- `ROLLUP`, `UNION`, and `INTERSECT`

### ⚙️ Example Queries

```sql
-- 1. Number of States
SELECT COUNT(DISTINCT State) AS Number_of_States
FROM Location;

-- 2. Total Marketing Spend for Product ID = 1
SELECT SUM(Marketing) AS Total_Marketing_Spending
FROM Fact1
WHERE ProductID = 1;

-- 3. State-wise Sales & Profit
SELECT L.State, SUM(F.Sales) AS Total_Sales, SUM(F.Profit) AS Total_Profit
FROM Fact1 F
JOIN Location L ON F.Area_Code = L.Area_Code
GROUP BY L.State;
````

---

# 🏢 Case Study 2 — *Employee and Department Management*

### 🎯 Problem Statement

Design and query a **company database** to analyze departments, employees, job roles, and their relationships.

### 🗂️ Tables

| Table          | Description        | Key Columns                                      |
| -------------- | ------------------ | ------------------------------------------------ |
| **Location**   | Office locations   | Location_ID, City                                |
| **Department** | Department details | Department_ID, Name, Location_ID                 |
| **Job1**       | Job designations   | Job_ID, Designation                              |
| **Employee**   | Employee records   | Employee_ID, Name, Job_ID, Salary, Department_ID |

### 🧱 Concepts Covered

* Table creation with constraints and relationships
* Filtering with `WHERE`, `BETWEEN`, `LIKE`, `IN`, and `NOT IN`
* Ordering results with `ORDER BY`
* Aggregation and grouping using `GROUP BY` + `HAVING`
* Complex joins between multiple tables
* Subqueries, nested queries, and salary analysis
* Use of `SET` operators (`UNION`, `INTERSECT`)
* Conditional classification using `CASE` (Salary Grades)

### ⚙️ Example Queries

```sql
-- 1. Department-wise Max, Min, Avg Salary
SELECT Department_ID, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Department_ID;

-- 2. Employees in New York
SELECT COUNT(E.Employee_ID) AS EmployeesInNewYork
FROM Employee E
JOIN Department D ON E.Department_ID = D.Department_ID
JOIN Location L ON D.Location_ID = L.Location_ID
WHERE L.City = 'New York';

-- 3. Salary Grading using CASE
SELECT *,
       CASE
           WHEN Salary BETWEEN 2000 AND 3000 THEN 'Grade A'
           WHEN Salary BETWEEN 3001 AND 4000 THEN 'Grade B'
           WHEN Salary BETWEEN 4001 AND 5000 THEN 'Grade C'
           ELSE 'Grade D'
       END AS SalaryGrade
FROM Employee;
```

---

# 🏦 Case Study 3 — *Banking Transactions and Customer Insights*

### 🎯 Problem Statement

As a **Database Developer** in an international bank, analyze and manage data related to:

* Customer transactions (deposit, withdrawal, purchase)
* Regional transaction analysis
* Stored procedures, functions, and triggers for automation and auditing

### 🗂️ Tables

| Table            | Description          | Key Columns                                  |
| ---------------- | -------------------- | -------------------------------------------- |
| **Continent**    | Regions of operation | region_id, region_name                       |
| **Customers**    | Customer details     | customer_id, region_id, start_date, end_date |
| **Transaction1** | Transaction details  | customer_id, txn_date, txn_type, txn_amount  |

### 🧱 Concepts Covered

* `JOIN` operations across customer, region, and transaction data
* Aggregations and filtering by year/month
* Stored Procedures for modular logic
* Scalar and Table-Valued Functions
* Error handling with `TRY...CATCH`
* Triggers for auditing and access control
* Pivot tables for data summarization

### ⚙️ Example Queries

```sql
-- 1. Customers per region (Year 2020)
SELECT C.region_id, COUNT(C.customer_id) AS customer_count
FROM Customers AS C
JOIN Transaction1 AS T ON C.customer_id = T.customer_id
WHERE YEAR(T.txn_date) = 2020
GROUP BY C.region_id;

-- 2. Stored Procedure: Transactions after June 2020
CREATE PROCEDURE GetCustomersWithTransactionDateGreaterThanJune2020
AS
BEGIN
    SELECT C.customer_id, C.region_id, T.txn_date, T.txn_type, T.txn_amount
    FROM Customers AS C
    JOIN Transaction1 AS T ON C.customer_id = T.customer_id
    WHERE T.txn_date > '2020-06-30';
END;

-- 3. Trigger: Prevent Deletion of Tables
CREATE TRIGGER PreventDeleteTable
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    PRINT 'Deleting tables is not allowed.';
    ROLLBACK;
END;
```

---

# 🧰 Tools & Technologies

* **Microsoft SQL Server**
* **T-SQL (Transact-SQL)**
* **CSV data import/export**
* **Stored Procedures, Triggers, Functions**
* **Data Analysis and Reporting**

---

# 📈 🧾 Learning Outcomes

- ✅ Data Modeling and Schema Design
- ✅ SQL Joins, Grouping, and Subqueries
- ✅ Stored Procedures & Functions
- ✅ Data Integrity using Triggers
- ✅ Real-world Business Problem Solving
- ✅ Performance-oriented Query Writing

---

# 💡 Conclusion

These three case studies collectively demonstrate SQL’s **power in data analysis, process automation, and database management**.
They are ideal for:

* SQL learners practicing real-world problem-solving
* Data analysts preparing for interviews
* Professionals exploring database design and optimization

---

# 🙌 Author

**👩‍💻 Shanila Anjum**
- 📧 [shanilaanjum07@gmail.com](mailto:shanilaanjum07@gmail.com)
- **GitHub:**  [GitHub Profile](https://github.com/Shaneela07)
- **LinkedIn:** [![](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in//shaneela-anjum/)


---

⭐ **If you found this repository helpful, don’t forget to star it!**

---

**THANK YOU FOR READING**

