create database dbsql1
go
use dbsql1
go
-- Inicializar las tablas
-- drop table tabla4,tabla2,tabla3,tabla1
create table tabla1 (c1 int not null primary key, c2 varchar(20) null)
create table tabla2 (c1 int not null primary key, c2 varchar(50) null)
create table tabla3 (c3 int not null primary key, c1 int null foreign key references tabla1(c1))
create table tabla4 (c4 smallint not null primary key, c5 varchar(5) not null)
insert into tabla1 values(1,'a')
insert into tabla1 values(2,'b')
insert into tabla1 values(3,'c')
insert into tabla2 values (2,'b')
insert into tabla4 values (1,'1')
insert into tabla4 values (2,'2')


-- 1
select count(1) from tabla1
select count(*) from tabla1
select count(c1) from tabla1

/*
Diferencias importantes:

COUNT(*) está garantizado para contar todas las filas (incluso aquellas con valores NULL en alguna columna).
COUNT(1) también cuenta todas las filas, pero no se hace distinción sobre los valores NULL de las columnas (ya que no se pasa ninguna columna).
En resumen: En cuanto a la semántica, COUNT(*) y COUNT(1) son equivalentes. En cuanto a optimización, el motor de base de datos puede tratarlos de manera diferente, pero en la mayoría de los casos, ambos deberían tener un rendimiento muy similar.

¿Existe alguna diferencia con haber usado COUNT(c1)?
Sí, hay una diferencia. Si usas COUNT(c1), estarás contando las filas en las que la columna c1 no sea NULL. Es decir, si alguna fila tiene un valor NULL en la columna c1, esa fila no será contada.
*/

-- 2
(SELECT DISTINCT 'Juan' AS Nombre, 'Perez' as Apellido)
UNION ALL
(SELECT DISTINCT 'Juan' AS Nombre, 'Perez' as Apellido)

/*
1. ¿Cuántas filas devolvió?
Para entender cuántas filas devuelve esta consulta, es importante analizar los componentes que la conforman:

Subconsulta 1: (SELECT DISTINCT 'Juan' AS Nombre, 'Perez' AS Apellido)

La subconsulta retorna una única fila con los valores 'Juan' para el campo Nombre y 'Perez' para el campo Apellido. Como la subconsulta ya utiliza DISTINCT, esto asegura que se eliminen duplicados, pero en este caso, ya que solo estamos seleccionando los mismos valores constantes, el resultado es una única fila.

Subconsulta 2: (SELECT DISTINCT 'Juan' AS Nombre, 'Perez' AS Apellido)

Al igual que la primera, esta subconsulta también retorna una única fila con los mismos valores 'Juan' y 'Perez'.

Ahora, la operación que conecta ambas subconsultas es UNION ALL:

UNION ALL no elimina duplicados. Con UNION ALL, todas las filas de ambas subconsultas se combinan, incluyendo las filas duplicadas.
En este caso, como ambas subconsultas retornan exactamente las mismas filas ('Juan', 'Perez'), UNION ALL las devolverá ambas filas, sin realizar ningún tipo de eliminación de duplicados.
Resultado:
La consulta devolverá 2 filas, ya que ambas subconsultas son idénticas, y como UNION ALL no elimina duplicados, ambas filas se incluyen en el resultado.

2. ¿Cómo debería realizar para filtrar duplicados?
Si tu objetivo es filtrar duplicados y que solo se devuelvan filas únicas (es decir, eliminar las filas repetidas), deberías usar UNION en lugar de UNION ALL.

UNION: Combina los resultados de ambas subconsultas y elimina los duplicados de forma automática.
La consulta corregida sería:

(SELECT DISTINCT 'Juan' AS Nombre, 'Perez' AS Apellido)
UNION
(SELECT DISTINCT 'Juan' AS Nombre, 'Perez' AS Apellido)
En este caso, la consulta devolvería 1 fila, ya que UNION elimina duplicados y las dos subconsultas están devolviendo el mismo conjunto de datos.

3. ¿Qué sucede cuando las columnas no tienen alias?
Cuando no se usan alias en las columnas, SQL Server asigna nombres genéricos a las columnas en los resultados de la consulta, generalmente basados en las expresiones o valores que se seleccionan.

Por ejemplo, si omites los alias:

(SELECT DISTINCT 'Juan', 'Perez')
UNION ALL
(SELECT DISTINCT 'Juan', 'Perez')
La consulta aún será válida, pero los nombres de las columnas en los resultados serían asignados automáticamente por el motor de base de datos como Expr1, Expr2, etc. (dependiendo del sistema de bases de datos que utilices).

El resultado podría verse así:

Expr1	Expr2
Juan	Perez
Juan	Perez
En este caso, las columnas no tienen un nombre descriptivo (como Nombre y Apellido en tu consulta original), sino que se les asignan alias predeterminados como Expr1 y Expr2.

Resumen:

UNION ALL devuelve todas las filas, incluidos los duplicados. En tu consulta original, devolverá 2 filas.
UNION elimina los duplicados, por lo que devolverá solo 1 fila.
Si no se usan alias en las columnas, SQL Server asignará alias predeterminados como Expr1, Expr2, etc., a las columnas de los resultados.
*/

