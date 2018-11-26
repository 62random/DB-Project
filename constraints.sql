use farmacia;
ALTER TABLE fatura
ADD CONSTRAINT CHK_data CHECK (data_s < data_f);

-- alter table fatura  CHK_data;

insert into fatura
(id, data_f, data_s, pontos_r, pontos_u, desconto, total, id_func, id_c)
Values (16,'2018-06-01 00:00:01','2018-06-02 23:55:59',10,0,0,18.96, 2,2);
delete from fatura where id=16;

