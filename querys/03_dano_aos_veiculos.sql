--3- Somando o custo dos danos aos veículos, ocorridos nos acidentes evitáveis 
SELECT
 description,
 SUM(vehicle_damage_cost)
 AS dano_veiculo
FROM safety_incidents 
WHERE preventable_flag =True
GROUP BY description;
