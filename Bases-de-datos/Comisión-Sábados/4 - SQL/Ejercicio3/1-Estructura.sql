/*
Dada la siguiente base de datos:
Producto (idProducto, nombre, descrip, estado, idProveedor )
--Proveedor (idProveedor, nombre, respdCivil, cuit)
--Dirección ( idDir, idPers, calle, nro, piso, dpto )
--Cliente (idCliente, nombre, respIVA, CUIL)
--Vendedor (idEmpleado, nombre, apellido, DNI)
Venta (nroFactura, idCliente, fecha, idVendedor )
Detalle_venta(nroFactura,nro,idProducto, cantidad,
precioUnitario)
NOTA: El precio unitario es necesario para almacenar los valores al momento de la venta*/USE MASTER
 
CREATE DATABASE EJERCICIO_3
go

USE EJERCICIO_3 CREATE TABLE Vendedor
(
idEmpleado INT IDENTITY(1,1) not null,
nombre  VARCHAR(20), 
apellido VARCHAR(20),
DNI  int,
CONSTRAINT PK_Vendedor PRIMARY KEY (idEmpleado)
)



CREATE TABLE Cliente
(
idCliente INT IDENTITY(1,1) not null,
nombre  VARCHAR(20), 
respIVA VARCHAR(50),
CUIL  VARCHAR(20),
CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
)


CREATE TABLE Proveedor
(
idProveedor INT IDENTITY(1,1) not null,
nombre  VARCHAR(20), 
respdCivil VARCHAR(50),
cuit  VARCHAR(20),
CONSTRAINT PK_Proveedor PRIMARY KEY (idProveedor)
)

 
 
CREATE TABLE Producto
(
idProducto INT IDENTITY(1,1) not null,
nombre  VARCHAR(50), 
descrip VARCHAR(50),
estado  VARCHAR(20),
idProveedor  INT,
CONSTRAINT PK_Producto PRIMARY KEY (idProducto),
CONSTRAINT FK_ProductoProveedor FOREIGN KEY (idProveedor)     REFERENCES Proveedor(idProveedor)
)

 
 CREATE TABLE Direccion
(
idDir INT IDENTITY(1,1) not null,
idPers  INT, 
calle VARCHAR(20),
nro  int,
piso  INT,
dpto varchar(2),
CONSTRAINT PK_Direccion PRIMARY KEY (idDir),
CONSTRAINT FK_DireccionCliente FOREIGN KEY (idPers)     REFERENCES Cliente(idCliente)

)


 
 CREATE TABLE Venta
(
nroFactura INT IDENTITY(1,1) not null,
idCliente  INT, 
fecha datetime,
idVendedor  int,
 
CONSTRAINT PK_Venta PRIMARY KEY (nroFactura),
CONSTRAINT FK_VentaCliente FOREIGN KEY (idCliente)     REFERENCES Cliente(idCliente),
CONSTRAINT FK_VentaVendedor FOREIGN KEY (idVendedor)     REFERENCES Vendedor(idEmpleado)

)

 CREATE TABLE Detalle_venta
(
nro INT   not null,
nroFactura INT  not null,
idProducto  INT, 
cantidad int,
precioUnitario decimal(18,2),
 
CONSTRAINT PK_Detalle_venta PRIMARY KEY (nro,nroFactura),
CONSTRAINT FK_Detalle_ventaVenta FOREIGN KEY (nroFactura)     REFERENCES Venta(nroFactura),
CONSTRAINT FK_Detalle_ventaProducto FOREIGN KEY (idProducto)     REFERENCES Producto(idProducto)

)
 