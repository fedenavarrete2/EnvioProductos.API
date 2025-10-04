-- Script de creación de base de datos para Sistema de Envío de Productos
-- Base de datos: EnvioProductosDB

USE master;
GO

-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'EnvioProductosDB')
BEGIN
    CREATE DATABASE EnvioProductosDB;
END
GO

USE EnvioProductosDB;
GO

-- Tabla: TipoProductos
CREATE TABLE TipoProductos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    EsActivo BIT NOT NULL DEFAULT 1
);

-- Tabla: Productos
CREATE TABLE Productos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(200) NOT NULL,
    Precio DECIMAL(18,2) NOT NULL,
    Peso DECIMAL(10,2) NOT NULL,
    TipoProductoId INT NOT NULL,
    EsActivo BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (TipoProductoId) REFERENCES TipoProductos(Id)
);

-- Tabla: Transportistas
CREATE TABLE Transportistas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(200) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Telefono NVARCHAR(20),
    EsActivo BIT NOT NULL DEFAULT 1
);

-- Tabla: Envios
CREATE TABLE Envios (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FechaEnvio DATETIME NOT NULL,
    DireccionDestino NVARCHAR(500) NOT NULL,
    Estado NVARCHAR(50) NOT NULL, -- Pendiente, EnTransito, Entregado, Cancelado
    TransportistaId INT NOT NULL,
    CostoTotal DECIMAL(18,2) NOT NULL,
    EsActivo BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (TransportistaId) REFERENCES Transportistas(Id)
);

-- Tabla: DetalleEnvios (Relación muchos a muchos entre Envios y Productos)
CREATE TABLE DetalleEnvios (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    EnvioId INT NOT NULL,
    ProductoId INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (EnvioId) REFERENCES Envios(Id),
    FOREIGN KEY (ProductoId) REFERENCES Productos(Id)
);

-- Insertar datos de ejemplo para TipoProductos
INSERT INTO TipoProductos (Nombre, EsActivo) VALUES 
('Electrónicos', 1),
('Ropa', 1),
('Hogar', 1),
('Libros', 1),
('Deportes', 1);

-- Insertar datos de ejemplo para Productos
INSERT INTO Productos (Nombre, Precio, Peso, TipoProductoId, EsActivo) VALUES 
('Laptop HP', 899.99, 2.5, 1, 1),
('Mouse Inalámbrico', 25.50, 0.2, 1, 1),
('Camiseta Algodón', 19.99, 0.3, 2, 1),
('Pantalón Jeans', 49.99, 0.8, 2, 1),
('Lámpara LED', 35.00, 1.2, 3, 1),
('Libro Programación', 45.00, 0.5, 4, 1),
('Pelota Fútbol', 29.99, 0.4, 5, 1);

-- Insertar datos de ejemplo para Transportistas
INSERT INTO Transportistas (Nombre, Email, Telefono, EsActivo) VALUES 
('TransExpress SA', 'contacto@transexpress.com', '+54-11-4567-8901', 1),
('LogiRápido', 'info@logirapido.com', '+54-11-2345-6789', 1),
('EnvíoSeguro', 'ventas@envioseguro.com', '+54-11-8765-4321', 1);

-- Insertar datos de ejemplo para Envios
INSERT INTO Envios (FechaEnvio, DireccionDestino, Estado, TransportistaId, CostoTotal, EsActivo) VALUES 
('2024-01-15 10:30:00', 'Av. Corrientes 1234, CABA', 'Entregado', 1, 950.48, 1),
('2024-01-16 14:45:00', 'San Martín 567, Rosario', 'EnTransito', 2, 75.49, 1),
('2024-01-17 09:15:00', 'Mitre 890, Córdoba', 'Pendiente', 3, 84.99, 1);

-- Insertar datos de ejemplo para DetalleEnvios
INSERT INTO DetalleEnvios (EnvioId, ProductoId, Cantidad, PrecioUnitario) VALUES 
-- Envío 1
(1, 1, 1, 899.99),  -- 1 Laptop
(1, 2, 2, 25.50),   -- 2 Mouse

-- Envío 2
(2, 3, 1, 19.99),   -- 1 Camiseta
(2, 4, 1, 49.99),   -- 1 Pantalón
(2, 6, 1, 45.00),   -- 1 Libro

-- Envío 3
(3, 5, 1, 35.00),   -- 1 Lámpara
(3, 7, 1, 29.99);   -- 1 Pelota

GO

-- Crear índices para mejorar el rendimiento
CREATE INDEX IX_Productos_TipoProductoId ON Productos(TipoProductoId);
CREATE INDEX IX_Envios_TransportistaId ON Envios(TransportistaId);
CREATE INDEX IX_Envios_FechaEnvio ON Envios(FechaEnvio);
CREATE INDEX IX_DetalleEnvios_EnvioId ON DetalleEnvios(EnvioId);
CREATE INDEX IX_DetalleEnvios_ProductoId ON DetalleEnvios(ProductoId);

GO

PRINT 'Base de datos EnvioProductosDB creada exitosamente con datos de ejemplo.';