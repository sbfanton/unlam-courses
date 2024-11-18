use EJERCICIO_4

/* a. Encontrar el nombre de todas las personas que 
trabajan en la empresa “Banelco”. */

select t.nomPersona from Trabaja t 
where LOWER(t.nomEmpresa) = 'banelco' 
and t.feEgreso is null


/*b. Localizar el nombre y la ciudad de todas las personas que trabajan para la
empresa “Telecom”.*/
select t.nomPersona from Trabaja t 
where LOWER(t.nomEmpresa) = 'telecom' 
and t.feEgreso is null

select distinct
v.nomPersona, 
v.ciudad
from Vive v 
join Trabaja t on v.nomPersona = t.nomPersona 
where LOWER(t.nomEmpresa) = 'telecom'
and t.feEgreso is null

/*c. Buscar el nombre, calle y ciudad de todas las personas que trabajan para la
empresa “Paulinas” y ganan más de $50000.*/
select distinct
v.nomPersona, 
v.calle,
v.ciudad
from Vive v 
join Trabaja t on v.nomPersona = t.nomPersona 
where LOWER(t.nomEmpresa) = 'paulinas' 
and t.salario > 50000 
and t.feEgreso is null


/* d. Encontrar las personas que viven en la misma ciudad en la que se halla la
empresa en donde trabajan.*/
select * from Situada_En

select distinct
v.nomPersona,
v.ciudad as ciudad_persona,
t.nomEmpresa,
s.ciudad as ciudad_empresa
from Vive v 
join Trabaja t on v.nomPersona = t.nomPersona 
join Situada_En s on v.ciudad = s.ciudad and t.nomEmpresa = s.nomEmpresa
order by v.nomPersona


/* e. Hallar todas las personas que viven en la misma ciudad y en la misma calle que
su supervisor. */
select distinct
v.nomPersona,
v.ciudad as ciudad_persona,
s.nomSupervisor,
v2.ciudad as ciudad_supervisor
from Vive v 
join Supervisa s on v.nomPersona = s.nomPersona 
join Vive v2 on v2.nomPersona = s.nomSupervisor 
and v2.ciudad = v.ciudad 
and v2.calle = v.calle
order by v.nomPersona


SELECT *
FROM [dbo].[Vive] V1
JOIN [dbo].[Supervisa] S
ON V1.nomPersona=S.nomSupervisor
JOIN [dbo].[Vive] V2
ON V2.nomPersona=S.nomPersona
WHERE V1.calle=V2.calle AND V1.ciudad=V2.ciudad


/*f. Encontrar todas las personas que ganan más que cualquier empleado de la
empresa “Clarín”.*/
select max(t.salario) from Trabaja t 
where LOWER(t.nomEmpresa) = 'clarin' 
and t.feEgreso is null

select distinct 
t.nomPersona
from Trabaja t 
where t.salario > (
	select max(t.salario) from Trabaja t 
	where LOWER(t.nomEmpresa) = 'clarin'
) 
and t.feEgreso is null

/* g. Localizar las ciudades en las que todos los trabajadores que vienen en ellas
ganan más de $10000. */
select distinct v.ciudad from Vive v 
where v.ciudad in (
	select distinct 
	ve.ciudad
	from Vive ve 
	join Trabaja t on t.nomPersona = ve.nomPersona
	where t.salario > 10000
	and t.feEgreso is null
)


/* h. Listar los primeros empleados que la compañía “Sony” contrató. */
select min(t.feIngreso) 
from Trabaja t 
where t.nomEmpresa = 'Sony'

select * from Trabaja T 
where t.feIngreso = (
	select min(t.feIngreso) from Trabaja t 
	where t.nomEmpresa = 'Sony'
)
and t.nomEmpresa = 'Sony'


/* i. Listar los empleados que hayan ingresado en mas de 4 Empresas en el periodo
01-01-2000 y 31-03-2004 y que no hayan tenido menos de 5 supervisores */


--los empleados que hayan ingresado en mas de 4 Empresas en el periodo 01-01-2000 y 31-03-2004
select t.nomPersona from Trabaja t
where t.feIngreso between '2000-01-01' AND '2004-03-31' 
group by t.nomPersona 
having count(distinct t.nomEmpresa) > 4

-- los empleados que no hayan tenido menos de 5 supervisores
select s.nomPersona from Supervisa s 
group by s.nomPersona 
having count(distinct s.nomSupervisor) >= 5


-- juntamos todo:
select t.nomPersona from Trabaja t
where t.feIngreso between '2000-01-01' AND '2004-03-31' 
group by t.nomPersona 
having count(distinct t.nomEmpresa) > 4

intersect

select s.nomPersona from Supervisa s 
group by s.nomPersona 
having count(distinct s.nomSupervisor) >= 5