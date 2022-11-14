USE dbtestewk;

CREATE TABLE IF NOT EXISTS PRODUTOS ( ID_Produto Integer NOT NULL AUTO_INCREMENT
          									, NM_Produto VarChar(80) NOT NULL
                                    , VL_Produto FLOAT NOT NULL
                                    , primary key(ID_Produto));

INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Esmalte', 6.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Arroz', 8.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Azeite', 8.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Bolachas e biscoitos', 8.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Café', 8.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Chá', 8.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Extrato de tomate', 8.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Leite', 9.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Manteiga', 14.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Cerveja', 10.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Peixes', 30.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Carne', 100.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Ovos', 80.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Detergente', 80.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Alcool em gel', 80.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Desinfetante', 15.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Flanelas', 15.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Sal', 12.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Queijo Ralado', 5.00);
INSERT INTO PRODUTOS (NM_Produto, VL_Produto) VALUES ('Molho de tomate', 5.00);

