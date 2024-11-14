use EJERCICIO_5

/*1. Listar los clientes que no hayan reportado 
préstamos del rubro “Policial”.*/

-- Obtenemos el codigo de rubro Policial
select r.CodRubro from Rubro r 
where r.NombRubro = 'Policial'

-- Obtenemos los clientes que han pedido prestamo de rubro Policial
select distinct
p.CodCli
from Prestamo p 
join Pelicula pel on p.CodPel = pel.CodPel 
where pel.CodRubro = (
	select r.CodRubro from Rubro r 
	where r.NombRubro = 'Policial'
)


select distinct
c.CodCli,
c.Nombre,
c.Apellido
from Cliente c 
join Prestamo p on c.CodCli = p.CodCli 
where p.CodCli not in (
	select distinct
	p.CodCli
	from Prestamo p 
	join Pelicula pel on p.CodPel = pel.CodPel 
	where pel.CodRubro = (
		select r.CodRubro from Rubro r 
		where r.NombRubro = 'Policial'
	)
)

-- otra forma:
select distinct
c.CodCli,
c.Nombre,
c.Apellido
from Cliente c 
join Prestamo p on c.CodCli = p.CodCli 
where p.CodCli not in (
	select distinct
	p.CodCli
	from Prestamo p 
	join Pelicula pel on p.CodPel = pel.CodPel 
	join Rubro r on pel.CodRubro = r.CodRubro
	where r.NombRubro = 'Policial'
)


/*
2. Listar las películas de mayor duración 
que alguna vez fueron prestadas.
*/

-- opcion 1: de las peliculas que fueron prestadas, veo las de mayor duracion

-- obtenemos las peliculas que fueron prestadas y su duracion
select distinct
p.CodPel,
p.Duracion
from Pelicula p 
join Prestamo pr on p.CodPel = pr.CodPel

-- obtenemos la duracion maxima
select max(Duracion) 
from (
	select distinct
	p.CodPel,
	p.Duracion
	from Pelicula p 
	join Prestamo pr on p.CodPel = pr.CodPel
) as P

-- obtenemos las peliculas con esa duracion:
select * from Pelicula p 
where p.Duracion = (
	select max(Duracion) 
	from (
		select distinct
		p.CodPel,
		p.Duracion
		from Pelicula p 
		join Prestamo pr on p.CodPel = pr.CodPel
	) as P
)


/*
3. Listar los clientes que tienen más de un préstamo sobre la misma película (listar
Cliente, Película y cantidad de préstamos).
*/

--listamos clientes con mas de un prestamo sobre la misma pelicula y cuantas veces pidio cada pelicula:
select 
p.CodCli,
p.CodPel,
count(*) as cant_prestamos
from Prestamo p 
group by p.CodCli, p.CodPel
having count(*) > 1

/*
- COUNT(*) cuenta todas las filas, incluidas las que tienen NULL en cualquier columna.
- COUNT(columna) solo cuenta las filas donde la columna especificada tiene valores no nulos.
*/

select 
c.CodCli,
c.Nombre,
c.Apellido,
p.CodPel,
p.Titulo,
Prest.cant_prestamos
from Cliente c 
join (
	select 
	p.CodCli,
	p.CodPel,
	count(*) as cant_prestamos
	from Prestamo p 
	group by p.CodCli, p.CodPel
	having count(*) > 1
) as Prest ON c.CodCli = Prest.CodCli 
join Pelicula p on p.CodPel = Prest.CodPel


/*
4. Listar los clientes que han realizado préstamos del título 
“Rey León” y “Terminador
*/

select distinct c.*
from Cliente c 
join Prestamo pr on c.CodCli = pr.CodCli 
join Pelicula p on p.CodPel = pr.CodPel 
where p.Titulo = 'Rey León'

intersect 

select distinct c.*
from Cliente c 
join Prestamo pr on c.CodCli = pr.CodCli 
join Pelicula p on p.CodPel = pr.CodPel 
where p.Titulo like '%Terminator%'