-- 3

insert into tabla3 values(1,null)

/*
1. Restricción de clave foránea (FK) y valor NULL:
Cuando tienes una columna que es una clave foránea (FK), esa columna debe hacer referencia a una clave primaria (PK) en otra tabla. Sin embargo, si el valor de la clave foránea es NULL, no hay una violación de la restricción de clave foránea, porque NULL no se considera un valor válido para hacer la comparación con la PK. En este caso, el valor NULL en la columna de la clave foránea no está intentando hacer referencia a ningún registro en la tabla principal, por lo que no se produce una violación de la integridad referencial.

Conclusión: Si la columna en cuestión permite valores NULL, la inserción no violará la restricción de clave foránea y debería ejecutarse correctamente, siempre y cuando el resto de las restricciones (por ejemplo, si la columna clave primaria tiene restricciones de NOT NULL) no sean violadas.

2. Restricción de clave primaria (PK):
Por otro lado, la clave primaria en una tabla no permite valores NULL. Si intentaras insertar NULL en una columna que forma parte de una clave primaria, se generaría un error porque la clave primaria debe ser única y no nula.

Conclusión: En este caso, si NULL se estuviera intentando insertar en una columna que es parte de una clave primaria (y no de una clave foránea), la consulta fallaría porque NULL no está permitido en las claves primarias.

3. ¿Se puede insertar un NULL en una clave foránea?
Sí, se puede insertar un valor NULL en una columna que es clave foránea, a menos que explícitamente se haya configurado la columna para no permitir valores NULL. El valor NULL en la columna de clave foránea indica que no hay ninguna fila en la tabla referenciada (a través de la clave primaria), y es un caso válido.

Conclusión: Si la columna FK en tabla3 permite valores NULL, la inserción será válida.

Resumen de condiciones:
Si la columna con NULL es una clave foránea (FK):
Si la columna FK permite valores NULL, la inserción se podrá realizar correctamente porque NULL no necesita cumplir con la restricción de la clave foránea (no se busca una fila específica en la tabla referenciada). En este caso, la consulta sería válida.

Si la columna con NULL es parte de una clave primaria (PK):
No puedes insertar NULL en una columna que sea parte de una clave primaria, ya que las claves primarias deben ser únicas y no nulas. Si intentas hacerlo, la consulta fallaría.

¿Es correcto usar NULL en una clave foránea?
Es completamente válido usar NULL en una columna de clave foránea si la restricción lo permite. Un valor NULL en una clave foránea significa que esa fila no está relacionada con ninguna fila de la tabla referenciada (es decir, la relación es opcional en este caso).

Conclusión general:
Si la columna de clave foránea en tabla3 permite NULL, entonces la consulta se ejecutará correctamente, y el valor NULL no violará ninguna restricción de clave foránea.
Si se trata de una columna que es parte de una clave primaria, entonces la consulta fallará, ya que no puedes insertar un valor NULL en una columna que es parte de una clave primaria.
*/

-- 4

select * from tabla1,tabla2

