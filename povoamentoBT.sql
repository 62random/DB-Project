USE farmacia;

INSERT INTO Cliente
	(id, nome, nif, email, tlmv, pontos, pass)
	VALUES 
		(1, 'Joao da Costa e Campos',  '123456789', 'jcc@gmail.pt' , '912345678', 0, 'd1925c0ef3f6c8c16ab291510383617148a53979'),
		(2, 'Josefina Vivida da Paz', '122133144', 'josefina@hotmail.pt', '910987654', 0, '1eab06cab995dfeb32b6b7c709b8a6c62cabacfe'),
		(3, 'Ana Santa do Carmo', '876543298', 'saca@gmail.pt','961234567', 0, 'd7b4fc529d86c836c9720c77287611765f7124c5'),
		(4, 'Jesualdo Peza-Mor',  '564352786', 'pezamor@hotmail.pt', '921456876', 0, 'c29dd6c83b67a1d6d3b28588a1f068b68689aa1d'),
		(5, 'Maria da Trindade Pascoal',	'777666555', 'trindade@iol.pt', '912492054', 0, 'd9f02d46be016f1b301f7c02a4b9c4ebe0dde7ef'),
		(6, 'Florindo Teixo Figueirinha', '787676651', 'teixof@gmail.pt', '927147962', 0, '6ed32edf4e92ab3c0a4dc6f90242953c344051ad'),
		(7, 'Carminho Cunha Bastos',  '543234111', 'cbastos@hotmail.pt', '934789246' , 0, 'a43f9fc96f67c191be1a430b30da0129bf1c98af')
	;
    
INSERT INTO Funcionario
	(id, nome, tlmv, niss, iban, ordenado, cedula, pass)
	VALUES 
		(1, 'Mariana Pereira Fernandes', '910851961', '12345678909', 'PT 50 2732 5162 12345678909', 750.27, '12345', '608e01334f5575f10813efa40ce0102f2dc0a75e'),
		(2, 'Pedro Jorge Rito Lima', '934567123', '14385639201',  'PT 50 2751 3262 76598707612', 800.32, '54321', '3cfa1c281281ffe4f5db2ccfbe7a17f8a9479808'),
		(3, 'Alexandre de Freitas Ferreira Pacheco', '932765078', '65824809821',  'PT 50 3227 6251 16549867803', 510.51, '74509','90fb6e73d036fa2ee3dde303538c4e4a12277bbc'),
		(4, 'Jose Pedro Milhazes Carvalho Pinto',  '963789245' , '18746783601', 'PT 50 6227 3251 87637898710', 800.62, '76912', '679951a24ba997db7355e6b63d66ea51c4a1a5ba' )
	;

INSERT INTO Medicamento
  	(id, des, qt, un, formato, categoria, preco, stock, lab, receita, pos)
  	VALUES
		(1,'Ben-U-Ron 500', 20,'un','granulado','Analgesico',2.51, 21, 'Laboratorio do Rio Ave', 'N', 'A12'),
		(2,'Claritromicina',14,'un','comprimido','Antibiotico',4.99, 21, 'Laboratorio do Rio Ave', 'N', 'H35'),
		(3,'Brufen',200,'ml','xarope','Analgesico',4.32, 22, 'Laboratorio do Chile', 'N', 'L24'),
		(4,'Cefotaxima',20,'un','comprimido','Antibiotico',8.51, 22, 'Laboratorio Ahrro', 'S', 'D26'),
		(5,'Fotexina I.M.',10,'un','comprimido','Antibiotico',10.20, 21, 'Vitalis', 'S', 'L52'),
        (6, 'Sinvastatina',30,'un','comprimido','Estatina',16.45,25,'Mylan','S','K23')
    ;

INSERT INTO Fatura -- tratar das datas
	(id, data_f, data_s, pontos_r, pontos_u, desconto, total, id_func, id_c)
	VALUES 
		(1,'2017-12-10 08:08:32','2017-12-10 08:05:25',0,0,0,4.99, 1,3),
		(2,'2017-12-10 08:13:02','2017-12-10 08:06:45',10,0,0,12.83, 2,2),
		(3,'2017-12-10 08:41:01','2017-12-10 08:07:00',25,0,0,21.47, 1,1), -- morto
		(4,'2018-01-25 12:22:02','2018-01-25 12:00:32',0,0,0,2.51, 1,3),
		(5,'2018-01-29 23:51:51','2018-01-29 23:47:34',40,0,0,33.36, 3,3),
		(6,'2018-01-30 15:51:32','2018-01-30 15:30:19',0,0,0,4.32, 3,2),
		(7,'2018-01-31 19:59:04','2018-01-31 19:45:29',0,0,0,16.45, 4,1), -- morto
		(8,'2018-02-05 15:59:06','2018-02-05 15:57:26',25,0,0,23.03, 4,6),
		(9,'2018-02-16 11:59:01','2018-02-16 11:53:29',10,0,0,16.45, 4,1), -- morto
		(10,'2018-03-09 14:29:52','2018-03-09 14:23:23',0,0,0,8.51, 4,4),
		(11,'2018-03-13 13:54:39','2018-03-13 13:50:42',25,0,0,24.96, 4,1), -- morto 
		(12,'2018-04-05 23:00:01','2018-04-05 22:53:21',0,0,0,2.51, 2,5),
		(13,'2018-04-05 23:21:53','2018-04-05 22:59:23',10,0,0,16.45, 2,1), -- morto
		(14,'2018-05-11 15:42:00','2018-05-11 15:32:59',55,0,0,46.98, 1,7),
		(15,'2018-06-03 00:00:01','2018-06-02 23:55:59',10,0,0,18.96, 2,2)
    ;
    
INSERT INTO Fatura_Med
	(id_f, id_m, qt_v, preco_v, preco_l)
    VALUES
		(1,1,1,4.99,4.99),
        (2,4,1,8.51,8.51),
        (2,3,1,4.32,4.32),
        (3,1,2,2.51,5.02),
        (3,6,1,16.45,16.45),
        (4,1,1,2.51,2.51),
        (5,3,3,4.32,12.96),
        (5,5,2,10.20,20.40),
        (6,3,1,4.32,4.32),
        (7,6,1,16.45,16.45),
        (8,3,1,4.32,4.32),
        (8,4,1,8.51,8.51),
        (8,5,1,10.20,10.20),
        (9,6,1,16.45,16.45),
        (10,4,1,8.51,8.51),
        (11,6,1,16.45,16.45),
        (11,4,1,8.51,8.51),
        (12,1,1,2.51,2.51),
        (13,6,1,16.45,16.45),
        (14,1,1,2.51,2.51),
        (14,2,1,4.99,4.99),
        (14,3,1,4.32,4.32),
        (14,4,1,8.51,8.51),
        (14,5,1,10.20,10.20),
        (14,6,1,16.45,16.45),
        (15,6,1,16.45,16.45),
        (15,1,1,2.51,2.51)
	;
    
        
INSERT INTO Fatura_Receita
	(id_fatura, cod_receita)
	VALUES 
		(2,1234),
		(2,424),
		(3,80),
		(5,83),
		(7,92),
		(8,10),
        (8,24),
        (8,312),
        (9,32),
        (10,12),
        (11,120),
		(13,1224),
        (14,104),
        (14,180),
        (14,6),
        (15,12)        
	;
    
