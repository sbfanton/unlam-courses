-- 0. SETEO DE DB
USE EJERCICIO_2
/*
Proveedor (NroProv, NomProv, Categoria, CiudadProv)
Art�culo  (NroArt, Descripci�n, CiudadArt, Precio)
Cliente   (NroCli, NomCli, CiudadCli)
Pedido    (NroPed, NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal)
Stock     (NroArt, fecha, cantidad)
*/

-- 0. Liste todos los proveedores
SELECT * FROM Proveedor;

-- 0.1. Liste los proveedores de la ciudad San Justo
SELECT * FROM Proveedor p WHERE p.CiudadProv = "San Justo"; 
SELECT * FROM Proveedor p WHERE LOWER(p.CiudadProv) = LOWER("San Justo"); 
SELECT * FROM Proveedor p WHERE p.CiudadProv LIKE "San Justo"; 

-- 0.2. Liste los proveedores de Laferrere y de categoria 'cat2'
SELECT * FROM Proveedor p 
WHERE p.CiudadProv = "Laferrere" 
AND p.Categoria = 2;


-- 0.3. Liste los proveedores de San Justo o de categoria 'cat4'
SELECT * FROM Proveedor p 
WHERE p.CiudadProv LIKE "San Justo" 
OR p.Categoria = 4;

-- 1.	Hallar el c�digo (nroProv) de los proveedores que proveen el art�culo a146.
SELECT a.NroArt FROM Articulo a 
WHERE a.Descripcion LIKE "a146";

SELECT DISTINCT 
p.NroProv from Proveedor p 
LEFT JOIN Pedido p2 
ON p.NroProv = p2.NroProv 
WHERE p2.NroArt IN (
	SELECT a.NroArt FROM Articulo a 
	WHERE a.Descripcion LIKE "a146"
);

-- 2.	Hallar los clientes (nomCli) que solicitan art�culos provistos por p015.
SELECT p.NroProv from Proveedor p 
WHERE p.NomProv LIKE "p015";

SELECT DISTINCT 
c.NomCli from Cliente c 
LEFT JOIN Pedido p 
ON c.NroCli = p.NroCli 
WHERE p.NroProv IN (
	SELECT p.NroProv from Proveedor p 
	WHERE p.NomProv LIKE "p015"
);

-- 3.	Hallar los clientes que solicitan alg�n item provisto por proveedores 
--      con categor�a mayor que 4.
SELECT p.NroProv from Proveedor p 
WHERE p.Categoria > 4;

SELECT DISTINCT 
c.NroCli, c.NomCli 
FROM Cliente c 
LEFT JOIN Pedido p 
ON c.NroCli = p.NroCli 
WHERE p.NroProv IN (
	SELECT p.NroProv from Proveedor p 
	WHERE p.Categoria > 4
);

-- 4.	Hallar los pedidos en los que un cliente de Rosario solicita art�culos 
--      producidos en la ciudad de Mendoza.
SELECT a.NroArt from Articulo a 
WHERE a.CiudadArt LIKE 'Mendoza';

SELECT c.NroCli from Cliente c 
WHERE c.CiudadCli LIKE 'Rosario';

SELECT * from Pedido p 
WHERE p.NroCli IN (
	SELECT c.NroCli from Cliente c 
	WHERE c.CiudadCli LIKE 'Rosario'
) AND 
p.NroArt IN (
	SELECT a.NroArt from Articulo a 
	WHERE a.CiudadArt LIKE 'Mendoza'
) 
ORDER BY p.NroPedido;

-- 5.	Hallar los pedidos en los que el cliente c23 solicita art�culos solicitados 
--      por el cliente c30.
SELECT DISTINCT p.NroArt from Pedido p 
WHERE p.NroCli = (
	SELECT c.NroCli from Cliente c 
	WHERE c.NomCli LIKE 'c30'
)


SELECT * from Pedido p 
WHERE p.NroCli = (
	SELECT c.NroCli from Cliente c 
	WHERE c.NomCli LIKE 'c23'
) AND 
p.NroArt IN (
	SELECT DISTINCT p.NroArt from Pedido p 
	WHERE p.NroCli = (
		SELECT c.NroCli from Cliente c 
		WHERE c.NomCli LIKE 'c30'
	)
);

-- 6.0  Hallar los proveedores que suministran todos los art�culos
-- ayuda:
-- 1ro contar articulos
-- 2do contar cuantos art provee cada prov.
-- usar ambas queries

SELECT COUNT(a.NroArt) from Articulo a; -- me devuelva la cant de articulos

SELECT p.NroProv, count(distinct p.NroArt) as ArtCount
from Pedido p 
GROUP BY p.NroProv 
ORDER BY ArtCount DESC;

SELECT p.NroProv
from Pedido p 
GROUP BY p.NroProv 
HAVING count(distinct NroArt) = (SELECT COUNT(a.NroArt) from Articulo a); 


-- 6.1 Hallar los proveedores que suministran todos los art�culos cuyo precio es superior 
--      al precio promedio de todos los art.

SELECT a.NroArt from Articulo a 
WHERE a.Precio > (SELECT AVG(a2.Precio) from Articulo a2);

