----Get the Costliest Products

--This will give only max cost
SELECT MAX(StandardCost) FROM Production.Product;

-- Solution_1 :: SubCategory
SELECT ProductID, Name, Color, StandardCost, ProductSubcategoryID FROM Production.Product
WHERE StandardCost = 
(
SELECT MAX(StandardCost) FROM Production.Product
);

-- Solution_2 :: Limit______(NOT AN APPROPRIATE SOLUTION)
SELECT ProductID, Name, Color, StandardCost, ProductSubcategoryID FROM Production.Product
ORDER BY StandardCost DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;

-----Get 3rd Costliest products
/*
TOP N ANALYSIS
  RANKING FUNCTION
  ROW_NUMBER
  RANK
  DENSE_RANK
  NTILE
*/

--Sorting the data is mandaory while working with raking functions
SELECT ProductID, Name, Color, StandardCost, ProductSubcategoryID,
ROW_NUMBER()OVER(ORDER BY StandardCost DESC) AS [Row Number]
FROM Production.Product;
----

SELECT ProductID, Name, Color, StandardCost, ProductSubcategoryID,
ROW_NUMBER()OVER(ORDER BY StandardCost DESC) AS [Row Number],
RANK()OVER(ORDER BY StandardCost DESC) AS [Rank]
FROM Production.Product;
-----

SELECT ProductID, Name, Color, StandardCost, ProductSubcategoryID,
ROW_NUMBER()OVER(ORDER BY StandardCost DESC) AS [Row Number],
RANK()OVER(ORDER BY StandardCost DESC) AS [Rank],
DENSE_RANK()OVER(ORDER BY StandardCost DESC) AS [Dense Rank]
FROM Production.Product;
