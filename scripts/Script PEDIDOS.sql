USE dbtestewk;

CREATE TABLE IF NOT EXISTS PEDIDOS (ID_Pedido   INTEGER  NOT NULL AUTO_INCREMENT
									        ,DT_Emissao  DateTime NOT NULL
                                   ,VL_Pedido   FLOAT    NOT NULL
                                   ,ID_Cliente  INTEGER  NOT NULL
                                   ,PRIMARY KEY(ID_Pedido));
                                    
ALTER TABLE PEDIDOS ADD CONSTRAINT FK_Cliente FOREIGN KEY ( ID_Cliente ) REFERENCES CLIENTES ( ID_Cliente ) ;
                                    
CREATE TABLE IF NOT EXISTS PEDIDOS_ITENS (ID_Pedido_Item INTEGER NOT NULL AUTO_INCREMENT
                                         ,ID_Pedido      INTEGER NOT NULL
                                         ,ID_Produto     INTEGER NOT NULL                                         
                                         ,VL_Unitario    FLOAT   NOT NULL
                                         ,NO_Quantidade  INTEGER NOT NULL
                                         ,VL_Total       FLOAT   NOT NULL
                                         ,PRIMARY KEY(ID_Pedido_Item));
                                         
ALTER TABLE PEDIDOS_ITENS ADD CONSTRAINT FK_Pedido  FOREIGN KEY (ID_Pedido)  REFERENCES PEDIDOS (ID_Pedido);
ALTER TABLE PEDIDOS_ITENS ADD CONSTRAINT FK_Produto FOREIGN KEY (ID_Produto) REFERENCES PRODUTOS(ID_Produto);
                                         
CREATE INDEX ix_ID_Pedido  ON PEDIDOS_ITENS(ID_Pedido);
CREATE INDEX ix_ID_Cliente ON PEDIDOS(ID_Cliente);

SELECT ID_Pedido_Item, ID_Pedido, ID_Produto, VL_Unitario, NO_Quantidade, VL_Total
FROM pedidos_itens
WHERE ID_Pedido = :ID_Pedido