/*
1. ¿Qué operación realizó entre tabla1 y tabla2?
Esta consulta realiza un producto cartesiano entre las dos tablas (tabla1 y tabla2), también conocido como cross join (aunque no se utiliza explícitamente CROSS JOIN en esta consulta, el comportamiento es el mismo). Un producto cartesiano devuelve todas las combinaciones posibles entre las filas de tabla1 y tabla2.

Producto cartesiano (Cross Join):
Si tabla1 tiene n filas y tabla2 tiene m filas, entonces el resultado de la consulta tendrá un total de n * m filas, donde cada fila de tabla1 se combina con cada fila de tabla2.
Es decir, la consulta devuelve todas las combinaciones posibles de filas entre ambas tablas.
2. ¿Cómo se llaman las columnas del listado?
Cuando no se especifican alias para las columnas y se usa el asterisco (*), se seleccionan todas las columnas de ambas tablas, pero las columnas tendrán nombres compuestos que reflejan el nombre de las tablas.

Convención de nombres de columnas:
Si ambas tablas tienen columnas con los mismos nombres, los motores de bases de datos, como SQL Server, generalmente renombrarán las columnas para evitar ambigüedades.
En la mayoría de los sistemas de bases de datos, las columnas resultantes de un SELECT * que involucra más de una tabla serán nombradas de la siguiente manera:
Las columnas de tabla1 se nombrarán como tabla1.columnaX.
Las columnas de tabla2 se nombrarán como tabla2.columnaY.
Por ejemplo, si tabla1 tiene las columnas A, B y C, y tabla2 tiene las columnas X, Y y Z, el resultado de la consulta tendría las siguientes columnas:

tabla1.A	tabla1.B	tabla1.C	tabla2.X	tabla2.Y	tabla2.Z
valor1	valor2	valor3	valor4	valor5	valor6
valor7	valor8	valor9	valor10	valor11	valor12
...	...	...	...	...	...
3. Consideraciones sobre el producto cartesiano:
El uso de SELECT * junto con el producto cartesiano puede generar un número de filas muy grande si las tablas tienen muchos registros. Además, en un producto cartesiano, no se aplican condiciones de filtrado ni combinaciones (como un JOIN basado en alguna condición específica). Esto puede ser útil en algunas situaciones, pero también puede ser muy costoso en términos de rendimiento.

Ejemplo:
Si tabla1 tiene 5 filas y tabla2 tiene 3 filas, el producto cartesiano generará:

5
 
(
filas de tabla1
)
×
3
 
(
filas de tabla2
)
=
15
 
filas en el resultado
5(filas de tabla1)×3(filas de tabla2)=15filas en el resultado
Conclusión:
Operación realizada: Se realizó un producto cartesiano entre tabla1 y tabla2.
Nombres de las columnas: Los nombres de las columnas resultantes estarán compuestos por el nombre de la tabla y el nombre de la columna, por ejemplo, tabla1.columna1, tabla2.columna2, etc.
Impacto: Esta consulta puede generar una gran cantidad de resultados, especialmente si las tablas involucradas contienen muchas filas.
*/

-- 5

select * from tabla1,tabla4 where tabla1.c1=tabla4.c4

select * from tabla1,tabla4 where tabla1.c1=tabla4.c5

select * from tabla1,tabla2 where tabla1.c2=tabla2.c2

