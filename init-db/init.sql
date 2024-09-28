
CREATE DATABASE uspg_pos
GO

USE uspg_pos
GO

CREATE TABLE marcas (
    id BIGINT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE clasificaciones (
    id BIGINT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE clientes (
    id BIGINT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(255) NOT NULL,
    nit NVARCHAR(50) NOT NULL,
    correo NVARCHAR(255)
)
GO

CREATE TABLE sucursales (
    id BIGINT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(255) NOT NULL,
    area NVARCHAR(255),
    ciudad NVARCHAR(255)
)
GO

CREATE TABLE usuarios (
    id BIGINT PRIMARY KEY IDENTITY,
    usuario NVARCHAR(255) NOT NULL UNIQUE,
    nombre NVARCHAR(255) NOT NULL,
    password NVARCHAR(255) NOT NULL,
    rol NVARCHAR(50) CHECK (rol IN ('Admin', 'Vendedor')) NOT NULL
)
GO

CREATE TABLE usuario_sucursal (
    id BIGINT PRIMARY KEY IDENTITY,
    usuario_id BIGINT FOREIGN KEY REFERENCES usuarios(id),
    sucursal_id BIGINT FOREIGN KEY REFERENCES sucursales(id),
    UNIQUE (usuario_id, sucursal_id)
)
GO

CREATE TABLE productos (
    id BIGINT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(255) NOT NULL,
    marca_id BIGINT FOREIGN KEY REFERENCES marcas(id),
    clasificacion_id BIGINT FOREIGN KEY REFERENCES clasificaciones(id),
    precio DECIMAL(10, 2) NOT NULL,
    cantidad INT NOT NULL
)
GO

CREATE TABLE ventas (
    id BIGINT PRIMARY KEY IDENTITY,
    fecha DATETIME NOT NULL DEFAULT GETDATE(),
    total DECIMAL(10, 2) NOT NULL,
    cliente_id BIGINT FOREIGN KEY REFERENCES clientes(id),
    sucursal_id BIGINT FOREIGN KEY REFERENCES sucursales(id)
)
GO

CREATE TABLE detalles_venta (
    id BIGINT PRIMARY KEY IDENTITY,
    venta_id BIGINT FOREIGN KEY REFERENCES ventas(id),
    producto_id BIGINT FOREIGN KEY REFERENCES productos(id),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
)
GO

INSERT INTO marcas (nombre) VALUES
('Sony'), ('Logitech'), ('TP-Link'), ('Belkin'), ('Anker')
GO

INSERT INTO clasificaciones (nombre) VALUES
('Audífonos'), ('Teclados'), ('Routers'), ('Repetidores'), ('Cables')
GO

INSERT INTO clientes (nombre, nit, correo) VALUES
('Juan Pérez', '123456-7', 'juan.perez@example.com'),
('María López', '234567-8', 'maria.lopez@example.com'),
('Carlos García', '345678-9', 'carlos.garcia@example.com')
GO

INSERT INTO sucursales (nombre, area, ciudad) VALUES
('Sucursal Centro', 'Centro', 'Ciudad de Guatemala'),
('Sucursal Norte', 'Norte', 'Quetzaltenango'),
('Sucursal Sur', 'Sur', 'Antigua Guatemala')
GO

INSERT INTO usuarios (usuario, nombre, password, rol) VALUES
('maria_gonzalez', 'María González', 'MariaPass@123', 'Admin'),
('juan_hernandez', 'Juan Hernández', 'JuanPass@123', 'Vendedor'),
('ana_fernandez', 'Ana Fernández', 'AnaPass@123', 'Vendedor')
GO
