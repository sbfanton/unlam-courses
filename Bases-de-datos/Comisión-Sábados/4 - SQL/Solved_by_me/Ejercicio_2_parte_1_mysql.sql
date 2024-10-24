-- Ejercicio 2

CREATE DATABASE EJERCICIO_2;

USE EJERCICIO_2;

-- Creacion de tablas
/*
Proveedor (NroProv, NomProv, Categoria, CiudadProv)
Art�culo  (NroArt, Descripci�n, CiudadArt, Precio)
Cliente   (NroCli, NomCli, CiudadCli)
Pedido    (NroPed, NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal)
Stock     (NroArt, fecha, cantidad)

*/

CREATE TABLE Proveedor(
	NroProv INT AUTO_INCREMENT PRIMARY KEY,
	NomProv VARCHAR(20) NOT NULL,
	Categoria VARCHAR(20) NOT NULL,
	CiudadProv VARCHAR(20) NOT NULL
);

CREATE TABLE Articulo(
	NroArt INT AUTO_INCREMENT PRIMARY KEY,
	Descripcion VARCHAR(50) NOT NULL,
	CiudadArt VARCHAR(20) NOT NULL,
	Precio DECIMAL(9, 2) NOT NULL
);

CREATE TABLE Cliente(
	NroCli INT AUTO_INCREMENT PRIMARY KEY,
	NomCli VARCHAR(20) NOT NULL,
	CiudadCli VARCHAR(20) NOT NULL
);

CREATE TABLE Pedido(
	NroPedido INT AUTO_INCREMENT PRIMARY KEY,
	NroArt INT NOT NULL,
	NroCli INT NOT NULL,
	NroProv INT NOT NULL,
	FechaPedido DATETIME NOT NULL,
	Cantidad INT NOT NULL,
	PrecioTotal DECIMAL(9, 2) NOT NULL
);

ALTER TABLE Pedido 
ADD CONSTRAINT FK_Pedido_Art 
FOREIGN KEY (NroArt) 
REFERENCES Articulo(NroArt);

ALTER TABLE Pedido 
ADD CONSTRAINT FK_Pedido_Cli 
FOREIGN KEY (NroCli) 
REFERENCES Cliente(NroCli);

ALTER TABLE Pedido 
ADD CONSTRAINT FK_Pedido_Prov 
FOREIGN KEY (NroProv) 
REFERENCES Proveedor(NroProv);

CREATE TABLE Stock(
	NroArt INT,
	Fecha DATETIME NOT NULL,
	Cantidad INT NOT NULL,
	PRIMARY KEY (NroArt, Fecha)
);

ALTER TABLE Stock 
ADD CONSTRAINT FK_Stock_Art 
FOREIGN KEY (NroArt) 
REFERENCES Articulo(NroArt);

-- Insercion de datos

INSERT INTO EJERCICIO_2.Proveedor (NomProv, Categoria, CiudadProv)
		VALUES ("Prov1","Cat1", "San Justo");
INSERT INTO EJERCICIO_2.Proveedor (NomProv, Categoria, CiudadProv) VALUES ("Prov2","Cat2", "San justo");
INSERT INTO EJERCICIO_2.Proveedor (NomProv, Categoria, CiudadProv) VALUES ("Prov3","Cat3", "Laferrere");
INSERT INTO EJERCICIO_2.Proveedor (NomProv, Categoria, CiudadProv) VALUES ("Prov4","Cat4", "Isidro Casanova");
INSERT INTO EJERCICIO_2.Proveedor (NomProv, Categoria, CiudadProv) VALUES ("Prov5","Cat5", "Gonzalez Catan");
INSERT INTO EJERCICIO_2.Proveedor (NomProv, Categoria, CiudadProv) VALUES ("Prov6","Cat6", "Ramos Mejia");

INSERT INTO EJERCICIO_2.Articulo (Descripcion, CiudadArt, Precio) VALUES ("Art1","San Justo", 50.20); 
INSERT INTO EJERCICIO_2.Articulo (Descripcion, CiudadArt, Precio) VALUES ("Art2","Laferrere", 5000.520);
INSERT INTO EJERCICIO_2.Articulo (Descripcion, CiudadArt, Precio) VALUES ("Art3","Gonzalez Catan", 80010);
INSERT INTO EJERCICIO_2.Articulo (Descripcion, CiudadArt, Precio) VALUES ("Art4","Ramos Mejia", 74120);
INSERT INTO EJERCICIO_2.Articulo (Descripcion, CiudadArt, Precio) VALUES ("Art5","Ramos Mejia", 602.30);
INSERT INTO EJERCICIO_2.Articulo (Descripcion, CiudadArt, Precio) VALUES ("Art6","Ramos Mejia", 9.201);
INSERT INTO EJERCICIO_2.Articulo (Descripcion, CiudadArt, Precio) VALUES ("Art7","Laferrere", 85440.2440);


