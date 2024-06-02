////////////////////////////////////////////////////// SQL CASE STUDY 3 //////////////////////////////////////////////////////////////////////////

--Problem Statement:

You are the database developer of an international bank. You are responsible for
managing the bank’s database. You want to use the data to answer a few
questions about your customers regarding withdrawal, deposit and so on,
especially about the transaction amount on a particular date across various
regions of the world. Perform SQL queries to get the key insights of a customer.

--Dataset:
The 3 key datasets for this case study are:

--a. Continent:
The Continent table has two attributes i.e., region_id and
region_name, where region_name consists of different continents such as
Asia, Europe, Africa etc., assigned with the unique region id.
--b. Customers: 
The Customers table has four attributes named customer_id,
region_id, start_date and end_date which consists of 3500 records.
--c. Transaction: 
Finally, the Transaction table contains around 5850 records
and has four attributes named customer_id, txn_date, txn_type and
txn_amount.

USE [MandatoryAssignments]

--To View Tables
select * from Customers
select * from Continent
select * from Transaction1

--Task to be performed:

--1. Display the count of customers in each region who have done the transaction in the year 2020.
Solution-->
SELECT C.region_id, COUNT(C.customer_id) AS customer_count
FROM Customers AS C
INNER JOIN Transaction1 AS T ON C.customer_id = T.customer_id
WHERE YEAR(T.txn_date) = 2020
GROUP BY C.region_id

--2. Display the maximum and minimum transaction amount of each transaction type.
Solution-->
SELECT txn_type, MAX(txn_amount) AS max_amount, MIN(txn_amount) AS min_amount
FROM Transaction1
GROUP BY txn_type

--3. Display the customer id, region name and transaction amount where transaction type is deposit and transaction amount > 2000.
Solution-->
SELECT C.customer_id, Co.region_name, T.txn_amount
FROM Customers AS C
INNER JOIN Transaction1 AS T ON C.customer_id = T.customer_id
INNER JOIN Continent AS Co ON C.region_id = Co.region_id
WHERE T.txn_type = 'deposit' AND T.txn_amount >2000

--4. Find duplicate records in the Customer table.
Solution-->
SELECT customer_id, COUNT(*) AS duplicate_count
FROM Customers
GROUP BY customer_id
HAVING COUNT(*) > 1

--5. Display the customer id, region name, transaction type and transaction amount for the minimum transaction amount in deposit.
Solution-->
SELECT C.customer_id, Co.region_name, T.txn_type, T.txn_amount
FROM Customers AS C
INNER JOIN Transaction1 AS T ON C.customer_id = T.customer_id
INNER JOIN Continent AS Co ON C.region_id = Co.region_id
WHERE T.txn_type = 'deposit' AND T.txn_amount = (SELECT MIN(txn_amount) FROM Transaction1 WHERE txn_type = 'deposit')

--6. Create a stored procedure to display details of customers in the Transaction table where the transaction date is 
--greater than Jun 2020.
Solution-->
CREATE PROCEDURE GetCustomersWithTransactionDateGreaterThanJune2020
AS
BEGIN
    SELECT C.customer_id, C.region_id, T.txn_date, T.txn_type, T.txn_amount
    FROM Customers AS C
    INNER JOIN Transaction1 AS T ON C.customer_id = T.customer_id
    WHERE T.txn_date > '2020-06-30';
END;

--7. Create a stored procedure to insert a record in the Continent table.
Solution-->
CREATE PROCEDURE InsertContinentRecord
    @region_id INT,
    @region_name NVARCHAR(255)
AS
BEGIN
    INSERT INTO Continent (region_id, region_name)
    VALUES (@region_id, @region_name);
END;

--8. Create a stored procedure to display the details of transactions that happened on a specific day.
Solution-->
CREATE PROCEDURE GetTransactionsByDate
    @specific_date DATE
AS
BEGIN
    SELECT C.customer_id, Co.region_name, T.txn_date, T.txn_type, T.txn_amount
    FROM Customers AS C
    INNER JOIN Transaction1 AS T ON C.customer_id = T.customer_id
    INNER JOIN Continent AS Co ON C.region_id = Co.region_id
    WHERE T.txn_date = @specific_date;
