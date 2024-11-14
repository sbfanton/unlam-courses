USE EJ7;
GO

--  1. Indique cuales son los autos con mayor cantidad de kilómetros 
--     realizados en el último mes.

-- HINTS! PUEDEN USAR LA FUNCION DATEDIFF

select v.coche, SUM(v.kmTotales) km 
from Viaje v 
WHERE DATEDIFF (MONTH, FechaHoraInicio, GETDATE()) = 0 
group by v.coche
having sum(v.kmTotales) = (
	select max(km)
	from (
		select v.coche, SUM(v.kmTotales) km 
		from Viaje v 
		WHERE DATEDIFF (MONTH, FechaHoraInicio, GETDATE()) = 0 
		group by v.coche
	) as T
)

-- RESULTADO ESPERADO (CON LOS DATOS DADOS): COCHE AAA123, KM 86
--==============================================================================================

--  2. Indique los clientes que más viajes hayan realizado con el mismo chofer.
select v.cliente,  v.chofer, count(v.FechaHoraInicio) as viajes_realizados
from viaje v 
group by v.cliente, v.chofer

select 
v.cliente,  
v.chofer, 
count(v.FechaHoraInicio) as viajes_realizados
from viaje v 
group by v.cliente, v.chofer 
having count(v.FechaHoraInicio) = (
	select max(viajes_realizados) 
	from (
		select 
		v.cliente,  
		v.chofer, 
		count(v.FechaHoraInicio) as viajes_realizados
		from viaje v 
		group by v.cliente, v.chofer 
	) as T
)

-- RESULTADO ESPERADO (CON LOS DATOS DADOS): CLIENTE 1, CHOFER 1, VIAJES 7
--==============================================================================================

--  3. Indique el o los clientes con mayor cantidad de viajes en este año.
select v.cliente, count(*) viajes_realizados 
from Viaje v 
where YEAR(v.FechaHoraInicio) = YEAR(getdate()) 
group by v.cliente

select v.cliente 
from Viaje v 
where YEAR(v.FechaHoraInicio) = YEAR(getdate()) 
group by v.cliente 
having count(*) = (
	select max(viajes_realizados) from (
		select v.cliente, count(*) viajes_realizados 
		from Viaje v 
		where YEAR(v.FechaHoraInicio) = YEAR(getdate()) 
		group by v.cliente 
	) as T
)

-- RESULTADO ESPERADO (CON LOS DATOS DADOS): CLIENTE 1
--==============================================================================================


--  4. Obtenga nombre y apellido de los choferes que no manejaron todos 
--     los vehículos que disponemos.
select count(*) from coche

select v.chofer 
from viaje v 
group by v.chofer 
having count(distinct coche) = (select count(*) from coche)

-- usando not in
select 
c.nroLicencia,
c.nombre,
c.apellido
from chofer c 
where c.nroLicencia not in (
	select v.chofer 
	from viaje v 
	group by v.chofer 
	having count(distinct coche) = (select count(*) from coche)
)

-- usando except (resta)
select c.nroLicencia
from chofer c 

except 

select v.chofer 
from viaje v 
group by v.chofer 
having count(distinct coche) = (select count(*) from coche)

-- RESULTADO ESPERADO (CON LOS DATOS DADOS): NROLICENCIA 2, 3, 4
--==============================================================================================

--  5. Obtenga el nombre y apellido de los clientes que hayan viajado en 
--     todos nuestros autos.selectc.nombre,c.apellidofrom cliente c where c.nroCliente = (	select v.cliente	from viaje v 	group by v.cliente 	having count(distinct v.coche) = (select count(*) from coche))-- otra formaselect c.nombre,c.apellidofrom cliente c join viaje v on c.nroCliente = v.cliente group by c.nombre, c.apellidohaving count(distinct v.coche) = (select count(*) from coche)-- RESULTADO ESPERADO (CON LOS DATOS DADOS): NOMBRE DIEGO, APELLIDO BORATTO
--==============================================================================================
-- 6. Queremos conocer el tiempo de espera promedio de los viajes de los 
--    últimos 2 meses
-- viajes d elos ultimos dos meses:
select *, DATEDIFF(MONTH, FechaHoraInicio, GETDATE())
from viaje v 
where DATEDIFF(MONTH, FechaHoraInicio, GETDATE()) < 2

