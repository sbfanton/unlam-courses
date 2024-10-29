create database EJERCICIO_1;

use EJERCICIO_1;

-- Creacion de tablas

create table Almacen(
	Nro int primary key,
	Responsable varchar(50)
);

create table Articulo(
	CodArt int primary key,
	Descripcion varchar(50),
	Precio float
);

create table Material(
	CodMat int primary key,
	Descripcion varchar(50)
);

create table Proveedor(
	CodProv int primary key,
	Nombre varchar(50),
	Domicilio varchar(50),
	Ciudad varchar(50)
);

create table Tiene(
	Nro int, 
	CodArt int,
	primary key (Nro, CodArt)
);

alter table Tiene 
add constraint fk_Tiene_Nro 
foreign key (Nro) 
references Almacen (Nro);

alter table Tiene 
add constraint fk_Tiene_CodArt
foreign key (CodArt) 
references Articulo (CodArt);

create table Compuesto_por(
	CodArt int, 
	CodMat int,
	primary key (CodArt, CodMat)
);

alter table Compuesto_por 
add constraint fk_Compuesto_por_CodArt
foreign key (CodArt) 
references Articulo (CodArt);

alter table Compuesto_por 
add constraint fk_Compuesto_por_CodMat
foreign key (CodMat) 
references Material (CodMat);

create table Provisto_por(
	CodMat int, 
	CodProv int,
	primary key (CodMat, CodProv)
);

alter table Provisto_por 
add constraint fk_Provisto_por_CodMat
foreign key (CodMat) 
references Material (CodMat);

alter table Provisto_por 
add constraint fk_Provisto_por_CodProv
foreign key (CodProv) 
references Proveedor (CodProv);

-- Insercion de datos (provistos en ejercitacion)

insert into Almacen values
(1, 'Juan Perez'),
(2, 'Jose Basualdo'),
(3, 'Rogelio Rodriguez')
insert into Articulo values
(1, 'Sandwich JyQ', 5),
(2, 'Pancho', 6),
(3, 'Hamburguesa', 10),
(4, 'Hamburguesa completa', 15)
insert into Material values
(1, 'Pan'),
(2, 'Jamon'),
(3, 'Queso'),
(4, 'Salchicha'),
(5, 'Pan Pancho'),
(6, 'Paty'),
(7, 'Lechuga'),
(8, 'Tomate')
insert into Proveedor values
(1, 'Panadería Carlitos', 'Carlos Calvo 1212', 'CABA'),
(2, 'Fiambres Perez', 'San Martin 121', 'Pergamino'),
(3, 'Almacen San Pedrito', 'San Pedrito 1244', 'CABA'),
(4, 'Carnicería Boedo', 'Av. Boedo 3232', 'CABA'),
(5, 'Verdulería Platense', '5 3232', 'La Plata')
insert into Tiene values
--Juan Perez
(1, 1),
--Jose Basualdo
(2, 1),
(2, 2),
(2, 3),
(2, 4),
--Rogelio Rodriguez
(3, 3),
(3, 4)
insert into Compuesto_Por values
--Sandwich JyQ
(1, 1), (1, 2), (1, 3),
--Pancho
(2, 4), (2, 5),
--Hamburguesa
(3, 1), (3, 6),
--Hamburguesa completa
(4, 1), (4, 6), (4, 7), (4, 8)
insert into Provisto_Por values
--Pan
(1, 1), (1, 3),
--Jamon
(2, 2), (2, 3), (2, 4),
--Queso
(3, 2), (3, 3),
--Salchicha
(4, 3), (4, 4),
--Pan Pancho
(5, 1), (5, 3),
--Paty
(6, 3), (6, 4),
--Lechuga
(7, 3), (7, 5),
--Tomate
(8, 3), (8, 5)