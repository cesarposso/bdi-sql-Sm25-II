-- CLIENTS
INSERT INTO fintech.clients 
(client_id, first_name, middle_name, last_name, gender, birth_date, email, phone, address)
VALUES
('INS-AUTO17924456381', 'Camila', 'Andrea', 'Rodríguez Gómez', 'Female', '1992-07-15', 'camila.rodriguez@gmail.com', '+573151234567', 'Calle 85 #23-45, Bogotá, Colombia'),
('INS-AUTO17924456382', 'Santiago', 'José', 'Martínez Ospina', 'Male', '1988-03-22', 'santiago.martinez@outlook.com', '+573209876543', 'Carrera 42 #18-30, Medellín, Colombia'),
('INS-AUTO17924456383', 'Valentina', 'María', 'García Restrepo', 'Female', '1995-11-08', 'valentina.garcia@hotmail.com', '+573187654321', 'Avenida 5 Norte #23-41, Cali, Colombia'),
('INS-AUTO17924456384', 'Andrés', 'Felipe', 'López Sánchez', 'Male', '1990-05-30', 'andres.lopez@yahoo.com', '+573004567890', 'Calle 27 #35-19, Barranquilla, Colombia'),
('INS-AUTO17924456385', 'Isabella', 'Sofía', 'Hernández Pérez', 'Female', '1993-09-12', 'isabella.hernandez@gmail.com', '+573112345678', 'Carrera 15 #78-44, Bucaramanga, Colombia');

-- ISSUERS
INSERT INTO fintech.issuers 
(issuer_id, name, bank_code, contact_phone, country_code)
VALUES
('ISU-007BANCOLOMBIA', 'Bancolombia S.A.', '07', '+57604510900', 'CO'),
('ISU-051DAVIVIENDA', 'Banco Davivienda S.A.', '51', '+57018000123838', 'CO'),
('ISU-013BBVACOLOMBIA', 'BBVA Colombia S.A.', '13', '+57601401000', 'CO'),
('ISU-001BOGOTA', 'Banco de Bogotá', '01', '+57601343000', 'CO'),
('ISU-023OCCIDENTE', 'Banco de Occidente', '23', '+57602554000', 'CO');

-- FRANCHISES
INSERT INTO fintech.FRANCHISES 
(name, issuer_id, country_code)
VALUES
-- Franquicias para Bancolombia
('Visa', 'ISU-007BANCOLOMBIA', 'CO'),
('MasterCard', 'ISU-007BANCOLOMBIA', 'CO'),
('American Express', 'ISU-007BANCOLOMBIA', 'CO'),

-- Franquicias para Davivienda
('Visa', 'ISU-051DAVIVIENDA', 'CO'),
('MasterCard', 'ISU-051DAVIVIENDA', 'CO'),

-- Franquicias para BBVA Colombia
('Visa', 'ISU-013BBVACOLOMBIA', 'CO'),
('MasterCard', 'ISU-013BBVACOLOMBIA', 'CO'),

-- Franquicias para Banco de Bogotá
('Visa', 'ISU-001BOGOTA', 'CO'),
('MasterCard', 'ISU-001BOGOTA', 'CO'),

-- Franquicias para Banco de Occidente
('Visa', 'ISU-023OCCIDENTE', 'CO');

-- CREDIT CARDS
INSERT INTO fintech.CREDIT_CARDS 
(card_id, client_id, issue_date, expiration_date, status, franchise_id)
VALUES
-- Cliente 1 con dos tarjetas
('4539789612345678', 'INS-AUTO17924456381', '2022-03-15', '2027-03-31', 'Activate', 1150001), -- Visa
('5236784512349876', 'INS-AUTO17924456381', '2023-07-10', '2028-07-31', 'Activate', 1150005), -- MasterCard

-- Cliente 2 con dos tarjetas
('4916123456789012', 'INS-AUTO17924456382', '2021-11-05', '2026-11-30', 'Blocked', 1150002), -- Visa
('376412349876123', 'INS-AUTO17924456382', '2024-01-20', '2029-01-31', 'Activate', 1150008), -- American Express

-- Cliente 3 con una tarjeta
('5432167890123456', 'INS-AUTO17924456383', '2023-05-12', '2028-05-31', 'Activate', 1150003), -- MasterCard

