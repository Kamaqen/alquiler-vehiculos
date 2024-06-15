USE master;
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DBALQUILERES')
BEGIN
    CREATE DATABASE DBALQUILERES;
    PRINT 'Base de datos DBALQUILERES creada exitosamente.';
END
ELSE
BEGIN
    PRINT 'La base de datos DBALQUILERES ya existe.';
END
GO

USE DBALQUILERES;
GO

CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    FechaRegistro DATE NOT NULL
);
GO

CREATE TABLE Vehiculos (
    VehiculoID INT PRIMARY KEY,
    Marca NVARCHAR(100) NOT NULL,
    Modelo NVARCHAR(100) NOT NULL,
    Anio INT NOT NULL,
    PrecioDia DECIMAL(18, 2) NOT NULL
);
GO

CREATE TABLE Alquileres (
    AlquilerID INT PRIMARY KEY,
    ClienteID INT NOT NULL,
    VehiculoID INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    Total DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (VehiculoID) REFERENCES Vehiculos(VehiculoID)
);
GO

-- CONSULTAS

--Seleccionar todos los registros de la tabla de Clientes:
SELECT * FROM Clientes;

--Seleccionar todos los registros de la tabla de Vehículos:
SELECT * FROM Vehiculos;

--Seleccionar todos los registros de la tabla de Alquileres:
SELECT * FROM Alquileres;

--Mostrar el total de alquileres por cada cliente:
SELECT
    C.Nombre,
    C.Apellido,
    SUM(A.Total) AS VolumenTotal
FROM
    Clientes C
JOIN
    Alquileres A ON C.ClienteID = A.ClienteID
GROUP BY
    C.Nombre,
    C.Apellido
ORDER BY
    VolumenTotal DESC

--Mostrar los 10 vehículos más alquilados:
SELECT TOP 10
    V.Modelo,
    V.Marca,
    COUNT(A.AlquilerID) AS NumeroAlquileres
FROM
    Vehiculos V
JOIN
    Alquileres A ON V.VehiculoID = A.VehiculoID
GROUP BY
    V.Modelo,
    V.Marca
ORDER BY
    NumeroAlquileres DESC
    