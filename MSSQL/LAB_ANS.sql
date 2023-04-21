USE AdventureWorks2019;
------------------------------LAB_1--------------------------
CREATE DATABASE LAB_1;

USE LAB_1;

CREATE SCHEMA production;

CREATE TABLE production.product(
productId INT PRIMARY KEY IDENTITY(1,1),
productName VARCHAR(20) NOT NULL,
productCost MONEY NOT NULL,
quantityInStock INT NOT NULL,
productSubCategoryId INT REFERENCES production.productSubCategory(productSubCategoryId));

CREATE TABLE production.productSubCategory(
productSubCategoryId INT PRIMARY KEY,
productSubCategoryName VARCHAR(20) NOT NULL,
productCategoryId INT REFERENCES production.productCategory(productCategoryId));


CREATE TABLE production.productCategory(
productCategoryId INT PRIMARY KEY,
productCategoryName VARCHAR(20));
------------sales----------------

CREATE SCHEMA sales;


CREATE TABLE sales.SalesOrderDetail(
SalesOrderDetailID INT PRIMARY KEY,
SalesOrderHeaderID INT REFERENCES sales.SalesOrderHeader(SalesOrderHeaderID),
ProductID INT REFERENCES production.product(productId),
OrderQuantity INT NOT NULL);

CREATE TABLE sales.SalesOrderHeader(
SalesOrderHeaderID INT PRIMARY KEY,
OrderDate INT NOT NULL,
CustomerID INT REFERENCES sales.Customer(CustomerID),
SalesPersonID INT NOT NULL);

CREATE TABLE sales.Customer(
CustomerID INT PRIMARY KEY,
PersonID INT REFERENCES HumanResources.Person(PersonID),
TerritoryID INT sales.Territory(TerritoryID),
CustomerGrade INT);

CREATE TABLE sales.Country(
CountryID INT PRIMARY KEY,
CountryName VARCHAR(20) NOT NULL);

CREATE TABLE sales.Territory(
TerritoryID INT PRIMARY KEY,
TerritoryName VARCHAR(20) NOT NULL,
CountryID INT REFERENCES sales.Country(CountryID));

CREATE SCHEMA HumanResources;

CREATE TABLE HumanResources.Employee(
EmployeeID INT PRIMARY KEY,
Designation VARCHAR(20) NOT NULL,
ManagerID INT NOT NULL,
DateOfJoining DATE,
DepartmentID INT REFERENCES HumanResources.Department(DepartmentID),
PersonID INT REFERENCES HumanResources.Person(PersonID));

CREATE TABLE HumanResources.Department(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(20) NOT NULL);

CREATE TABLE HumanResources.Person(
PersonId INT PRIMARY KEY,
Title VARCHAR(20) NOT NULL,
FirstName VARCHAR(20) NOT NULL,
MiddleName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
ModifiedDate DATE NOT NULL);

----------------------------------------------------------------------------------------
------------------------------LAB_3--------------------------
SELECT * FROM Person.Person;

--ques :1 ANSWER
SELECT BusinessEntityID, NameStyle ,FirstName, MiddleName, LastName, ModifiedDate FROM Person.Person
WHERE ModifiedDate >'29-Dec-2000';

--ques :2 ANSWER          
SELECT BusinessEntityID, NameStyle ,FirstName, MiddleName, LastName, ModifiedDate FROM Person.Person
WHERE YEAR(ModifiedDate) <> 2000 AND MONTH(ModifiedDate) <> 12;
-----OR-----
SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate 
FROM Person.Person 
WHERE ModifiedDate NOT BETWEEN '2000-12-01' AND '2000-12-31';

--ques :3 ANSWER
SELECT ProductID, Name FROM Production.Product 
WHERE Name LIKE 'Chain%';

--ques :4 ANSWER
SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate FROM Person.Person
WHERE MiddleName IN ('E', 'B');

--ques :5 ANSWER
SELECT * FROM Sales.SalesOrderHeader;

SELECT SalesOrderID, OrderDate, TotalDue FROM Sales.SalesOrderHeader
WHERE TotalDue > 1000 AND OrderDate >= '01-Sep-2012' AND OrderDate <= '30-Sep-2012';

--ques :6 ANSWER
SELECT * FROM Sales.SalesOrderHeader
WHERE TotalDue > 1000 AND SalesPersonID = 279 OR TerritoryID = 6;

