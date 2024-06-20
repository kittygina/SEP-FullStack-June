USE Northwind
GO

-- Regina Afu
-- SEP Full Stack - IL Jun 2024 Batch
-- Assignment 2 SQL Using Northwind


--14.  List all Products that has been sold at least once in last 27 years.
SELECT DISTINCT p.ProductName
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID=o.OrderID
WHERE o.OrderDate >= '1997-01-01';

--15.List top 5 locations (Zip Code) where the products sold most.
SELECT TOP 5 C.PostalCode AS ZipCode, COUNT(OD.ProductID) AS ProductsSold
FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID JOIN Customers C ON O.CustomerID = C.CustomerID
Where C.PostalCode IS NOT NULL
GROUP BY C.PostalCode
ORDER BY ProductsSold DESC

--16.  List top 5 locations (Zip Code) where the products sold most in last 27 years.
SELECT 
    TOP 5 C.PostalCode AS ZipCode, 
    COUNT(OD.ProductID) AS ProductsSold
FROM 
    Orders O
JOIN 
    [Order Details] OD ON O.OrderID = OD.OrderID
JOIN 
    Customers C ON O.CustomerID = C.CustomerID
WHERE 
    O.OrderDate >= '1997-01-01'
GROUP BY 
    C.PostalCode
ORDER BY 
    ProductsSold DESC;


--17.   List all city names and number of customers in that city.     
SELECT 
    City, 
    COUNT(CustomerID) AS NumberOfCustomers
FROM 
    Customers
GROUP BY 
    City;

--18.  List city names which have more than 2 customers, and number of customers in that city
SELECT 
    City, 
    COUNT(CustomerID) AS NumberOfCustomers
FROM 
    Customers
GROUP BY 
    City
HAVING 
    COUNT(CustomerID) > 2;


--19.  List the names of customers who placed orders after 1/1/98 with order date.
SELECT 
    C.ContactName AS CustomerName, 
    O.OrderDate
FROM 
    Orders O
JOIN 
    Customers C ON O.CustomerID = C.CustomerID
WHERE 
    O.OrderDate > '1998-01-01';


--20.  List the names of all customers with most recent order dates
SELECT 
    C.ContactName AS CustomerName, 
    MAX(O.OrderDate) AS MostRecentOrderDate
FROM 
    Orders O
JOIN 
    Customers C ON O.CustomerID = C.CustomerID
GROUP BY 
    C.ContactName
ORDER BY 
    MostRecentOrderDate DESC;

--21.  Display the names of all customers  along with the  count of products they bought
SELECT 
    C.ContactName AS CustomerName, 
    COUNT(OD.ProductID) AS ProductsBought
FROM 
    Orders O
JOIN 
    Customers C ON O.CustomerID = C.CustomerID
JOIN 
    [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY 
    C.ContactName;


--22.  Display the customer ids who bought more than 100 Products with count of products.
SELECT 
    O.CustomerID, 
    COUNT(OD.ProductID) AS ProductsBought
FROM 
    Orders O
JOIN 
    [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY 
    O.CustomerID
HAVING 
    COUNT(OD.ProductID) > 100;


--23.  List all of the possible ways that suppliers can ship their products. Display the results as below

    -- Supplier Company Name                Shipping Company Name

    ---------------------------------            ----------------------------------
SELECT DISTINCT 
    S.CompanyName AS SupplierCompanyName, 
    Sh.CompanyName AS ShippingCompanyName
FROM 
    Suppliers S
JOIN 
    Products P ON S.SupplierID = P.SupplierID
JOIN 
    [Order Details] OD ON P.ProductID = OD.ProductID
JOIN 
    Orders O ON OD.OrderID = O.OrderID
JOIN 
    Shippers Sh ON O.ShipVia = Sh.ShipperID;

--24.  Display the products order each day. Show Order date and Product Name.
SELECT 
    O.OrderDate, 
    P.ProductName
FROM 
    Orders O
JOIN 
    [Order Details] OD ON O.OrderID = OD.OrderID
JOIN 
    Products P ON OD.ProductID = P.ProductID
ORDER BY 
    O.OrderDate, P.ProductName;


--25.  Displays pairs of employees who have the same job title.
SELECT 
    E1.FirstName + ' ' + E1.LastName AS Employee1, 
    E2.FirstName + ' ' + E2.LastName AS Employee2, 
    E1.Title
FROM 
    Employees E1
JOIN 
    Employees E2 ON E1.Title = E2.Title AND E1.EmployeeID < E2.EmployeeID
ORDER BY 
    E1.Title, Employee1, Employee2;


--26.  Display all the Managers who have more than 2 employees reporting to them.
SELECT 
    m.FirstName + ' ' + m.LastName AS ManagerName, 
    COUNT(e.EmployeeID) AS NumberOfReports
FROM 
    Employees e
JOIN 
    Employees m ON e.ReportsTo = m.EmployeeID
GROUP BY 
    m.FirstName, 
    m.LastName
HAVING 
    COUNT(e.EmployeeID) > 2
ORDER BY 
    NumberOfReports DESC;

--27.  Display the customers and suppliers by city. The results should have the following columns
SELECT City,CompanyName AS Name,ContactName,'Customer' AS Type
FROM Customers

UNION

SELECT 
    City, 
    CompanyName AS Name, 
    ContactName, 
    'Supplier' AS Type
FROM 
    Suppliers

ORDER BY 
    City, 
    Type, 
    Name;

