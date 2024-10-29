use EJERCICIO_1;

-- 1. Listar los nombres de los proveedores de la ciudad de La Plata.
select p.Nombre from Proveedor p 
where Ciudad = 'La Plata';

-- 2. Listar los números de artículos cuyo precio sea inferior a $10.
select a.CodArt from Articulo a 
where a.Precio < 10;

-- 3. Listar los responsables de los almacenes
select a.Responsable from Almacen a;

--4. Listar los códigos de los materiales que provea el proveedor 3 y no los provea el proveedor 5.
select pr.CodMat from Provisto_por pr 
where pr.CodProv = 3 and pr.CodMat not in (
	select CodMat from Provisto_por 
	where CodProv = 5
)

-- 5. Listar los números de almacenes que almacenan el artículo 1.
select t.Nro from Tiene t
where t.CodArt = 1

-- 6. Listar los proveedores de Pergamino que se llamen Pérez.
select * from Proveedor pr
where pr.Ciudad = 'Pergamino' 
and pr.Nombre like '%Perez%'

-- 7. Listar los almacenes que contienen los artículos 1 y los artículos 2 (ambos).
select a.Nro, a.Responsable
from Almacen a 
join Tiene t on a.Nro = t.Nro 
where t.CodArt in (1,2)
group by a.Nro, a.Responsable
having count(distinct t.CodArt) = 2

-- 8. Listar los artículos que cuesten más de $100 o que estén compuestos por el material 1.
select a.CodArt, a.Descripcion, a.Precio 
from Articulo a 
join Compuesto_por c 
on a.CodArt = c.CodArt
where a.Precio > 100 
or c.CodMat = 1

-- 9. Listar los materiales, código y descripción, provistos por proveedores de la ciudad
-- de Rosario.
select distinct m.CodMat, m.Descripcion 
from Material m 
join Provisto_por p 
on m.CodMat = p.CodMat 
where p.CodProv in (
	select pr.CodProv from Proveedor pr
	where pr.Ciudad = 'Rosario'
)

-- 10. Listar el código, descripción y precio de los artículos que se almacenan en A1.
select a.CodArt, a.Descripcion, a.Precio
from Articulo a 
join Tiene t 
on a.CodArt = t.CodArt 
where t.Nro = 1

-- 11. Listar la descripción de los materiales que componen el artículo B.
select m.Descripcion
from Material m 
join Compuesto_por c 
on m.CodMat = c.CodMat 
where c.CodArt = 2

-- 12. Listar los nombres de los proveedores que proveen los materiales al almacén que
-- Martín Gómez tiene a su cargo.
select distinct p.CodProv, p.Nombre 
from Proveedor p 
join Provisto_por pr on p.CodProv = pr.CodProv 
join Compuesto_por c on pr.CodMat = c.CodMat 
join Tiene t on c.CodArt = t.CodArt 
join Almacen a on t.Nro = a.Nro 
where a.Responsable = 'Martin Gomez'

-- 13. Listar códigos y descripciones de los artículos compuestos por al menos un
-- material provisto por el proveedor López.
select distinct a.CodArt, a.Descripcion 
from Articulo a 
join Compuesto_por c on a.CodArt = c.CodMat 
join Provisto_por p on c.CodMat = p.CodMat 
join Proveedor pr on p.CodProv = pr.CodProv
where pr.Nombre like '%Lopez%'

-- 14. Hallar los códigos y nombres de los proveedores que proveen al menos un
-- material que se usa en algún artículo cuyo precio es mayor a $100.
select distinct p.CodProv, p.Nombre
from Proveedor p 
join Provisto_por pr on p.CodProv = pr.CodProv 
join Compuesto_por c on c.CodMat = pr.CodMat 
join Articulo a on a.CodArt = c.CodArt 
where a.Precio > 100

-- 15. Listar los números de almacenes que tienen todos los artículos que incluyen el
-- material con código 123.
select a.Nro as nro_almacen
from Almacen a 
join Tiene t on t.Nro = a.Nro 
join Articulo ar on ar.CodArt = t.CodArt 
join Compuesto_por c on c.CodArt = ar.CodArt 
where c.CodMat in (1, 2, 3)
group by a.Nro 
having count(distinct c.CodArt) = (
	select count(distinct co.CodArt) from Compuesto_por co
	where co.CodMat in (1,2,3)
)