--ques :7 ANSWER
SELECT ProductID, Name, Color FROM Production.Product
WHERE Color <> 'blue';

--ques :8 ANSWER
8.	Write a query that returns the business entity ID and name columns from the Person.Person table. 
Sort the results by LastName, FirstName, and MiddleName. 

SELECT BusinessEntityID, FirstName, MiddleName, LastName, ModifiedDate FROM Person.Person
ORDER BY LastName, FirstName, MiddleName;

	
--ques :9 ANSWER
SELECT AddressLine1 + ' (' + City + ' ' + PostalCode + ')' FROM Person.Address;

--ques :10 ANSWER
SELECT ProductID, ISNULL(Color, 'No Color') AS [Color], Name FROM Production.Product;

--ques :11 ANSWER
SELECT ProductID, Name + ISNULL(': ' + Color,'') AS ProductNameWithColor FROM Production.Product;

--ques :12 ANSWER
SELECT SpecialOfferID, Description, MaxQty - MinQty AS [Difference] 
FROM Sales.SpecialOffer;

SELECT SpecialOfferID, Description, MaxQty, MinQty
FROM Sales.SpecialOffer;

--ques :13 ANSWER
SELECT SpecialOfferID, Description, ISNULL(MaxQty,10) * DiscountPct AS Discount FROM Sales.SpecialOffer;

--ques :14 ANSWER
SELECT SUBSTRING(AddressLine1,1,10) AS AddressCharFirst10
FROM Person.Address;

--ques :15 ANSWER
SELECT SalesOrderID, OrderDate, ShipDate, DATEDIFF(d,OrderDate,ShipDate) AS NumberOfDays FROM Sales.SalesOrderHeader;

--ques :16 ANSWER
SELECT CONVERT(VARCHAR,OrderDate,1) AS OrderDate, CONVERT(VARCHAR, ShipDate,1) AS ShipDate FROM Sales.SalesOrderHeader;

--ques :17 ANSWER
SELECT SalesOrderID, OrderDate, DATEADD(m,6,OrderDate) Plus6Months FROM Sales.SalesOrderHeader;

--ques :18 ANSWER
SELECT SalesOrderID, OrderDate, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth FROM Sales.SalesOrderHeader;

--ques :19 ANSWER
SELECT CAST(RAND() * 10 AS INT) + 1;

--ques :20 ANSWER
SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader ORDER BY MONTH(OrderDate), YEAR(OrderDate);
--ques :21 ANSWER
SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader ORDER BY MONTH(OrderDate), YEAR(OrderDate);

--ques :22 ANSWER
SELECT JobTitle, BirthDate, FirstName, LastName 
FROM HumanResources.Employee AS E 
INNER JOIN Person.Person AS P ON E.BusinessEntityID = P.BusinessEntityID;

--ques :23 ANSWER
SELECT CustomerID, StoreID, TerritoryID, FirstName, MiddleName, LastName 
FROM Sales.Customer AS C 
INNER JOIN Person.Person AS P ON C.PersonID = P.BusinessEntityID;

--ques :24 ANSWER
SELECT SalesOrderID, SalesQuota, Bonus FROM Sales.SalesOrderHeader AS S 
INNER JOIN Sales.SalesPerson AS SP ON S.SalesPersonID = SP.BusinessEntityID;

--ques :25 ANSWER
SELECT PM.CatalogDescription, Color, Size 
FROM Production.Product AS P 
INNER JOIN Production.ProductModel AS PM ON P.ProductModelID = PM.ProductModelID;

--ques :26 ANSWER
SELECT FirstName, MiddleName, LastName, Prod.Name 
FROM Sales.Customer AS C INNER JOIN Person.Person AS P ON C.PersonID = P.BusinessEntityID 
INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID = SOH.CustomerID 
INNER JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID 
INNER JOIN Production.Product AS Prod ON SOD.ProductID = Prod.ProductID;

--ques :27 ANSWER
SELECT SalesOrderID, P.ProductID, P.Name 
FROM Production.Product AS P 
LEFT OUTER JOIN Sales.SalesOrderDetail AS SOD ON P.ProductID = SOD.ProductID;

