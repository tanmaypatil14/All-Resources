USE ImpactBatch14DB;
USE AdventureWorks2019;

CREATE SCHEMA PatientAdministration;

CREATE TABLE PatientAdministration.Patient
(
PatientID INT PRIMARY KEY IDENTITY(1001,1),
PatientName VARCHAR(20) NOT NULL,
BirthDate DATE NOT NULL CHECK(BirthDate<=GETDATE()),
Gender VARCHAR(1) CHECK(Gender IN('M', 'F', 'O', 'U')),
LastModified DATE DEFAULT GETDATE()
);


DROP TABLE PatientAdministration.Patient;

INSERT INTO PatientAdministration.Patient (PatientName, BirthDate, Gender) values
('Gary', '12-Jan-2001', 'M');

INSERT INTO PatientAdministration.Patient (PatientName, BirthDate, Gender) values
('Smith', '23-Oct-1995', 'M'),
('Fiona', '18-Feb-2004', 'F');

SET IDENTITY_INSERT PatientAdministration.Patient OFF

INSERT INTO PatientAdministration.Patient (PatientName, BirthDate, Gender) values
('Mike', '23-Oct-2020', NULL);

SELECT * FROM PatientAdministration.Patient;

-------------------------------------------------------------------------------------------------
/*
Foreign Key
*/

CREATE TABLE PatientAdministration.PatientRelatives
(
RelativeID INT Primary Key IDENTITY(1,1),
RelativeName VARCHAR(20) NOT NULL,
Relation VARCHAR(20),
PatientID INT REFERENCES PatientAdministration.Patient(PatientID) ON DELETE CASCADE NOT NULL
);

INSERT INTO PatientAdministration.PatientRelatives (RelativeName, Relation, PatientID) values
('Pinky', 'Spouse', 1001),
('Sumit', 'Father', 1003),
('michael', 'Brother', 1008);

SELECT * FROM PatientAdministration.PatientRelatives;

------------------------------------------------------------------------------------------------------------
/*
Modify the data
*/

UPDATE PatientAdministration.Patient SET Gender = 'M'
WHERE PatientID = 1009;

UPDATE PatientAdministration.Patient SET Gender = 'M'
WHERE PatientID = 1010;

SELECT * FROM PatientAdministration.Patient;

------------------------------------------------------------------------------------------------------------
/*
Delete the data
*/

DELETE FROM PatientAdministration.Patient 
WHERE PatientID = 1011;

SELECT * FROM PatientAdministration.Patient;

-----------------------------------------------------------------------------------------
USE AdventureWorks2019;
/*
DQL - SELECT Command 
BY USING ADVENTURE WORKS DB
*/
--get all the product details

SELECT * FROM Production.Product;

 --GET id, name, number, color, standardCost, for all products
 ----PROJECTION

SELECT ProductID, Name, ProductNumber, Color, StandardCost FROM Production.Product;

 --Get all the products costing more than 1000
 ----FILTERING (use WHERE Clause)

SELECT ProductID, Name, ProductNumber, Color, StandardCost FROM Production.Product
WHERE StandardCost > 1000;

--Get all the products which are red, green, or blue in color

SELECT ProductID, Name, ProductNumber, Color, StandardCost FROM Production.Product
WHERE Color IN ('Red', 'Green', 'Blue');

---ALTERNATE

SELECT ProductID, Name, ProductNumber, Color, StandardCost FROM Production.Product
WHERE Color = 'Red' OR Color = 'Green' OR Color = 'Blue';

--Get all the products which are red, green, or blue in color and costing is above 1000

SELECT ProductID, Name, ProductNumber, Color, StandardCost FROM Production.Product
WHERE Color IN ('Red', 'Green', 'Blue') AND StandardCost > 1000;

--Get all the products which are red or green or costing more than 1500

SELECT ProductID, Name, ProductNumber, Color, StandardCost FROM Production.Product
WHERE Color IN ('Red', 'Green') OR StandardCost > 1500;


