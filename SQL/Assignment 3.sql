-- Regina Afu
-- SEP Full Stack - IL Jun 2024 Batch
-- Assignment 2 SQL Using Northwind

--1.      List all cities that have both Employees and Customers.
USE Northwind
GO 

SELECT DISTINCT E.City 
FROM Employees E JOIN Customers C ON E.City = C.City;

--2.      List all cities that have Customers but no Employee.
--				a. Use sub-query
SELECT DISTINCT C.City
FROM Customers C
WHERE C.City NOT IN (SELECT DISTINCT E.City FROM Employees E);

--	b. Do not use sub-query
SELECT DISTINCT C.City
FROM Customers C LEFT JOIN Employees E ON C.City = E.City
WHERE E.City IS NULL;

--3.    List all products and their total order quantities throughout all orders.
SELECT P.ProductName, SUM(OD.Quantity) AS TotalOrderQuantity
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY TotalOrderQuantity DESC;

--4.      List all Customer Cities and total products ordered by that city.
SELECT C.City, SUM(OD.Quantity) AS TotalProductsOrdered
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.City
ORDER BY TotalProductsOrdered DESC;

--5.      List all Customer Cities that have at least two customers.
--a.      Use union
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) = 2

UNION

SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2
ORDER BY City;

--b.      Use sub-query and no union
SELECT City
FROM Customers
WHERE City IN 
(SELECT City
 FROM Customers 
 GROUP BY City 
 HAVING COUNT(CustomerID) >= 2)
GROUP BY City;

--6.      List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.City
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;

--7.      List all Customers who have ordered products, but have the ‘ship city’ on the order different 
--from their own customer cities.
SELECT DISTINCT c.CustomerID, c.CompanyName, c.City AS CustomerCity, o.ShipCity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity;

--8.     List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
WITH ProductPopularity AS (
    SELECT 
        od.ProductID, 
        p.ProductName, 
        AVG(od.UnitPrice) AS AveragePrice,
        SUM(od.Quantity) AS TotalQuantity
    FROM [Order Details] od
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY od.ProductID, p.ProductName
),
Top5Products AS (
    SELECT TOP 5 
        ProductID, 
        ProductName, 
        AveragePrice,
        TotalQuantity
    FROM ProductPopularity
    ORDER BY TotalQuantity DESC
),
CustomerCityPopularity AS (
    SELECT 
        od.ProductID,
        c.City,
        SUM(od.Quantity) AS TotalQuantity
    FROM [Order Details] od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY od.ProductID, c.City
),
MostPopularCity AS (
    SELECT 
        t5.ProductID,
        t5.ProductName,
        t5.AveragePrice,
        ccp.City
    FROM Top5Products t5
    JOIN CustomerCityPopularity ccp ON t5.ProductID = ccp.ProductID
    WHERE ccp.TotalQuantity = (
        SELECT MAX(ccp2.TotalQuantity)
        FROM CustomerCityPopularity ccp2
        WHERE ccp2.ProductID = t5.ProductID
    )
)
SELECT 
    ProductID, 
    ProductName, 
    AveragePrice, 
    City AS MostPopularCity
FROM MostPopularCity;


--9.      List all cities that have never ordered something but we have employees there.--

-- a.      Use sub-query
SELECT DISTINCT e.City
FROM Employees e
WHERE e.City NOT IN (
    SELECT DISTINCT o.ShipCity
    FROM Orders o
)

--b.      Do not use sub-query
SELECT DISTINCT e.City
FROM Employees e
LEFT JOIN Orders o ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL;


--10.  List one city, if exists, that is the city,from where the employee sold most orders (not the product quantity) is, 
--and also the city of most total quantity of products ordered from. (tip: join  sub-query)
WITH EmployeeCityOrders AS (
    SELECT e.City, COUNT(o.OrderID) AS TotalOrders
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.City
),
TopEmployeeCity AS (
    SELECT TOP 1 City, TotalOrders
    FROM EmployeeCityOrders
    ORDER BY TotalOrders DESC
),
CustomerCityOrders AS (
    SELECT o.ShipCity AS City, SUM(od.Quantity) AS TotalQuantity
    FROM Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY o.ShipCity
),
TopCustomerCity AS (
    SELECT TOP 1 City, TotalQuantity
    FROM CustomerCityOrders
    ORDER BY TotalQuantity DESC
)
SELECT 'Employee City with Most Orders' AS Criteria, tec.City, tec.TotalOrders AS Value
FROM TopEmployeeCity tec
UNION ALL
SELECT 'Customer City with Most Quantity Ordered', tcc.City, tcc.TotalQuantity
FROM TopCustomerCity tcc;



--11. How do you remove the duplicates record of a table?
WITH CTE AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY OrderID, CustomerID, OrderDate ORDER BY (SELECT NULL)) AS rn
    FROM 
        Orders
)
DELETE FROM Orders
WHERE OrderID IN (
    SELECT OrderID
    FROM CTE
    WHERE rn > 1
)
