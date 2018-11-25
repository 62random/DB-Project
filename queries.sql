USE farmacia;
SELECT * FROM cliente;
SELECT * FROM funcionario;
SELECT * FROM fatura;

SELECT f.nome AS Funcionario, sum(fa.total) as Total_Vendas FROM funcionario AS f INNER JOIN 
										fatura AS fa 
											ON f.id = fa.id_func
WHERE DATE(data_f) >= "2018-01-01" AND DATE(data_f) <= "2018-01-31" 
GROUP BY Funcionario
ORDER BY Total_Vendas DESC
LIMIT 1;