--Get all the products which are red, green, and blue in color

SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Color IN ('Red', 'Green', 'Blue');

--Get all the Black products belonging to sub category 6 and 12

SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE ProductSubcategoryID IN (6, 12)  AND Color IN('Black');

--Get all the products not beloging to subcategory no 12

SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE ProductSubcategoryID NOT IN (12);
----------OR--------
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE ProductSubcategoryID <> 12;
----------OR--------
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE ProductSubcategoryID != 12;

----Handling NULL Values
--Get all the products which do not have color
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Color IS NULL;

--Get all the products which have color
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Color IS NOT NULL;

--Get all the products which do not have color as well as sub category
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Color IS NULL AND ProductSubcategoryID IS NULL;

--Get all the products which starts with letter C
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Name LIKE 'C%';

--Get all the products which ends with letter T
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Name LIKE '%T';

--Get all the products which have word 'BALL' in its name
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Name LIKE '%ball%';

--Get all the products which starts with letter a to c
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Name LIKE '[a-c]%';

--Get all the black products costing more than 1000 and less than 2000
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE Color = 'Black' AND (StandardCost > 1000 AND StandardCost < 2000);
---------------OR
SELECT ProductID, Name, ProductNumber, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE COLOR = 'Black' AND (StandardCost BETWEEN 1000 AND 2000);

--------------------------------------------------------------------------------------------------------------
SELECT * FROM HumanResources.Employee;

SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours FROM HumanResources.Employee

--Get all the Single Employees
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours 
FROM HumanResources.Employee
WHERE MaritalStatus = 'S';

--Get all the Employees not Single
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours 
FROM HumanResources.Employee
WHERE MaritalStatus <> 'S';

--Get all the Single female Employees
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours 
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender = 'F';

--Get all the Single male Employees taken sick leaves more than 50 hours
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender = 'M' AND SickLeaveHours > 50;

--Get all the employees born on 7th of jan 1983
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours
FROM HumanResources.Employee
WHERE BirthDate = '7-Jan-1983';

--Get all the employees born before 1980
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours
FROM HumanResources.Employee
WHERE BirthDate < '1980';
------------------OR
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours
FROM HumanResources.Employee
WHERE YEAR(BirthDate) < 1980;

-----------------------------------------------------------------------------------------------------------------
--Replace the null value for color with no color
SELECT ProductID, Name, ISNULL(Color, 'undefined') AS [Color], StandardCost, ProductSubcategoryID FROM Production.Product;

----Use CASE
--display Gender When 'M' then it will be 'Male' and 'F' then it will be 'Female'
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, 
CASE Gender
     WHEN 'M' THEN 'Male'
	 WHEN 'F' THEN 'Female'
	 ELSE 'Unknown'
END AS[Gender],
HireDate, SickLeaveHours
FROM HumanResources.Employee;

----Display the products in given format
-- ProductNumber**Name (StandardCost)
-- AR-5381**Adjustable Race (0.00)
--SELECT ProductNumber + ' ** ' + Name + ' (' + StandardCost + ')' FROM Production.Product;
SELECT ProductNumber + ' ** ' + Name + ' (' + Convert(VARCHAR(20),StandardCost) + ')' AS [Products]
FROM Production.Product;
--OR--
SELECT CONCAT(ProductNumber,' ** ',Name,' (',StandardCost,')') AS [Products]
FROM Production.Product

---------------------------------------------------------------------------------------------------------
--------BUILT IN FUNCTIONS---------
/*
NUMERIC FUNCTIONS
STRING FUNCTIONS
DATE FUNCTIONS
AGGREGATE FUNCTIONS
*/
--------------------------------------------
/*
NUMERIC
*/
SELECT ProductID, Name, 
ISNULL(Color, 'undefined') AS [Color],
StandardCost,
CEILING(StandardCost) AS [Celing],
FLOOR(StandardCost) AS [Floor],
ROUND(StandardCost,0) AS [Round],
ProductSubcategoryID 
FROM Production.Product

