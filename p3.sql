-- Для кожної унікальної комбінації Entity та Code або їх id порахуйте середнє, мінімальне, 
-- максимальне значення та суму для атрибута Number_rabies.
-- Врахуйте, що атрибут Number_rabies може містити порожні значення '' — вам попередньо 
-- необхідно їх відфільтрувати.
-- Результат відсортуйте за порахованим середнім значенням у порядку спадання.
-- Оберіть тільки 10 рядків для виведення на екран.
SELECT e.entity, 
cc.code, 
AVG(ic.Number_rabies) as avg_rabies, 
MAX(ic.Number_rabies) as max_rabies, 
MIN(ic.Number_rabies) as min_rabies,
SUM(ic.Number_rabies) as sum_rabies
FROM infectious_cases ic
JOIN entities e ON e.id = ic.entity_id
JOIN country_codes cc ON cc.id = ic.code_id
WHERE ic.Number_rabies != ''
GROUP by e.entity, cc.code
ORDER by avg_rabies DESC
LIMIT 10;
