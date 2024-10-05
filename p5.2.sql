-- Створіть функцію, що рахує кількість захворювань за певний період. 
-- Для цього треба поділити кількість захворювань на рік на певне число: 
-- 12 — для отримання середньої кількості захворювань на місяць, 4 — на квартал або 2 — на півріччя. 
-- Таким чином, функція буде приймати два параметри: кількість захворювань на рік та довільний дільник. 
-- Ви також маєте використати її — запустити на даних. Оскільки не всі рядки містять число захворювань, 
-- вам необхідно буде відсіяти ті, що не мають чисельного значення (≠ '').
DROP FUNCTION IF EXISTS CasesForPeriod;

DELIMITER //

CREATE FUNCTION CasesForPeriod(cases TEXT, period INT)
RETURNS FLOAT
DETERMINISTIC 
NO SQL
BEGIN
	DECLARE cases_numeric FLOAT;
	IF period = 0 OR cases = '' THEN
		RETURN NULL;
	ELSE
		SET cases_numeric = CAST(cases AS DECIMAL(10, 2));
        IF cases_numeric IS NULL THEN
            RETURN NULL;
        END IF;
		RETURN cases_numeric / period;
	END IF;
END //

DELIMITER ;

SELECT
CAST(Number_rabies AS DECIMAL(10, 2)) as rabies_yearly,
CasesForPeriod(ic.Number_rabies, 2) as rabies_semiannually,
CasesForPeriod(ic.Number_rabies, 4) as rabies_quarterely,
CasesForPeriod(ic.Number_rabies, 12) as rabies_monthly
FROM infectious_cases ic
ORDER by rabies_monthly DESC;