select avg(v.esperaTotal) as promedio_espera_ultimos_dos_meses 
from viaje v 
where DATEDIFF(MONTH, FechaHoraInicio, GETDATE()) < 2

-- RESULTADO ESPERADO (CON LOS DATOS DADOS): [PROM ESPERA TOTAL] 1
--==============================================================================================

-- 7. Indique los kilómetros realizados en viajes por cada auto.
select v.coche, sum(v.kmTotales)
from viaje v 
group by v.coche

-- RESULTADO ESPERADO (CON LOS DATOS DADOS): 
/*
COCHE   KM DEL AUTO
AA888BB	12
AAA123	86
AAA321	12
AS777AB	114
BBB123	12
CCC132	12
*/
--==============================================================================================

-- 8. Indique el costo promedio de los viajes realizados por cada auto.
select v.coche, avg(v.costoEspera + v.costoKms) as costo_promedio
from viaje v 
group by v.coche

-- RESULTADO ESPERADO (CON LOS DATOS DADOS): 
/*
COCHE   COSTO PROMEDIO
AA888BB	12000.00
AAA123	29000.00
AAA321	12000.00
AS777AB	29250.00
BBB123	12000.00
CCC132	12000.00
*/
--==============================================================================================

-- 9. Indique el costo total de los viajes realizados por cada chofer en el 
--    último mes.
select *, DATEDIFF(month, v.FechaHoraInicio, GETDATE())
from viaje v 
where DATEDIFF(month, v.FechaHoraInicio, GETDATE()) = 0

select v.chofer, sum(v.costoKms + v.costoEspera) as costo_total
from viaje v 
where DATEDIFF(month, v.FechaHoraInicio, GETDATE()) = 0 
group by v.chofer

-- RESULTADO ESPERADO (CON LOS DATOS DADOS): 
/*
CHOFER COSTO TOTAL
1	147000.00
2	70000.00
*/
--==============================================================================================

-- 10. Indique la fecha inicial, el chofer y el cliente que hayan realizado 
--     el viaje más largo de este año.select max(v.kmTotales) from viaje v where YEAR(v.FechaHoraInicio) = YEAR(GETDATE())--opcion 1 por kmsselect v.FechaHoraInicio, v.cliente,v.choferfrom viaje v where v.kmTotales = (	select max(v.kmTotales) 	from viaje v 	where YEAR(v.FechaHoraInicio) = YEAR(GETDATE()))--opcion 2 por horaselect max(datediff(MINUTE, v.FechaHoraInicio, v.FechaHoraFin)) from viaje v where YEAR(v.FechaHoraInicio) = YEAR(GETDATE())select v.FechaHoraInicio, v.cliente,c.nombre as nombre_cliente,c.apellido as apellido_cliente,v.chofer,ch.nombre as nombre_chofer,ch.apellido as nombre_choferfrom viaje v join cliente c on c.nroCliente = v.cliente join chofer ch on ch.nroLicencia = v.choferwhere datediff(MINUTE, v.FechaHoraInicio, v.FechaHoraFin) = (	select max(datediff(MINUTE, v.FechaHoraInicio, v.FechaHoraFin)) 	from viaje v 	where YEAR(v.FechaHoraInicio) = YEAR(GETDATE()))-- RESULTADO ESPERADO (CON LOS DATOS DADOS): 
/*
fechaHoraInicio	    Chofer	cliente
2024-11-08 18:30:00	1	    1
*/
--==============================================================================================

