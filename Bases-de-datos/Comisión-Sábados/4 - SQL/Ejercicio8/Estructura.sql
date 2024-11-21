create database ejercicio_8

use ejercicio_8


create table Persona (
	id bigint identity(1, 1) primary key,
	nombre varchar(50) not null,
	apellido varchar(50) not null
)

create table Bar(
	id bigint identity(1, 1) primary key,
	nombre varchar(50) not null
)

create table Cerveza(
	id bigint identity(1, 1) primary key,
	nombre varchar(50) not null
)

create Table Frecuenta(
	personaId bigint not null,
	barId bigInt not null,
	constraint pk_frecuenta primary key (personaId, barId),
	constraint fk_frecuenta_persona foreign key (personaId) references Persona(id),
	constraint fk_frecuenta_bar foreign key (barId) references Bar(id)
)

create Table Sirve(
	cervezaId bigint not null,
	barId bigInt not null,
	constraint pk_sirve primary key (cervezaId, barId),
	constraint fk_sirve_cerveza foreign key (cervezaId) references Cerveza(id),
	constraint fk_sirve_bar foreign key (barId) references Bar(id)
)

create Table Gusta(
	cervezaId bigint not null,
	personaId bigInt not null,
	constraint pk_gusta primary key (cervezaId, personaId),
	constraint fk_gusta_cerveza foreign key (cervezaId) references Cerveza(id),
	constraint fk_gusta_persona foreign key (personaId) references Persona(id)
)