#NIVEL 1
#Ejercicio 1
CREATE TABLE IF NOT EXISTS credit_card (
    id VARCHAR(15) PRIMARY KEY,
    iban VARCHAR(34),
    pan VARCHAR(19),
    pin CHAR(4),
    cvv CHAR(3),
    expiring_date VARCHAR(10)
);

#Añadir restricciones y claves foráneas en transaction
ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card
FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);


SELECT *
FROM credit_card;

#Ejercicio 2 
UPDATE credit_card
SET iban = 'R323456312213576817699999'
WHERE id = 'CcU-2938';


#Ejercicio 3
SHOW CREATE TABLE user;
ALTER TABLE user DROP FOREIGN KEY user_ibfk_1;

INSERT INTO user (id) VALUES ('9999');
INSERT INTO company(id) VALUES ('b-9999');
INSERT INTO credit_card(id) VALUES('CcU-9999');

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined) 
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', 829.999, -117.999, 111.11, 0);

# comprobación de registro
SELECT *
FROM transaction
WHERE id = '108B1D1D-5B23-A76C-55EF-C568E49A99DD';


#Ejercicio 4
ALTER TABLE credit_card
DROP COLUMN pan;

DESCRIBE credit_card;

# NIVEL 2
#Ejercicio 1
DELETE FROM transaction 
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';



#Ejercicio 2
CREATE VIEW VistaMarketing AS
SELECT c.company_name, c.phone, c.country, ROUND(AVG(t.amount), 2) AS avg_purchase
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE t.declined = 0
GROUP BY c.company_name, c.phone, c.country
ORDER BY avg_purchase DESC;


SELECT *
FROM VistaMarketing;

#Ejercicio 3
SELECT company_name, country
FROM VistaMarketing
WHERE country = 'Germany';

# Nivel 3
# Ejercicio 1
# Eliminar la columna 'website' de la tabla 'company'
ALTER TABLE company
DROP COLUMN website;

#Cambiar nombre de tabla user a data_user
RENAME TABLE user TO data_user;

# Agregar la columna 'fecha_actual' a la tabla 'credit_card'
ALTER TABLE credit_card
ADD COLUMN fecha_actual DATE DEFAULT(CURRENT_DATE);

# Renombrar la columna 'email' a 'personal_email' en la tabla 'user'
ALTER TABLE data_user
CHANGE email personal_email VARCHAR(150);

#Cambiar tipo de dato de la variable pin
ALTER TABLE credit_card
MODIFY COLUMN pin VARCHAR(4);

#Cambiar tipo de dato de iban
ALTER TABLE credit_card
MODIFY COLUMN iban VARCHAR(50);

#Cambiar tipo de dato cvv
ALTER TABLE credit_card
MODIFY COLUMN cvv INT;


# Ejercicio 2
CREATE VIEW InformeTecnico AS
SELECT t.id, u.name, u.surname, cc.iban, c.company_name
FROM transaction t
JOIN data_user u ON t.user_id = u.id
JOIN credit_card cc ON t.credit_card_id = cc.id
JOIN company c ON t.company_id = c.id
ORDER BY t.id DESC;

SELECT *
FROM InformeTecnico;
