-- JOINS APPLICATION
-- DATABASE: FINTECH_CARDS
-- LAST_UPDATED: 10/05/202

/**
1. Obtener el total de gastos por cliente en los últimos 6 meses, 
mostrando solo aquellos que han gastado más de $5,000, 
incluyendo su nombre completo y cantidad de transacciones realizadas.
*/
SELECT 
    cl.client_id,
    (cl.first_name || ' ' || COALESCE(cl.middle_name, '') || ' ' || cl.last_name) AS client,
    COUNT(tr.transaction_id) AS total_transactions,
    SUM(tr.amount) AS total_spent

FROM fintech.transactions AS tr
JOIN fintech.credit_cards AS cc ON tr.card_id = cc.card_id
JOIN fintech.clients AS cl ON cc.client_id = cl.client_id

WHERE tr.transaction_date >= (CURRENT_DATE - INTERVAL '6 months')

GROUP BY cl.client_id, cl.first_name, cl.middle_name, cl.last_name
HAVING SUM(tr.amount) > 5000
ORDER BY total_spent DESC;


/**
2. Listar las categorías de comercios con el promedio de transacciones
por país, mostrando solo aquellas categorías donde el 
promedio de transacción supere los $100 y se hayan 
realizado al menos 50 operaciones.
**/

SELECT
	ml.category,
  AVG(tr.amount) AS avg_transactions,
  COUNT(tr.transaction_id) AS total_operations_made,
  co.name AS country
FROM 
	fintech.merchant_locations AS ml
INNER JOIN fintech.transactions AS tr
	ON ml.location_id = tr.location_id
INNER JOIN fintech.countries AS co
	ON ml.country_code = co.country_code
--WHERE ml.country_code = 'CO' optional filter by colombia
GROUP BY ml.category, co.name
HAVING AVG(tr.amount) > 100
	AND COUNT(tr.transaction_id) >= 50
ORDER BY total_operations_made DESC;


/**
3. Identificar las franquicias de tarjetas con mayor tasa de rechazo 
de transacciones por país, mostrando el nombre de la franquicia, 
país y porcentaje de rechazos, limitando a aquellas 
con más de 5% de rechazos y al menos 100 intentos de transacción.
**/

SELECT 
    fr.name AS franquicia,
    co.name AS pais,
    (re.rechazos * 100.0 / tot.total) AS porcentaje_rechazos,
    tot.total AS intentos

FROM 
    (
        SELECT 
            cc.franchise_id,
            ml.country_code,
            COUNT(*) AS total
        FROM fintech.transactions tr
        INNER JOIN fintech.merchant_locations ml ON tr.location_id = ml.location_id
        INNER JOIN fintech.credit_cards cc ON tr.card_id = cc.card_id
        GROUP BY cc.franchise_id, ml.country_code
    ) AS tot

INNER JOIN 
    (
        SELECT 
            cc.franchise_id,
            ml.country_code,
            COUNT(*) AS rechazos
        FROM fintech.transactions tr
        INNER JOIN fintech.merchant_locations ml ON tr.location_id = ml.location_id
        INNER JOIN fintech.credit_cards cc ON tr.card_id = cc.card_id
        WHERE tr.status = 'Rejected'
        GROUP BY cc.franchise_id, ml.country_code
    ) AS re

ON tot.franchise_id = re.franchise_id AND tot.country_code = re.country_code

INNER JOIN fintech.franchises fr ON tot.franchise_id = fr.franchise_id
INNER JOIN fintech.countries co ON tot.country_code = co.country_code

WHERE 
    (re.rechazos * 100.0 / tot.total) > 5
    AND tot.total >= 100

ORDER BY porcentaje_rechazos DESC
LIMIT 10;

--No muestra nada porque nadie ha realizado 100 o mas intentos


/**
4. Mostrar los métodos de pago más utilizados por cada ciudad, 
incluyendo el nombre del método, ciudad, país y cantidad de 
transacciones, filtrando solo aquellas
combinaciones que representen más del 20% .
del total de transacciones de esa ciudad.
**/
SELECT 
    pm.name AS metodo_pago,
    ml.city AS ciudad,
    c.name AS pais,
    COUNT(*) AS cantidad_transacciones

FROM fintech.transactions t
INNER JOIN fintech.merchant_locations ml ON t.location_id = ml.location_id
INNER JOIN fintech.payment_methods pm ON t.method_id = pm.method_id
INNER JOIN fintech.countries c ON ml.country_code = c.country_code

GROUP BY pm.name, ml.city, c.name
HAVING 
    COUNT(*) > (
        SELECT 
            COUNT(*) * 0.20
        FROM fintech.transactions t2
        INNER JOIN fintech.merchant_locations ml2 ON t2.location_id = ml2.location_id
        WHERE ml2.city = ml.city
    )
ORDER BY ml.city, cantidad_transacciones DESC

LIMIT 10;


/**
Analizar el comportamiento de compra por género y rango de edad, 
mostrando el total gastado, promedio por transacción y número de operaciones 
completadas, incluyendo solo los grupos demográficos 
que tengan al menos 30 clientes activos.
**/
SELECT
    c.gender,
    CONCAT(
        (DATE_PART('year', AGE(CURRENT_DATE, c.birth_date)) / 10)::int * 10,
        's'
    ) AS rango_edad,
    SUM(t.amount) AS total_gastado,
    AVG(t.amount) AS promedio_por_transaccion,
    COUNT(*) AS numero_operaciones

FROM fintech.clients c
INNER JOIN fintech.credit_cards cc ON c.client_id = cc.client_id
INNER JOIN fintech.transactions t ON cc.card_id = t.card_id

WHERE t.status = 'Completed'

GROUP BY c.gender, CONCAT(
    (DATE_PART('year', AGE(CURRENT_DATE, c.birth_date)) / 10)::int * 10,
    's'
)

HAVING COUNT(DISTINCT c.client_id) >= 30

ORDER BY total_gastado DESC;
