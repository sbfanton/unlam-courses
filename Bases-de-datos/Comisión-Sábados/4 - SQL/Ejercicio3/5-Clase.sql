/*
1. Indique la cantidad de productos que tiene la empresa.
2. Indique la cantidad de productos en estado 'en stock' que tiene la empresa.
3. Indique los productos que nunca fueron vendidos.
 
4. Indique la cantidad de unidades que fueron vendidas de cada producto.
5. Indique cual es la cantidad promedio de unidades vendidas de cada producto.
6. Indique quien es el vendedor con mas ventas realizadas.
7. Indique todos los productos de lo que se hayan vendido más de 15.000 unidades.
8. Indique quien es el vendedor con mayor volumen de ventas.*/--1. Indique la cantidad de productos que tiene la empresa.SELECT COUNT(*)FROM [dbo].[Producto]--2. Indique la cantidad de productos en estado 'en stock' que tiene la empresa.SELECT count(*)--estado,lower(estado),UPPER(estado)FROM [dbo].[Producto]WHERE lower(estado)='EN STOCK'--UPPER(estado)='en stock'--lower(estado)--3. Indique los productos que nunca fueron vendidos.
 --fORMA 1
 select *
 from [dbo].[Producto]
 where [idProducto]   not in  (
							select [idProducto]
							from [dbo].[Detalle_venta]


					    )

--FORMA2
SELECT *
FROM [dbo].[Producto] P
LEFT JOIN  [dbo].[Detalle_venta] DV
ON P.idProducto=DV.idProducto
WHERE DV.nro IS NULL

--FORMA 3

SELECT *
FROM [dbo].[Producto] P
WHERE 
 
NOT EXISTS

						(
						  SELECT 1
						  FROM [dbo].[Detalle_venta] DV
						  WHERE  P.idProducto=DV.idProducto
						)

--4. Indique la cantidad de unidades que fueron vendidas de cada producto.
SELECT  [idProducto],SUM([cantidad])
FROM  [dbo].[Detalle_venta]
GROUP BY  [idProducto]
 

SELECT  P.[idProducto],COALESCE( SUM([cantidad]),0)+1, ISNULL(SUM([cantidad]),0)
FROM [dbo].[Producto] P
LEFT JOIN [dbo].[Detalle_venta] DV
ON P.[idProducto]=DV.[idProducto]
GROUP BY P.[idProducto]



--5. Indique cual es la cantidad promedio de unidades vendidas de cada producto.


SELECT  P.[idProducto],COALESCE( AVG([cantidad]),0) 
FROM [dbo].[Producto] P
LEFT JOIN [dbo].[Detalle_venta] DV
ON P.[idProducto]=DV.[idProducto]
GROUP BY P.[idProducto]


--6. Indique quien es el vendedor con mas ventas realizadas.

--Cuantas ventas hizo cada vendedor

SELECT [idVendedor],COUNT(*)
FROM [dbo].[Venta]
GROUP BY [idVendedor]

--mAXIMA VENTA
SELECT  MAX(CANTvENT)
FROM (
		SELECT COUNT(*) CANTvENT
		FROM [dbo].[Venta]
		GROUP BY [idVendedor]
	) mAXIMAvENTA 
 

--pASO 3
SELECT [idVendedor],COUNT(*)
FROM [dbo].[Venta]
GROUP BY [idVendedor]
HAVING COUNT(*)   =   (
						SELECT MAX(CANTvENT)
						FROM (
								SELECT COUNT(*) CANTvENT
								FROM [dbo].[Venta]
								GROUP BY [idVendedor]
							) mAXIMAvENTA 
	)










--7. Indique todos los productos de lo que se hayan vendido más de 15.000 unidades.


SELECT [idProducto] ,SUM([cantidad])
FROM [dbo].[Detalle_venta]
GROUP BY [idProducto] 
HAVING SUM([cantidad])>3

--8. Indique quien es el vendedor con mayor volumen de ventas.--cALCULO EL VOLUMEN DE CADA VENDEDORCREATE VIEW V_VolumenVendedor as SELECT V.idVendedor,SUM(CANTIDAD*[precioUnitario])  VOLVENTFROM [dbo].[Venta] VJOIN [dbo].[Detalle_venta] DVON V.nroFactura=DV.nroFacturaGROUP BY V.idVendedor--- BUSCAMOS EL MAXIMO VOLUMENSELECT MAX(VOLVENT  )FROM (		SELECT  SUM(CANTIDAD*[precioUnitario]) VOLVENT		FROM [dbo].[Venta] V		JOIN [dbo].[Detalle_venta] DV		ON V.nroFactura=DV.nroFactura		GROUP BY V.idVendedor	) VOLUMENVENTA--con vistaSELECT  MAX(VOLVENT  )FROM V_VolumenVendedor-- NOS QUEDAMOS CON EL VENDEDOR DE MAYOR VOLUMENSELECT V.idVendedor,SUM(CANTIDAD*[precioUnitario])FROM [dbo].[Venta] VJOIN [dbo].[Detalle_venta] DVON V.nroFactura=DV.nroFacturaGROUP BY V.idVendedorHAVING SUM(CANTIDAD*[precioUnitario]) =(											SELECT  MAX(VOLVENT  )												FROM V_VolumenVendedor										)--Con vistaSELECT *FROM V_VolumenVendedorwhere VOLVENT =(				SELECT  MAX(VOLVENT  )				FROM V_VolumenVendedor				)