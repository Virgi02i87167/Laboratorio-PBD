--Crear un stored procedure que se encargue de mostrar toda la informaci�n 
--relacionada con los detalles de compra. La informaci�n a mostrar es la 
--siguiente: nombre del cliente, email del cliente, fecha de la compra, 
--t�tulo del libro, autor del libro, cantidad ordenada, precio unitario, 
--precio total por libro y precio total de toda la orden.

create procedure dbo.spMostrarInformacion
as
begin
	select 
		c.FirstName, 
		c.Email, 
		o.OrderDate, 
		b.Title, 
		b.Author, 
		od.Quantity, 
		od.UnitPrice, 
		b.Price, 
		sum(od.UnitPrice * od.Quantity) as 'Precio total'
	from Customers c
	inner Join Orders o
	on c.CustomerID = o.CustomerID
	inner join OrderDetails od
	on o.OrderID = od.OrderID
	inner join Books b
	on b.BookID = od.BookID

	GROUP BY 
        c.FirstName, 
        c.Email, 
        o.OrderDate, 
        b.Title, 
        b.Author, 
        od.Quantity, 
        od.UnitPrice, 
        b.Price;
end

exec dbo.spMostrarInformacion