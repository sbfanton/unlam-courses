
-- OPERADOR DE DIVISION
-- SUPONGAMOS QUE TENEMOS LA CONSULTA, 
-- "LISTE TODOS LOS ELEMENTOS DE X 
-- CONJUNTO QUE TENGA CORRESPONDENCIA CON TODOS LOS 
-- ELEMENTOS DEL 2do CONJUNTO".
--> ejemplos:
--    liste los alumnos que rindieron todas las materias
--    liste los materiales provistos por todos los proveedores
--    liste los nombres de localidades que se repiten en todas las provincias
--    etc

-- conjuntos -->> tablas
create database clase2;
go 
USE clase2;
GO

--DROP TABLE Alumno
CREATE TABLE Alumno
(
	legajo VARCHAR(2) PRIMARY KEY, 
	nombre VARCHAR(50)
);

CREATE TABLE Materia
(
	codigo VARCHAR(2) PRIMARY KEY,
	nombre VARCHAR(50)
)

CREATE TABLE Rinde
(
	alumno VARCHAR(2), 
	materia VARCHAR(2),
	PRIMARY KEY (materia, alumno),
	FOREIGN KEY (alumno) REFERENCES alumno (legajo),
	FOREIGN KEY (materia) REFERENCES materia (codigo)
)
/*
SELECT * FROM ALUMNO 
SELECT * FROM MATERIA
SELECT * FROM RINDE
*/
INSERT INTO Alumno  VALUES ('A1', 'juan'), ('A2', 'ana'), ('A3', 'diego');
INSERT INTO Materia VALUES ('M1', 'BDD'), ('M2', 'prog 2'), ('M3', 'ingles');
INSERT INTO Rinde VALUES 
('A1', 'M1'), ('A1', 'M2'), ('A1', 'M3'), 
('A2', 'M1'), 
('A3', 'M1'),('A3', 'M3');
 
select * from rinde order by alumno
select * from alumno
select * from materia

-- liste el/los alumnos que rindieron todas las materias
-- AR 
-- RESULTADO <- PRO idAlumno(ALUMNO) - PROYECTAR idAlumno ((PROYECTAR idAlumno  (alumno) X PROYECTAR codMat (mat)) - rinde)

--> ejemplo con script SQL con consulta de AR.
SELECT legajo 
FROM alumno
EXCEPT
SELECT legajo
FROM (
	SELECT a.legajo, m.codigo
	FROM alumno a, materia m
	EXCEPT 
	SELECT * 
	FROM rinde r
	) AS alumnosQueLesFaltanMaterias
 
--------------------------------------------------------------------
-- OTRA FORMA DE RESOLVER LO MISMO.
--------------------------------------------------------------------
SELECT A.*
FROM Alumno A -- ponemos "A" como ALIAS de alumno
WHERE NOT EXISTS 
	(
	SELECT 'a' -- ingreso una costante para optimizar la query
	FROM Materia M -- ponemos "M" como alias de Materia
	WHERE NOT EXISTS
		(
		SELECT 1  -- ingreso una costante para optimizar la query
		FROM Rinde R -- ponemos "R" como alias de Rinde
		WHERE a.legajo = r.alumno AND m.codigo = r.materia 
		-- usamos los alias para acceder a las columnas de las tablas
		)
	)

-- pasos
--paso 1 toma alumno A1, con materia M1
--paso 2 toma alumno A1, con materia M2
--paso 3 toma alumno A1, con materia M3
-- LISTA EL ALUMNO A1
--paso 4 toma alumno A2, con materia M1
--paso 5 toma alumno A2, con materia M2 
--paso 6 toma alumno A2, con materia M3
-- LISTA LAS MATERIAS M2 Y M3 QUE EL ALUMNO NO RINDI�, ENTONCES EL NOT EXISTS DA FALSO, ENTONCES NO LISTA AL ALUMNO A2
--paso 7 toma alumno A3, con materia M1
--paso 8 toma alumno A3, con materia M2 
--paso 9 toma alumno A3, con materia M3
-- LISTA LA MATERIA M2, QUE EL ALUMNO A3 NO RINDI�, ENTONCES EL NOT EXISTS DA FALSO, ENTONCES NO LISTA AL ALUMNO A3

-- OTRA FORMA DE RESOLVER LO MISMO:

-- que sabemos? o que podemos saber?

--1) la cantidad de materias

