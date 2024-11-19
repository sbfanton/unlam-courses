use EJERCICIO_2;

-- 0. SETEO DE DB
USE EJERCICIO_2
GO
/*
Proveedor (NroProv, NomProv, Categoria, CiudadProv)
Artículo  (NroArt, Descripción, CiudadArt, Precio)
Cliente   (NroCli, NomCli, CiudadCli)
Pedido    (NroPed, NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal)
Stock     (NroArt, fecha, cantidad)
*/
--0. Liste todos los proveedores
select * from Proveedor

--0.1. Liste los proveedores de la ciudad San Justo
select * from Proveedor p 
where p.CiudadProv = 'san justo'

--0.2. Liste los proveedores de Laferrere y de categoria 'cat2'
select * from Proveedor p 
where p.CiudadProv = 'laferrere' 
and p.Categoria = 2

--0.3. Liste los proveedores de San Justo o de categoria 'cat4'
select * from Proveedor p 
where p.CiudadProv = 'san justo' 
or p.Categoria = 4

--1.	Hallar el código (nroProv) de los proveedores que proveen el artículo a146.
select distinct
p.NroProv 
from Pedido p 
join Articulo a on a.NroArt = p.NroArt 
where a.Descripcion = 'a146'

--2.	Hallar los clientes (nomCli) que solicitan artículos provistos por p015.
select distinct
c.NomCli
from Cliente c
join Pedido p on c.NroCli = p.NroCli 
join Proveedor pr on p.NroProv = pr.NroProv 
where pr.NomProv = 'p015'

--3.	Hallar los clientes que solicitan algún item provisto por proveedores 
--      con categoría mayor que 4.
select distinct 
c.NroCli,
c.NomCli
from Cliente c 
join Pedido p on c.NroCli = p.NroCli 
join Proveedor pr on pr.NroProv = p.NroProv 
where pr.Categoria > 4

--4.	Hallar los pedidos en los que un cliente de Rosario solicita artículos 
--      producidos en la ciudad de Mendoza.
select 
p.*
from Pedido p 
join Cliente c on p.NroCli = c.NroCli 
join Articulo a on a.NroArt = p.NroArt
where c.CiudadCli = 'Rosario' 
and a.CiudadArt = 'Mendoza'

--5.	Hallar los pedidos en los que el cliente c23 solicita artículos solicitados 
--      por el cliente c30.
-- articulos solicitados por c30
select distinct
p.NroArt --, c.NomCli
from Pedido p 
join Cliente c on p.NroCli = c.NroCli 
where c.NomCli = 'c30'


select 
p.*
from Pedido p 
join Cliente c on p.NroCli = c.NroCli 
where c.NomCli = 'c23' 
and p.NroArt in (
	select distinct
	pe.NroArt
	from Pedido pe 
	join Cliente cl on pe.NroCli = cl.NroCli 
	where cl.NomCli = 'c30'
)


--6.0  Hallar los proveedores que suministran todos los artículos
--ayuda:
--1ro contar articulos
--2do contar cuantos art provee cada prov.
-- usar ambas queries

-- total articulos
select count(*) from Articulo

select 
p.NroProv,
pr.NomProv,
count(distinct p.NroArt) as cant_art
from Pedido p 
join Proveedor pr on pr.NroProv = p.NroProv 
group by p.NroProv, pr.NomProv
having count(distinct p.NroArt) = (
	select count(*) from Articulo
)


--6.1 Hallar los proveedores que suministran todos los artículos cuyo precio es superior 
--      al precio promedio de todos los art.
select avg(a.Precio) from Articulo a

select 
ar.NroArt
from Articulo ar 
where ar.Precio > (
	select avg(a.Precio) from Articulo a
)

/*select * from Proveedor p, Articulo a*/

-- producto cartesiano entre Proveedor y articulos de precio mayor al promedio:
SELECT p.NroProv, a.NroArt
	FROM Proveedor p, 
	(
		SELECT *
		FROM Articulo 
		WHERE PRECIO > (SELECT AVG(PRECIO) FROM Articulo)
	) AS a


-- se quita de esa combinacion los proveedores y articulos registrados, con lo cual nos quedariamos solo con los que no cumplen con proveer todos esos articulos
SELECT p.NroProv, a.NroArt
FROM Proveedor p, 
	(
		SELECT *
		FROM Articulo 
		WHERE PRECIO > (SELECT AVG(PRECIO) FROM Articulo)
	) AS a