--ques :28 ANSWER
SELECT CR.CurrencyRateID, CR.AverageRate, SM.ShipBase, SalesOrderID 
FROM Sales.SalesOrderHeader AS SOH 
LEFT OUTER JOIN Sales.CurrencyRate AS CR ON SOH.CurrencyRateID = CR.CurrencyRateID 
LEFT OUTER JOIN Purchasing.ShipMethod AS SM ON SOH.ShipMethodID = SM.ShipMethodID;

--ques :29 ANSWER
SELECT COUNT(*) AS CountOfCustomers FROM Sales.Customer;

--ques :30 ANSWER
SELECT MIN(ListPrice) AS Minimum, MAX(ListPrice) AS Maximum, AVG(ListPrice) AS Average 
FROM Production.Product;

--ques :31 ANSWER
SELECT SUM(OrderQty) AS TotalOrdered, ProductID 
FROM Sales.SalesOrderDetail GROUP BY ProductID;

--ques :32 ANSWER
SELECT COUNT(*) AS CountOfOrders, SalesOrderID 
FROM Sales.SalesOrderDetail GROUP BY SalesOrderID;

--ques :33 ANSWER
SELECT COUNT(*) AS CountOfProducts, ProductLine 
FROM Production.Product GROUP BY ProductLine;

--ques :34 ANSWER
SELECT CustomerID, COUNT(*) AS CountOfSales, YEAR(OrderDate) AS OrderYear 
FROM Sales.SalesOrderHeader GROUP BY CustomerID, YEAR(OrderDate);

--ques :35 ANSWER
SELECT SUM(LineTotal) AS SumOfLineTotal, SalesOrderID 
FROM Sales.SalesOrderDetail GROUP BY SalesOrderID HAVING SUM(LineTotal) > 1000;

--ques :36 ANSWER
SELECT ProductModelID, COUNT(*) AS CountOfProducts 
FROM Production.Product GROUP BY ProductModelID HAVING COUNT(*) = 1;

--ques :37 ANSWER
SELECT SUM(OrderQty) SumOfOrderQty, P.ProductID, SOH.OrderDate 
FROM Sales.SalesOrderHeader AS SOH 
INNER JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderDetailID 
INNER JOIN Production.Product AS P ON SOD.ProductID = P.ProductID GROUP BY P.ProductID, SOH.OrderDate;

---------------------------------LAB-4-----------------------
CREATE TABLE #Passengers
(
    Passenger INT PRIMARY KEY IDENTITY (1,1),
    PassengerId VARCHAR(20),
    PassengerName  VARCHAR(20),
    PassengerGender VARCHAR(20),
    Birthdate DATE
)
CREATE PROCEDURE sp_passengerdata
(
    @pPassengerId VARCHAR(20),
    @pPassengerName VARCHAR(20),
    @pPassengerGender VARCHAR(20),
    @pBirthdate DATE
)
AS 
BEGIN
IF (DATEDIFF (YYYY,@pBirthdate,GetDate())  BETWEEN 6 AND 90) and @pPassengerGender  in ('Male','Female','other') and @pPassengerName is not null and @pBirthdate is not null
    BEGIN
    INSERT INTO #Passengers (PassengerId,PassengerName,PassengerGender,Birthdate) VALUES (@pPassengerId,@pPassengerName,@pPassengerGender,@pBirthdate)
    END
ELSE
    BEGIN
    PRINT 'Incorrect Data!'
    END
END
EXECUTE sp_passengerdata 'P9003','Renna ','Female','21-Jan-2010'
EXECUTE sp_passengerdata 'P9002','sam john','Male','12-Dec-2021'
SELECT * FROM #Passengers;
DROP TABLE #Passengers
DROP PROCEDURE sp_passengerdata
-----------------------------------------LAB-5----------------------------------
DECLARE
LOW number(2);
HIGH number(2);
n number(2);
m number(2);
c number(20);
BEGIN
dbms_output.put_line('Enter the lower and higher limit:');
LOW=&LOW;
HIGH=&HIGH;
FOR n IN LOW.. HIGH
LOOP
c:=0;
FOR m IN 1.. n
LOOP  
    IF mod(n, m)=0 THEN
    c:=c+1;
    END IF;
END LOOP;
            IF c<=2 THEN 
               dbms_output.put_line(n||'\n');
            END IF;
END LOOP; 
END;

