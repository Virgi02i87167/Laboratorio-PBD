--Crear un trigger que se encargue de llevar el control de los cambios de precios de los libros. 
--Cada cambio debe verse reflejado en la tabla BooksLogPrices

CREATE TRIGGER trg_ControlLibros
ON Books
AFTER UPDATE
AS
BEGIN

    INSERT INTO BooksLogPrices(BookID, OldPrice, NewPrice, OldStockQuantity, NewStockQuantity, ChangeDate)
    SELECT 
        inserted.BookID, 
        deleted.Price AS OldPrice, 
        inserted.Price AS NewPrice,
        deleted.StockQuantity AS OldStockQuantity,
        inserted.StockQuantity AS NewStockQuantity,
        GETDATE() AS ChangeDate
    FROM 
        inserted
    JOIN 
        deleted ON inserted.BookID = deleted.BookID
    WHERE 
        inserted.Price <> deleted.Price OR inserted.StockQuantity <> deleted.StockQuantity;
END;