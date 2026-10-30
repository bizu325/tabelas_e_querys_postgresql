--6- descobrindo a mediana de experiência dos motoristas de cada categoria de acidente:
SELECT
 s.description,COUNT(*) AS numero_acidentes,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY d.years_experience)AS mediana_por_categoria
FROM  safety_incidents s
JOIN drivers d ON d.driver_id = s.driver_id
GROUP BY s.description
ORDER BY s.description;