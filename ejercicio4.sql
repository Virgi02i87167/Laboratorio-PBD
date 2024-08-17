--Hacer una consulta que procese las ordenes de compra una por una y evalúe si una orden "Pendiente" 
--tiene más de 30 días si cumple con la condición cambiar el status de la orden de Pendiente a Expirada 
--sino dejarla como Pendiente. Use while.


DECLARE @OrderID INT;
DECLARE @OrderDate DATE;
DECLARE @Status NVARCHAR(50);

DECLARE OrderCursor CURSOR FOR
SELECT [OrderID], [OrderDate], [Status]
FROM [Bookstore].[dbo].[Orders]
WHERE [Status] = 'Pending';

OPEN OrderCursor;

FETCH NEXT FROM OrderCursor INTO @OrderID, @OrderDate, @Status;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF DATEDIFF(DAY, @OrderDate, GETDATE()) > 30
    BEGIN
        
        UPDATE [Bookstore].[dbo].[Orders]
        SET [Status] = 'Expirada'
        WHERE [OrderID] = @OrderID;
    END

    FETCH NEXT FROM OrderCursor INTO @OrderID, @OrderDate, @Status;
END

CLOSE OrderCursor;
DEALLOCATE OrderCursor;


