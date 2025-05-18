-- JOINS APPLICATION
-- DATABASE: FINTECH_CARDS
-- LAST_UPDATED: 10/05/2025

/**
INNER JOIN: Listar todas las transacciones con detalles del cliente, 
incluyendo nombre del cliente, monto de la transacción, 
nombre del comercio y método de pago utilizado.
**/

-- JOIN (transactions -> merchant_locations -> credit_cards -> clients ->payment_methods)
SELECT 
    (cl.first_name ||' '||COALESCE(cl.middle_name, '')||' '||cl.last_name) AS client,
    tr.amount AS transaction_amount,
    ml.store_name AS purchased_store,
    pm.name AS payment_method

FROM fintech.transactions AS tr
    INNER JOIN fintech.merchant_locations AS ml
    ON tr.location_id = ml.location_id
    INNER JOIN fintech.credit_cards AS cc
    ON tr.card_id = cc.card_id
    INNER JOIN fintech.clients AS cl
    ON cl.client_id = cc.client_id
    INNER JOIN fintech.payment_methods AS pm
    ON tr.method_id = pm.method_id

LIMIT 10;

/**
LEFT JOIN: Listar todos los clientes y sus tarjetas de crédito, 
incluyendo aquellos clientes que no tienen ninguna 
tarjeta registrada en el sistema.
**/

SELECT 
    (cl.first_name ||' '||COALESCE(cl.middle_name, '')||' '||cl.last_name) AS client,
    cc.card_id AS credit_card

FROM fintech.clients AS cl
    LEFT JOIN fintech.credit_cards AS cc
    ON cl.client_id = cc.client_id

LIMIT 10;


/**
RIGHT JOIN: Listar todas las ubicaciones comerciales y las transacciones 
realizadas en ellas, incluyendo aquellas ubicaciones donde 
aún no se han registrado transacciones.
**/
SELECT
    tr.transaction_id AS id_transaction,
    ml.location_id AS id_locations

FROM fintech.transactions AS tr
RIGHT JOIN fintech.merchant_locations AS ml
  ON tr.location_id = ml.location_id

LIMIT 10;



/**
FULL JOIN: Listar todas las franquicias y los países donde operan, 
incluyendo franquicias que no están asociadas a ningún país 
específico y países que no tienen franquicias operando en ellos.
**/

SELECT 
    fr.name AS franchise,
    c.name AS country    

FROM fintech.franchises AS fr

FULL JOIN fintech.countries AS c
    ON fr.country_code = c.country_code

limit 10;

/**
SELF JOIN: Encontrar pares de transacciones realizadas por el mismo 
cliente en la misma ubicación comercial en diferentes
**/

SELECT 
    cl.first_name || ' ' || COALESCE(cl.middle_name, '') || ' ' || cl.last_name AS client,
    ml.store_name AS store,
    t1.transaction_id AS transaction_1,
    t1.transaction_date AS date_1,
    t2.transaction_id AS transaction_2,
    t2.transaction_date AS date_2

FROM fintech.transactions t1
JOIN fintech.transactions t2
    ON t1.card_id = t2.card_id
    AND t1.location_id = t2.location_id
    AND t1.transaction_id < t2.transaction_id

JOIN fintech.credit_cards cc ON t1.card_id = cc.card_id
JOIN fintech.clients cl ON cc.client_id = cl.client_id
JOIN fintech.merchant_locations ml ON t1.location_id = ml.location_id

LIMIT 10;
