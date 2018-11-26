CREATE PROCEDURE new_cliente(id INT, nome VARCHAR(50), nif INT, email VARCHAR(50), tlmv INT, pontos INT)
BEGIN
	INSERT INTO cliente VALUES (id, "nome", 123, "ola@ola.com", 96601011, 1);
END 
