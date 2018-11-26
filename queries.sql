USE farmacia;
-- Alterar o nº de telemóvel do cliente 6
UPDATE cliente
SET tlmv="926515582"
WHERE id=6;

SELECT id, tlmv FROM cliente WHERE id=6;
SELECT id, ordenado FROM funcionario WHERE id=1;
-- Aumentar o ordenado do funcionario 1
UPDATE funcionario
SET ordenado = ordenado + 20
WHERE id=1;

-- Ordenados a Pagar
SELECT nome, iban, ordenado FROM funcionario;

select nome, sum(total) from funcionario inner join fatura on funcionario.id=fatura.id_func
group by nome
order by sum(total) DESC
limit 1;
-- Funcionário do Mês (Janeiro)
SELECT f.nome AS Funcionario, SUM(fa.total) as Total_Vendas FROM funcionario AS f INNER JOIN 
										fatura AS fa 
											ON f.id = fa.id_func
WHERE DATE(data_f) >= "2018-01-01" AND DATE(data_f) <= "2018-01-31" 
GROUP BY Funcionario
ORDER BY Total_Vendas DESC
LIMIT 1;

-- Pacientes crónicos e os seus medicamentos
SELECT c.nome as Nome_Cliente, m.des as Nome_Med, COUNT(id_m) as N_Compras FROM fatura as f 
							INNER JOIN fatura_med AS fm ON f.id=fm.id_f 
                            INNER JOIN cliente AS c ON c.id=f.id_c 
                            INNER JOIN medicamento AS m ON m.id=fm.id_m
GROUP BY f.id_c,fm.id_m
HAVING (COUNT(id_m))>=5;

-- Medicamento mais vendido
SELECT des as Nome_Medicamento, COUNT(qt_v) AS Total FROM fatura_med AS fm INNER JOIN medicamento AS m ON fm.id_m = m.id 
GROUP BY id_m
ORDER BY Total DESC
LIMIT 1;


-- Media dos tempos de atendimento
SELECT sec_to_time(AVG(TIME_TO_SEC(t))) as Tempo_Medio FROM(
										SELECT timediff(data_f,data_s) AS t FROM fatura) AS q;
                                        
-- Media dos tempos de atendimento por hora
SELECT HOUR(data_s) AS Hora, timediff(data_f,data_s) as Tempo_Medio AS t FROM fatura
ORDER BY HORA;

SELECT h as HORA, sec_to_time(AVG(TIME_TO_SEC(t))) as Tempo_Medio 
FROM (SELECT HOUR(data_s) as h, timediff(data_f,data_s) AS t FROM fatura) AS q1
GROUP BY HORA
ORDER BY HORA;	