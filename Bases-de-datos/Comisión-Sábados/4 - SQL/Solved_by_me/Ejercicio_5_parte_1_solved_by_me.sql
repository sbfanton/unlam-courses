use EJERCICIO_5

create table Rubro(
	CodRubro int identity(1, 1) not null,
	NomRubro varchar(50) not null,
	constraint pk_rubro primary key (CodRubro)
)

create table Pelicula(
	CodPel bigint identity(1, 1) not null,
	Titulo varchar(50) not null,
	Duracion int not null,
	Anio int not null,
	CodRubro int not null,
	constraint pk_pelicula primary key (CodPel),
	constraint fk_pelicula foreign key (CodRubro) references Rubro(CodRubro)
)

create table Ejemplar(
	CodEj int not null,
	CodPel bigint not null,
	Estado varchar(20) not null,
	Ubicacion varchar(50) not null,
	constraint pk_ejemplar primary key (CodPel, CodEj),
	constraint fk_ejemplar foreign key (CodPel)  references Pelicula(CodPel),
	constraint ck_estado_ejemplar check (Estado in ('Libre', 'Ocupado'))
)

create table Cliente(
	CodCli bigint identity(1, 1) not null, 
	Nombre varchar(50) not null, 
	Apellido varchar(50) not null, 
	Dirección varchar(50) not null, 
	Tel bigint not null, 
	Email varchar(50),
	constraint pk_cliente primary key (CodCli)
)


create table Prestamo(
	CodPrest bigint identity(1, 1) not null, 
	CodEj int not null, 
	CodPel bigint not null, 
	CodCli bigint not null, 
	FechaPrest date not null,
	FechaDev date,
	constraint pk_prestamo primary key (CodPrest),
	constraint fk_prestamo_ej foreign key (CodPel, CodEj) references Ejemplar(CodPel, CodEj),
	constraint fk_prestamo_cliente foreign key (CodCli) references Cliente(CodCli)
)
