USE MASTER

CREATE DATABASE EJERCICIO_4
go

USE EJERCICIO_4
go



CREATE TABLE Vive
(
nomPersona varchar(100) PRIMARY KEY,
calle VARCHAR(100) NOT NULL ,
ciudad VARCHAR(100) NOT NULL
);


CREATE TABLE Situada_En
(
nomEmpresa varchar(100) PRIMARY KEY,
ciudad VARCHAR(100) NOT NULL  
);


 


CREATE TABLE Trabaja
(
nomPersona varchar(100) not null,
nomEmpresa VARCHAR(100) NOT NULL ,
salario decimal(18,2) NOT NULL,
feIngreso datetime not null,
feEgreso datetime null
);


ALTER TABLE Trabaja
ADD CONSTRAINT PK_Trabaja PRIMARY KEY (nomPersona);

ALTER TABLE Trabaja
ADD CONSTRAINT FK_Trabaja_nomEmpresa
FOREIGN KEY (nomEmpresa) REFERENCES Situada_En(nomEmpresa);




CREATE TABLE Supervisa
(
nomPersona varchar(100) NOT NULL   ,
nomSupervisor VARCHAR(100) NOT NULL  
);


ALTER TABLE Supervisa
ADD CONSTRAINT PK_Supervisa PRIMARY KEY (nomPersona,nomSupervisor);

ALTER TABLE Supervisa
ADD CONSTRAINT FK_Supervisa_nomPersona
FOREIGN KEY (nomPersona) REFERENCES Vive(nomPersona);

ALTER TABLE Supervisa
ADD CONSTRAINT FK_Supervisa_nomSupervisor
FOREIGN KEY (nomSupervisor) REFERENCES Vive(nomPersona);



