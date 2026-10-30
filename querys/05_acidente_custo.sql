--5- contando a quantidade de acidentes para cada categoria e seus respectivos custos:
SELECT
description, COUNT(*),SUM(vehicle_damage_cost) AS total_custo_danos
FROM safety_incidents
GROUP BY description;