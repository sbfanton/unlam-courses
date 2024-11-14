CREATE DATABASE EJERCICIO_7

USE EJERCICIO_7

--Auto (matrícula, modelo, año)
create table Auto(
	matricula varchar(8) not null,
	modelo varchar(50) not null,
	anio int,
	constraint pk_auto primary key (matricula)
)

--Chofer(nroLicencia, nombre, apellido, fecha_ingreso, teléfono)
create table Chofer(
	nroLicencia int not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	fecha_ingreso date not null,
	telefono bigint,
	constraint pk_chofer primary key (nroLicencia)
)

--Cliente (nroCliente, calle, nro, localidad)
create table Cliente(
	nroCliente int not null,
	calle varchar(50),
	nro int,
	localidad varchar(50),
	constraint pk_cliente primary key (nroCliente)
)

alter table Cliente
add nombre varchar(50);

alter table Cliente
add apellido varchar(50);

--Viaje(FechaHoraInicio, FechaHoraFin, chofer, cliente, auto,
--kmTotales, esperaTotal, costoEspera, costoKms )

create table Viaje(
	fechaHoraInicio datetime not null,
	fechaHoraFin datetime,
	nroLicencia int not null,
	nroCliente int not null,
	matricula varchar(8) not null,
	kmTotales bigint,
	esperaTotal int,
	costoEspera decimal(18,2),
	costoKms decimal(18,2),
	constraint pk_viaje primary key (fechaHoraInicio, nroLicencia),
	constraint fk_viaje_chofer foreign key (nroLicencia) references Chofer (nroLicencia),
	constraint fk_viaje_cliente foreign key (nroCliente) references Cliente (nroCliente),
	constraint fk_viaje_auto foreign key (matricula) references Auto (matricula)
)

-- Insercion de datos:
INSERT INTO Auto (matricula, modelo, anio) VALUES 
('ABC1234', 'Toyota Corolla', 2020),
('XYZ5678', 'Ford Fiesta', 2019),
('JKL9012', 'Chevrolet Onix', 2021),
('MNO3456', 'Volkswagen Gol', 2018),
('QWE3456', 'Honda Civic', 2017),
('RTY7890', 'Hyundai Elantra', 2022),
('ASD1357', 'Nissan Versa', 2020),
('FGH2468', 'Peugeot 208', 2021),
('ZXC3579', 'Kia Rio', 2019),
('VBN4680', 'Fiat Argo', 2021),
('PLM1234', 'Renault Sandero', 2018),
('OPQ5678', 'Suzuki Baleno', 2020),
('ABC6789', 'Volkswagen Polo', 2021),
('XYZ4321', 'Chevrolet Tracker', 2022),
('JKL8765', 'Toyota Yaris', 2019),
('MNO2345', 'Ford EcoSport', 2020),
('QWE6789', 'Hyundai Tucson', 2021),
('RTY1234', 'Nissan Kicks', 2019),
('ASD9876', 'Peugeot 2008', 2020),
('FGH1357', 'Kia Seltos', 2022);

INSERT INTO Chofer (nroLicencia, nombre, apellido, fecha_ingreso, telefono) VALUES 
(101, 'Juan', 'Pérez', '2021-01-15', 1234567890),
(102, 'María', 'Gómez', '2020-06-10', 2345678901),
(103, 'Carlos', 'López', '2019-11-20', 3456789012),
(104, 'Laura', 'Martínez', '2022-02-05', 4567890123),
(105, 'Pedro', 'Fernández', '2021-03-12', 5678901234),
(106, 'Ana', 'Sánchez', '2020-07-22', 6789012345),
(107, 'Luis', 'Ramírez', '2019-10-10', 7890123456),
(108, 'Elena', 'Torres', '2022-04-15', 8901234567),
(109, 'Javier', 'Romero', '2021-05-20', 9012345678),
(110, 'Sofía', 'Hernández', '2020-08-30', 1122334455),
(111, 'Diego', 'Cruz', '2019-12-01', 2233445566),
(112, 'Marta', 'Vásquez', '2022-01-14', 3344556677),
(113, 'Fernando', 'Alvarez', '2021-02-25', 4455667788),
(114, 'Valentina', 'García', '2020-09-09', 5566778899),
(115, 'Ricardo', 'Morales', '2019-11-30', 6677889900),
(116, 'Lucía', 'Ponce', '2022-03-13', 7788990011),
(117, 'Andrés', 'Salinas', '2021-06-17', 8899001122),
(118, 'Natalia', 'Mendoza', '2020-05-05', 9900112233),
(119, 'Gabriel', 'Castro', '2019-08-23', 1011121314),
(120, 'Rocío', 'Salazar', '2022-07-14', 1213141516);