/*
1. ¿Se pudo ejecutar la sentencia?
En principio, sí se podría ejecutar esta sentencia, pero todo depende de las siguientes condiciones:

Existencia de las tablas y columnas: La consulta solo se ejecutará si tabla1 y tabla4 existen en la base de datos y las columnas c1 y c4 están definidas en esas tablas, respectivamente.
Tipo de datos compatible: La condición tabla1.c1 = tabla4.c4 debe ser válida en términos de los tipos de datos de las columnas c1 y c4. Es decir, los tipos de datos de c1 y c4 deben ser comparables. Si las columnas tienen tipos de datos incompatibles (por ejemplo, una columna es INT y la otra es VARCHAR sin una conversión explícita), SQL Server podría lanzar un error o intentar realizar una conversión implícita.

2. ¿Qué tipo de conversión se ha realizado?
En la cláusula WHERE tabla1.c1 = tabla4.c4, si las columnas c1 y c4 tienen tipos de datos diferentes pero comparables, SQL Server intentará hacer una conversión implícita para que la comparación sea válida. Esto depende de los tipos de datos de las columnas involucradas.

Ejemplo de situaciones comunes de conversión implícita:
Si c1 es de tipo INT y c4 es de tipo VARCHAR, SQL Server intentará convertir automáticamente el valor de c4 a un número (en este caso, un INT) para hacer la comparación.
Si c1 es de tipo DATETIME y c4 es de tipo DATE, SQL Server puede intentar convertir la columna c4 a DATETIME para hacer la comparación.
Si c1 es de tipo VARCHAR y c4 es de tipo NVARCHAR, no se realiza una conversión numérica, pero SQL Server puede realizar una conversión de tipos de texto dependiendo de los valores que contengan las columnas.
¿Qué sucede si los tipos no son compatibles?
Si los tipos de las columnas no son compatibles y SQL Server no puede hacer una conversión implícita, lanzará un error de tipo de datos. Por ejemplo, si intentas comparar un DATETIME con un INT, SQL Server no podrá realizar la comparación correctamente y generará un error de conversión.

Ejemplo de error:
Si c1 es de tipo INT y c4 es de tipo VARCHAR que contiene texto no numérico, SQL Server intentará realizar una conversión implícita, pero fallará cuando no pueda convertir el valor de VARCHAR a INT. El error podría ser algo como:

Error de conversión de tipo de datos.

3. ¿Qué sucede si hay un error de conversión?
Si se produce un error de conversión durante la ejecución de la consulta, SQL Server no podrá completar la operación. Algunos errores comunes incluyen:

Conversión de tipos incompatible: Si no se puede realizar una conversión implícita de un tipo a otro, se lanzará un error.
Valores no válidos: Si una columna de tipo VARCHAR tiene texto que no puede ser convertido a INT (por ejemplo, 'abc'), la conversión fallará.
4. Recomendaciones para evitar problemas de conversión
Si estás seguro de que las columnas deben ser comparadas pero tienen tipos de datos diferentes, puedes especificar una conversión explícita utilizando funciones como CAST() o CONVERT() para asegurarte de que la comparación sea correcta:

Usando CAST:

sql
Copiar código
SELECT * 
FROM tabla1, tabla4 
WHERE CAST(tabla1.c1 AS VARCHAR) = tabla4.c4;
En este caso, convertimos tabla1.c1 a VARCHAR para asegurar que ambos valores sean comparables.

Usando CONVERT:

SELECT * 
FROM tabla1, tabla4 
WHERE CONVERT(VARCHAR, tabla1.c1) = tabla4.c4;
De manera similar, CONVERT permite especificar una conversión explícita.

Resumen de la respuesta:
¿Se pudo ejecutar la sentencia?: Sí, se podría ejecutar si las tablas y las columnas existen y los tipos de datos de las columnas son compatibles. Si los tipos de datos no son compatibles, se produciría un error de conversión.

¿Qué tipo de conversión se ha realizado?: SQL Server intentará hacer una conversión implícita entre las columnas si los tipos de datos son compatibles. Si no lo son, se generará un error de conversión.

Recomendación: Asegúrate de que los tipos de datos de las columnas que estás comparando sean compatibles. Si no lo son, utiliza funciones como CAST() o CONVERT() para hacer una conversión explícita y evitar errores de conversión.
*/


-- TRIGGERS

create trigger tg1 
on tabla1,tabla2 
after insert
as 
insert into tabla1 select c1*10, 'tg-' + c2 from inserted