SELECT p.NroProv
from Pedido p  
WHERE p.NroArt IN (
	SELECT a.NroArt from Articulo a 
	WHERE a.Precio > (SELECT AVG(a2.Precio) from Articulo a2)
) 
GROUP BY p.NroProv;


-- QUE CAMBIA RESPECTO DE LA QUERY 6.0? QUE EL TODOS, AHORA ES UN CONJUNTO MENOR

-- 6.2	Hallar los proveedores que suministran todos los art�culos cuyo precio es superior 
--      al precio promedio de los art�culos que se producen en La Plata.

-- AYUDA: 1ro art precio superior al promedio y producios en la plata
-- luego hago el cociente

SELECT p.NroProv
from Pedido p  
WHERE p.NroArt IN (
	SELECT a.NroArt from Articulo a 
	WHERE a.Precio > (
		SELECT AVG(a2.Precio) from Articulo a2 
		WHERE a2.CiudadArt LIKE 'La Plata'
	)
) 
GROUP BY p.NroProv;


-- 7.	Hallar la cantidad de art�culos diferentes provistos por cada proveedor que provee a todos los clientes de Jun�n.
SELECT c.NroCli from Cliente c 
WHERE c.CiudadCli LIKE "Junin";

SELECT p.NroProv, COUNT(DISTINCT p.NroArt) 
from Pedido p  
WHERE p.NroCli IN (
	SELECT c.NroCli from Cliente c 
	WHERE c.CiudadCli LIKE "Junin"
) 
GROUP BY p.NroProv;


-- 8.	Hallar los nombres de los proveedores cuya categor�a sea mayor que la de todos los 
--      proveedores que proveen el art�culo cuaderno.


-- AYUDA:
-- LISTAR PROV CON LA CATEGORIA MAYOR
-- LISTAR PROVEE DE ART CUADERNO
-- LISTAR categoria de los prov de cuadernos
-- BUSCAR max categoria de los prov de cuadernos


-- 8.1 Hallar los nombres de los proveedores cuya categor�a sea mayor que la de todos los proveedores que proveen el art�culo cuaderno.

-- 9.	Hallar los proveedores que han provisto m�s de 1000 unidades entre los art�culos 1 y 100 .

	 
-- 10.	Listar la cantidad y el precio total de cada art�culo que han pedido los Clientes 
-- a sus proveedores entre las fechas 01-01-2004 y 31-03-2004
-- (se requiere visualizar Cliente, Articulo, Proveedor, Cantidad y Precio).


-- 11.	Idem anterior y que adem�s la Cantidad sea mayor o igual a 1000 o el Precio sea mayor a $1000


-- 12.	Listar la descripci�n de los art�culos en donde se hayan pedido en el d�a m�s del 
--      stock existente para ese mismo d�a.

-- 13.	Listar los datos de los proveedores que hayan pedido de todos los art�culos en un mismo d�a. 
--      Verificar s�lo en el �ltimo mes de pedidos.

-- 13.1 Listar los datos de los proveedores que hayan pedido de todos los art�culos

-- 13.2 Listar los datos de los proveedores que hayan pedido de todos los art�culos en un mismo d�a.


-- 14.	Listar los proveedores a los cuales no se les haya solicitado ning�n art�culo en el �ltimo mes, 
--      pero s� se les haya pedido en el mismo mes del a�o anterior.

/*
Proveedor (NroProv, NomProv, Categoria, CiudadProv)
Art�culo  (NroArt, Descripci�n, CiudadArt, Precio)
Cliente   (NroCli, NomCli, CiudadCli)
Pedido    (NroPed, NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal)
Stock     (NroArt, fecha, cantidad)
*/


-- TRABAJO CON FECHAS
SELECT GETDATE() [FECHA HOY], DATEADD(MONTH, -1, GETDATE()) [ UN MES PARA ATRAS], YEAR(GETDATE()) [A�o], MONTH(GETDATE()) [MES], DAY(GETDATE()) [DIA]
-- FECHAS DEL A�O PASADO
SELECT DATEADD(YEAR ,-1, DATEADD(MONTH, -1, GETDATE())) ,  DATEADD(YEAR, -1, GETDATE())
-- datediff -- muestra diferencia entre dos fechas
-- dateadd -- agregar o substrae respecto de una fecha. puedo agregarle a una fecha dada, X segundos o Y minutos, o Z dias, etc 
-- getdate -- | now  retorna la fecha de hoy

-- prov que tuvieron pedidos durante el ultimo mes
-- prov que NO tuvieron pedidos durante el ultimo mes


-- prov que SI tuvieron pedidos durante el ultimo mes, pero del a�o anterior

-- Listar los proveedores a los cuales no se les haya solicitado ning�n art�culo en el �ltimo mes, pero s� se les haya pedido en el mismo mes del a�o anterior.

-- 15.	Listar los nombres de los clientes que hayan solicitado m�s de un art�culo cuyo precio sea superior a $100
-- y que correspondan a proveedores de Capital Federal. Por ejemplo, se considerar� si se ha solicitado el art�culo a2 y a3, 
-- pero no si solicitaron 5 unidades del articulo a2.
 