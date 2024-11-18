CREATE DATABASE EJ7;
GO
USE EJ7;
GO

/* MR
Auto (matrícula (PK), modelo, año) 
Chofer(nroLicencia(PK), nombre, apellido, fecha_ingreso, teléfono)
Viaje(FechaHoraInicio(PK), FechaHoraFin, chofer(PKFK), cliente(FK), auto(FK),
      kmTotales, esperaTotal, costoEspera, costoKms )
Cliente (nroCliente(PK), calle, nro, localidad )
*/
-- drop table coche
CREATE TABLE coche
(
	patente VARCHAR(7),
	modelo varchar(50),
	anio int, 
	PRIMARY KEY (patente)
)
GO

--DROP TABLE chofer
CREATE TABLE chofer
(
	nroLicencia INT PRIMARY KEY, 
	nombre VARCHAR(50), 
	apellido VARCHAR(50), 
	fecha_ingreso SMALLDATETIME, 
	telefono VARCHAR(12)
)
GO

--DROP TABLE cliente 
CREATE TABLE cliente 
(
	nroCliente INT PRIMARY KEY, 
	nombre varchar(50),
	apellido varchar (50),
	calle VARCHAR(50) NOT NULL, 
	nro INT NOT NULL, 
	localidad VARCHAR(50) NOT NULL
)
GO


--DROP TABLE viaje
CREATE TABLE viaje
(
	FechaHoraInicio SMALLDATETIME, 
	FechaHoraFin SMALLDATETIME, 
	chofer INT, 
	cliente INT, 
	coche VARCHAR(7),
	kmTotales INT, 
	esperaTotal INT, 
	costoEspera MONEY, 
	costoKms MONEY,
	PRIMARY KEY (FechaHoraInicio, chofer),
	FOREIGN KEY (chofer) REFERENCES chofer(nroLicencia),
	FOREIGN KEY (cliente) REFERENCES cliente(nroCliente),
	FOREIGN KEY (coche) REFERENCES coche(patente)
)
GO
