Use AdventureWorks2025;
GO

----------------------------------READ SIMPLE----------------------------------
CREATE OR ALTER PROCEDURE sp_SalesOrderGetAll
AS
BEGIN
    SELECT  SS.SalesOrderID,
            SS.SalesOrderNumber,
            SS.CustomerID,
            SS.SalesPersonID,
            SS.PurchaseOrderNumber,
            SS.AccountNumber,
            SS.TerritoryID,
            SS.SubTotal,
            SS.TaxAmt,
            SS.Freight,
            SS.TotalDue,
            SS.CreditCardID,
            SS.Comment
        FROM SALES.SalesOrderHeader AS SS;
END;
GO

EXEC sp_SalesOrderGetAll;
GO

----------------------------------READ CON JOIN----------------------------------
CREATE OR ALTER PROCEDURE sp_ProductGetAll
AS
BEGIN
    SELECT  PP.Name AS ProductName, 
            PP.ProductNumber,
            PC.Name AS ProductCategoryName,
            PS.Name AS ProductSubcategoryName,
            PP.Color,
            PP.StandardCost,
            PP.ListPrice,
            PP.Size,
            PP.Weight,
            PP.SellStartDate,
            PP.SellEndDate,
            PP.DiscontinuedDate
        FROM PRODUCTION.Product AS PP
        LEFT JOIN PRODUCTION.ProductSubcategory AS PS ON PS.ProductSubcategoryID = PP.ProductSubcategoryID
        LEFT JOIN PRODUCTION.ProductCategory AS PC ON PC.ProductCategoryID = PS.ProductCategoryID
        ORDER BY PP.ProductID ASC;
END;
GO
        
EXEC sp_ProductGetAll;
GO

----------------------------------READ CON JOIN Y PARÁMETROS----------------------------------
CREATE OR ALTER PROCEDURE sp_ProductGetByID
    @ProductID INT
AS
BEGIN
    SELECT  PP.ProductID,
            PP.Name AS ProductName, 
            PP.ProductNumber,
            PC.Name AS ProductCategoryName,
            PS.Name AS ProductSubcategoryName,
            PP.Color,
            PP.StandardCost,
            PP.ListPrice,
            PP.Size,
            PP.Weight,
            PP.SellStartDate,
            PP.SellEndDate,
            PP.DiscontinuedDate        
        FROM PRODUCTION.Product AS PP
        LEFT JOIN PRODUCTION.ProductSubcategory AS PS ON PS.ProductSubcategoryID = PP.ProductSubcategoryID
        LEFT JOIN PRODUCTION.ProductCategory AS PC ON PC.ProductCategoryID = PS.ProductCategoryID
        WHERE PP.ProductID = @ProductID;
END;
GO

EXEC sp_ProductGetByID 749;
GO

----------------------------------CREATE SIMPLE----------------------------------
CREATE OR ALTER PROCEDURE sp_CreateProduct
    @Name NVARCHAR(50), 
    @ProductNumber NVARCHAR(25), 
    @Color NVARCHAR(15), 
    @SafetyStockLevel SMALLINT, 
    @ReorderPoint SMALLINT, 
    @StandardCost MONEY, 
    @ListPrice MONEY,  
    @Size NVARCHAR(5), 
    @DaysToManufacture INT, 
    @SellStartDate DATE
AS 
BEGIN
    INSERT INTO PRODUCTION.Product (Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, 
                                    StandardCost, ListPrice, Size, DaysToManufacture, SellStartDate)
        VALUES (@Name, @ProductNumber, @Color, @SafetyStockLevel, @ReorderPoint, @StandardCost, 
                @ListPrice, @Size, @DaysToManufacture, @SellStartDate);
END;
GO

EXEC sp_CreateProduct 'Mountain Bike Helmet', 'MB-M01B-01', 'Red', 100, 50, 10.00, 20.00, 'M', 5, '20260913';
GO

----------------------------------UPDATE SIMPLE----------------------------------
CREATE OR ALTER PROCEDURE sp_UpdateProduct
    @ProductID INT,
    @Color NVARCHAR(15), 
    @StandardCost MONEY, 
    @ListPrice MONEY, 
    @Size NVARCHAR(5), 
    @DaysToManufacture INT
AS 
BEGIN
UPDATE PRODUCTION.Product
    SET Color = @Color, StandardCost = @StandardCost, ListPrice = @ListPrice, Size = @Size, DaysToManufacture = @DaysToManufacture
    WHERE ProductID = @ProductID;
END;
GO

EXEC sp_UpdateProduct 316, 'Grey', 14.50, 35.00, 'S', 5;
GO

----------------------------------DELETE SIMPLE----------------------------------
CREATE OR ALTER PROCEDURE sp_DeleteProduct
    @ProductID INT
AS
BEGIN
    DELETE FROM PRODUCTION.Product 
        WHERE ProductID = @ProductID;
END;
GO

EXEC sp_DeleteProduct 1003;
GO
