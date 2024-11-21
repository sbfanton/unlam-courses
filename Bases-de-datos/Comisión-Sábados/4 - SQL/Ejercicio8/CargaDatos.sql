use ejercicio_8

-- Insertar personas
INSERT INTO Persona (nombre, apellido) VALUES ('Juan', 'Pérez');
INSERT INTO Persona (nombre, apellido) VALUES ('Ana', 'Gómez');
INSERT INTO Persona (nombre, apellido) VALUES ('Carlos', 'Sánchez');
INSERT INTO Persona (nombre, apellido) VALUES ('María', 'Lopez');

-- Insertar bares
INSERT INTO Bar (nombre) VALUES ('Bar La Bodega');
INSERT INTO Bar (nombre) VALUES ('Bar El Refugio');
INSERT INTO Bar (nombre) VALUES ('Bar del Centro');

-- Insertar cervezas
INSERT INTO Cerveza (nombre) VALUES ('Rubia');
INSERT INTO Cerveza (nombre) VALUES ('IPA');
INSERT INTO Cerveza (nombre) VALUES ('Stout');
INSERT INTO Cerveza (nombre) VALUES ('Lager');

-- Insertar frecuentaciones (Frecuenta)
-- Juan frecuenta Bar La Bodega y Bar del Centro
INSERT INTO Frecuenta (personaId, barId) VALUES (1, 1);  -- Juan en Bar La Bodega
INSERT INTO Frecuenta (personaId, barId) VALUES (1, 3);  -- Juan en Bar del Centro

-- Ana frecuenta solo Bar El Refugio
INSERT INTO Frecuenta (personaId, barId) VALUES (2, 2);  -- Ana en Bar El Refugio

-- Carlos frecuenta Bar La Bodega y Bar del Centro
INSERT INTO Frecuenta (personaId, barId) VALUES (3, 1);  -- Carlos en Bar La Bodega
INSERT INTO Frecuenta (personaId, barId) VALUES (3, 3);  -- Carlos en Bar del Centro

-- María frecuenta Bar El Refugio y Bar del Centro
INSERT INTO Frecuenta (personaId, barId) VALUES (4, 2);  -- María en Bar El Refugio
INSERT INTO Frecuenta (personaId, barId) VALUES (4, 3);  -- María en Bar del Centro

-- Insertar cervezas que sirven los bares (Sirve)
-- Bar La Bodega sirve Rubia y IPA
INSERT INTO Sirve (cervezaId, barId) VALUES (1, 1);  -- Rubia en Bar La Bodega
INSERT INTO Sirve (cervezaId, barId) VALUES (2, 1);  -- IPA en Bar La Bodega

-- Bar El Refugio sirve IPA y Stout
INSERT INTO Sirve (cervezaId, barId) VALUES (2, 2);  -- IPA en Bar El Refugio
INSERT INTO Sirve (cervezaId, barId) VALUES (3, 2);  -- Stout en Bar El Refugio

-- Bar del Centro sirve IPA, Stout y Lager
INSERT INTO Sirve (cervezaId, barId) VALUES (2, 3);  -- IPA en Bar del Centro
INSERT INTO Sirve (cervezaId, barId) VALUES (3, 3);  -- Stout en Bar del Centro
INSERT INTO Sirve (cervezaId, barId) VALUES (4, 3);  -- Lager en Bar del Centro

-- Insertar gustos de las personas (Gusta)
-- Juan gusta de Rubia e IPA
INSERT INTO Gusta (cervezaId, personaId) VALUES (1, 1);  -- Rubia gusta a Juan
INSERT INTO Gusta (cervezaId, personaId) VALUES (2, 1);  -- IPA gusta a Juan

-- Ana gusta de IPA
INSERT INTO Gusta (cervezaId, personaId) VALUES (2, 2);  -- IPA gusta a Ana

-- Carlos gusta de Stout y Lager
INSERT INTO Gusta (cervezaId, personaId) VALUES (3, 3);  -- Stout gusta a Carlos
INSERT INTO Gusta (cervezaId, personaId) VALUES (4, 3);  -- Lager gusta a Carlos

-- María gusta de IPA y Stout
INSERT INTO Gusta (cervezaId, personaId) VALUES (2, 4);  -- IPA gusta a María
INSERT INTO Gusta (cervezaId, personaId) VALUES (3, 4);  -- Stout gusta a María
