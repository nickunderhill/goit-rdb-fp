-- Нормалізуйте таблицю infectious_cases до 3ї нормальної форми. 
-- Збережіть у цій же схемі дві таблиці з нормалізованими даними.
USE pandemic;
SELECT * FROM infectious_cases;

CREATE TABLE IF NOT EXISTS entities (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `entity` varchar(255) NOT NULL
);

INSERT INTO entities (`entity`)
SELECT DISTINCT `Entity` FROM infectious_cases
WHERE `Entity` != '';

CREATE TABLE IF NOT EXISTS country_codes (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `code` varchar(255) NOT NULL
);

INSERT INTO country_codes (`code`)
SELECT DISTINCT `Code` FROM infectious_cases
WHERE `Code` != '';

ALTER TABLE infectious_cases ADD COLUMN (entity_id INT, code_id INT);
ALTER TABLE infectious_cases ADD CONSTRAINT fk_code_id FOREIGN KEY (code_id) REFERENCES country_codes(id);
ALTER TABLE infectious_cases ADD CONSTRAINT fk_entity_id FOREIGN KEY (entity_id) REFERENCES entities(id);

SET SQL_SAFE_UPDATES = 0;

UPDATE infectious_cases
INNER JOIN entities ON infectious_cases.Entity = entities.entity
SET infectious_cases.entity_id = entities.id;

UPDATE infectious_cases
INNER JOIN country_codes ON infectious_cases.Code = country_codes.code
SET infectious_cases.code_id = country_codes.id;

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE infectious_cases DROP COLUMN Code;
ALTER TABLE infectious_cases DROP COLUMN Entity;
