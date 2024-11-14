USE EJ7;
GO

--DELETE FROM COCHE 
INSERT INTO coche (patente, modelo, anio)
VALUES
('AAA123', 'nissan', '2020'),
('BBB123', 'nissan', '2020'),
('AAA321', 'nissan', '2020'),
('CCC132', 'nissan', '2020'),
('AA888BB', 'nissan', '2024'),
('AS777AB', 'nissan', '2027')

-- DELETE FROM CHOFER
INSERT INTO chofer
(nroLicencia, nombre, apellido, fecha_ingreso, telefono)
VALUES
(1, 'JUAN', 'GOMEZ', '2024-01-01', '11-1234-1234'),
(2, 'LUIS', 'RODRIGUEZ', '2023-01-01', '11-4321-1234'),
(3, 'MARIA', 'LOPEZ', '2022-01-01', '11-1234-5555'),
(4, 'ANA', 'RUIZ', '2021-01-01', '11-4444-2222')

--DELETE FROM CLIENTE
INSERT INTO cliente
(nroCliente, calle, nro, localidad, nombre, apellido)
VALUES
(1, 'Florencio Varela', 1903, 'San Justo','Diego', 'Boratto'),
(2, 'Florencio Varela', 403, 'Ramos Mejia', 'Sabina', 'Melia'),
(3, 'JD Peron', 2673, 'San Justo', 'Raul', 'Tejerina'),
(4, 'Catamarca', 1903, 'Roque Perez', 'Andrea', 'Conti'),
(5, 'Rondo', 903, 'CABA', 'Alba', 'Piagio')

-- DELETE FROM VIAJE
INSERT INTO viaje
(FechaHoraInicio, FechaHoraFin, chofer, cliente, coche, kmTotales, esperaTotal, costoEspera, costoKms)
VALUES
('2024-11-10 8:30', '2024-11-10 8:30', 1, 1, 'AAA123', 12, 2, 10, 12000),
('2024-11-11 8:30', '2024-11-10 8:30', 1, 1, 'BBB123', 12, 2, 10, 12000),
('2024-11-12 8:32', '2024-11-10 8:30', 1, 1, 'AAA321', 12, 2, 10, 12000),
('2024-11-13 8:29', '2024-11-10 8:30', 1, 1, 'CCC132', 12, 2, 10, 12000),
('2024-11-14 8:35', '2024-11-10 8:30', 1, 1, 'AA888BB', 12, 2, 10, 12000),
('2024-11-15 8:30', '2024-11-10 8:30', 1, 1, 'AS777AB', 12, 2, 10, 12000),
('2024-11-08 18:30', '2024-11-08 19:30', 1, 1, 'AAA123', 40, 5, 10, 40000),
('2024-11-09 18:30', '2024-11-08 19:30', 1, 2, 'AAA123', 34, 0, 10, 35000),
('2024-11-08 18:30', '2024-11-08 19:30', 2, 2, 'AS777AB', 34, 0, 10, 35000),
('2024-10-10 18:30', '2024-11-08 19:30', 2, 2, 'AS777AB', 34, 0, 10, 35000),
('2024-11-10 18:30', '2024-11-08 19:30', 2, 2, 'AS777AB', 34, 0, 10, 35000)
