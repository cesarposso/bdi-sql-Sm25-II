--update fintech.issuers
SELECT FROM fintech.issuers
WHERE country_code = (SELECT country_code FROM fintech.countries WHERE name = 'Colombia' LIMIT 1);