--8 ¿Se pudo crear? ¿Por qué? ¿Qué debería realizar para corregirlo?
 /*
     Error en la declaración del trigger: El trigger que has escrito está tratando de aplicarse a dos tablas (tabla1 y tabla2), pero en SQL Server un trigger solo puede estar asociado a una única tabla o vista. En tu caso, estás intentando definir un trigger para dos tablas al mismo tiempo, lo cual no es válido.

    Sintaxis incorrecta: En la declaración de la sentencia ON, solo puedes especificar una tabla o vista. No puedes usar más de una tabla en la misma declaración de trigger. SQL Server no permite que un trigger se aplique a múltiples tablas directamente, como lo estás intentando hacer con tabla1, tabla2.

¿Cómo corregirlo?

    Si deseas que el trigger se ejecute después de un INSERT en tabla1 (y no en tabla2), simplemente debes eliminar tabla2 de la sentencia ON.

    Si necesitas que el trigger se ejecute en ambas tablas (por ejemplo, después de un INSERT en cualquiera de las dos tablas), deberías crear dos triggers separados, uno para tabla1 y otro para tabla2.
 
 
 Una vez corregido, el trigger que has planteado tiene el propósito de realizar una inserción en tabla1 después de un INSERT en esa misma tabla (o en tabla2, dependiendo de cómo lo hayas implementado). Específicamente, lo que hace es lo siguiente:
Resumen del comportamiento del trigger:

    Ejecuta después de un INSERT: El trigger se ejecuta después de que se realice una inserción (INSERT) en la tabla asociada (tabla1 o tabla2).

    Accede a los datos insertados: Dentro del trigger, se hace referencia a la tabla especial llamada inserted. Esta tabla contiene las filas que han sido insertadas recientemente en la tabla a la que está asociado el trigger. Es importante notar que inserted es una tabla virtual que está disponible dentro del contexto del trigger y que refleja el estado de los datos después de la inserción.

    Realiza una transformación de los datos: En el SELECT dentro del trigger, se están realizando dos transformaciones:
        Se toma el valor de la columna c1 y se multiplica por 10 (c1 * 10).
        Se toma el valor de la columna c2 y se le concatena el prefijo 'tg-' a su valor ('tg-' + c2).

    Inserta los datos modificados en tabla1: Después de aplicar las transformaciones a los datos de la tabla inserted, se realiza un nuevo INSERT en tabla1, utilizando los valores transformados de c1 y c2.
 */

create trigger tg3 
on tabla1 
after select
as 
insert into tabla1 select c1*10, 'tg-' + c2 from inserted

/*

9 ¿Se pudo crear? ¿Por qué?

No puedes crear un trigger que responda a un SELECT en SQL Server, porque los triggers solo pueden responder a cambios en los datos (INSERT, UPDATE, DELETE).
Si necesitas realizar una acción después de un SELECT, puedes hacerlo dentro de un procedimiento almacenado que contenga tanto la consulta como la inserción.
Si necesitas realizar acciones después de modificaciones en los datos, puedes utilizar triggers en respuesta a las operaciones INSERT, UPDATE o DELETE.
*/

-- triggers recursivos

create or alter trigger tg1_tabla1 
on tabla1 
instead of insert
as
begin
declare @val1 int, @val2 varchar(20)
select @val1=c1, @val2=c2 from inserted
insert into tabla2 values (@val1, @val2)
end

create or alter trigger tg1_tabla2 
on tabla2 
instead of insert
as
begin
declare @val1 int, @val2 varchar(20)
select @val1=c1, @val2=c2 from inserted
insert into tabla2 values (@val1, @val2 + 'xxxxx')
end

select * from tabla1
select * from tabla2
insert into tabla1 values (4,'d')

