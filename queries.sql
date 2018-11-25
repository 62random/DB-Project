USE farmacia;
-- Alterar o nº de telemóvel do cliente 6
UPDATE cliente
SET tlmv="926515582"
WHERE id=6;

-- Aumentar o ordenado do funcionario 1
UPDATE funcionario
SET ordenado = ordenado + 20
WHERE id=1;

-- Ordenados a Pagar
SELECT nome, iban, ordenado FROM funcionario;

-- Funcionário do Mês (Janeiro)
SELECT f.nome AS Funcionario, sum(fa.total) as Total_Vendas FROM funcionario AS f INNER JOIN 
										fatura AS fa 
											ON f.id = fa.id_func
WHERE DATE(data_f) >= "2018-01-01" AND DATE(data_f) <= "2018-01-31" 
GROUP BY Funcionario
ORDER BY Total_Vendas DESC
LIMIT 1;

-- Pacientes crónicos e os seus medicamentos
SELECT c.nome, m.des, COUNT(id_m) FROM fatura as f INNER JOIN fatura_med AS fm ON f.id=fm.id_f INNER JOIN cliente AS c ON c.id=f.id_c INNER JOIN medicamento AS m ON m.id=fm.id_m
GROUP BY f.id_c,fm.id_m
HAVING (COUNT(id_m))>=4;

-- Medicamento mais vendido
SELECT des, COUNT(qt_v) as tot FROM fatura_med as fm inner join medicamento as m on fm.id_m = m.id 
GROUP BY id_m
ORDER BY tot DESC
LIMIT 1;
-- Media dos tempos de atendimento
SELECT sec_to_time(AVG(TIME_TO_SEC(t))) FROM(
										SELECT timediff(data_f,data_s) AS t FROM fatura) AS q;
                                        
-- Media dos tempos de atendimento por hora
SELECT HOUR(data_s) AS h, timediff(data_f,data_s) AS t FROM fatura
ORDER BY h;

SELECT h, sec_to_time(AVG(TIME_TO_SEC(t))) FROM (SELECT HOUR(data_s) AS h, timediff(data_f,data_s) AS t FROM fatura) AS q1
GROUP BY h
ORDER BY h;