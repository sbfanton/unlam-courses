use EJERCICIO_5

-- Insertar varios rubros
INSERT INTO Rubro (NomRubro)
VALUES 
('Policial'),      -- Rubro 1
('Acción'),        -- Rubro 2
('Comedia'),       -- Rubro 3
('Drama'),         -- Rubro 4
('Aventura');      -- Rubro 5

-- Insertar películas con variedad de rubros
INSERT INTO Pelicula (Titulo, Duracion, Anio, CodRubro)
VALUES 
('Rey León', 88, 1994, 5),           -- Rubro Aventura
('Terminator 3', 109, 2003, 2),      -- Rubro Acción
('La Máscara', 101, 1994, 3),        -- Rubro Comedia
('El Padrino', 175, 1972, 4),        -- Rubro Drama
('La Casa de Papel', 60, 2017, 1),   -- Rubro Policial
('Gladiador', 155, 2000, 2),         -- Rubro Acción
('Intocable', 112, 2011, 3),        -- Rubro Comedia
('Titanic', 195, 1997, 4),           -- Rubro Drama
('Jurassic Park', 127, 1993, 5),     -- Rubro Aventura
('Misión Imposible', 126, 1996, 2);  -- Rubro Acción


-- Insertar ejemplares para las películas
INSERT INTO Ejemplar (CodEj, CodPel, Estado, Ubicacion)
VALUES 
(1, 1, 'Libre', 'Sala 1'),  -- Ejemplar 1 de "Rey León"
(2, 1, 'Ocupado', 'Sala 2'),  -- Ejemplar 2 de "Rey León"
(3, 1, 'Libre', 'Sala 3'),  -- Ejemplar 1 de "Terminator 3"
(1, 2, 'Ocupado', 'Sala 4'),  -- Ejemplar 2 de "Terminator 3"
(2, 2, 'Libre', 'Sala 5'),  -- Ejemplar 1 de "La Máscara"
(1, 3, 'Ocupado', 'Sala 6'),  -- Ejemplar 2 de "La Máscara"
(2, 3, 'Libre', 'Sala 7'),  -- Ejemplar 1 de "El Padrino"
(3, 3, 'Ocupado', 'Sala 8'),  -- Ejemplar 2 de "El Padrino"
(1, 4, 'Libre', 'Sala 9'),  -- Ejemplar 1 de "La Casa de Papel"
(2, 4, 'Ocupado', 'Sala 10'),  -- Ejemplar 2 de "La Casa de Papel"
(3, 4, 'Libre', 'Sala 11'),  -- Ejemplar 1 de "Gladiador"
(4, 4, 'Ocupado', 'Sala 12'),  -- Ejemplar 2 de "Gladiador"
(1, 5, 'Libre', 'Sala 13'),  -- Ejemplar 1 de "Intocable"
(1, 6, 'Ocupado', 'Sala 14'),  -- Ejemplar 2 de "Intocable"
(1, 7, 'Libre', 'Sala 15'),  -- Ejemplar 1 de "Titanic"
(1, 8, 'Ocupado', 'Sala 16'),  -- Ejemplar 2 de "Titanic"
(2, 8, 'Libre', 'Sala 17'),  -- Ejemplar 1 de "Jurassic Park"
(1, 9, 'Ocupado', 'Sala 18'),  -- Ejemplar 2 de "Jurassic Park"
(1, 10, 'Libre', 'Sala 19');  -- Ejemplar 1 de "Misión Imposible"


-- Insertar clientes
INSERT INTO Cliente (Nombre, Apellido, Dirección, Tel, Email)
VALUES 
('Juan', 'Pérez', 'Calle Falsa 123', 123456789, 'juan.perez@example.com'),
('María', 'Gómez', 'Av. Libertad 456', 987654321, 'maria.gomez@example.com'),
('Carlos', 'Alvarez', 'Calle Real 789', 555666777, 'carlos.alvarez@example.com'),
('Ana', 'Rodríguez', 'Calle Mayor 321', 666777888, 'ana.rodriguez@example.com'),
('Luis', 'Martínez', 'Calle 45', 777888999, 'luis.martinez@example.com');


-- Insertar préstamos
-- Insertar más préstamos (con códigos de película hasta 10)
INSERT INTO Prestamo (CodEj, CodPel, CodCli, FechaPrest, FechaDev)
VALUES 
(1, 1, 1, '2024-10-11', '2024-10-20'),  -- Juan Pérez toma el ejemplar 1 de "Rey León"
(2, 1, 3, '2024-10-12', '2024-10-22'),  -- Carlos Álvarez toma el ejemplar 2 de "Rey León"
(1, 2, 4, '2024-10-13', '2024-10-23'),  -- Ana Rodríguez toma el ejemplar 1 de "Terminator 3"
(1, 2, 5, '2024-10-14', '2024-10-24'),  -- Luis Martínez toma el ejemplar 2 de "Terminator 3"
(1, 3, 2, '2024-10-15', '2024-10-25'),  -- María Gómez toma el ejemplar 1 de "La Máscara"
(2, 3, 1, '2024-10-16', '2024-10-26'),  -- Juan Pérez toma el ejemplar 2 de "La Máscara"
(3, 4, 5, '2024-10-17', '2024-10-27'),  -- Luis Martínez toma el ejemplar 1 de "El Padrino"
(2, 4, 3, '2024-10-18', '2024-10-28'),  -- Carlos Álvarez toma el ejemplar 2 de "El Padrino"
(1, 5, 4, '2024-10-19', '2024-10-29'),  -- Ana Rodríguez toma el ejemplar 1 de "La Casa de Papel"
(1, 6, 3, '2024-10-22', '2024-11-01'),  -- Carlos Álvarez toma el ejemplar 2 de "Gladiador"
(1, 7, 5, '2024-10-24', '2024-11-03'),  -- Luis Martínez toma el ejemplar 2 de "Intocable"
(1, 8, 1, '2024-10-25', '2024-11-05'),  -- Juan Pérez toma el ejemplar 1 de "Titanic"
(2, 8, 2, '2024-10-26', '2024-11-06'),  -- María Gómez toma el ejemplar 2 de "Titanic"
(1, 9, 4, '2024-10-27', '2024-11-07'),  -- Ana Rodríguez toma el ejemplar 1 de "Jurassic Park"
(1, 10, 5, '2024-10-29', '2024-11-09');  -- Luis Martínez toma el ejemplar 1 de "Misión Imposible"
