--DELETE LAST PAYMENT METHOD
DELETE FROM fintech.payment_methods
WHERE method_id = (SELECT method_id FROM fintech.payment_methods WHERE name = 'Apple Pay');