/*
El INSTEAD OF INSERT es un tipo de trigger en SQL Server que reemplaza la operación de inserción estándar (INSERT) en la tabla a la que está asociado. Es decir, cuando ocurre un INSERT en la tabla, el trigger INSTEAD OF INSERT no ejecuta el INSERT original que se habría realizado, sino que ejecuta el código del trigger que define el comportamiento personalizado.
Explicación del comportamiento de INSTEAD OF INSERT:

Cuando se define un trigger INSTEAD OF INSERT, se le da la oportunidad de interceptar la operación de inserción y realizar alguna acción personalizada, como:

    Modificar los datos que se van a insertar.
    Insertar los datos en otra tabla o hacer alguna validación.
    Realizar un procedimiento alternativo a la inserción estándar.

A diferencia de un trigger AFTER INSERT (que se ejecuta después de la inserción), el trigger INSTEAD OF INSERT sustituye la acción original.


¿Qué sucedió al ejecutarse un trigger que posee una tabla con otro trigger?

Cuando un trigger (tg1_tabla1) ejecuta un INSERT en una tabla (tabla2), eso dispara otro trigger (tg1_tabla2), ya que el segundo trigger está asociado a tabla2. Este segundo trigger, a su vez, también ejecuta un INSERT en tabla2, lo que genera una secuencia de eventos en la que un trigger activa a otro.

En este caso, el primer trigger inserta en tabla2, y luego el segundo trigger hace una modificación en los datos antes de volver a insertar en tabla2. Este comportamiento puede generar inserciones repetidas o alteradas en la misma tabla, lo cual es lo que ocurre aquí.

¿Podemos decir que un trigger puede llamar a otro trigger implícitamente?

Sí, un trigger puede llamar a otro trigger implícitamente. Cuando un trigger realiza una operación que afecta una tabla que tiene otro trigger asociado (como un INSERT en una tabla que tiene un trigger INSTEAD OF INSERT), este segundo trigger se ejecuta automáticamente.

Por ejemplo, en este caso, el trigger tg1_tabla1 inserta datos en tabla2, lo que activa el trigger tg1_tabla2 de manera implícita, sin que el usuario o el desarrollador lo haya llamado directamente. Este comportamiento se debe al diseño del trigger y cómo SQL Server maneja las operaciones dentro de sus tablas.
Resumen:

    Un trigger puede activar otro trigger implícitamente cuando realiza una operación en una tabla que tiene un trigger asociado.
    Los triggers INSTEAD OF INSERT pueden reemplazar y modificar las operaciones estándar de INSERT, y pueden generar efectos en cadena si insertan datos en tablas que también tienen triggers definidos.
    Este tipo de comportamiento puede ser útil, pero también puede resultar en efectos secundarios no deseados (como inserciones repetidas), por lo que se debe tener cuidado al usar triggers que interactúan entre sí.

*/

-- triggers ciclicos

create or alter trigger tg1_tabla1 
on tabla1 
instead of insert
as
begin
declare @val1 int, @val2 varchar(20)
select @val1=c1, @val2=c2 from inserted
insert into tabla2 values (@val1, @val2)
end

create or alter trigger tg1_tabla2 
on tabla2 
instead of insert
as
begin
declare @val1 int, @val2 varchar(20)
select @val1=c1, @val2=c2 from inserted
insert into tabla1 values (@val1, @val2 + 'x')
end

select * from tabla1
select * from tabla2
insert into tabla1 values (4,'d')
go
/*
¿Qué sucedió al ejecutarse un trigger que posee una tabla con otro trigger en forma cíclica? 
¿Podemos decir que es posible realizar ciclos a través de los triggers o provoca algún error?

¿Qué está pasando?

Un ciclo infinito entre los triggers se está formando, y este ciclo de inserciones entre tabla1 y tabla2 puede continuar indefinidamente.

¿Qué sucederá en la práctica?

    El sistema se quedará atrapado en un ciclo infinito de inserciones. Cada INSERT en tabla1 genera un INSERT en tabla2, y cada INSERT en tabla2 genera un INSERT de vuelta en tabla1.
    SQL Server manejará este ciclo de la siguiente manera: después de un número determinado de operaciones de inserción, se alcanzará un límite de recursión y SQL Server arrojará un error "Maximum trigger recursion" o algo similar. Este límite se configura con el parámetro TRIGGER_MAX_RECURSION, que, por defecto, está establecido en 32.

¿Es posible realizar ciclos a través de los triggers o provoca algún error?

SQL Server previene ciclos infinitos entre triggers, pero al mismo tiempo, es posible que los triggers creen ciclos si no se controla adecuadamente. Cuando los triggers se llaman mutuamente (como en tu caso), se puede generar un bucle recursivo que SQL Server detecta y detiene automáticamente después de un número predeterminado de ejecuciones. Este límite predeterminado es de 32 niveles de recursión, pero se puede ajustar.

*/


-- Vistas

create view vista1
as
select c1 from tabla1 order by 1