SELECT COUNT(CODIGO) [total de materias]
FROM Materia

--2) la cantidad de materias que rindio cada alumno

SELECT alumno, count(distinct materia) [cant materias rendidas]
FROM RINDE
GROUP BY alumno
ORDER BY ALUMNO

--3) AHORA JUNTAMOS AMBAS QUERIES 

SELECT alumno, count(distinct materia) [cant materias rendidas]
FROM RINDE
GROUP BY alumno
HAVING count(distinct materia) = (SELECT COUNT(CODIGO) FROM Materia)
ORDER BY ALUMNO

-- que esta comparando en la query anterior?
-- columna 2 (cant de rendidas) con la 3 (total de materias).
SELECT alumno, count(distinct materia) [cant materias rendidas], 
   (SELECT COUNT(CODIGO) FROM Materia) [cant total de materias]
FROM RINDE
GROUP BY alumno


-- MISMA QUERY PERO CON MAS INFO
SELECT a.*, count (r.materia) as cantidad, STRING_AGG(m.nombre, ', ')
FROM rinde r join alumno a on r.alumno = a.legajo 
JOIN Materia m ON r.materia = m.codigo 
GROUP BY a.legajo, a.nombre 
having count (r.materia) = (select count (*) from materia)

-- VISTAS
---- las vistas son una forma de guardar CODIGO de una consulta. 
---- No se almacena el resultado, SI la consulta y su TXT.

CREATE VIEW vista1 (alumno)
AS

	SELECT a.nombre
	FROM rinde r join alumno a on r.alumno = a.legajo
	GROUP BY a.legajo, a.nombre 
	having count (r.materia) = (select count (*) from materia)

---
SELECT * FROM vista1; -- << luego, se puede hacer uso de la vista en el from, como si fuera una tabla

-- el select anterior es equivalente a realizar la siguiente sub consulta:

SELECT *
FROM (
	SELECT a.nombre
	FROM rinde r join alumno a on r.alumno = a.legajo
	GROUP BY a.legajo, a.nombre 
	having count (r.materia) = (select count (*) from materia)
) AS vista1

-- SI ACTUALIZO LA INFO DE LAS TABLAS, SE VE REFLEJADO EN LAS VISTAS
update Alumno 
set 
nombre = 'Juana'
where nombre = 'Juan'

-- QUE PASA SI MODIFICO LA INFORMACI�N AGREGANDO MAS VALORES EN RINDE? 
INSERT INTO Rinde VALUES ('A2', 'M2') , ('A2', 'M3') 

SELECT * FROM vista1;

-- EQUIVALENTE A
SELECT * 
FROM 
(
	SELECT a.nombre
	FROM rinde r join alumno a on r.alumno = a.legajo
	GROUP BY a.legajo, a.nombre 
	having count (r.materia) = (select count (*) from materia)
) AS VISTA1

-- BORRADO
DROP VIEW vista1;
 
---- Funciones de usuario: Las funciones son un conjunto de codigo que 
---- retornan valores. 
--   Pueden ser 1 escalar, o una tabla

-- devolviendo escalar.

CREATE FUNCTION dbo.miFuncion (@param INT)
RETURNS int
AS 
	BEGIN
	RETURN @param * 2
	END;

	--NOTAS: SE CREA UNA FUNCION Que recibe un parametro entero, que ademas, retorna otro entero.
	-- luego, con las palabras reservadas BEGIN/END generamos un grupo sin nombre de codigo


-- ejecucion de prueba de la funcion
SELECT dbo.miFuncion(2), dbo.miFuncion(3), dbo.miFuncion(20)

SELECT alumno, count(materia) [cant materias], dbo.miFuncion(count(materia)) [cant materias por dos]
FROM rinde
group by alumno

-- devolviendo tabla
CREATE FUNCTION dbo.miFuncionTabla (@param INT)
RETURNS TABLE
AS
	RETURN
		(
			SELECT power(CAMPO1, @param) as id, campo2
			FROM tablaUno
		);
--NOTA: Como se ve, hacemos un RETURN en linea, no hace falta usar un BEGIN/END

-- ejecucion de prueba de la funcion
SELECT * FROM dbo.miFuncionTabla(2);
SELECT * FROM dbo.miFuncionTabla(3);
SELECT * FROM dbo.miFuncionTabla(4);

-- para borrar una funcion:
DROP FUNCTION dbo.miFuncionTabla;

