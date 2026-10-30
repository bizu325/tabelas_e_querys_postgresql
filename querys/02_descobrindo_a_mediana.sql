--2- descobrindo qual a mediana do tempo de experiência dos motoristas:
SELECT
 percentile_cont(0.5) WITHIN GROUP(ORDER BY years_experience)AS mediana 
FROM drivers;
