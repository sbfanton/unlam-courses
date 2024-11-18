use EJERCICIO_3

--1. Indique la cantidad de productos que tiene la empresa.
select count(*)as cant_productos from Producto;


--2. Indique la cantidad de productos en estado 'en stock' que tiene la empresa.
select count(*) as cant_en_stock from Producto p 
where p.estado = 'en stock'

--3. Indique los productos que nunca fueron vendidos.
select distinct d.idProducto from Detalle_venta d

select 
p.idProducto,
p.nombre
from Producto p
where p.idProducto not in (
	select distinct dv.idProducto from Detalle_venta dv
	WHERE dv.idProducto IS NOT NULL
)

--4. Indique la cantidad de unidades que fueron vendidas de cada producto.
select d.idProducto, sum(d.cantidad) as unidades_vendidas_total 
from Detalle_venta d 
group by d.idProducto

SELECT  P.[idProducto], ISNULL(SUM([cantidad]),0) as cantidad_vendida
FROM [dbo].[Producto] P
LEFT JOIN [dbo].[Detalle_venta] DV
ON P.[idProducto]=DV.[idProducto]
GROUP BY P.[idProducto]

--5. Indique cual es la cantidad promedio de unidades vendidas de cada producto.
select d.idProducto, avg(d.cantidad) as unidades_vendidas_promedio
from Detalle_venta d 
group by d.idProducto

SELECT  P.[idProducto], COALESCE( AVG([cantidad]),0) as promedio_unid_vendidas
FROM [dbo].[Producto] P
LEFT JOIN [dbo].[Detalle_venta] DV
ON P.[idProducto]=DV.[idProducto]
GROUP BY P.[idProducto]


--6. Indique quien es el vendedor con mas ventas realizadas.
select v.idVendedor, count(v.nroFactura) as cant_ventas from Venta v 
group by v.idVendedor

select max(cant_ventas) from (
	select v.idVendedor, count(v.nroFactura) as cant_ventas from Venta v 
	group by v.idVendedor
) as ven

SELECT 
    ve.idVendedor, 
    ven.nombre, 
    ven.apellido 
FROM Venta ve
JOIN Vendedor ven ON ve.idVendedor = ven.idEmpleado
GROUP BY ve.idVendedor, ven.nombre, ven.apellido
having count(ve.nroFactura) = (
	select max(cant_ventas) from (
		select v.idVendedor, count(v.nroFactura) as cant_ventas from Venta v 
		group by v.idVendedor
	) as ven
)


--7. Indique todos los productos de lo que se hayan vendido más de 10 unidades.
select d.idProducto, sum(d.cantidad) as cantidad_total 
from Detalle_venta d 
group by d.idProducto 
having sum(d.cantidad) > 10


--8. Indique quien es el vendedor con mayor volumen de ventas.
select 
v.idVendedor, sum(d.cantidad) as volumen_total_ventas
from Detalle_venta d 
join Venta v on v.nroFactura = d.nroFactura 
group by v.idVendedor 


select 
v.idVendedor, 
ve.nombre, 
ve.apellido,
sum(d.cantidad) as volumen_total_ventas
from Vendedor ve
join Venta v on ve.idEmpleado = v.idVendedor
join Detalle_venta d on  d.nroFactura = v.nroFactura
group by v.idVendedor, ve.nombre, ve.apellido
having sum(d.cantidad) = (
	select max(vol_ven) from (
		select 
		v.idVendedor, sum(d.cantidad) as vol_ven
		from Detalle_venta d 
		join Venta v on v.nroFactura = d.nroFactura 
		group by v.idVendedor 
	) as ven
)