--Mostrar los Clientes que Han Gastado Más de un Monto Específico en Alquileres:
CREATE FUNCTION dbo.ClientesQueGastaronMasQue(@Monto DECIMAL(18, 2))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        c.Nombre,
        c.Apellido,
        SUM(a.Total) AS MontoTotalGastado
    FROM 
        Clientes c
    INNER JOIN 
        Alquileres a ON c.ClienteID = a.ClienteID
    GROUP BY 
        c.Nombre,
        c.Apellido
    HAVING 
        SUM(a.Total) > @Monto
);
GO

