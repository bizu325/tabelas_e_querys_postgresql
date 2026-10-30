--4- descobrir se quanto maior o tempo de experiência(usando a mediana) menor a quantidade de acidentes

SELECT
    d.driver_id,
    d.first_name,
    d.last_name,
    d.years_experience,
    s.description AS tipo_acidente
FROM drivers d
JOIN safety_incidents s
    ON d.driver_id = s.driver_id
WHERE d.years_experience >= 13;