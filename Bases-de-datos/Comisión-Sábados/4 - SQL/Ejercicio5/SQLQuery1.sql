use ejercicio_5

--Realizar las siguientes consultas en SQL:

--1)Listar los clientes que no hayan reportado préstamos del rubro Policial.
 
 SELECT DISTINCT PR.CodCli
 FROM [dbo].[Prestamo] PR
 WHERE PR.CodCli NOT IN(

 
 SELECT  DISTINCT PR.CodCli
 FROM [dbo].[Prestamo] PR
 JOIN [dbo].[Pelicula] PE
	ON PR.CodPel=PE.CodPel
JOIN [dbo].[Rubro] RU
	ON RU.CodRubro=PE.CodRubro
WHERE RU.NombRubro='Policial'

)



--2)Listar las películas de mayor duración que alguna vez fueron prestadas.
 
 SELECT *
 FROM [dbo].[Pelicula] PE
 JOIN [dbo].[Prestamo] PR
	ON PE.CodPel=PR.CodPel
WHERE PE.Duracion=(


 SELECT MAX([Duracion])
 FROM [dbo].[Pelicula] PE
 JOIN [dbo].[Prestamo] PR
	ON PE.CodPel=PR.CodPel
	)

--3)Listar los clientes que tienen más de un préstamo sobre la misma película (listar Cliente, Película y cantidad de prestamos).


 SELECT [CodCli] ,[CodPel], COUNT(*)
 FROM [dbo].[Prestamo] 
 GROUP BY  [CodCli],[CodPel]
 HAVING COUNT(*)>1




--4)Listar los clientes que han realizado préstamos del título Rey León y Terminador 3 (Ambos).
 
 SELECT PR.CodCli
 FROM [dbo].[Prestamo] PR
 JOIN [dbo].[Pelicula] PE
	ON PR.CodPel=PE.CodPel
WHERE PE.Titulo='Rey León'

INTERSECT


SELECT PR.CodCli
FROM [dbo].[Prestamo] PR
 JOIN [dbo].[Pelicula] PE
	ON PR.CodPel=PE.CodPel
WHERE PE.Titulo='Terminador 3'


--Otra forma:

 
 SELECT PR.CodCli
 FROM [dbo].[Prestamo] PR
 JOIN [dbo].[Pelicula] PE
	ON PR.CodPel=PE.CodPel
WHERE PE.Titulo='Rey León'
and pr.CodCli in(
				SELECT PR.CodCli
				FROM [dbo].[Prestamo] PR
				 JOIN [dbo].[Pelicula] PE
					ON PR.CodPel=PE.CodPel
				WHERE PE.Titulo='Terminador 3'


                )



--5) Listar las películas más vistas en cada mes (Mes, Película, Cantidad de Alquileres).

SELECT MONTH([FechaPrest]), [CodPel], COUNT(*)
FROM [dbo].[Prestamo] PR
GROUP BY MONTH([FechaPrest]), [CodPel]

HAVING COUNT(*) = (SELECT MAX(VALOR)
				FROM (

					 SELECT MONTH([FechaPrest]) MES, [CodPel], COUNT(*) VALOR
					 FROM [dbo].[Prestamo] PR1
					 WHERE MONTH(PR.[FechaPrest])= MONTH(PR1.[FechaPrest])
					 GROUP BY  MONTH([FechaPrest]), [CodPel]
					) MAXI
					)
  
  

--6)Listar los clientes que hayan alquilado todas las películas del video.



SELECT CodCli
FROM [dbo].[Prestamo]
GROUP BY [CodCli]
HAVING COUNT( DISTINCT [CodPel])=(

									SELECT COUNT(*)
									FROM [dbo].[Pelicula]
)


SELECT *
FROM [dbo].[Cliente] C
WHERE NOT EXISTS (
					SELECT 1
					FROM [dbo].[Pelicula] PE
					WHERE NOT EXISTS (
										SELECT 1
										FROM [dbo].[Prestamo] PR
										WHERE PR.CodCli=C.CodCli
										AND PR.CodPel=PE.CodPel
										)
				)




 

--7)Listar las películas que no han registrado ningún préstamo a la fecha.
 
 SELECT *
 FROM [dbo].[Pelicula]
 WHERE CodPel NOT IN(

 SELECT CodPel
 FROM [dbo].[Prestamo]

 )
--8)Listar los clientes que no han efectuado la devolución de ejemplares.					
 
 SELECT DISTINCT [CodCli]
 FROM [dbo].[Prestamo]
 WHERE [FechaDev] IS NULL


--9)Listar los títulos de las películas que tienen la mayor cantidad de préstamos.
 

 SELECT [CodPel]
 FROM [dbo].[Prestamo]
 GROUP BY [CodPel]
 HAVING COUNT(*)=(

 SELECT MAX( MAXIMO)
 FROM (
	
		 SELECT [CodPel],COUNT(*) MAXIMO
		 FROM [dbo].[Prestamo]
		 GROUP BY  [CodPel]
		) PELMAX
		)


--10)Listar las películas que tienen todos los ejemplares prestados.

SELECT [CodPel]
FROM [dbo].[Ejemplar] E
GROUP BY [CodPel]
HAVING COUNT(*) =(
					SELECT COUNT( DISTINCT CodEj)
					FROM [dbo].[Prestamo] PR
					WHERE PR.CodPel=E.[CodPel]
					AND [FechaDev] IS NULL

                     )

 