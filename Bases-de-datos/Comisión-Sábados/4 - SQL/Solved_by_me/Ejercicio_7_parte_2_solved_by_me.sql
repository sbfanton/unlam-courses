use EJERCICIO_7

/*1. Indique cuales son los autos con mayor cantidad de kilómetros realizados en el
último mes.*/

select v.matricula, sum(v.kmTotales) as kmTotales
from Viaje v 
WHERE year(v.fechaHoraInicio) = year(getdate()) 
  AND month(v.fechaHoraInicio) = month(getdate()) - 1
group by v.matricula


select max(vk.kmTotales) as kmTotales from (
	select v.matricula, sum(v.kmTotales) as kmTotales
	from Viaje v 
	WHERE year(v.fechaHoraInicio) = year(getdate()) 
	  AND month(v.fechaHoraInicio) = month(getdate()) - 1
	group by v.matricula
) as vk

select 
va.matricula, sum(va.kmTotales) as kmTotales
from Viaje va 
WHERE year(va.fechaHoraInicio) = year(getdate()) 
AND month(va.fechaHoraInicio) = month(getdate()) - 1
group by va.matricula 
having sum(va.kmTotales) = (
	select max(vk.kmTotales) as kmTotales from (
		select v.matricula, sum(v.kmTotales) as kmTotales
		from Viaje v 
		WHERE year(v.fechaHoraInicio) = year(getdate()) 
		  AND month(v.fechaHoraInicio) = month(getdate()) - 1
		group by v.matricula
	) as vk
)

/* 2. Indique los clientes que más viajes 
hayan realizado con el mismo chofer. */

with ViajesPorCliente as (
	select 
	v.nroCliente, 
	v.nroLicencia as chofer, 
	count(v.fechaHoraInicio) as cantidad_viajes
	from Viaje v 
	group by v.nroCliente, v.nroLicencia 
), 
MaxViajesChofer as (
	 SELECT 
        chofer, 
        MAX(cantidad_viajes) AS max_viajes
    FROM ViajesPorCliente
    GROUP BY chofer
)

SELECT 
    vpc.nroCliente, 
    vpc.chofer, 
    vpc.cantidad_viajes
FROM ViajesPorCliente vpc
JOIN MaxViajesChofer mv ON vpc.chofer = mv.chofer AND vpc.cantidad_viajes = mv.max_viajes
ORDER BY vpc.chofer, vpc.nroCliente;

/*
3. Indique el o los clientes con mayor cantidad de viajes en este año.
*/
-- viajes por cliente en año actual
select v.nroCliente, count(v.fechaHoraInicio) as cantidadViajes
from Viaje v 
where year(v.fechaHoraInicio) = year(getdate()) 
group by v.nroCliente

-- maximo viajes por cliente año actual
select max(cantidadViajes) as max_cant
from (
	select v.nroCliente, count(v.fechaHoraInicio) as cantidadViajes
	from Viaje v 
	where year(v.fechaHoraInicio) = year(getdate()) 
	group by v.nroCliente
) as ViajesClienteAnioActual 

-- cliente y cantidad de viajes maximo
select 
va.nroCliente,
count(va.fechaHoraInicio) as cantidadViajes
from Viaje va 
where year(va.fechaHoraInicio) = year(getdate()) 
group by va.nroCliente 
having count(va.fechaHoraInicio) = (
	select max(cantidadViajes)
	from (
		select v.nroCliente, count(v.fechaHoraInicio) as cantidadViajes
		from Viaje v 
		where year(v.fechaHoraInicio) = year(getdate()) 
		group by v.nroCliente
	) as ViajesClienteAnioActual 
)

/*
4. Obtenga nombre y apellido de los choferes que no manejaron todos los vehículos
que disponemos.
*/
select count(*) from Auto

select v.nroLicencia as chofer 
from Viaje v 
group by v.nroLicencia 
having count(distinct v.matricula) = (
	select count(*) from Auto
)


select 
ch.nroLicencia,
ch.nombre, 
ch.apellido
from Chofer ch 
where ch.nroLicencia not in (
	select v.nroLicencia as chofer 
	from Viaje v 
	group by v.nroLicencia 
	having count(distinct v.matricula) = (
		select count(*) from Auto
	)
)

/*
5. Obtenga el nombre y apellido de los clientes que hayan viajado en todos nuestros
autos.
*/
select v.nroCliente as cliente 
from Viaje v 
group by v.nroCliente 
having count(distinct v.matricula) = (
	select count(*) from Auto
)

select 
c.nroCliente, 
c.nombre,
c.apellido
from Cliente c 
where c.nroCliente in (
	select v.nroCliente
	from Viaje v 
	group by v.nroCliente 
	having count(distinct v.matricula) = (
		select count(*) from Auto
	)
)

/*
6. Queremos conocer el tiempo de espera promedio de los viajes de los últimos 2
meses
*/

select avg(v.esperaTotal) as promedioEsperaUltimosDosMeses
from Viaje v 
where month(v.fechaHoraInicio) <= month(getdate()) - 1
and month(v.fechaHoraInicio) >= month(getdate()) -2

-- otra opcion:
SELECT AVG(v.esperaTotal) AS promedioEsperaUltimosDosMeses
FROM Viaje v
WHERE v.fechaHoraInicio >= DATEADD(MONTH, -2, GETDATE())
  AND v.fechaHoraInicio < DATEADD(MONTH, 0, GETDATE());

/*
7. Indique los kilómetros realizados en viajes por cada auto.
*/

select 
v.matricula as auto, 
sum(v.kmTotales) as kmTotales
from Viaje v 
group by v.matricula

/*
8. Indique el costo promedio de los viajes realizados por cada auto.
*/
select 
v.matricula as auto, 
avg(v.costoKms + v.costoEspera) as promedioCosto
from Viaje v 
group by v.matricula


/*
9. Indique el costo total de los viajes realizados por cada chofer en el último mes.
*/

select 
v.nroLicencia as chofer, 
sum(v.costoEspera + v.costoKms) as costoTotal
from Viaje v 
where v.fechaHoraInicio < getdate() and
v.fechaHoraInicio >= dateadd(month, -1, getdate())
group by v.nroLicencia

/*
10. Indique la fecha inicial, el chofer y el cliente que hayan realizado el viaje más largo
de este año.
*/

select datediff(minute, v.fechaHoraInicio, v.fechaHoraFin) as tiempoTotal
from Viaje v 
where year(v.fechaHoraInicio) = year(GETDATE())

select max(tiempoTotal) from (
	select datediff(minute, v.fechaHoraInicio, v.fechaHoraFin) as tiempoTotal
	from Viaje v 
	where year(v.fechaHoraInicio) = year(GETDATE())
) as ViajeMasLargoAnioActual

select 
va.fechaHoraInicio,
va.nroLicencia,
va.nroCliente
from Viaje va 
where year(va.fechaHoraInicio) = year(GETDATE()) 
and datediff(minute, va.fechaHoraInicio, va.fechaHoraFin) = (
	select max(tiempoTotal) from (
		select datediff(minute, v.fechaHoraInicio, v.fechaHoraFin) as tiempoTotal
		from Viaje v 
		where year(v.fechaHoraInicio) = year(GETDATE())
	) as ViajeMasLargoAnioActual
)