-- 16. Listar los proveedores de Capital Federal que sean únicos proveedores de algún
-- material.

-- Materiales provistos por un solo proveedor
select pp.CodMat from Provisto_por pp 
group by pp.CodMat 
having count(pp.CodProv) > 1


select p.CodProv, p.Nombre 
from Proveedor p 
join Provisto_por pr on p.CodProv = pr.CodProv 
join Material m on m.CodMat = pr.CodMat 
where p.Ciudad = 'CABA'
and pr.CodMat not in (
	select pp.CodMat from Provisto_por pp 
	group by pp.CodMat 
	having count(pp.CodProv) > 1
)

-- 17. Listar el/los artículo/s de mayor precio.
select MAX(ar.Precio) from Articulo ar

select * from Articulo a
where a.Precio = (
	select MAX(ar.Precio) from Articulo ar
)


-- 18. Listar el/los artículo/s de menor precio.
select MIN(ar.Precio) from Articulo ar

select * from Articulo a
where a.Precio = (
	select MIN(ar.Precio) from Articulo ar
)

-- 19. Listar el promedio de precios de los artículos en cada almacén.
select a.Nro, AVG(ar.Precio) as Promedio_precios
from Almacen a 
join Tiene t on a.Nro = t.Nro 
join Articulo ar on ar.CodArt = t.CodArt
group by a.Nro

-- 20. Listar los almacenes que almacenan la mayor cantidad de artículos.
-- Contamos la cantidad de articulos por almacen
select count(t.CodArt) as cantidad
from Tiene t
group by t.Nro

-- encontramoe el maximo
select max(cantidad) as maximo
from (
	select count(t.CodArt) as cantidad
	from Tiene t
	group by t.Nro
) as conteo

select a.Nro, a.Responsable 
from Almacen a 
join Tiene ti on a.Nro = ti.Nro 
group by a.Nro, a.Responsable
having count(ti.CodArt) = (
	select max(cantidad) as maximo
	from (
		select count(t.CodArt) as cantidad
		from Tiene t
		group by t.Nro
	) as conteo
)

-- 21. Listar los artículos compuestos por al menos 3 materiales.
-- listamos la cantidad de materiales de cada articulo
select co.CodArt as articulo, count(co.CodMat) as cantidad_materiales
from Compuesto_por co 
group by co.CodArt 
-- listamos los articulos compuestos por al menos 3 materiales
select articulo, cantidad_materiales from (
	select co.CodArt as articulo, count(co.CodMat) as cantidad_materiales
	from Compuesto_por co 
	group by co.CodArt
) as conteo 
where cantidad_materiales >= 3

-- 22. Listar los artículos compuestos por exactamente 2 materiales.
select a.CodArt, a.Descripcion 
from Articulo a 
where a.CodArt in(
	select articulo from (
		select co.CodArt as articulo, count(co.CodMat) as cantidad_materiales
		from Compuesto_por co 
		group by co.CodArt
	) as conteo 
	where cantidad_materiales = 2
)

-- 23. Listar los artículos que estén compuestos con hasta 2 materiales.
select a.CodArt, a.Descripcion 
from Articulo a 
where a.CodArt in(
	select articulo from (
		select co.CodArt as articulo, count(co.CodMat) as cantidad_materiales
		from Compuesto_por co 
		group by co.CodArt
	) as conteo 
	where cantidad_materiales <= 2
)

-- 24. Listar los artículos compuestos por todos los materiales.
select co.CodArt as articulo, count(co.CodMat) as cantidad_materiales
from Compuesto_por co 
group by co.CodArt 
having count(co.CodMat) = (select count(m.CodMat) from Material m)

select a.CodArt, a.Descripcion 
from Articulo a 
where a.CodArt in (
	select co.CodArt as articulo 
	from Compuesto_por co 
	group by co.CodArt 
	having count(co.CodMat) = (select count(m.CodMat) from Material m)
)

-- 25. Listar las ciudades donde existan proveedores que provean todos los materiales.
select pp.CodProv from Provisto_por pp 
group by pp.CodProv 
having count(pp.CodMat) = (
	select count(m.CodMat) from Material m
)

select distinct p.Ciudad
from Proveedor p 
where p.CodProv in (
	select pp.CodProv from Provisto_por pp 
	group by pp.CodProv 
	having count(pp.CodMat) = (
		select count(m.CodMat) from Material m
	)
)



