INSERT INTO Cliente (nroCliente, calle, nro, localidad) VALUES 
(1, 'Av. Libertador', 100, 'Buenos Aires'),
(2, 'Calle Falsa', 123, 'CABA'),
(3, 'Av. Corrientes', 456, 'Buenos Aires'),
(4, 'Calle de la Paz', 789, 'La Plata'),
(5, 'Av. 9 de Julio', 200, 'Buenos Aires'),
(6, 'Calle San Martín', 345, 'CABA'),
(7, 'Av. Rivadavia', 456, 'Buenos Aires'),
(8, 'Calle Belgrano', 123, 'San Isidro'),
(9, 'Av. General Paz', 999, 'CABA'),
(10, 'Calle Sarmiento', 88, 'La Plata'),
(11, 'Calle Mitre', 12, 'Quilmes'),
(12, 'Av. San Juan', 50, 'CABA'),
(13, 'Calle Tucumán', 34, 'Morón'),
(14, 'Av. Córdoba', 11, 'San Fernando'),
(15, 'Calle Libertad', 77, 'Avellaneda'),
(16, 'Calle San Luis', 25, 'Temperley'),
(17, 'Av. Independencia', 60, 'CABA'),
(18, 'Calle La Rioja', 80, 'Lanús'),
(19, 'Calle Mendoza', 33, 'Villa Devoto'),
(20, 'Av. Paseo Colón', 42, 'CABA');

INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2023-11-01 08:00:00', '2023-11-01 08:30:00', 101, 1, 'ABC1234', 15, 5, 10.00, 5.00),
('2023-11-01 09:00:00', '2023-11-01 09:45:00', 102, 2, 'XYZ5678', 20, 3, 5.00, 8.00),
('2023-11-01 10:00:00', '2023-11-01 10:20:00', 103, 3, 'JKL9012', 10, 0, 0.00, 2.50),
('2023-11-01 11:00:00', '2023-11-01 11:30:00', 104, 4, 'MNO3456', 25, 10, 15.00, 12.50),
('2023-11-02 08:15:00', '2023-11-02 08:45:00', 101, 5, 'QWE3456', 30, 4, 8.00, 10.00),
('2023-11-02 09:30:00', '2023-11-02 10:00:00', 102, 6, 'RTY7890', 18, 2, 4.00, 6.00),
('2023-11-02 10:15:00', '2023-11-02 10:50:00', 103, 7, 'ASD1357', 22, 3, 6.00, 7.50),
('2023-11-02 11:30:00', '2023-11-02 12:00:00', 104, 8, 'FGH2468', 14, 0, 0.00, 5.00),
('2023-11-03 08:00:00', '2023-11-03 08:30:00', 101, 9, 'ZXC3579', 27, 5, 10.00, 11.00),
('2023-11-03 09:00:00', '2023-11-03 09:45:00', 102, 10, 'VBN4680', 15, 3, 5.00, 9.00),
('2023-11-03 10:00:00', '2023-11-03 10:20:00', 103, 11, 'PLM1234', 12, 0, 0.00, 3.00),
('2023-11-03 11:00:00', '2023-11-03 11:30:00', 104, 12, 'OPQ5678', 30, 10, 15.00, 13.50),
('2023-11-04 08:15:00', '2023-11-04 08:45:00', 101, 13, 'ABC6789', 20, 4, 8.00, 7.00);

-- Viajes para el cliente nroCliente 1 con chofer nroLicencia 101
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2023-11-01 09:00:00', '2023-11-01 09:30:00', 101, 1, 'ABC1234', 10, 2, 4.00, 3.00),
('2023-11-02 10:00:00', '2023-11-02 10:20:00', 101, 1, 'ABC1234', 12, 1, 2.00, 4.00),
('2023-11-03 11:00:00', '2023-11-03 11:40:00', 101, 1, 'ABC1234', 20, 5, 10.00, 5.00);

