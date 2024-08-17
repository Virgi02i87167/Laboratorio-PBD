--Crear un stored procedure que se encargue de calcular al acumulado de las ventas por cada cliente de la tabla de ordenes, el stored procedure debe iterar
--por cada cliente para calcular el total acumulado y luego actualizar la columna CumulativeSales
CREATE PROCEDURE CalculateCumulativeSales
AS
BEGIN
    DECLARE @CustomerID INT;
    DECLARE @CumulativeTotal DECIMAL(18, 2);
    
    DECLARE customer_cursor CURSOR FOR
    SELECT CustomerID FROM Customers;
    
    OPEN customer_cursor;
    
    FETCH NEXT FROM customer_cursor INTO @CustomerID;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @CumulativeTotal = SUM(TotalAmount)
        FROM Orders
        WHERE CustomerID = @CustomerID
          AND Status = 'Completed'; 
        
        IF @CumulativeTotal IS NULL
        BEGIN
            SET @CumulativeTotal = 0;
        END

        UPDATE Customers
        SET CumulativeSales = @CumulativeTotal
        WHERE CustomerID = @CustomerID;

        FETCH NEXT FROM customer_cursor INTO @CustomerID;
    END;
    
    CLOSE customer_cursor;
    DEALLOCATE customer_cursor;
END;

EXEC CalculateCumulativeSales;