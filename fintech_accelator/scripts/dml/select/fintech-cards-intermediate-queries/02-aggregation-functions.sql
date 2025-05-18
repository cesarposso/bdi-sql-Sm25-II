-- JOINS APPLICATION
-- DATABASE: FINTECH_CARDS
-- LAST_UPDATED: 10/05/2025


/**
SUM: Calcular el monto total de transacciones realizadas por cada cliente 
en los últimos 3 meses, mostrando el nombre del cliente y el total gastado.
**/
-- FK: (transactions -> credit_cards -> clients)
SELECT
	cl.client_id,
    (cl.first_name ||' '||cl.last_name) AS client,
    COUNT(*) AS total_transactions_done,
    SUM(tr.amount) AS total_amount_spent
FROM 
    fintech.transactions AS tr
INNER JOIN fintech.credit_cards AS cc
    ON tr.card_id = cc.card_id
INNER JOIN fintech.clients AS cl
    ON cc.client_id = cl.client_id
WHERE 
    tr.transaction_date >= (CURRENT_DATE - INTERVAL '3 months')
GROUP BY cl.client_id, cl.first_name, cl.last_name
ORDER BY cl.client_id DESC
LIMIT 5;

-- check specific transactions
SELECT tr.amount, tr.transaction_date, cc.card_id, cc.client_id
FROM fintech.TRANSACTIONS as tr
INNER JOIN fintech.credit_cards AS cc
ON tr.card_id = cc.card_id
WHERE cc.client_id = '  INS-AUTO17924456385';



/**
AVG: Obtener el valor promedio de las transacciones agrupadas por categoría
de comercio y método de pago, para identificar los patrones de gasto según 
el tipo de establecimiento.
**/

SELECT 
    ml.category AS store_category,
    pm.name AS payment_method,
    AVG(tr.amount) AS avg_transaction_amount

FROM fintech.transactions AS tr
JOIN fintech.merchant_locations AS ml ON tr.location_id = ml.location_id
JOIN fintech.payment_methods AS pm ON tr.method_id = pm.method_id

GROUP BY ml.category, pm.name
ORDER BY avg_transaction_amount DESC;

/**
COUNT: Contar el número de tarjetas de crédito emitidas por cada entidad 
bancaria (issuer), agrupadas por franquicia, mostrando qué bancos 
tienen mayor presencia por tipo de tarjeta.
**/

SELECT 
    fr.name AS franchise,
    COUNT(cc.card_id) AS total_cards_issued

FROM fintech.credit_cards AS cc
JOIN fintech.franchises AS fr 
    ON cc.franchise_id = fr.franchise_id

GROUP BY fr.name
ORDER BY total_cards_issued DESC;



/**
MIN y MAX: Mostrar el monto de transacción más bajo y más alto para cada 
cliente, junto con la fecha en que ocurrieron, para identificar patrones 
de gasto extremos.
**/

SELECT 
    cl.client_id,
    (cl.first_name || ' ' || cl.last_name) AS client,

    MIN(tr.amount) AS min_transaction,
    MAX(tr.amount) AS max_transaction,

    (SELECT tr1.transaction_date 
     FROM fintech.transactions tr1 
     WHERE tr1.card_id = cc.card_id 
     ORDER BY tr1.amount ASC 
     LIMIT 1) AS date_min,

    (SELECT tr2.transaction_date 
     FROM fintech.transactions tr2 
     WHERE tr2.card_id = cc.card_id 
     ORDER BY tr2.amount DESC 
     LIMIT 1) AS date_max

FROM fintech.transactions AS tr
JOIN fintech.credit_cards AS cc ON tr.card_id = cc.card_id
JOIN fintech.clients AS cl ON cc.client_id = cl.client_id

GROUP BY cl.client_id, cl.first_name, cl.last_name, cc.card_id
ORDER BY cl.client_id
LIMIT 10;