-- Viajes para el cliente nroCliente 2 con chofer nroLicencia 102
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2023-11-01 08:00:00', '2023-11-01 08:30:00', 102, 2, 'XYZ5678', 15, 0, 0.00, 5.00),
('2023-11-02 09:00:00', '2023-11-02 09:45:00', 102, 2, 'XYZ5678', 25, 3, 5.00, 10.00),
('2023-11-03 10:00:00', '2023-11-03 10:30:00', 102, 2, 'XYZ5678', 30, 2, 4.00, 8.00);

-- Viajes para el cliente nroCliente 3 con chofer nroLicencia 103
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2023-11-01 10:30:00', '2023-11-01 11:00:00', 103, 3, 'JKL9012', 8, 0, 0.00, 2.00),
('2023-11-02 11:00:00', '2023-11-02 11:20:00', 103, 3, 'JKL9012', 12, 1, 2.00, 3.00),
('2023-11-03 12:00:00', '2023-11-03 12:30:00', 103, 3, 'JKL9012', 18, 4, 8.00, 5.00);

-- Viajes para el cliente nroCliente 4 con chofer nroLicencia 104
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2023-11-01 09:15:00', '2023-11-01 09:45:00', 104, 4, 'MNO3456', 22, 3, 5.00, 7.00),
('2023-11-02 10:30:00', '2023-11-02 11:00:00', 104, 4, 'MNO3456', 19, 2, 4.00, 6.00),
('2023-11-03 11:30:00', '2023-11-03 12:00:00', 104, 4, 'MNO3456', 25, 0, 0.00, 8.00);

-- Viajes para el cliente nroCliente 1 con chofer nroLicencia 101
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-15 09:00:00', '2024-01-15 09:30:00', 101, 1, 'ABC1234', 15, 5, 10.00, 5.00),
('2024-02-10 08:15:00', '2024-02-10 08:45:00', 101, 1, 'ABC1234', 20, 0, 0.00, 8.00),
('2024-03-05 10:00:00', '2024-03-05 10:30:00', 101, 1, 'ABC1234', 12, 3, 6.00, 3.00);

-- Viajes para el cliente nroCliente 2 con chofer nroLicencia 102
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-20 09:30:00', '2024-01-20 10:00:00', 102, 2, 'XYZ5678', 25, 2, 4.00, 10.00),
('2024-02-15 11:00:00', '2024-02-15 11:45:00', 102, 2, 'XYZ5678', 30, 1, 2.00, 12.00),
('2024-03-10 08:45:00', '2024-03-10 09:15:00', 102, 2, 'XYZ5678', 22, 3, 5.00, 9.00);

-- Viajes para el cliente nroCliente 3 con chofer nroLicencia 103
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-30 10:30:00', '2024-01-30 11:00:00', 103, 3, 'JKL9012', 18, 0, 0.00, 5.00),
('2024-02-20 09:15:00', '2024-02-20 09:45:00', 103, 3, 'JKL9012', 25, 2, 4.00, 8.00),
('2024-03-15 11:30:00', '2024-03-15 12:00:00', 103, 3, 'JKL9012', 30, 3, 6.00, 10.00);

-- Viajes para el cliente nroCliente 4 con chofer nroLicencia 104
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-25 08:00:00', '2024-01-25 08:30:00', 104, 4, 'MNO3456', 20, 0, 0.00, 7.00),
('2024-02-18 10:00:00', '2024-02-18 10:30:00', 104, 4, 'MNO3456', 15, 1, 2.00, 5.00),
('2024-03-22 09:45:00', '2024-03-22 10:15:00', 104, 4, 'MNO3456', 28, 2, 3.00, 11.00);

-- Viajes para el cliente nroCliente 1 con chofer nroLicencia 101
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-18 10:00:00', '2024-01-18 10:30:00', 101, 1, 'ABC1234', 15, 5, 10.00, 5.00),
('2024-02-12 14:15:00', '2024-02-12 14:45:00', 101, 1, 'ABC1234', 20, 0, 0.00, 8.00),
('2024-03-07 11:00:00', '2024-03-07 11:30:00', 101, 1, 'ABC1234', 12, 3, 6.00, 3.00);

