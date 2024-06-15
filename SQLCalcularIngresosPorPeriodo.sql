CREATE FUNCTION dbo.CalcularIngresosPorPeriodo(@FechaInicio DATE, @FechaFin DATE)
RETURNS DECIMAL
AS
BEGIN
    DECLARE @Total DECIMAL(18, 2);

    SELECT @Total = SUM(Total)
    FROM Alquileres
    WHERE FechaInicio >= @FechaInicio AND FechaFin <= @FechaFin

    RETURN @Total
END;