-- Cliente 4 con tres tarjetas
('6011234567890123', 'INS-AUTO17924456384', '2022-09-18', '2027-09-30', 'Activate', 1150004), -- Discover
('345267894561234', 'INS-AUTO17924456384', '2023-02-25', '2028-02-28', 'Blocked', 1150006), -- American Express
('5678901234567890', 'INS-AUTO17924456384', '2021-08-30', '2026-08-31', 'Canceled', 1150009), -- MasterCard

-- Cliente 5 con dos tarjetas
('4123456789012345', 'INS-AUTO17924456385', '2024-02-05', '2029-02-28', 'Activate', 1150007), -- Visa
('6759123456789012', 'INS-AUTO17924456385', '2023-10-15', '2028-10-31', 'Activate', 1150010)  -- Maestro

-- MERCHANT LOCATION
-- Inserts para la tabla fintech.MERCHANT_LOCATIONS
INSERT INTO fintech.MERCHANT_LOCATIONS (store_name, category, city, country_code, latitude, longitude)
VALUES ('Almacenes Éxito', 'General Store', 'Bogotá', 'CO', 4.6097, -74.0817),
('El Corte Textil', 'Collection', 'Medellín', 'CO', 6.2476, -75.5658),
('Creative Design Studio', 'Studio', 'Cali', 'CO', 3.4516, -76.5320),
('Digital Tech Store', 'Store', 'Barranquilla', 'CO', 10.9639, -74.7964),
('Artesanías Colombianas', 'Shop', 'Cartagena', 'CO', 10.3932, -75.4832),
('Luxury Fashion Boutique', 'Boutique', 'Bogotá', 'CO', 4.6840, -74.0450),
('Gran Bodega Industrial', 'Warehouse', 'Bucaramanga', 'CO', 7.1254, -73.1198),
('Distribuidora Nacional', 'Supply', 'Cúcuta', 'CO', 7.8890, -72.4966),
('Tienda Todo en Uno', 'General Store', 'Pereira', 'CO', 4.8133, -75.6961),
('Colección Vintage', 'Collection', 'Santa Marta', 'CO', 11.2404, -74.2113),
('Arte y Diseño', 'Studio', 'Manizales', 'CO', 5.0687, -75.5173),
('Tech Solutions', 'Store', 'Villavicencio', 'CO', 4.1420, -73.6279),
('Ecomarket', 'Shop', 'Pasto', 'CO', 1.2136, -77.2811),
('Designer Collections', 'Boutique', 'Popayán', 'CO', 2.4448, -76.6147),
('Suministros Industriales', 'Supply', 'Ibagué', 'CO', 4.4389, -75.2322);