-- Viajes para el cliente nroCliente 2 con chofer nroLicencia 102
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-21 09:30:00', '2024-01-21 10:00:00', 102, 2, 'XYZ5678', 25, 2, 4.00, 10.00),
('2024-02-16 11:00:00', '2024-02-16 11:45:00', 102, 2, 'XYZ5678', 30, 1, 2.00, 12.00),
('2024-03-11 08:45:00', '2024-03-11 09:15:00', 102, 2, 'XYZ5678', 22, 3, 5.00, 9.00),
('2024-04-02 15:30:00', '2024-04-02 16:00:00', 102, 2, 'XYZ5678', 18, 0, 0.00, 7.00);

-- Viajes para el cliente nroCliente 3 con chofer nroLicencia 103
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-31 10:30:00', '2024-01-31 11:00:00', 103, 3, 'JKL9012', 18, 0, 0.00, 5.00),
('2024-02-21 09:15:00', '2024-02-21 09:45:00', 103, 3, 'JKL9012', 25, 2, 4.00, 8.00),
('2024-03-16 11:30:00', '2024-03-16 12:00:00', 103, 3, 'JKL9012', 30, 3, 6.00, 10.00);

-- Viajes para el cliente nroCliente 4 con chofer nroLicencia 104
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-26 08:00:00', '2024-01-26 08:30:00', 104, 4, 'MNO3456', 20, 0, 0.00, 7.00),
('2024-02-19 10:00:00', '2024-02-19 10:30:00', 104, 4, 'MNO3456', 15, 1, 2.00, 5.00);





-- Viajes para el cliente nroCliente 5 con chofer nroLicencia 105
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-03-21 12:00:00', '2024-03-21 12:45:00', 105, 5, 'JKL9012', 28, 3, 5.00, 9.00),
('2024-04-03 14:30:00', '2024-04-03 15:00:00', 105, 5, 'JKL9012', 22, 0, 0.00, 8.00);



-- Viajes para el cliente nroCliente 6 con chofer nroLicencia 106
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-02-02 11:15:00', '2024-02-02 11:45:00', 106, 6, 'JKL9012', 12, 1, 2.00, 6.00);

-- Viajes para el cliente nroCliente 7 con chofer nroLicencia 107
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-16 13:00:00', '2024-01-16 13:30:00', 107, 7, 'JKL9012', 14, 0, 0.00, 7.00),
('2024-03-13 15:00:00', '2024-03-13 15:30:00', 107, 7, 'JKL9012', 16, 2, 3.00, 8.00);

-- Viajes para el cliente nroCliente 8 con chofer nroLicencia 108
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-21 10:00:00', '2024-01-21 10:30:00', 108, 8, 'JKL9012', 18, 1, 2.00, 6.00),
('2024-02-26 12:00:00', '2024-02-26 12:30:00', 108, 8, 'JKL9012', 20, 0, 0.00, 7.00),
('2024-03-31 09:00:00', '2024-03-31 09:30:00', 108, 8, 'JKL9012', 22, 3, 4.00, 8.00);

-- Viajes para el cliente nroCliente 9 con chofer nroLicencia 109
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-01-23 14:00:00', '2024-01-23 14:30:00', 109, 9, 'JKL9012', 10, 0, 0.00, 5.00),
('2024-02-16 16:00:00', '2024-02-16 16:30:00', 109, 9, 'JKL9012', 12, 1, 1.50, 6.00),
('2024-03-06 18:00:00', '2024-03-06 18:45:00', 109, 9, 'JKL9012', 14, 2, 3.00, 7.00),
('2024-04-11 12:30:00', '2024-04-11 13:00:00', 109, 9, 'JKL9012', 15, 0, 0.00, 7.50);

-- Viajes para el cliente nroCliente 1 con chofer nroLicencia 101
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-10-01 10:00:00', '2024-10-01 10:30:00', 101, 1, 'ABC1234', 15, 5, 10.00, 5.00),
('2024-10-10 14:15:00', '2024-10-10 14:45:00', 101, 1, 'ABC1234', 20, 0, 0.00, 8.00),
('2024-10-15 11:00:00', '2024-10-15 11:30:00', 101, 1, 'ABC1234', 12, 3, 6.00, 3.00);