/*
¿Se pudo crear? ¿Por qué? ¿Qué debería realizar para corregirlo? Realiza las correcciones necesarias.

¿Por qué no se puede crear esta vista?

    Cláusula ORDER BY en vistas: En SQL Server, no es posible utilizar la cláusula ORDER BY directamente dentro de la definición de una vista, a menos que también se use con una cláusula TOP.
        El motivo es que las vistas son, en esencia, consultas que devuelven un conjunto de resultados sin un orden específico.
        El orden de los resultados de una vista no está garantizado. De hecho, el ORDER BY en una vista no tiene efecto en el orden de las filas cuando se consulta la vista.
        Para garantizar un orden en los resultados de una vista, el ORDER BY debe aplicarse al momento de consultar la vista, no dentro de la vista misma.

Corregido:

create view vista1
as
select c1 from tabla1

select * from vista1 order by 1

La cláusula ORDER BY 1 es una forma abreviada de especificar el orden de las columnas en SQL. El número 1 hace referencia a la primera columna seleccionada en la lista de la consulta SELECT

*/

create view vista2
as
insert into tabla2 values (2,'b')
go
/*
¿Se puede crear una vista con una sentencia de Insert? 
¿Qué sentencias pueden existir en una vista?

No, no se puede crear una vista con una sentencia INSERT en SQL Server. 
Las vistas están diseñadas para representar consultas de lectura, es decir, son una forma de almacenar una consulta 
que se ejecuta para obtener datos de una o más tablas. 
No pueden contener operaciones que modifiquen datos, 
como INSERT, UPDATE, DELETE, o MERGE.
Solo se puede usar SELECT

*/

create view vista2 
as select count(*) from tabla2
go
/*
¿Se pudo crear? ¿Por qué? 
¿Qué debería realizar para corregirlo? Realiza las acciones necesarias.

No, no se puede crear una vista de esa manera. El error se produce porque la consulta que estás tratando de definir en la vista no incluye un alias para el resultado de la función de agregación COUNT(*). 
En SQL Server, cuando se define una vista, la consulta debe devolver un conjunto de resultados que tenga columnas con nombres o alias definidos.

Corregido:

create view vista2 
as select count(*) as cant_filas from tabla2

select * from vista2

*/

create view vista3
as
select * from tabla1,tabla2
where tabla1.c1=tabla2.c1
go
/*
¿Se pudo crear? ¿Por qué? ¿Qué debería realizar para corregirlo?

No se puede crear porque las tablas tienen columnas con igual nombre y esto puede provocar ambiguedades.

Corregido:

CREATE VIEW vista3 AS
SELECT tabla1.c1 AS c1_tabla1, 
       tabla1.c2 AS c2_tabla1,
       tabla2.c1 AS c1_tabla2, 
       tabla2.c2 AS c2_tabla2
FROM tabla1
JOIN tabla2 ON tabla1.c1 = tabla2.c1;

select * from vista3

*/

create view vista4
as
select * from tabla1
go
---------------------
--Verificamos qué datos tiene la vista:
select * from vista4

--Intentamos actualizar la vista:
update vista4 set c1=c1*10 where c1=1
go
/*
¿Se pudo realizar? Sí

¿Se puede actualizar la vista? Si la vista es actualizable, el comando UPDATE debería funcionar correctamente.
¿Por qué no se puede actualizar una vista? Si la vista involucra varias tablas o tiene agregaciones, podría no ser actualizable. También pueden existir restricciones adicionales en la tabla subyacente.
Solución: Si la vista no es actualizable, podrías usar un trigger INSTEAD OF para gestionar la actualización a través de la vista.

*/

alter view vista4
as
select top 10 * from tabla1 order by c1
go
--Intentamos actualizar la vista:
update vista4 set c1=c1*10 where c1=1
go

------

alter view vista4
as
select tabla1.*,tabla2.c1 as t2c1, tabla2.c2 t2c2 from tabla1,tabla2
where tabla1.c1=tabla2.c1
go