EXCEPT 
SELECT pe.NroProv, pe.NroArt
FROM Pedido pe

-- esos que no cumplen, los quito de la lista de proveedores para quedarme solo con los que cumplen
select 
pr.NroProv
from Proveedor pr 
except 
select NoCumplen.NroProv  from (
	SELECT p.NroProv, a.NroArt
	FROM Proveedor p, 
		(
			SELECT *
			FROM Articulo 
			WHERE PRECIO > (SELECT AVG(PRECIO) FROM Articulo)
		) AS a
	EXCEPT 
	SELECT pe.NroProv, pe.NroArt
	FROM Pedido pe
) as NoCumplen


-- QUE CAMBIA RESPECTO DE LA QUERY 6.0? QUE EL TODOS, AHORA ES UN CONJUNTO MENOR

--6.2	Hallar los proveedores que suministran todos los artículos cuyo precio es superior 
--      al precio promedio de los artículos que se producen en La Plata.

-- AYUDA: 1ro art precio superior al promedio y producios en la plata
-- luego hago el cociente

-- este ejercicio es similar al anterior

-- precio promedi articulos de la plata
select avg(a.Precio) as promedio_precio_la_plata
from Articulo a 
where a.CiudadArt = 'La Plata'

-- articulos cuyo precio es superior a ese promedio
select a.NroArt from Articulo a 
where a.Precio > (
	select avg(a.Precio) as promedio_precio_la_plata
	from Articulo a 
	where a.CiudadArt = 'La Plata'
)


select pr.NroProv, art_sup.NroArt 
from Proveedor pr, (
	select a.NroArt from Articulo a 
	where a.Precio > (
		select avg(a.Precio) as promedio_precio_la_plata
		from Articulo a 
		where a.CiudadArt = 'La Plata'
	)
) as art_sup


select pr.NroProv, art_sup.NroArt 
from Proveedor pr, (
	select a.NroArt from Articulo a 
	where a.Precio > (
		select avg(a.Precio) as promedio_precio_la_plata
		from Articulo a 
		where a.CiudadArt = 'La Plata'
	)
) as art_sup
except
select pe.NroProv, pe.NroArt from Pedido pe


select prov.NroProv 
from Proveedor prov
except 
select NoCumplen.NroProv from (
	select pr.NroProv, art_sup.NroArt 
	from Proveedor pr, (
		select a.NroArt from Articulo a 
		where a.Precio > (
			select avg(a.Precio) as promedio_precio_la_plata
			from Articulo a 
			where a.CiudadArt = 'La Plata'
		)
	) as art_sup
	except
	select pe.NroProv, pe.NroArt from Pedido pe
) as NoCumplen



--7.	Hallar la cantidad de artículos diferentes provistos por cada proveedor que provee a todos los clientes de Junín.
-- clientes de Junin
select count(c.NroCli) from Cliente c where c.CiudadCli = 'Junin'

select 
pe.NroProv,
count(distinct pe.NroArt) as cant_art
from Pedido pe 
join Cliente c on c.NroCli = pe.NroCli 
where c.CiudadCli = 'Junin' 
group by pe.NroProv 
having count(distinct pe.NroCli) = (
	select count(c.NroCli) from Cliente c where c.CiudadCli = 'Junin'
)


--8.	Hallar los nombres de los proveedores cuya categoría sea mayor que la de todos los 
--      proveedores que proveen el artículo cuaderno.

--AYUDA:
-- LISTAR PROV CON LA CATEGORIA MAYOR
-- LISTAR PROVEE DE ART CUADERNO
-- LISTAR categoria de los prov de cuadernos
-- BUSCAR max categoria de los prov de cuadernos

-- nro articulo cuaderno
select a.NroArt from Articulo a where a.Descripcion = 'cuaderno'

-- proveedores que proveen cuaderno
select distinct pe.NroProv 
from Pedido pe 
where pe.NroArt = (
	select a.NroArt from Articulo a where a.Descripcion = 'cuaderno'
)

-- categoria maxima proveedores cuaderno
select max(pr.Categoria) as cat_max_cuad from Proveedor pr 
where pr.NroProv in (
	select distinct pe.NroProv 
	from Pedido pe 
	where pe.NroArt = (
		select a.NroArt from Articulo a where a.Descripcion = 'cuaderno'
	)
)

