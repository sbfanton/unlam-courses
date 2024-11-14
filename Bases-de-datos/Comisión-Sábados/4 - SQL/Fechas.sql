select getdate() as FechaHora_actual

SELECT CAST('2024-11-13' AS DATE) AS FechaConvertida;
SELECT CAST('2024-11-13' AS DATETIME) AS FechaHoraConvertida;


/*DATEDIFF

La función DATEDIFF calcula la diferencia entre dos fechas y devuelve el resultado en una unidad de tiempo específica (como días, meses, años, horas, minutos, etc.).
Sintaxis:

DATEDIFF(unidad, fecha_inicial, fecha_final)

    unidad: Especifica la unidad de tiempo en la que deseas medir la diferencia. Algunas de las unidades más comunes son:
        year o yy (años)
        quarter o qq (trimestres)
        month o mm (meses)
        day o dd (días)
        hour o hh (horas)
        minute o mi (minutos)
        second o ss (segundos)
        millisecond (milisegundos)

    fecha_inicial: La primera fecha de la comparación.

    fecha_final: La segunda fecha de la comparación.

*/

SELECT DATEDIFF(day, '2024-01-01', getDate()) AS DiferenciaEnDias;


/*
DATEADD

La función DATEADD se utiliza para sumar o restar un intervalo de tiempo a una fecha dada.
Sintaxis:

DATEADD(unidad, cantidad, fecha)

    unidad: Especifica la unidad de tiempo en la que se sumará o restará la cantidad. Puede ser lo mismo que en DATEDIFF (por ejemplo, year, month, day, etc.).
    cantidad: La cantidad que deseas sumar o restar (puede ser un número positivo o negativo).
    fecha: La fecha a la que se le sumará o restará la cantidad.
*/

-- Sumando dias:

SELECT DATEADD(day, 10, '2024-11-01') AS NuevaFecha;

-- Restando meses:

SELECT DATEADD(month, -2, '2024-11-13') AS FechaRestada;