update vista4 set c1=c1*10 where c1=2
go
/*

¿Se pudo realizar? ¿Cuándo una vista es actualizable?

La vista no es actualizable en este caso debido a las siguientes razones:

    Involucra múltiples tablas: La vista está basada en dos tablas (tabla1 y tabla2), y al intentar actualizarla, SQL Server no sabe cómo reflejar esa actualización en ambas tablas, ya que no hay una correspondencia directa entre las columnas seleccionadas en la vista y las columnas de las tablas subyacentes.

    En particular:
        Si intentas actualizar la columna c1 a través de la vista, SQL Server no puede determinar si debe actualizar la columna c1 en tabla1 o en tabla2 porque ambas tablas contienen una columna llamada c1.
        La columna c1 en la vista se refiere a tabla1.c1, pero como también existe una columna c1 en tabla2, SQL Server no sabe cómo proceder con la actualización sin especificar a qué tabla debe afectar.

    Columnas de tabla2: En la vista también hay columnas de tabla2 (t2c1 y t2c2), pero estas columnas no son directamente actualizables, ya que t2c1 y t2c2 son alias para las columnas de tabla2. Esto agrega más complejidad a la actualización, ya que SQL Server no puede determinar cómo reflejar los cambios en estas columnas a las tablas subyacentes.

Cuándo una vista es actualizable:

Una vista será actualizable si cumple con ciertas condiciones. En general, para que una vista sea actualizable, debe cumplir con las siguientes reglas:

    La vista debe estar basada en una sola tabla: Si una vista involucra múltiples tablas (por ejemplo, un JOIN entre tabla1 y tabla2), la vista generalmente no será actualizable, a menos que utilices un trigger INSTEAD OF para manejar las actualizaciones manualmente.

    No debe contener operaciones que cambien el número de filas: La vista no debe involucrar operaciones como GROUP BY, DISTINCT, o TOP, ya que estas operaciones cambian el número de filas que se devuelven, lo que hace que SQL Server no pueda determinar cómo reflejar una actualización en la tabla subyacente.

    Debe ser una representación unívoca de las filas de la tabla subyacente: Si la vista no puede mapear de manera unívoca las filas de la tabla subyacente, no será actualizable. Esto es especialmente importante cuando la vista involucra combinaciones de múltiples tablas.

    La vista no debe tener funciones agregadas: Si la vista contiene funciones agregadas (por ejemplo, SUM(), AVG()), entonces no es actualizable porque no se puede determinar cómo realizar una actualización sobre el conjunto de resultados agregados.

    No debe tener UNION ni DISTINCT: Las vistas que usan UNION, UNION ALL o DISTINCT para combinar filas de diferentes conjuntos de datos no son actualizables, porque SQL Server no puede determinar cómo propagar los cambios a las tablas subyacentes.

*/

-- Funciones:

create function function1()
returns int
as
begin
update tabla1 set c1=c1*10
return (select count(*) from tabla1)
end

/*
La razón por la que no se pudo crear esta función es que una función en SQL Server (de tipo scalar o table-valued) no puede contener sentencias que modifiquen el estado de la base de datos, como en este caso el UPDATE. 
Las funciones en SQL Server están limitadas a operaciones que solo devuelvan valores o resultados sin alterar los datos en las tablas subyacentes.

Tipo de sentencias que permiten las funciones en SQL Server:

Las funciones en SQL Server permiten solo las siguientes operaciones:

    Sentencias de consulta (SELECT):
        Las funciones pueden ejecutar consultas SELECT para obtener valores que devuelvan resultados (como un valor escalar o una tabla).

    Ejemplo:

	CREATE FUNCTION GetEmployeeCount()
	RETURNS INT
	AS
	BEGIN
		RETURN (SELECT COUNT(*) FROM Employees);
	END;

	Declaración de variables:

		Las funciones pueden declarar variables para almacenar valores temporales durante su ejecución.

	Operaciones aritméticas o lógicas:

		Pueden realizar cálculos, manipulaciones de cadenas o operaciones lógicas.

	Operaciones de tipo condicional (IF, CASE, BEGIN...END):

		Puedes usar lógica condicional dentro de la función para devolver valores basados en ciertas condiciones.

No permiten modificar datos (es decir, no se pueden usar INSERT, UPDATE, DELETE, ni cambios de estado).

*/