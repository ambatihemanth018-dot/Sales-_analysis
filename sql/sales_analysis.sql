
CREATE DATABASE Amazon_sales;
GO

USE Amazon_sales;
GO

CREATE TABLE dbo.amazon_Sales (
    OrderID NVARCHAR(20) PRIMARY KEY,     
    OrderDate DATE,                       -- format: 31-01-2023
    CustomerID NVARCHAR(20),
    CustomerName NVARCHAR(100),
    ProductID NVARCHAR(20),
    ProductName NVARCHAR(150),
    Category NVARCHAR(50),
    Brand NVARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Tax DECIMAL(10,2),
    ShippingCost DECIMAL(10,2),
    TotalAmount DECIMAL(12,2),
    PaymentMethod NVARCHAR(50),
    OrderStatus NVARCHAR(50),
    City NVARCHAR(100),
    State NVARCHAR(50),
    Country NVARCHAR(50),
    SellerID NVARCHAR(20)
);

SET DATEFORMAT dmy;

BULK INSERT dbo.Amazon_Sales
FROM 'C:\Datasets\Amazon_sales.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

SELECT TOP 10 * 
FROM dbo.amazon_Sales;

SELECT COUNT(*) AS TotalRows
FROM dbo.Amazon_Sales;

SELECT TOP 10 OrderDate
FROM dbo.Amazon_Sales;

SELECT SUM(TotalAmount) AS TotalRevenue
FROM dbo.Amazon_Sales;

SELECT OrderStatus, COUNT(*) AS TotalOrders
FROM dbo.Amazon_Sales
GROUP BY OrderStatus;




---- Are high-value customers driving most of our revenue?
----Impact: Shows dependence on key customers and revenue concentration.

SELECT TOP 10 CustomerID, CustomerName, SUM(TotalAmount) AS TotalRevenue
FROM dbo.amazon_Sales
GROUP BY CustomerID, CustomerName
ORDER BY TotalRevenue DESC;

------ Which products are underperforming in sales?
-----  Impact: Helps prioritize inventory, marketing, or product improvement.

SELECT ProductID, ProductName, SUM(Quantity) AS TotalQuantitySold
FROM dbo.amazon_Sales
GROUP BY ProductID, ProductName
ORDER BY TotalQuantitySold ASC; -- lowest sales first

---- Are discounts improving sales or reducing profitability?
---- Impact: Evaluates the effectiveness of discounts on revenue and margins.

SELECT Category, SUM(Discount) AS TotalDiscountGiven, SUM(TotalAmount) AS TotalRevenue
FROM dbo.amazon_Sales
GROUP BY Category
ORDER BY TotalDiscountGiven DESC;


---- Is order fulfillment timely? (Pending vs Completed)
---- Impact: Shows operational efficiency and customer satisfaction.

SELECT OrderStatus, COUNT(OrderID) AS NumberOfOrders, 
       COUNT(OrderID) * 100.0 / (SELECT COUNT(*) FROM dbo.amazon_Sales) AS PercentageOfTotal
FROM dbo.amazon_Sales
GROUP BY OrderStatus;


---  Are sales increasing over time? (Monthly trend)
---  Impact: Measures project growth and trajectory.

SELECT YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month, SUM(TotalAmount) AS TotalSales
FROM dbo.amazon_Sales
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year, Month;


---- Which sellers are contributing most to project success?
---- Impact: Identifies high-performing partners and dependencies.

SELECT SellerID, SUM(TotalAmount) AS TotalSales, COUNT(OrderID) AS OrdersHandled
FROM dbo.amazon_Sales
GROUP BY SellerID
ORDER BY TotalSales DESC;



----- Top 5 customers by total revenue with ranking
----- Business impact: Identifies key revenue drivers and priority clients.

SELECT 
    CustomerID,
    CustomerName,
    SUM(TotalAmount) AS TotalRevenue,
    RANK() OVER (ORDER BY SUM(TotalAmount) DESC) AS RevenueRank
FROM dbo.amazon_Sales
GROUP BY CustomerID, CustomerName
ORDER BY RevenueRank;

---- Identify products with high discount but low revenue
---- Business impact: Highlights products that reduce profitability.

SELECT 
    ProductID,
    ProductName,
    SUM(TotalAmount) AS TotalRevenue,
    SUM(Discount) AS TotalDiscount,
    RANK() OVER (ORDER BY SUM(Discount) DESC, SUM(TotalAmount) ASC) AS RiskRank
FROM dbo.amazon_Sales
GROUP BY ProductID, ProductName
ORDER BY RiskRank;


---- Customers Buying Same Product

SELECT 
    a.ProductName,
    a.CustomerName AS Customer1,
    b.CustomerName AS Customer2
FROM amazon_Sales a
JOIN amazon_Sales b
    ON a.ProductID = b.ProductID
    AND a.CustomerID <> b.CustomerID;


---- Same City Customers Comparison

SELECT 
    a.City,
    a.CustomerName AS Customer1,
    b.CustomerName AS Customer2
FROM amazon_Sales a
JOIN amazon_Sales b
    ON a.City = b.City
    AND a.CustomerID <> b.CustomerID;