CREATE FUNCTION dbo.MesesSinAlquiler(@FechaFin NVARCHAR(10))
RETURNS INT
AS 
BEGIN 
    DECLARE @Today DATE = CAST(GETDATE() AS DATE);
    DECLARE @ParsedFechaFin DATE;
    DECLARE @MonthsDifference INT;

    -- Convertir la fecha de fin del formato japonés a DATE
    SET @ParsedFechaFin = CONVERT(DATE, @FechaFin, 111);

    IF @ParsedFechaFin IS NULL
    BEGIN
        -- Devuelve -1 si la fecha de fin es NULL
        RETURN -1;
    END

    SET @MonthsDifference = DATEDIFF(MONTH, @ParsedFechaFin, @Today);

    RETURN @MonthsDifference;
END;
GO

