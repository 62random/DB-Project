USE farmacia;
SELECT * FROM cliente;
SELECT * FROM funcionario;
SELECT * FROM fatura;

select nome,sum(total) from funcionario inner join fatura on fatura.id_func=funcionario.id
GROUP BY nome
ORDER BY sum(total) DESC
LIMIT 1;





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
select c.nome, m.des, count(id_m) from fatura as f inner join fatura_med as fm on f.id=fm.id_f inner join cliente as c on c.id=f.id_c inner join medicamento as m on m.id=fm.id_m
group by f.id_c,fm.id_m
having (count(id_m))>=4;

-- Medicamento mais vendido
SELECT des, COUNT(qt_v) as tot FROM fatura_med as fm inner join medicamento as m on fm.id_m = m.id 
GROUP BY id_m
ORDER BY tot DESC
LIMIT 1;
-- Media dos tempos de atendimento
SELECT sec_to_time(avg(TIME_TO_SEC(t))) from(
										SELECT timediff(TIME(data_f),TIME(data_s)) as t from fatura) as q;
                                        
select time_to_sec(t) from (SELECT timediff(TIME(data_f),TIME(data_s)) as t from fatura) as q;