-- TRANSACTIONS
INSERT INTO fintech.TRANSACTIONS (transaction_id, card_id, amount, currency, transaction_date, channel, status, device_type, location_id, method_id)
VALUES
('TR-20250511-001', '4539789612345678', 875000.00, 'COP', '2025-01-10 08:30:45', 'Physical', 'Completed', 'POS', 1150005, 2),
('TR-20250511-002', '5236784512349876', 2350000.00, 'COP', '2025-01-10 09:45:12', 'Digital', 'Completed', 'Web browser', 1150008, 1),
('TR-20250511-003', '4916123456789012', 632500.00, 'COP', '2025-01-10 10:15:33', 'Physical', 'Completed', 'POS', 1150003, 3),
('TR-20250511-004', '376412349876123', 4500000.00, 'COP', '2025-01-10 11:22:18', 'Digital', 'Rejected', 'Mobile', 1150012, 4),
('TR-20250511-005', '5432167890123456', 1250000.00, 'COP', '2025-01-10 12:05:59', 'Physical', 'Completed', 'Smartwatch', 1150001, 2),
('TR-20250511-006', '6011234567890123', 8700000.00, 'COP', '2025-01-10 13:45:27', 'Digital', 'Completed', 'Web browser', 1150014, 1),
('TR-20250511-007', '345267894561234', 950000.00, 'COP', '2025-01-10 14:30:10', 'Physical', 'Pending', 'POS', 1150007, 3),
('TR-20250511-008', '5678901234567890', 3200000.00, 'COP', '2025-01-10 15:20:42', 'Digital', 'Completed', 'Tablet', 1150010, 4),
('TR-20250511-009', '4123456789012345', 1550000.00, 'COP', '2025-01-10 16:15:30', 'Physical', 'Completed', 'POS', 1150004, 2),
('TR-20250511-010', '6759123456789012', 7250000.00, 'COP', '2025-01-10 17:40:15', 'Digital', 'Rejected', 'Mobile', 1150013, 1),
('TR-20250511-011', '4539789612345678', 5350000.00, 'COP', '2025-01-09 08:15:22', 'Physical', 'Completed', 'Kiosk', 1150002, 3),
('TR-20250511-012', '5236784512349876', 745000.00, 'COP', '2025-01-09 09:30:40', 'Digital', 'Completed', 'Voice assistant', 1150009, 4),
('TR-20250511-013', '4916123456789012', 10800000.00, 'COP', '2025-01-09 10:45:18', 'Physical', 'Completed', 'POS', 1150006, 2),
('TR-20250511-014', '376412349876123', 1580000.00, 'COP', '2025-01-09 11:50:33', 'Digital', 'Pending', 'Smart TV', 1150015, 1),
('TR-20250511-015', '5432167890123456', 925000.00, 'COP', '2025-02-09 12:25:14', 'Physical', 'Completed', 'POS', 1150003, 3),
('TR-20250511-016', '6011234567890123', 3450000.00, 'COP', '2025-02-09 13:40:59', 'Digital', 'Completed', 'Web browser', 1150011, 4),
('TR-20250511-017', '345267894561234', 6780000.00, 'COP', '2025-02-09 14:55:27', 'Physical', 'Rejected', 'ATM', 1150008, 2),
('TR-20250511-018', '5678901234567890', 1120000.00, 'COP', '2025-02-09 15:10:48', 'Digital', 'Completed', 'Mobile', 1150001, 1),
('TR-20250511-019', '4123456789012345', 4750000.00, 'COP', '2025-02-09 16:30:22', 'Physical', 'Completed', 'POS', 1150014, 3),
('TR-20250511-020', '6759123456789012', 890000.00, 'COP', '2025-02-09 17:45:36', 'Digital', 'Completed', 'Tablet', 1150007, 4),
('TR-20250511-021', '4539789612345678', 2850000.00, 'COP', '2025-02-08 09:05:12', 'Physical', 'Completed', 'POS', 1150010, 2),
('TR-20250511-022', '5236784512349876', 11500000.00, 'COP', '2025-02-08 10:20:45', 'Digital', 'Pending', 'Web browser', 1150004, 1),
('TR-20250511-023', '4916123456789012', 780000.00, 'COP', '2025-02-08 11:35:30', 'Physical', 'Completed', 'Car system', 1150013, 3),
('TR-20250511-024', '376412349876123', 2350000.00, 'COP', '2025-02-08 12:50:18', 'Digital', 'Completed', 'Mobile', 1150002, 4),
('TR-20250511-025', '5432167890123456', 4920000.00, 'COP', '2025-02-08 13:15:42', 'Physical', 'Rejected', 'POS', 1150009, 2),
('TR-20250511-026', '6011234567890123', 670000.00, 'COP', '2025-02-08 14:30:27', 'Digital', 'Completed', 'Smart TV', 1150006, 1),
('TR-20250511-027', '345267894561234', 3280000.00, 'COP', '2025-02-08 15:45:59', 'Physical', 'Completed', 'POS', 1150015, 3),
('TR-20250511-028', '5678901234567890', 9350000.00, 'COP', '2025-02-08 16:10:33', 'Digital', 'Completed', 'Web browser', 1150003, 4),
('TR-20250511-029', '4123456789012345', 1850000.00, 'COP', '2025-02-08 17:25:14', 'Physical', 'Completed', 'Kiosk', 1150011, 2),
('TR-20250511-030', '6759123456789012', 5150000.00, 'COP', '2025-02-08 18:40:27', 'Digital', 'Pending', 'Mobile', 1150008, 1),
('TR-20250511-031', '4539789612345678', 725000.00, 'COP', '2025-02-07 08:05:18', 'Physical', 'Completed', 'POS', 1150001, 3),
('TR-20250511-032', '5236784512349876', 2980000.00, 'COP', '2025-02-07 09:20:42', 'Digital', 'Rejected', 'Voice assistant', 1150014, 4),
('TR-20250511-033', '4916123456789012', 11200000.00, 'COP', '2025-02-07 10:35:30', 'Physical', 'Completed', 'ATM', 1150007, 2),
('TR-20250511-034', '376412349876123', 835000.00, 'COP', '2025-02-07 11:50:15', 'Digital', 'Completed', 'Web browser', 1150010, 1),
('TR-20250511-035', '5432167890123456', 3650000.00, 'COP', '2025-02-07 12:15:33', 'Physical', 'Completed', 'POS', 1150004, 3),
('TR-20250511-036', '6011234567890123', 6250000.00, 'COP', '2025-02-07 13:30:59', 'Digital', 'Completed', 'Mobile', 1150013, 4),
('TR-20250511-037', '345267894561234', 930000.00, 'COP', '2025-03-07 14:45:27', 'Physical', 'Pending', 'Smartwatch', 1150002, 2),
('TR-20250511-038', '5678901234567890', 4520000.00, 'COP', '2025-03-07 15:10:48', 'Digital', 'Completed', 'Tablet', 1150009, 1),
('TR-20250511-039', '4123456789012345', 8780000.00, 'COP', '2025-03-07 16:25:22', 'Physical', 'Rejected', 'POS', 1150006, 3),
('TR-20250511-040', '6759123456789012', 1340000.00, 'COP', '2025-03-07 17:40:36', 'Digital', 'Completed', 'Web browser', 1150015, 4),
('TR-20250511-041', '4539789612345678', 5750000.00, 'COP', '2025-03-06 09:15:12', 'Physical', 'Completed', 'Car system', 1150003, 2),
('TR-20250511-042', '5236784512349876', 920000.00, 'COP', '2025-03-06 10:30:45', 'Digital', 'Completed', 'Mobile', 1150011, 1),
('TR-20250511-043', '4916123456789012', 3180000.00, 'COP', '2025-03-06 11:45:30', 'Physical', 'Completed', 'POS', 1150008, 3),
('TR-20250511-044', '376412349876123', 6850000.00, 'COP', '2025-03-06 12:00:18', 'Digital', 'Pending', 'Smart TV', 1150001, 4),
('TR-20250511-045', '5432167890123456', 1120000.00, 'COP', '2025-03-06 13:15:42', 'Physical', 'Completed', 'Kiosk', 1150014, 2),
('TR-20250511-046', '6011234567890123', 4950000.00, 'COP', '2025-03-06 14:30:27', 'Digital', 'Rejected', 'Web browser', 1150007, 1),
('TR-20250511-047', '345267894561234', 9780000.00, 'COP', '2025-03-06 15:45:59', 'Physical', 'Completed', 'POS', 1150010, 3),
('TR-20250511-048', '5678901234567890', 690000.00, 'COP', '2025-03-06 16:00:33', 'Digital', 'Completed', 'Mobile', 1150004, 4),
('TR-20250511-049', '4123456789012345', 2350000.00, 'COP', '2025-04-06 17:15:14', 'Physical', 'Completed', 'POS', 1150013, 2),
('TR-20250511-050', '6759123456789012', 7450000.00, 'COP', '2025-05-06 18:30:27', 'Digital', 'Completed', 'Tablet', 1150002, 1);