--------------------------que-2--------------------------------------------
alter function Production.get_ProductDetails(@CategoryID int)
returns @table table(ProductID int,Name varchar(50),ProductNumber nvarchar(25),
ProductModelID int,Size nvarchar(5),StandardCost money,style nchar(2),
Color nvarchar(15),Weight decimal(8,2), ProductCategoryID int)
as
begin

insert into @table select prd.ProductID,prd.Name,prd.ProductNumber,prd.ProductModelID,
prd.Size,prd.StandardCost,prd.Style,prd.Color,prd.Weight,cat.ProductCategoryID from Production.Product as prd
left join Production.ProductSubcategory as sub
on prd.ProductSubcategoryID= sub.ProductSubcategoryID
left join Production.ProductCategory as cat
on sub.ProductCategoryID=cat.ProductCategoryID where cat.ProductCategoryID=@categoryID

return;
end

select * from Production.get_ProductDetails(4)

--------------------------------------TRIGGERS--------------------------------
CREATE SCHEMA BankAccounts;

CREATE TABLE BankAccounts.BankAccounts(
	AccountID  INT PRIMARY KEY IDENTITY(1,1),
	CustomerName VARCHAR(100) NOT NULL,
	AccountType  VARCHAR(10) NOT NULL CHECK (AccountType IN('Current ','Saving')),
	BALANCE MONEY CHECK (BALANCE>0),
	LastModified DATE DEFAULT GETDATE()
);


INSERT INTO BankAccounts.BankAccounts (CustomerName,AccountType,BALANCE) VALUES
('Tanmay', 'Saving', 6000),
('Vishal', 'Saving', 12780),
('Manish', 'Saving', 4300),
('Tejas', 'Saving', 9870),
('Pranav', 'Current', 140990),
('Kalpesh', 'Current', 160005),
('Anicket', 'Current', 1400000),
('Navoday', 'Current', 350000);

CREATE TABLE BankAccounts.BankTransactions(
	TransactionID INT PRIMARY KEY IDENTITY(1,1),
	AccountID INT REFERENCES BankAccounts.BankAccounts(AccountID) NOT NULL,
	TransactionDate DATE CHECK (TransactionDate<=GETDATE()),
	TransactionType VARCHAR(10) NOT NULL CHECK (TransactionType IN('Debit ','Credit')),
	TransactionAmount MONEY CHECK (TransactionAmount>0)
)


CREATE TRIGGER update_bankAccount
ON BankAccounts.BankTransactions
AFTER INSERT	
AS
BEGIN
	IF(SELECT TransactionType FROM inserted)='Credit'
		UPDATE BankAccounts.BankAccounts SET BALANCE=BALANCE+(SELECT TransactionAmount FROM inserted) WHERE AccountID=(SELECT AccountID FROM inserted)
	ELSE
		UPDATE BankAccounts.BankAccounts SET BALANCE=BALANCE-(SELECT TransactionAmount FROM inserted) WHERE AccountID=(SELECT AccountID FROM inserted)
	Print 'Balance updated in account table for the customer!'
END

INSERT INTO BankAccounts.BankTransactions (AccountID,TransactionDate,TransactionType,TransactionAmount) 
VALUES (1,'02-APR-2022','Debit',1000);

INSERT INTO BankAccounts.BankTransactions (AccountID,TransactionDate,TransactionType,TransactionAmount) 
VALUES (2,'02-APR-2022','Credit',1000);

SELECT * FROM BankAccounts.BankAccounts;

SELECT * FROM BankAccounts.BankTransactions;
------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_strException @INPUT VARCHAR(15)
AS 
DECLARE @num int;
DECLARE @k int;
SET @k=0;
BEGIN TRY
SET @num = Cast(@input AS BIGINT)
WHILE(@k<@num)
BEGIN    
    SET @k=@k+1;
    PRINT 'Hello';
END
END TRY
BEGIN CATCH
PRINT 'Cannot convert '''+@input+''' into number';
END CATCH
-------------------

CREATE TABLE #employee(
empID INT PRIMARY KEY IDENTITY(1,1),
NAME VARCHAR(30),
salary INT CHECK(salary>=10000)
)
DECLARE @name VARCHAR(10);
DECLARE @salary INT;
SET @name='Ketan';
SET @salary=50000;
BEGIN TRY
INSERT INTO #employee (name,salary)VALURES(@name,@salary)
END TRY
BEGIN CATCH
PRINT 'Salary should be greater than 10000'
END CATCH


