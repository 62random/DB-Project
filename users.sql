CREATE USER 'funcionario'@'localhost' IDENTIFIED BY 'funcproms';
GRANT SELECT,INSERT,UPDATE ON cliente.* TO 'funcionario'@'localhost';
GRANT SELECT ON medicamento.* TO 'funcionario'@'localhost';
GRANT SELECT,INSERT ON fatura.* TO 'funcionario'@'localhost';
GRANT SELECT,INSERT ON fatura_receita.* TO 'funcionario'@'localhost';
GRANT SELECT,INSERT ON fatura_med.* TO 'funcionario'@'localhost';


CREATE USER 'prometeu'@'localhost' IDENTIFIED BY 'promsbt';
GRANT SELECT ON cliente.* TO 'prometeu'@'localhost';
GRANT SELECT, INSERT, UPDATE ON medicamento.* TO 'prometeu'@'localhost';
GRANT DELETE ON fatura.* TO 'prometeu'@'localhost';
GRANT DELETE ON fatura_receita.* TO 'prometeu'@'localhost';
GRANT DELETE ON fatura_med.* TO 'prometeu'@'localhost';
GRANT SELECT,INSERT,UPDATE ON funcionario.* TO 'prometeu'@'localhost';


CREATE USER 'user'@'localhost' IDENTIFIED BY 'userproms';
GRANT SELECT ON fatura.* TO 'user'@'localhost';
GRANT SELECT ON fatura_med.* TO 'user'@'localhost';
GRANT SELECT, UPDATE ON clientes.* TO 'user'@'localhost';
