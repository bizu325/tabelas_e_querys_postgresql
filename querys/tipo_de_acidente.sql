--1- contando quantos tipos de acidentes há na tabela safety_incidents
SELECT
 description,COUNT(*) AS soma
FROM safety_incidents
GROUP BY description ;