INSERT INTO EJERCICIO_2.Cliente (NomCli, CiudadCli) VALUES ("Cli1","Laferrere");
INSERT INTO EJERCICIO_2.Cliente (NomCli, CiudadCli) VALUES ("Cli2","Laferrere");
INSERT INTO EJERCICIO_2.Cliente (NomCli, CiudadCli) VALUES ("Cli3","San Justo");
INSERT INTO EJERCICIO_2.Cliente (NomCli, CiudadCli) VALUES ("Cli4","Ramos Mejia");
INSERT INTO EJERCICIO_2.Cliente (NomCli, CiudadCli) VALUES ("Cli5","Gonzalez Catan");
INSERT INTO EJERCICIO_2.Cliente (NomCli, CiudadCli) VALUES ("Cli6","San Justo");
INSERT INTO EJERCICIO_2.Cliente (NomCli, CiudadCli) VALUES ("Cli7","Ramos Mejia");


INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,1,1,NOW(),5,209000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,1,2,NOW(),99,29000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,1,3,NOW(),524,9000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,2,1,NOW(),55,29000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,3,1,NOW(),966,4000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,4,2,NOW(),447,444000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (2,1,1,NOW(),254,2800);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (2,2,1,NOW(),9968,39000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (2,1,2,NOW(),249,449000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (3,1,1,NOW(),887,49000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (3,4,1,NOW(),998,200);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (2,4,1,NOW(),754,9000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (3,3,4,NOW(),1320,400);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (4,1,1,NOW(),8,24000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (4,2,1,NOW(),7769,19000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (4,3,1,NOW(),785,5000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (4,3,2,NOW(),998,19000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (5,1,1,NOW(),587,88000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (5,1,4,NOW(),999,9000);
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (5,5,5,NOW(),20,9000);


INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (1, "20200101",1254);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (1, "20200201",300);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (1, "20200301",8800);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (2, "20200101",6700);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (2, "20200201",9700);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (2, "20200301",7800);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (3, "20190101",9870);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (3, "20200101",25400);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (3, "20180101",9900);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (4, "20200101",870);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (4, "20190101",55600);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (4, "20180101",9900);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (5, "20200101",166000);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (5, "20200102",64450);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (5, "20200103",54660);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (5, "20200104",70);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (6, "20200101",100);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (6, "20200202",5500);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (6, "20200303",700);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (6, "20200304",1700);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (7, "20200101",500);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (7, "20200303",44000);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (7, "20200304",400);

INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (1, "20150101",140);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (2, "20160101",104);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (3, "20170101",140);
INSERT INTO EJERCICIO_2.Stock(NroArt, fecha, cantidad) VALUES (4, "20180106",10300);

-- Para adaptar a los ejercicios

use EJERCICIO_2

-- 1
update EJERCICIO_2.Articulo set Descripcion="a146" where NroArt=1;

-- 2
UPDATE EJERCICIO_2.Proveedor SET NomProv="p015" where NroProv=1;


-- 3
update EJERCICIO_2.Proveedor set Categoria=null;

alter table EJERCICIO_2.Proveedor
modify Categoria int;


-- 4
update EJERCICIO_2.Articulo set  CiudadArt="Mendoza" where NroArt=1;
UPDATE EJERCICIO_2.Cliente SET CiudadCli="Rosario" WHERE NroCli=1;



-- 5
UPDATE EJERCICIO_2.Cliente SET NomCli ="c23" WHERE NroCli=1;
UPDATE EJERCICIO_2.Cliente SET NomCli ="c30" WHERE NroCli=2;


-- 6
update EJERCICIO_2.Articulo set CiudadArt="La Plata" where  NroArt in(5,6);


/*
SELECT *
FROM EJERCICIO_2.Articulo
*/

-- 7

UPDATE EJERCICIO_2.Cliente SET CiudadCli="Junin" WHERE NroCli=3;
UPDATE EJERCICIO_2.Cliente SET CiudadCli="Junin" WHERE NroCli=4;


-- 8
update EJERCICIO_2.Articulo set Descripcion="cuaderno" where NroArt=2;



-- 9

update EJERCICIO_2.Articulo set Descripcion="A001" where NroArt=5;
update EJERCICIO_2.Articulo set Descripcion="A004" where NroArt=6;
update EJERCICIO_2.Articulo set Descripcion="A100" where NroArt=7;


INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (7,1,4,NOW(),900,9000);

-- SELECT *
-- FROM EJERCICIO_2.Articulo
-- WHERE Descripcion BETWEEN  "A001" AND "A100"


-- 10
UPDATE EJERCICIO_2.Pedido SET  FechaPedido="2004-01-01"      WHERE NroPedido=5;
UPDATE EJERCICIO_2.Pedido SET  FechaPedido="2004-02-01"      WHERE NroPedido=6;
UPDATE EJERCICIO_2.Pedido SET  FechaPedido="2004-03-31"      WHERE NroPedido=7;


-- 11 
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,3,1,"2004-02-06",500,8700);

-- 12

INSERT INTO Stock (NroArt, FECHA, CANTIDAD) VALUES(1, "2023-10-21", 2000);
-- 13

-- 14
INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,1,6,date_add(NOW(), INTERVAL -1 YEAR),5,209000);

INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,1,6,date_add(NOW(), INTERVAL -1 YEAR),5,209000);

INSERT INTO EJERCICIO_2.Pedido ( NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES (1,1,6,date_add(NOW(), INTERVAL -1 YEAR),5,209000);




-- 15

UPDATE EJERCICIO_2.Proveedor SET CiudadProv="Capital Federal" WHERE NroProv IN(4,5,6);

 -- ej 8. actualizo una categroria
UPDATE Proveedor
set
Categoria = 5
where NroProv = 5;

 