----
SELECT POWER(5,3) AS CUBE, PI()

/*
STRING FUNCTIONS
SUBSTRING(Name,2,5)---------where 2 is starting point of character and 5 is take char. from starting point to the number mentioned
*/
SELECT ProductID, UPPER(Name),
SUBSTRING(Name,2,5) AS [SubString],
ISNULL(Color, 'undefined') AS [Color],
StandardCost, ProductSubcategoryID
FROM Production.Product

-----------------------------------------------------------
/*
DATE FUNCTIONS
---10 IS NOTHING BUT AN WHAT IS THE DATE AFTER 10 YEARS FROM CURRENT DATE
*/
--YEAR
SELECT DATEADD(YYYY,10,GETDATE());
--MONTH
SELECT DATEADD(MM,10,GETDATE());
--WEEK
SELECT DATEADD(WK,10,GETDATE());
--DAY
SELECT DATEADD(DD,10,GETDATE());
--MINUTE
SELECT DATEADD(MI,10,GETDATE());

--Get the experience of all the employees
SELECT BusinessEntityID, NationalIDNumber, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SickLeaveHours,
DATEDIFF(YYYY, HireDate, GETDATE()) AS [Exp. In Years],
DATEDIFF(YYYY, BirthDate, GETDATE()) AS [AGE]
FROM HumanResources.Employee;

-------------------------------------------------------------
----SORTING----
--by default it will sorting ASC by productId
SELECT ProductID, ProductNumber, Name, Color, StandardCost, ProductSubcategoryID FROM Production.Product;

--Sorting by name by default ASC
SELECT ProductID, ProductNumber, Name, Color, StandardCost, ProductSubcategoryID FROM Production.Product
ORDER BY Name;

--Sorting by name in DESC
SELECT ProductID, ProductNumber, Name, Color, StandardCost, ProductSubcategoryID FROM Production.Product
ORDER BY Name DESC;

--Sort by Color
SELECT ProductID, ProductNumber, Name, Color, StandardCost, ProductSubcategoryID FROM Production.Product
ORDER BY Color;

--Sort by Color, standardCost DESC
SELECT ProductID, ProductNumber, Name, Color, StandardCost, ProductSubcategoryID FROM Production.Product
ORDER BY Color, StandardCost DESC;

-----------------------------------------------------------------------------------------------
/*
AGGREGATE FUNCTIONS
---Whenever we apply aggregation on data we loose access to individual rows and columns
*/
--GET total cost of all products
SELECT SUM(StandardCost) AS [Total Cost] FROM Production.Product;

--GET count of all products
SELECT COUNT(*) AS [Total Products] FROM Production.Product;

/*
This query will fail
*/
---Whenever we apply aggregation on data we loose access to individual rows and columns
SELECT ProductID, COUNT(*) AS [Total Products] FROM Production.Product;

--Get colorwise sum of standard cost for the products
SELECT Color, SUM(StandardCost) AS [Total Cost] FROM Production.Product
GROUP BY Color;

--Get colorwise count of products
SELECT Color, COUNT(*) AS [Total Products] FROM Production.Product
GROUP BY Color;

--Get the distinct count of employess based on gender and maritial status
SELECT Gender, MaritalStatus, COUNT(*) AS [Total Employees]
FROM HumanResources.Employee
GROUP BY Gender, MaritalStatus;

-----------------------------------------------------------------------------------
---Over Clause---applied on window functions(aggregate , ranking)

--List all the products with total cost for all products

SELECT ProductID, Name, Color, StandardCost, ProductSubcategoryID,
SUM(StandardCost) OVER() AS [Total Cost] 
FROM Production.Product;

--List all the products with Colorwise total cost for all products
SELECT ProductID, Name, Color, StandardCost, ProductSubcategoryID,
SUM(StandardCost) OVER(PARTITION BY Color) AS [Total Cost]
FROM Production.Product;
