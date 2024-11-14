--a. Encontrar el nombre de todas las personas que trabajan en la empresa “Banelco”.

 
SELECT  [nomPersona]
FROM [dbo].[Trabaja]
WHERE [nomEmpresa]='Banelco'
AND [feEgreso] IS NULL

 


--b. Localizar el nombre y la ciudad de todas las personas que trabajan para la
--empresa “Telecom”.


SELECT T.[nomPersona],V.ciudad
FROM [dbo].[Trabaja] T
JOIN [dbo].[Vive] V
ON T.nomPersona=V.nomPersona
WHERE [nomEmpresa]='Telecom'
AND [feEgreso] IS NULL



--c. Buscar el nombre, calle y ciudad de todas las personas que trabajan para la
--empresa “Paulinas” y ganan más de $1500.

SELECT T.nomPersona,V.ciudad,V.calle
FROM [dbo].[Trabaja] T
JOIN [dbo].[Vive] V
ON T.nomPersona=V.nomPersona
WHERE [nomEmpresa]='Paulinas' AND salario>1500
AND [feEgreso] IS NULL


--d. Encontrar las personas que viven en la misma ciudad en la que se halla la
--empresa en donde trabajan.

SELECT *
FROM [dbo].[Trabaja] T
JOIN [dbo].[Vive] V
ON T.nomPersona=V.nomPersona
JOIN [dbo].[Situada_En] S
ON  S.nomEmpresa=T.nomEmpresa
AND S.ciudad=V.ciudad 
WHERE [feEgreso] IS NULL

--e. Hallar todas las personas que viven en la misma ciudad y en la misma calle que
--su supervisor.

SELECT *
FROM [dbo].[Vive] V1
JOIN [dbo].[Supervisa] S
ON V1.nomPersona=S.nomSupervisor
JOIN [dbo].[Vive] V2
ON V2.nomPersona=S.nomPersona
WHERE V1.calle=V2.calle AND V1.ciudad=V2.ciudad



--f. Encontrar todas las personas que ganan más que cualquier empleado de la
--empresa “Clarín”.

SELECT max([salario])
FROM [dbo].[Trabaja]
WHERE nomEmpresa='Clarin' AND [feEgreso] IS NULL



select *
from [dbo].[Trabaja]
where salario>(
SELECT max([salario])
FROM [dbo].[Trabaja]
WHERE nomEmpresa='Clarin' AND [feEgreso] IS NULL

)
AND [feEgreso] IS NULL


--g. Localizar las ciudades en las que todos los trabajadores que vienen en ellas
--ganan más de $1000.


SELECT ciudad
FROM [dbo].[Trabaja] T
JOIN [dbo].[Vive] V
ON T.nomPersona=V.nomPersona
WHERE ciudad NOT IN(

					SELECT   V.ciudad
					FROM  [dbo].[Trabaja] T
					JOIN [dbo].[Vive] V
					ON T.nomPersona=V.nomPersona
					WHERE T.salario<=1000 AND [feEgreso] IS NULL

)
AND [feEgreso] IS NULL


--h. Listar los primeros empleados que la compañía “Sony” contrató.

select *
from [dbo].[Trabaja]
where feIngreso =(
					SELECT MIN(feIngreso)
					FROM [dbo].[Trabaja]
					WHERE [nomEmpresa]='sONY'
					)
and [nomEmpresa]='sONY'



--i. Listar los empleados que hayan ingresado en mas de 4 Empresas en el periodo
--01-01-2000 y 31-03-2004 y que no hayan tenido menos de 2 supervisores


--en el periodo  01-01-2000 y 31-03-2004 y que no hayan tenido menos de 2 supervisores
SELECT S.[nomPersona] 
FROM [dbo].[Supervisa]  S
JOIN [dbo].[Trabaja] T
ON S.nomPersona=T.nomPersona
--WHERE  feIngreso BETWEEN '2000-01-01' AND '2004-03-31'
GROUP BY S.[nomPersona]
HAVING COUNT(*)>=2

--los empleados que hayan ingresado en mas de 4 Empresas en el periodo 01-01-2000 y 31-03-2004


SELECT [nomPersona] 
FROM [dbo].[Trabaja]
--WHERE  feIngreso BETWEEN '2000-01-01' AND '2004-03-31'
GROUP BY [nomPersona] 
HAVING COUNT(DISTINCT  [nomEmpresa])>4


SELECT *
FROM (
		SELECT [nomPersona] 
		FROM [dbo].[Trabaja]
		--WHERE  feIngreso BETWEEN '2000-01-01' AND '2004-03-31'
		GROUP BY [nomPersona] 
		HAVING COUNT(DISTINCT  [nomEmpresa])>4
	) MASDE4
WHERE MASDE4.nomPersona IN(

							SELECT S.[nomPersona] 
							FROM [dbo].[Supervisa]  S
							JOIN [dbo].[Trabaja] T
							ON S.nomPersona=T.nomPersona
							--WHERE  feIngreso BETWEEN '2000-01-01' AND '2004-03-31'
							GROUP BY S.[nomPersona]
							HAVING COUNT(*)>=2
)



 
		SELECT [nomPersona] 
		FROM [dbo].[Trabaja]
		 WHERE  feIngreso BETWEEN '2000-01-01' AND '2004-03-31'
		AND  [nomPersona]  IN (

							SELECT S.[nomPersona] 
							FROM [dbo].[Supervisa]  S
							JOIN [dbo].[Trabaja] T
							ON S.nomPersona=T.nomPersona
							 WHERE  feIngreso BETWEEN '2000-01-01' AND '2004-03-31'
							GROUP BY S.[nomPersona]
							HAVING COUNT(*)>=2
								)
		GROUP BY [nomPersona] 
		HAVING COUNT(DISTINCT  [nomEmpresa])>4
	 