------------- NEW TRANSACTIONS ------------------

CREATE OR REPLACE PROCEDURE fintech.generate_deterministic_transactions()
LANGUAGE plpgsql
AS $$
DECLARE
    v_currencies TEXT[];
    v_card_ids TEXT[];
    v_transaction_id VARCHAR(50);
    v_card_id VARCHAR(50);
    v_amount DECIMAL(15,2);
    v_currency VARCHAR(3);
    v_transaction_date TIMESTAMP(6);
    v_channel VARCHAR(50);
    v_status VARCHAR(20);
    v_device_type VARCHAR(50);
    v_location_id INT;
    v_method_id INT;
    v_am_pm VARCHAR(2);
    v_random_number VARCHAR(24);
    v_counter INTEGER := 0;
    v_microseconds INTEGER;
    v_seed REAL := 42; -- Semilla fija para reproducibilidad
    v_predetermined_values RECORD;
    
    -- Arrays predefinidos para los valores deterministas
    v_amounts DECIMAL(15,2)[] := ARRAY[1450.25, 2780.50, 3800.75, 5200.00, 8750.60, 12000.75, 18500.50, 25000.00, 42800.25, 67500.75];
    v_channels VARCHAR(50)[] := ARRAY['Digital', 'Physical'];
    v_statuses VARCHAR(20)[] := ARRAY['Completed', 'Pending', 'Rejected'];
    v_device_types VARCHAR(50)[] := ARRAY['ATM', 'mobile', 'Smartwatch', 'POS', 'Web browser'];
    v_am_pm_values VARCHAR(2)[] := ARRAY['AM', 'PM'];
    
    -- Función para obtener un valor determinista basado en índice
    FUNCTION get_deterministic_value(p_arr ANYARRAY, p_index INTEGER) RETURNS ANYELEMENT AS
    $INNER$
    BEGIN
        RETURN p_arr[1 + (p_index % array_length(p_arr, 1))];
    END;
    $INNER$ LANGUAGE plpgsql;
    