-- Viajes para el cliente nroCliente 2 con chofer nroLicencia 102
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-10-02 09:30:00', '2024-10-02 10:00:00', 102, 2, 'XYZ5678', 25, 2, 4.00, 10.00),
('2024-10-11 11:00:00', '2024-10-11 11:45:00', 102, 2, 'XYZ5678', 30, 1, 2.00, 12.00),
('2024-10-21 08:45:00', '2024-10-21 09:15:00', 102, 2, 'XYZ5678', 22, 3, 5.00, 9.00),
('2024-10-30 15:30:00', '2024-10-30 16:00:00', 102, 2, 'XYZ5678', 18, 0, 0.00, 7.00);

-- Viajes para el cliente nroCliente 3 con chofer nroLicencia 103
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-10-05 10:30:00', '2024-10-05 11:00:00', 103, 3, 'JKL9012', 18, 0, 0.00, 5.00),
('2024-10-15 09:15:00', '2024-10-15 09:45:00', 103, 3, 'JKL9012', 25, 2, 4.00, 8.00),
('2024-10-22 11:30:00', '2024-10-22 12:00:00', 103, 3, 'JKL9012', 30, 3, 6.00, 10.00);

-- Viajes para el cliente nroCliente 4 con chofer nroLicencia 104
INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-10-12 08:00:00', '2024-10-12 08:30:00', 104, 4, 'MNO3456', 20, 0, 0.00, 7.00),
('2024-10-25 10:00:00', '2024-10-25 10:30:00', 104, 4, 'MNO3456', 15, 1, 2.00, 5.00);

INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-10-01 09:00:00', '2024-10-01 09:30:00', 101, 1, 'ABC1234', 15, 0, 0.00, 5.00), -- Toyota Corolla
('2024-10-02 10:00:00', '2024-10-02 10:30:00', 101, 2, 'XYZ5678', 20, 1, 2.00, 6.00), -- Ford Fiesta
('2024-10-03 11:00:00', '2024-10-03 11:30:00', 101, 3, 'JKL9012', 25, 0, 0.00, 7.00), -- Chevrolet Onix
('2024-10-04 12:00:00', '2024-10-04 12:30:00', 101, 4, 'MNO3456', 18, 2, 3.00, 5.00), -- Volkswagen Gol
('2024-10-05 13:00:00', '2024-10-05 13:30:00', 101, 5, 'QWE3456', 22, 1, 1.00, 8.00), -- Honda Civic
('2024-10-06 14:00:00', '2024-10-06 14:30:00', 101, 6, 'RTY7890', 30, 0, 0.00, 9.00), -- Hyundai Elantra
('2024-10-07 15:00:00', '2024-10-07 15:30:00', 101, 7, 'ASD1357', 10, 3, 2.00, 4.00), -- Nissan Versa
('2024-10-08 16:00:00', '2024-10-08 16:30:00', 101, 8, 'FGH2468', 12, 0, 0.00, 3.00), -- Peugeot 208
('2024-10-09 17:00:00', '2024-10-09 17:30:00', 101, 9, 'ZXC3579', 16, 2, 1.50, 5.50), -- Kia Rio
('2024-10-10 18:00:00', '2024-10-10 18:30:00', 101, 10, 'VBN4680', 14, 0, 0.00, 4.00), -- Fiat Argo
('2024-10-11 09:00:00', '2024-10-11 09:30:00', 101, 11, 'PLM1234', 20, 1, 2.00, 6.00), -- Renault Sandero
('2024-10-12 10:30:00', '2024-10-12 11:00:00', 101, 12, 'OPQ5678', 15, 0, 0.00, 5.00), -- Suzuki Baleno
('2024-10-13 11:30:00', '2024-10-13 12:00:00', 101, 13, 'ABC6789', 25, 2, 3.00, 7.00), -- Volkswagen Polo
('2024-10-14 12:30:00', '2024-10-14 13:00:00', 101, 14, 'XYZ4321', 18, 0, 0.00, 4.00), -- Chevrolet Tracker
('2024-10-15 13:30:00', '2024-10-15 14:00:00', 101, 15, 'JKL8765', 30, 1, 2.00, 8.00), -- Toyota Yaris
('2024-10-16 14:30:00', '2024-10-16 15:00:00', 101, 16, 'MNO2345', 12, 0, 0.00, 3.00), -- Ford EcoSport
('2024-10-17 15:30:00', '2024-10-17 16:00:00', 101, 17, 'QWE6789', 22, 3, 4.00, 9.00), -- Hyundai Tucson
('2024-10-18 16:30:00', '2024-10-18 17:00:00', 101, 18, 'RTY1234', 10, 0, 0.00, 2.00), -- Nissan Kicks
('2024-10-19 17:30:00', '2024-10-19 18:00:00', 101, 19, 'ASD9876', 14, 0, 0.00, 4.00), -- Peugeot 2008
('2024-10-20 18:00:00', '2024-10-20 18:30:00', 101, 20, 'FGH1357', 20, 1, 2.00, 5.00); -- Kia Seltos

