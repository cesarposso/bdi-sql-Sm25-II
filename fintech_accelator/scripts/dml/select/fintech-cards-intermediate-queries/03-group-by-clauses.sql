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
    fr.name AS franchise,
    co.name AS country,
    ROUND(100.0 * SUM(CASE WHEN tr.status = 'Rejected' THEN 1 ELSE 0 END) / COUNT(tr.transaction_id), 2) AS rejection_rate,
    COUNT(tr.transaction_id) AS total_attempts

FROM fintech.transactions AS tr
JOIN fintech.merchant_locations AS ml ON tr.location_id = ml.location_id
JOIN fintech.countries AS co ON ml.country_code = co.country_code
JOIN fintech.credit_cards AS cc ON tr.card_id = cc.card_id
JOIN fintech.franchises AS fr ON cc.franchise_id = fr.franchise_id

GROUP BY fr.name, co.name
HAVING 
    SUM(CASE WHEN tr.status = 'Rejected' THEN 1 ELSE 0 END) >= 1 -- asegura que haya al menos un rechazo
    AND COUNT(tr.transaction_id) >= 100
    AND ROUND(100.0 * SUM(CASE WHEN tr.status = 'Rejected' THEN 1 ELSE 0 END) / COUNT(tr.transaction_id), 2) > 5

ORDER BY rejection_rate DESC
LIMIT 10;




/**
4. Mostrar los métodos de pago más utilizados por cada ciudad, 
incluyendo el nombre del método, ciudad, país y cantidad de 
transacciones, filtrando solo aquellas
combinaciones que representen más del 20% .
del total de transacciones de esa ciudad.
**/
WITH city_totals AS (
    SELECT 
        ml.city,
        COUNT(tr.transaction_id) AS total_city_transactions
    FROM fintech.transactions AS tr
    JOIN fintech.merchant_locations AS ml ON tr.location_id = ml.location_id
    GROUP BY ml.city
)

SELECT 
    pm.name AS payment_method,
    ml.city,
    co.name AS country,
    COUNT(tr.transaction_id) AS method_usage,
    ROUND(100.0 * COUNT(tr.transaction_id) / ct.total_city_transactions, 2) AS method_percentage

FROM fintech.transactions AS tr
JOIN fintech.merchant_locations AS ml ON tr.location_id = ml.location_id
JOIN fintech.countries AS co ON ml.country_code = co.country_code
JOIN fintech.payment_methods AS pm ON tr.method_id = pm.method_id
JOIN city_totals AS ct ON ml.city = ct.city

GROUP BY pm.name, ml.city, co.name, ct.total_city_transactions
HAVING ROUND(100.0 * COUNT(tr.transaction_id) / ct.total_city_transactions, 2) > 20
ORDER BY ml.city, method_percentage DESC;

/**
Analizar el comportamiento de compra por género y rango de edad, 
mostrando el total gastado, promedio por transacción y número de operaciones 
completadas, incluyendo solo los grupos demográficos 
que tengan al menos 30 clientes activos.
**/
WITH client_info AS (
    SELECT 
        cl.client_id,
        cl.gender,
        FLOOR(EXTRACT(YEAR FROM AGE(CURRENT_DATE, cl.birth_date)) / 10) * 10 AS age_range
    FROM fintech.clients AS cl
)

SELECT 
    ci.gender,
    ci.age_range || 's' AS age_group,
    COUNT(DISTINCT ci.client_id) AS total_clients,
    COUNT(tr.transaction_id) AS total_transactions,
    SUM(tr.amount) AS total_spent,
    ROUND(AVG(tr.amount), 2) AS avg_transaction

FROM fintech.transactions AS tr
JOIN fintech.credit_cards AS cc ON tr.card_id = cc.card_id
JOIN client_info AS ci ON cc.client_id = ci.client_id

WHERE tr.transaction_date >= (CURRENT_DATE - INTERVAL '6 months')

GROUP BY ci.gender, ci.age_range
HAVING COUNT(DISTINCT ci.client_id) >= 30
ORDER BY age_range, gender;