----Procedimientos almacenados
-- UN Prodicimento es un conjunto de operaciones que se deben ejecutar de forma reiterativa. 

CREATE PROCEDURE borra(@legajo varchar(2))
AS

	DELETE FROM rinde WHERE alumno = @legajo;
	DELETE FROM alumno WHERE legajo = @legajo;


-- ejecutar procedimiento: 
DELETE FROM Alumno WHERE legajo = 'A3'

EXEC borra 'a3';

select * from Alumno;

 ----------- triggers: SON ESTRUCTURAS DE CODIGO QUE SE "DISPARAN" CUANDO OCURRE UN EVENTO. 
 -- POR EJEMPLO, INSERT, DELETE, UPDATE DE UNA TABLA

 
CREATE TABLE Cliente 
(
NroCli INT  not null,
NomCli  VARCHAR(20), 
CiudadCli VARCHAR(20)
CONSTRAINT PK_Cliente PRIMARY KEY (NroCli)
)


INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (1,'Cli1','Laferrere')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (2,'Cli2','Laferrere')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (3,'Cli3','San Justo')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (4,'Cli4','Ramos Mejia')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (5,'Cli5','Gonzalez Catan')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (6,'Cli6','San Justo')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (7,'Cli7','Ramos Mejia')

CREATE TABLE Cliente_historico
(
NroCli INT  not null,
NomCli  VARCHAR(20), 
CiudadCli VARCHAR(20),
FechaCambio DATETIME NOT NULL,
Usuario VARCHAR(20),
accion VARCHAR(20),
CONSTRAINT PK_ClienteHistorico PRIMARY KEY (NroCli, FechaCambio)
)

SELECT * FROM Cliente_historico

-- CREAR UN TRIGGER SOBRE CLIENTES, PARA LAS ACCIONES DE BORRADO Y MODIFICACION. ESTE TRIGGER DEBE
--    GUARDAR EN LA TABLA DE HISTORIAL DE CLIENTES EL VALOR PREVIO AL CAMBIO 

-- se ejecutara el trigger cuando SE HAGA UN DELETE O UN UPDATE en la tabla cliente
DELETE FROM Cliente WHERE NroCli  = 7
UPDATE Cliente set NomCli = '' WHERE NroCli = 6

-- CREACION DEL TRIGGER
CREATE TRIGGER tr_histClientes
ON CLIENTE
FOR UPDATE, DELETE
AS
	-- IMPORTANTE, LAS ESTRUCTURAS DEL DELETED E INSERTED 
	-- CUANDO SE INSERTA, TENGO LAS TUPLAS NUEVAS, EN INSERTED
	-- CUANDO SE BORRA, TENGO LAS TUPLAS BORRADAS EN DELETED
	-- CUANDO SE ACTUALIZA, TENGO LAS TUPLAS NUEVAS EN INSERTED Y LAS VIEJAS EN DELETED
	-- CUANDO SE ACTUALIZA TENGO LA INFO NUEVA EN INSERTED Y LA VIEJA EN DELETED
	-- EN OTROS MOTORES, SE LLAMAN NEW|OLD.

	IF EXISTS (SELECT * FROM INSERTED) -->> ES UN UPDATE 
		INSERT INTO Cliente_HISTORICO  (NROCLI, [NomCli], [CiudadCli], FechaCambio, accion)
		SELECT *, GETDATE(), 'UPDATE'
		FROM DELETED
	ELSE
		INSERT INTO Cliente_HISTORICO  (NROCLI, [NomCli], [CiudadCli], FechaCambio, accion)
		SELECT *, GETDATE(), 'DELETE'
		FROM DELETED
	
-- PRUEBA DEL TRIGGER

UPDATE Cliente
SET 
CIUDADcLI = 'san rafael'
WHERE NroCli = 6

SELECT * FROM Cliente WHERE NroCli = 6
SELECT * FROM Cliente_HISTORICO WHERE NroCli = 6

DELETE FROM cliente where nrocli = 5

SELECT * FROM Cliente WHERE NroCli = 5
SELECT * FROM Cliente_HISTORICO WHERE NroCli = 5

UPDATE Cliente
SET 
CIUDADcLI = 'TARTAGAL'
WHERE NroCli = 6

SELECT * FROM Cliente WHERE NroCli = 6
SELECT * FROM Cliente_HISTORICO WHERE NroCli = 6