/*
5. Listar las películas más vistas en cada mes 
(Mes, Película, Cantidad de Alquileres).
*/
-- listamos por mes y por pelicula la cantidad de alquileres
select 
MONTH(pr.FechaPrest) as Mes,
pr.CodPel,
count(*) as Cantidad_alquileres
from Prestamo pr 
group by MONTH(pr.FechaPrest), pr.CodPel 


-- vemos el maximo de cada mes
select P.Mes, max(Cantidad_alquileres)  
from (
	select 
	MONTH(pr.FechaPrest) as Mes,
	pr.CodPel,
	count(*) as Cantidad_alquileres
	from Prestamo pr 
	group by MONTH(pr.FechaPrest), pr.CodPel 
) as P 
group by P.Mes


-- juntamos todo
SELECT 
MONTH(pr.FechaPrest) AS Mes,
pr.CodPel,
COUNT(*) AS Cantidad_alquileres
FROM Prestamo pr
GROUP BY MONTH(pr.FechaPrest), pr.CodPel
having COUNT(*) = (
    SELECT MAX(Cantidad_alquileres)
    FROM (
        SELECT 
        MONTH(pr2.FechaPrest) AS Mes,
        pr2.CodPel,
        COUNT(*) AS Cantidad_alquileres
        FROM Prestamo pr2
        GROUP BY MONTH(pr2.FechaPrest), pr2.CodPel
    ) AS InnerP
    WHERE InnerP.Mes = MONTH(pr.FechaPrest)
)
ORDER BY MONTH(pr.FechaPrest)

/*
6. Listar los clientes que hayan alquilado 
todas las películas del video.
*/

select count(*) from Pelicula

select pr.CodCli from
Prestamo pr 
group by pr.CodCli 
having count(distinct pr.CodPel) = (
	select count(*) from Pelicula
)

/*
7. Listar las películas que no han registrado 
ningún préstamo a la fecha.
*/

/*select p.CodPel, count(*) from Prestamo p group by p.CodPel
delete from Prestamo where CodPel = 12*/

-- forma 1:
select * from Pelicula p 
where p.CodPel not in (
	select pr.CodPel 
	from Prestamo pr 
	group by pr.CodPel
)

--forma 2
select * from Pelicula p 
where not exists (
	select 1 
	from Prestamo pr 
	where p.CodPel = pr.CodPel
)

/*
8. Listar los clientes que no han efectuado 
la devolución de ejemplares.
*/

select pr.CodCli from Prestamo pr 
where pr.FechaDev IS NULL 
group by pr.CodCli

-- forma 1:
select * from Cliente c 
where c.CodCli in (
	select pr.CodCli from Prestamo pr 
	where pr.FechaDev IS NULL 
	group by pr.CodCli
)

-- forma 2:
select * from Cliente c 
where exists (
	select 1 
	from Prestamo pr 
	where pr.FechaDev IS NULL 
	and pr.CodCli = c.CodCli
)

/*
9. Listar los títulos de las películas que tienen 
la mayor cantidad de préstamos.
*/

select pr.CodPel, count(*) as Cantidad_prestamos
from Prestamo pr 
group by pr.CodPel

select * 
from Pelicula p 
where p.CodPel in (
	select pr.CodPel
	from Prestamo pr 
	group by pr.CodPel 
	having count(*) = (
		select max(Cantidad_prestamos) from (
			select pr.CodPel, count(*) as Cantidad_prestamos
			from Prestamo pr 
			group by pr.CodPel
		) as T
	)
)

/*
10. Listar las películas que tienen todos 
los ejemplares prestados.
*/

select ej.CodPel
from Ejemplar ej 
group by ej.CodPel 
having count(*) = (
	select count(distinct pr.CodEj)
	from Prestamo pr 
	where pr.FechaDev IS NULL 
	and ej.CodPel = pr.CodPel
)