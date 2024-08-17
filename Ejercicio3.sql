--Crear un stored procedure que verifique el monto total de un pedido. 
--Si el monto total excede los $400 hay que aplicar un 15% de descuento 
--y en caso contrario aplicar un 5% de descuento.

CREATE PROCEDURE dbo.spDescuentos
	@PedidoID INT
AS
BEGIN
	DECLARE @MontoTotal DECIMAL(10, 2);
	DECLARE @Descuento DECIMAL(10, 2);
    DECLARE @MontoFinal DECIMAL(10, 2);

	SELECT @MontoTotal = SUM(od.Quantity * od.UnitPrice)
	FROM OrderDetails od
	JOIN Orders o ON od.OrderID = o.OrderID
	WHERE o.OrderID = @PedidoID;

	IF @MontoTotal > 400
	BEGIN
		SET @Descuento = @MontoTotal * 0.15;
	END
	ELSE
	BEGIN
		SET @Descuento = @MontoTotal * 0.05;
	END
	
    SET @MontoFinal = @MontoTotal - @Descuento;

	UPDATE Orders
	SET TotalAmount = @MontoFinal
	WHERE OrderID = @PedidoID;

END
GO

EXEC dbo.spDescuentos @PedidoID = 1;