-- proveedores con categoria mayor a categoria maxima de proveedores de cuaderno
select prov.NomProv from Proveedor prov
where prov.Categoria > (
	select max(pr.Categoria) as cat_max_cuad from Proveedor pr 
	where pr.NroProv in (
		select distinct pe.NroProv 
		from Pedido pe 
		where pe.NroArt = (
			select a.NroArt from Articulo a where a.Descripcion like '%cuaderno%'
		)
	)
)


-- otra forma:
SELECT * 
FROM proveedor 
WHERE categoria >
		(
		SELECT MAX (pr.Categoria) [max Categoria De Prov De Cuadernos]
		FROM Articulo a 
		JOIN Pedido p ON a.NroArt = p.NroArt
		JOIN Proveedor pr ON p.NroProv = pr.NroProv
		WHERE Descripcion like '%cuaderno%' -- cuaderno tapa dura | cuaderno espiralado | nuevo cuaderno. Cordoba Córdoba 
		)
ORDER BY NomProv


--9.	Hallar los proveedores que han provisto más de 1000 unidades entre los artículos 1 y 2 .
select pe1.NroProv
from Pedido pe1 
where pe1.NroArt = 1 
intersect 
select pe2.NroProv
from Pedido pe2 
where pe2.NroArt = 2 

select pe.NroProv, sum(pe.Cantidad) as total_cant
from Pedido pe 
where pe.NroProv in (
	select pe1.NroProv
	from Pedido pe1 
	where pe1.NroArt = 1 
	intersect 
	select pe2.NroProv
	from Pedido pe2 
	where pe2.NroArt = 2 
) 
group by pe.NroProv 
having sum(pe.Cantidad) > 1000

	 
--10.	Listar la cantidad y el precio total de cada artículo que han pedido los Clientes 
--a sus proveedores entre las fechas 01-01-2004 y 31-03-2004
-- (se requiere visualizar Cliente, Articulo, Proveedor, Cantidad y Precio).
select * from Pedido pe 
where pe.FechaPedido between '2004-01-01' and '2004-03-31'

select 
pe.NroCli, 
pe.NroArt, 
pe.NroProv,
sum(pe.Cantidad) as cant_total,
sum(pe.PrecioTotal) as precio_total
from Pedido pe 
where pe.FechaPedido between '2004-01-01' and '2004-03-31' 
group by pe.NroCli, pe.NroArt, pe.NroProv


--11.	Idem anterior y que además la Cantidad sea mayor o igual a 1000 o el Precio sea mayor a $10000
select 
pe.NroCli, 
pe.NroArt, 
pe.NroProv,
sum(pe.Cantidad) as cant_total,
sum(pe.PrecioTotal) as precio_total
from Pedido pe 
where pe.FechaPedido between '2004-01-01' and '2004-03-31' 
group by pe.NroCli, pe.NroArt, pe.NroProv
having sum(pe.Cantidad) >= 1000 
or sum(pe.PrecioTotal) > 10000

--12.	Listar la descripción de los artículos en donde se hayan pedido en el día más del 
--      stock existente para ese mismo día.

select * 
from Pedido pe 
join Stock s on pe.FechaPedido = s.fecha and pe.NroArt = s.NroArt
where pe.Cantidad > s.cantidad


select distinct
a.NroArt, a.Descripcion
from Articulo a 
where a.NroArt in (
	select pe.NroArt 
	from Pedido pe 
	join Stock s on pe.FechaPedido = s.fecha and pe.NroArt = s.NroArt
	where pe.Cantidad > s.cantidad
)


--13.	Listar los datos de los proveedores que hayan pedido de todos los artículos. 
--      Verificar sólo en el último mes de pedidos.
-- ultimo mes de pedidos (mes anterior que ya paso)
select pe.NroProv, pe.NroArt from Pedido pe 
where datediff(month, pe.FechaPedido, getdate()) = 1
group by pe.NroProv, pe.NroArt

select 
pe.NroProv,
pr.NomProv, 
pr.Categoria, 
pr.CiudadProv
from Proveedor pr 
join Pedido pe on pr.NroProv = pe.NroProv 
where datediff(month, pe.FechaPedido, getdate()) = 1 
group by pe.NroProv, pr.NomProv, pr.Categoria, pr.CiudadProv
having count(distinct pe.NroArt) = (
	select count(*) from Articulo
)

--13.1 Listar los datos de los proveedores que hayan pedido de todos los artículos
select 
pe.NroProv,
pr.NomProv, 
pr.Categoria, 
pr.CiudadProv
from Proveedor pr 
join Pedido pe on pr.NroProv = pe.NroProv 
group by pe.NroProv, pr.NomProv, pr.Categoria, pr.CiudadProv
having count(distinct pe.NroArt) = (
	select count(*) from Articulo
)