UPDATE Cliente SET nombre = 'Juan', apellido = 'Pérez' WHERE nroCliente = 1;
UPDATE Cliente SET nombre = 'Ana', apellido = 'Gómez' WHERE nroCliente = 2;
UPDATE Cliente SET nombre = 'Luis', apellido = 'Martínez' WHERE nroCliente = 3;
UPDATE Cliente SET nombre = 'María', apellido = 'Fernández' WHERE nroCliente = 4;
UPDATE Cliente SET nombre = 'Carlos', apellido = 'Sánchez' WHERE nroCliente = 5;
UPDATE Cliente SET nombre = 'Laura', apellido = 'López' WHERE nroCliente = 6;
UPDATE Cliente SET nombre = 'Jorge', apellido = 'Ramírez' WHERE nroCliente = 7;
UPDATE Cliente SET nombre = 'Sofía', apellido = 'González' WHERE nroCliente = 8;
UPDATE Cliente SET nombre = 'Diego', apellido = 'Rodríguez' WHERE nroCliente = 9;
UPDATE Cliente SET nombre = 'Lucía', apellido = 'Díaz' WHERE nroCliente = 10;
UPDATE Cliente SET nombre = 'Fernando', apellido = 'Martín' WHERE nroCliente = 11;
UPDATE Cliente SET nombre = 'Valentina', apellido = 'Torres' WHERE nroCliente = 12;
UPDATE Cliente SET nombre = 'Ezequiel', apellido = 'Ríos' WHERE nroCliente = 13;
UPDATE Cliente SET nombre = 'Agustina', apellido = 'Mendoza' WHERE nroCliente = 14;
UPDATE Cliente SET nombre = 'Nicolás', apellido = 'Cruz' WHERE nroCliente = 15;
UPDATE Cliente SET nombre = 'Camila', apellido = 'Ponce' WHERE nroCliente = 16;
UPDATE Cliente SET nombre = 'Hugo', apellido = 'Vargas' WHERE nroCliente = 17;
UPDATE Cliente SET nombre = 'Martina', apellido = 'Ortega' WHERE nroCliente = 18;
UPDATE Cliente SET nombre = 'Rafael', apellido = 'Salazar' WHERE nroCliente = 19;
UPDATE Cliente SET nombre = 'Isabella', apellido = 'Fuentes' WHERE nroCliente = 20;

INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-10-01 09:01:00', '2024-10-01 09:30:00', 102, 1, 'ABC1234', 15, 0, 0.00, 5.00), -- Toyota Corolla
('2024-10-02 10:01:00', '2024-10-02 10:30:00', 101, 1, 'XYZ5678', 20, 1, 2.00, 6.00), -- Ford Fiesta
('2024-10-03 11:01:00', '2024-10-03 11:30:00', 102, 1, 'JKL9012', 25, 0, 0.00, 7.00), -- Chevrolet Onix
('2024-10-04 12:01:00', '2024-10-04 12:30:00', 102, 1, 'MNO3456', 18, 2, 3.00, 5.00), -- Volkswagen Gol
('2024-10-05 13:01:00', '2024-10-05 13:30:00', 102, 1, 'QWE3456', 22, 1, 1.00, 8.00), -- Honda Civic
('2024-10-06 14:01:00', '2024-10-06 14:30:00', 102, 1, 'RTY7890', 30, 0, 0.00, 9.00), -- Hyundai Elantra
('2024-10-07 15:01:00', '2024-10-07 15:30:00', 103, 1, 'ASD1357', 10, 3, 2.00, 4.00), -- Nissan Versa
('2024-10-08 16:01:00', '2024-10-08 16:30:00', 105, 1, 'FGH2468', 12, 0, 0.00, 3.00), -- Peugeot 208
('2024-10-09 17:01:00', '2024-10-09 17:30:00', 101, 1, 'ZXC3579', 16, 2, 1.50, 5.50), -- Kia Rio
('2024-10-10 18:01:00', '2024-10-10 18:30:00', 101, 1, 'VBN4680', 14, 0, 0.00, 4.00), -- Fiat Argo
('2024-10-11 09:01:00', '2024-10-11 09:30:00', 101, 1, 'PLM1234', 20, 1, 2.00, 6.00), -- Renault Sandero
('2024-10-12 10:31:00', '2024-10-12 11:00:00', 101, 1, 'OPQ5678', 15, 0, 0.00, 5.00), -- Suzuki Baleno
('2024-10-13 11:31:00', '2024-10-13 12:00:00', 106, 1, 'ABC6789', 25, 2, 3.00, 7.00), -- Volkswagen Polo
('2024-10-14 12:31:00', '2024-10-14 13:00:00', 106, 1, 'XYZ4321', 18, 0, 0.00, 4.00), -- Chevrolet Tracker
('2024-10-15 13:31:00', '2024-10-15 14:00:00', 107, 1, 'JKL8765', 30, 1, 2.00, 8.00), -- Toyota Yaris
('2024-10-16 14:31:00', '2024-10-16 15:00:00', 105, 1, 'MNO2345', 12, 0, 0.00, 3.00), -- Ford EcoSport
('2024-10-17 15:31:00', '2024-10-17 16:00:00', 103, 1, 'QWE6789', 22, 3, 4.00, 9.00), -- Hyundai Tucson
('2024-10-18 16:31:00', '2024-10-18 17:00:00', 105, 1, 'RTY1234', 10, 0, 0.00, 2.00), -- Nissan Kicks
('2024-10-19 17:31:00', '2024-10-19 18:00:00', 102, 1, 'ASD9876', 14, 0, 0.00, 4.00), -- Peugeot 2008
('2024-10-20 18:01:00', '2024-10-20 18:30:00', 101, 1, 'FGH1357', 20, 1, 2.00, 5.00); -- Kia Seltos

INSERT INTO Viaje (fechaHoraInicio, fechaHoraFin, nroLicencia, nroCliente, matricula, kmTotales, esperaTotal, costoEspera, costoKms) VALUES 
('2024-09-01 09:00:00', '2024-09-01 09:30:00', 101, 1, 'ABC1234', 15, 0, 0.00, 5.00), -- Juan Pérez, Toyota Corolla
('2024-09-05 10:00:00', '2024-09-05 10:30:00', 102, 2, 'XYZ5678', 20, 1, 2.00, 6.00), -- Ana Gómez, Ford Fiesta
('2024-09-10 11:00:00', '2024-09-10 11:30:00', 103, 3, 'JKL9012', 25, 0, 0.00, 7.00), -- Luis Martínez, Chevrolet Onix
('2024-09-12 14:00:00', '2024-09-12 14:45:00', 104, 4, 'MNO3456', 18, 2, 3.00, 5.00), -- María Fernández, Volkswagen Gol
('2024-09-15 08:30:00', '2024-09-15 09:00:00', 105, 5, 'QWE3456', 22, 0, 0.00, 8.00), -- Carlos Sánchez, Honda Civic
('2024-09-20 16:00:00', '2024-09-20 16:30:00', 106, 6, 'RTY7890', 30, 0, 0.00, 9.00), -- Laura López, Hyundai Elantra
('2024-09-22 17:00:00', '2024-09-22 17:30:00', 107, 7, 'ASD1357', 10, 3, 2.00, 4.00), -- Jorge Ramírez, Nissan Versa
('2024-09-25 18:00:00', '2024-09-25 18:30:00', 108, 8, 'FGH2468', 12, 0, 0.00, 3.00); -- Sofía González, Peugeot 208

