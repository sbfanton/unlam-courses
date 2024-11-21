create database ejercicio_13

use ejercicio_13

/*
Dado el siguiente esquema de relación:
Medición(fecha,hora,métrica,temperatura,presión,humedad,nivel)
Nivel (código, descripción)
*/

/*
1. p_CrearEntidades(): Realizar un procedimiento que permita crear las tablas
de nuestro modelo relacional.
*/

CREATE PROCEDURE p_CrearEntidades()
AS
BEGIN
    -- Crear la tabla 'Nivel' si no existe
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Nivel' AND schema_id = SCHEMA_ID('dbo'))
    BEGIN
        CREATE TABLE ejercicio_13.dbo.Nivel (
            codigo INT IDENTITY(1,1) PRIMARY KEY, 
            descripcion VARCHAR(50) NOT NULL
        );
        PRINT 'Tabla Nivel creada';
    END
    ELSE
    BEGIN
        PRINT 'La tabla Nivel ya existe';
    END

    -- Crear la tabla 'Medicion' si no existe
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Medicion' AND schema_id = SCHEMA_ID('dbo'))
    BEGIN
        CREATE TABLE ejercicio_13.dbo.Medicion (
            fecha DATE NOT NULL,
            hora TIME NOT NULL,
            metrica VARCHAR(20) NOT NULL,
            temperatura DECIMAL(15, 2) NOT NULL,
            presion DECIMAL(15, 2) NOT NULL,
            humedad DECIMAL(5, 2) NOT NULL,
            nivel INT NOT NULL,
            CONSTRAINT pk_medicion PRIMARY KEY (fecha, hora, metrica),
            CONSTRAINT fk_medicion FOREIGN KEY (nivel) REFERENCES ejercicio_13.dbo.Nivel(codigo)
        );
        PRINT 'Tabla Medicion creada';
    END
    ELSE
    BEGIN
        PRINT 'La tabla Medicion ya existe';
    END
END;

INSERT INTO ejercicio_13.dbo.Nivel (descripcion)
VALUES 
    ('Bajo'),
    ('Medio'),
    ('Alto');