--13.2 Listar los datos de los proveedores que hayan pedido de todos los artículos en un mismo día.
select pe.FechaPedido from Pedido pe 
group by pe.FechaPedido 
having count(distinct pe.NroArt) = (
	select count(*) from Articulo
)


select distinct 
pe.NroProv,
pr.NomProv
from Proveedor pr 
join Pedido pe on pr.NroProv = pe.NroProv 
where pe.FechaPedido in (
	select pe.FechaPedido from Pedido pe 
	group by pe.FechaPedido 
	having count(distinct pe.NroArt) = (
		select count(*) from Articulo
	)
)
group by pe.NroProv, pr.NomProv
having count(distinct pe.NroArt) = (
	select count(*) from Articulo
)

--14.	Listar los proveedores a los cuales no se les haya solicitado ningún artículo en el último mes, 
--      pero sí se les haya pedido en el mismo mes del año anterior.

-- TRABAJO CON FECHAS
SELECT GETDATE() [FECHA HOY], DATEADD(MONTH, -1, GETDATE()) [ UN MES PARA ATRAS], YEAR(GETDATE()) [Año], MONTH(GETDATE()) [MES], DAY(GETDATE()) [DIA]
-- FECHAS DEL AÑO PASADO
SELECT DATEADD(YEAR ,-1, DATEADD(MONTH, -1, GETDATE())) ,  DATEADD(YEAR, -1, GETDATE())
--datediff -- muestra diferencia entre dos fechas
--dateadd -- agregar o substrae respecto de una fecha. puedo agregarle a una fecha dada, X segundos o Y minutos, o Z dias, etc 
--getdate -- | now  retorna la fecha de hoy

-- prov que tuvieron pedidos durante el ultimo mes
select distinct
pe.NroProv 
from Pedido pe 
where month(pe.FechaPedido) = month(dateadd(month, -1, getdate())) 
and year(pe.FechaPedido) = year(getdate())

-- prov que NO tuvieron pedidos durante el ultimo mes
select distinct
pr.NroProv
from Proveedor pr

except 

select distinct
pe.NroProv 
from Pedido pe 
where month(pe.FechaPedido) = month(dateadd(month, -1, getdate())) 
and year(pe.FechaPedido) = year(getdate())

-- prov que SI tuvieron pedidos durante el ultimo mes, pero del año anterior
select distinct 
pe.NroProv
from Pedido pe 
where month(pe.FechaPedido) = month(dateadd(month, -1, getdate())) 
and year(pe.FechaPedido) = year(dateadd(year, -1, getdate()))

--Listar los proveedores a los cuales no se les haya solicitado ningún artículo en el último mes, pero sí se les haya pedido en el mismo mes del año anterior.
select distinct 
pe.NroProv
from Pedido pe 
where month(pe.FechaPedido) = month(dateadd(month, -1, getdate())) 
and year(pe.FechaPedido) = year(dateadd(year, -1, getdate()))

except

select distinct 
pe.NroProv
from Pedido pe 
where month(pe.FechaPedido) = month(dateadd(month, -1, getdate())) 
and year(pe.FechaPedido) = year(getdate())


--15.	Listar los nombres de los clientes que hayan solicitado más de un artículo cuyo precio sea superior a $100
--y que correspondan a proveedores de Capital Federal. Por ejemplo, se considerará si se ha solicitado el artículo a2 y a3, 
--pero no si solicitaron 5 unidades del articulo a2.
 
 select distinct
 c.NroCli, c.NomCli
 from Pedido pe 
 join Proveedor pr on pr.NroProv = pe.NroProv 
 join (
	 select pe.NroCli 
	 from Pedido pe 
	 join Articulo a on a.NroArt = pe.NroArt 
	 where a.Descripcion = 'a2' 
	 and pe.Cantidad > 1 
	 and pe.PrecioTotal > 100

	 intersect

	 select pe.NroCli
	 from Pedido pe 
	 join Articulo a on a.NroArt = pe.NroArt 
	 where a.Descripcion = 'a3' 
	 and pe.Cantidad > 1
	 and pe.PrecioTotal > 100

 ) as Cli on Cli.NroCli = pe.NroCli

 join Cliente c on c.NroCli = pe.NroCli
 where pr.CiudadProv = 'Capital Federal'