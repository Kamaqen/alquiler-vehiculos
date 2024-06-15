-- Mostrar el total de ingresos generados por los alquileres en un período de tiempo específico (en un rango de fechas)
CREATE FUNCTION dbo.CalcularIngresosPorPeriodo(@StringInicio DATE, @StringFin DATE)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(18, 2);
    DECLARE @FechaInicio DATE = CONVERT ( DATE , @StringInicio,111 )
    DECLARE @FechaFin DATE = CONVERT ( DATE , @StringFin,111 )

    -- Inicializar @Total a 0
    SET @Total = 0.00;

    -- Verificar si hay registros en el rango de fechas especificado
    IF EXISTS (
        SELECT 1
        FROM Alquileres
        WHERE FechaInicio >= @FechaInicio AND FechaFin <= @FechaFin
    )
    BEGIN
        -- Si hay registros, calcular el total de ingresos
        SELECT @Total = SUM(Total)
        FROM Alquileres
        WHERE FechaInicio >= @FechaInicio AND FechaFin <= @FechaFin;
    END

    RETURN @Total;
END;
GO