END;

--9. Create a user defined function to add 10% of the transaction amount in a table.
Solution-->
CREATE FUNCTION AddTenPercent(@amount DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @amount + (@amount * 0.10);
END

--10. Create a user defined function to find the total transaction amount for a given transaction type.
Solution-->
CREATE FUNCTION GetTotalTransactionAmountByType
(@txn_type NVARCHAR(255))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @totalAmount DECIMAL(10, 2)
    SELECT @totalAmount = SUM(txn_amount)
    FROM Transaction1
    WHERE txn_type = @txn_type;
    RETURN @totalAmount;
END

--11. Create a table value function which comprises the columns customer_id,region_id ,txn_date,txn_type , 
--txn_amount which will retrieve data from the above table.
Solution-->
CREATE FUNCTION GetTransactionData()
RETURNS TABLE
AS
RETURN (
    SELECT C.customer_id, C.region_id, T.txn_date, T.txn_type, T.txn_amount
    FROM Customers AS C
    INNER JOIN Transaction1 AS T ON C.customer_id = T.customer_id
)

--12. Create a TRY...CATCH block to print a region id and region name in a single column.
Solution-->
BEGIN TRY
    SELECT region_id, region_name
    FROM Continent;
END TRY
BEGIN CATCH
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH

--13. Create a TRY...CATCH block to insert a value in the Continent table.
Solution-->
BEGIN TRY
    INSERT INTO Continent (region_id, region_name)
    VALUES (10, 'NewRegion');
END TRY
BEGIN CATCH
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH

--14. Create a trigger to prevent deleting a table in a database.
Solution-->
CREATE TRIGGER PreventDeleteTable
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    PRINT 'Deleting tables is not allowed.';
    ROLLBACK;
END;

--15. Create a trigger to audit the data in a table.
Solution-->
-- Create an audit table to store the audit information
CREATE TABLE AuditTable (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    TableName NVARCHAR(255),
    AuditDate DATETIME,
    Action NVARCHAR(10), -- 'INSERT', 'UPDATE', or 'DELETE'
    OldData NVARCHAR(MAX),
    NewData NVARCHAR(MAX)
);

-- Create an audit trigger for the YourTable
CREATE TRIGGER AuditYourTable
ON YourTable
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @Action NVARCHAR(10);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @Action = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM deleted)
        SET @Action = 'DELETE';

    INSERT INTO AuditTable (TableName, AuditDate, Action, OldData, NewData)
    SELECT 'YourTable', GETDATE(), @Action, 
           CAST((SELECT * FROM deleted FOR XML RAW, ELEMENTS) AS NVARCHAR(MAX)),
           CAST((SELECT * FROM inserted FOR XML RAW, ELEMENTS) AS NVARCHAR(MAX));
END;

--16. Create a trigger to prevent login of the same user id in multiple pages.
Solution-->
CREATE TRIGGER trg_PreventMultipleLogins
ON Users
FOR INSERT
AS
BEGIN
    DECLARE @UserID INT
    SELECT @UserID = UserID FROM inserted

    IF EXISTS (SELECT * FROM LoggedInUsers WHERE UserID = @user_id)
    BEGIN
        RAISERROR ('User is already logged in', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        INSERT INTO LoggedInUsers (UserID) VALUES (@user_id)
    END
END

--17. Display top n customers on the basis of transaction type.
Solution-->
SELECT TOP (n) C.customer_id, Co.region_name, T.txn_type, T.txn_amount
FROM Customers AS C
INNER JOIN Transaction1 AS T ON C.customer_id = T.customer_id
INNER JOIN Continent AS Co ON C.region_id = Co.region_id
ORDER BY T.txn_amount DESC;
--Replace n by desired number

--18. Create a pivot table to display the total purchase, withdrawal and deposit for all the customers.
Solution-->
SELECT *
FROM (
    SELECT customer_id, txn_type, txn_amount
    FROM Transaction1
) AS SourceTable
PIVOT (
    SUM(txn_amount)
    FOR txn_type IN ([purchase], [withdrawal], [deposit])
) AS PivotTable;


/////////////////////////////////////////////////////////////// THANK YOU //////////////////////////////////////////////////////////////////////////////////