BEGIN
    -- Establecer la semilla para la función random (afecta a todo el procedimiento)
    PERFORM setseed(v_seed);
    
    -- Obtener todas las monedas disponibles en una matriz
    SELECT ARRAY(SELECT currency FROM fintech.countries) INTO v_currencies;
    
    -- Obtener todos los card_ids disponibles en una matriz
    SELECT ARRAY(SELECT card_id FROM fintech.credit_cards WHERE status = 'Activate') INTO v_card_ids;
    
    -- Si no hay tarjetas con status 'Activate', intentar sin el filtro
    IF array_length(v_card_ids, 1) IS NULL OR array_length(v_card_ids, 1) = 0 THEN
        SELECT ARRAY(SELECT card_id FROM fintech.credit_cards) INTO v_card_ids;
    END IF;
    
    -- Generar exactamente 1000 transacciones deterministas
    FOR i IN 1..1000 LOOP
        -- 1. Usar el valor de un array predeterminado para el monto
        v_amount := get_deterministic_value(v_amounts, i);
        
        -- 2. Seleccionar moneda de manera determinista
        v_currency := v_currencies[1 + (i % array_length(v_currencies, 1))];
        
        -- 3. Generar fecha determinista en el último año
        -- Cada transacción estará separada por horas en orden inverso desde ahora
        v_transaction_date := (NOW() - ((i * 8) * interval '1 hour'));
        
        -- Microsegundos deterministas
        v_microseconds := (i * 1000) % 1000000;
        v_transaction_date := v_transaction_date + (v_microseconds * interval '0.000001 second');
        
        -- 4. Generar transaction_id determinista con formato "TS-":(24 dígitos):"AM o PM"
        -- Crear 24 dígitos deterministas basados en el índice
        v_random_number := '';
        FOR j IN 1..24 LOOP
            v_random_number := v_random_number || ((i + j) % 10)::TEXT;
        END LOOP;
        
        -- Seleccionar AM/PM determinísticamente
        v_am_pm := v_am_pm_values[1 + (i % 2)];
        
        v_transaction_id := 'TS-' || v_random_number || '-' || v_am_pm;
        
        -- 5. Seleccionar card_id determinísticamente
        v_card_id := v_card_ids[1 + (i % array_length(v_card_ids, 1))];
        
        -- 6. Seleccionar canal determinísticamente
        v_channel := v_channels[1 + (i % 2)];
        
        -- 7. Seleccionar status determinísticamente
        v_status := v_statuses[1 + (i % 3)];
        
        -- 8. Seleccionar device_type determinísticamente
        v_device_type := v_device_types[1 + (i % 5)];
        
        -- 9. Generar location_id determinista entre 1 y 1000
        v_location_id := 1 + (i % 1000);
        
        -- 10. Generar method_id determinista entre 1 y 4
        v_method_id := 1 + (i % 4);
        
        -- Insertar transacción sin verificación de unicidad (son deterministas)
        BEGIN
            INSERT INTO fintech.transactions (
                transaction_id,
                card_id,
                amount,
                currency,
                transaction_date,
                channel,
                status,
                device_type,
                location_id,
                method_id
            ) VALUES (
                v_transaction_id,
                v_card_id,
                v_amount,
                v_currency,
                v_transaction_date,
                v_channel,
                v_status,
                v_device_type,
                v_location_id,
                v_method_id
            );
            
            v_counter := v_counter + 1;
            
            -- Mostrar progreso cada 100 inserciones
            IF v_counter % 100 = 0 THEN
                RAISE NOTICE 'Generadas % transacciones de 1000', v_counter;
            END IF;
            
        EXCEPTION WHEN OTHERS THEN
            -- Manejar errores, por ejemplo, si hay problemas con claves foráneas
            RAISE NOTICE 'Error al insertar transacción %: %', i, SQLERRM;
            -- Continuar con la siguiente iteración
        END;
    END LOOP;
    
    RAISE NOTICE 'Generación de transacciones completada. % transacciones añadidas.', v_counter;
END;
$$;

CALL fintech.generate_deterministic_transactions();

SELECT COUNT(*) FROM fintech.transactions;