-- Insertar datos para el 2024-11-21
INSERT INTO ejercicio_13.dbo.Medicion (fecha, hora, metrica, temperatura, presion, humedad, nivel)
VALUES 
    ('2024-11-21', '08:00:00', 'M1', 25.0, 1010.5, 55.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    ('2024-11-21', '08:15:00', 'M2', 24.5, 1012.3, 59.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    ('2024-11-21', '08:30:00', 'M3', 23.2, 1011.8, 63.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto')),
    ('2024-11-21', '09:00:00', 'M1', 26.1, 1013.0, 57.5, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    ('2024-11-21', '09:15:00', 'M2', 25.3, 1011.7, 60.2, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    ('2024-11-21', '09:30:00', 'M3', 24.1, 1012.2, 62.1, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto'));

-- Insertar datos para el 2024-11-22
INSERT INTO ejercicio_13.dbo.Medicion (fecha, hora, metrica, temperatura, presion, humedad, nivel)
VALUES 
    ('2024-11-22', '08:00:00', 'M1', 22.3, 1011.1, 60.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    ('2024-11-22', '08:15:00', 'M2', 23.5, 1010.9, 62.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    ('2024-11-22', '08:30:00', 'M3', 22.0, 1011.3, 65.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto')),
    ('2024-11-22', '09:00:00', 'M1', 23.7, 1013.2, 58.5, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    ('2024-11-22', '09:15:00', 'M2', 22.8, 1010.6, 60.8, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    ('2024-11-22', '09:30:00', 'M3', 21.5, 1012.0, 63.2, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto'));

-- Insertar datos para el 2024-11-23
INSERT INTO ejercicio_13.dbo.Medicion (fecha, hora, metrica, temperatura, presion, humedad, nivel)
VALUES 
    ('2024-11-23', '08:00:00', 'M1', 24.3, 1011.5, 58.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    ('2024-11-23', '08:15:00', 'M2', 25.1, 1012.8, 60.1, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    ('2024-11-23', '08:30:00', 'M3', 23.7, 1011.9, 62.8, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto')),
    ('2024-11-23', '09:00:00', 'M1', 25.0, 1012.5, 56.3, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    ('2024-11-23', '09:15:00', 'M2', 24.6, 1010.4, 59.4, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    ('2024-11-23', '09:30:00', 'M3', 23.3, 1011.2, 61.2, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto'));

-- Insertar datos para el 2024-11-24
INSERT INTO ejercicio_13.dbo.Medicion (fecha, hora, metrica, temperatura, presion, humedad, nivel)
VALUES 
    ('2024-11-24', '08:00:00', 'M1', 22.1, 1010.7, 61.5, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    ('2024-11-24', '08:15:00', 'M2', 23.0, 1012.0, 63.5, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    ('2024-11-24', '08:30:00', 'M3', 21.8, 1011.4, 64.8, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto')),
    ('2024-11-24', '09:00:00', 'M1', 22.4, 1013.3, 60.2, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    ('2024-11-24', '09:15:00', 'M2', 21.9, 1010.8, 62.3, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    ('2024-11-24', '09:30:00', 'M3', 21.6, 1011.0, 63.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto'));


	-- Insertar datos de mediciones con fecha de hace un mes (2024-10-21)
INSERT INTO ejercicio_13.dbo.Medicion (fecha, hora, metrica, temperatura, presion, humedad, nivel)
VALUES 
    (DATEADD(MONTH, -1, GETDATE()), '08:00:00', 'M1', 23.5, 1012.4, 60.5, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    (DATEADD(MONTH, -1, GETDATE()), '08:15:00', 'M2', 22.5, 1010.3, 58.3, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    (DATEADD(MONTH, -1, GETDATE()), '08:30:00', 'M3', 21.0, 1011.2, 65.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto')),
    (DATEADD(MONTH, -1, GETDATE()), '09:00:00', 'M1', 24.1, 1013.1, 59.4, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    (DATEADD(MONTH, -1, GETDATE()), '09:15:00', 'M2', 23.0, 1010.8, 61.7, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    (DATEADD(MONTH, -1, GETDATE()), '09:30:00', 'M3', 22.2, 1012.5, 63.3, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto'));

-- Insertar datos de mediciones para otro día de hace un mes atrás (2024-10-22)
INSERT INTO ejercicio_13.dbo.Medicion (fecha, hora, metrica, temperatura, presion, humedad, nivel)
VALUES 
    (DATEADD(MONTH, -2, GETDATE()), '08:00:00', 'M1', 25.0, 1010.5, 55.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    (DATEADD(MONTH, -2, GETDATE()), '08:15:00', 'M2', 24.5, 1012.3, 59.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    (DATEADD(MONTH, -2, GETDATE()), '08:30:00', 'M3', 23.2, 1011.8, 63.0, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto')),
    (DATEADD(MONTH, -2, GETDATE()), '09:00:00', 'M1', 26.1, 1013.0, 57.5, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Bajo')),
    (DATEADD(MONTH, -2, GETDATE()), '09:15:00', 'M2', 25.3, 1011.7, 60.2, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Medio')),
    (DATEADD(MONTH, -2, GETDATE()), '09:30:00', 'M3', 24.1, 1012.2, 62.1, (SELECT codigo FROM ejercicio_13.dbo.Nivel WHERE descripcion = 'Alto'));


/*
2. f_ultimamedicion(Métrica): Realizar una función que devuelva la fecha y hora
de la última medición realizada en una métrica específica, la cual será enviada
por parámetro. La sintaxis de la función deberá respetar lo siguiente:
Fecha/hora = f_ultimamedicion(vMetrica char(5))
Ejemplificar el uso de la función.
*/

create function f_ultimamedicion(@metrica varchar(20))
returns table 
as
return (
	select max(m.fecha) as ult_fecha, max(m.hora) as ult_hora from Medicion m 
	where m.metrica = @metrica
)

--otra creada por mi:
create function f_promedioTempUltimaSemana()
returns decimal
as
begin
	declare @promedioTemp decimal(15,2)

	select @promedioTemp = avg(m.temperatura) 
	from Medicion m 
	where m.fecha >= getdate() - 7

	return @promedioTemp
end

select * from dbo.f_ultimamedicion('M1')
select dbo.f_promedioTempUltimaSemana() as promedio

/*
3. v_Listado: Realizar una vista que permita listar las métricas en las cuales se
hayan realizado, en la última semana, mediciones para todos los niveles
existentes. El resultado del listado deberá mostrar, el nombre de la métrica que
respete la condición enunciada, el máximo nivel de temperatura de la última
semana y la cantidad de mediciones realizadas también en la última semana.
*/

select 
m.metrica,
max(m.temperatura) as maxima_temp,
count(*) as cant_mediciones_ult_semana
from Medicion m 
where m.fecha >= getdate() - 7
group by m.metrica 
having count(distinct m.nivel) = (select count(*) from Nivel)

create view v_Listado
as
	select 
	m.metrica,
	max(m.temperatura) as maxima_temp,
	count(*) as cant_mediciones_ult_semana
	from Medicion m 
	where m.fecha >= getdate() - 7
	group by m.metrica 
	having count(distinct m.nivel) = (select count(*) from Nivel)

select * from v_Listado

/*
4. p_ListaAcumulados(finicio,ffin): Realizar un procedimiento que permita
generar una tabla de acumulados diarios de temperatura por cada métrica y
por cada día. El procedimiento deberá admitir como parámetro el rango de
fechas que mostrará el reporte. Además, estas fechas deben ser validadas.
El informe se deberá visualizar de la siguiente forma:
*/

create procedure p_ListaAcumulados(@finicio date, @ffin date)
as 
begin
SELECT 
    m.fecha, 
    m.metrica,
    -- Acumulado de temperatura por fecha
    (SELECT SUM(m2.temperatura)
     FROM Medicion m2
     WHERE m2.fecha = m.fecha
     AND m2.metrica = m.metrica) AS temperatura_acumulada_por_fecha,
    -- Acumulado de temperatura por métrica
    (SELECT SUM(m2.temperatura)
     FROM Medicion m2
     WHERE m2.metrica = m.metrica
     AND m2.fecha BETWEEN @finicio AND @ffin) AS temperatura_acumulada_por_metrica
FROM 
    Medicion m
WHERE 
    m.fecha BETWEEN @finicio AND @ffin
GROUP BY 
    m.fecha, m.metrica
ORDER BY 
    m.fecha, m.metrica;
end

exec dbo.p_ListaAcumulados '2024-11-01', '2024-11-30'

/*
6. p_depuraMedicion(días): Realizar un procedimiento que depure la tabla de
mediciones, dejando sólo las últimas mediciones. El resto de las mediciones,
no deben ser borradas sino trasladadas a otra entidad que llamaremos
Medicion_Hist. El proceso deberá tener como parámetro la cantidad de días de
retención de las mediciones.
*/

CREATE TABLE ejercicio_13.dbo.Medicion_Hist (
            fecha DATE NOT NULL,
            hora TIME NOT NULL,
            metrica VARCHAR(20) NOT NULL,
            temperatura DECIMAL(15, 2) NOT NULL,
            presion DECIMAL(15, 2) NOT NULL,
            humedad DECIMAL(5, 2) NOT NULL,
            nivel INT NOT NULL,
            CONSTRAINT pk_medicion_hist PRIMARY KEY (fecha, hora, metrica),
            CONSTRAINT fk_medicion_hist FOREIGN KEY (nivel) REFERENCES ejercicio_13.dbo.Nivel(codigo)
        );


create procedure p_depuraMedicion(@dias int)
as
begin
	insert into Medicion_Hist 
	select * from Medicion m 
	where m.fecha <= getdate() - @dias

	delete from Medicion 
	where fecha <= getdate() - @dias
end

exec dbo.p_depuraMedicion 50

/*
7. tg_descNivel: Realizar un trigger que coloque la descripción en mayúscula
cada vez que se inserte un nuevo nivel.
*/

create trigger tg_descNivel
on Nivel
after insert, update 
as
begin
	UPDATE Nivel
	Set descripcion = upper(descripcion)
	Where codigo in (Select codigo from inserted)
end

insert into Nivel values('Super Alto')
