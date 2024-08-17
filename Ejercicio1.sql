--Hacer una consulta mostrando el monto total gastado por cada cliente y a su vez mostrar según la cantidad gastada lo siguiente: 
--Regular para montos menores a $100 dólares, Cliente Frecuente para montos totales entre $100 y $500 dólares y Cliente Premium para
--montos mayores $500. Debe mostrar el Id del cliente, el nombre completo, el total gastado y el tipo de cliente.

create procedure dbo.spTotalGastadoPorCliente
as
begin
	SELECT 
    o.CustomerID AS cliente_id,
    c.FirstName AS cliente_nombre,
    SUM(od.Quantity * od.UnitPrice) AS total_gastado,
    CASE
		WHEN SUM(od.Quantity * od.UnitPrice) <100
			THEN'Regular' 
		WHEN SUM(od.Quantity * od.UnitPrice) BETWEEN 100 AND 500
			THEN'Cliente Frecuente' 
			WHEN SUM(od.Quantity * od.UnitPrice) >500
				THEN'Cliente Premium' 
		END AS tipo_cliente
	FROM 
		OrderDetails od
	JOIN 
		Orders o ON od.OrderID = o.OrderID
	JOIN 
		Customers c ON o.CustomerID = c.CustomerID
	GROUP BY 
		o.CustomerID,
		c.FirstName;
end
go

exec dbo.spTotalGastadoPorCliente