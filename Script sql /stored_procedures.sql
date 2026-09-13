Use AdventureWorks2025;
GO

CREATE PROCEDURE sp_SalesOrderGetAll
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


CREATE PROCEDURE sp_ProductGetAll
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


CREATE PROCEDURE sp_ProductGetByName
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

EXEC sp_ProductGetByName 749;
GO