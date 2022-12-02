-- Localidades (verificaçao de restriçoes)
INSERT INTO Localidade (cod_postal,localidade) VALUES ('1000-00','Lisboa');
-- FALHA (verificaçao de restriçoes)
INSERT INTO Localidade (cod_postal,localidade) VALUES ('1000-003','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
INSERT INTO Localidade (cod_postal,localidade) VALUES (NULL,NULL);
-- FALHA (verificaçao de restriçoes)

-- Clientes (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (123456789,'nome',123456789,'email@email.com','morada','morada_entrega',123,'1234-123','1234-123',123,123);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (12345678,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',123456789,'email@email.com','morada','morada_entrega',123,'1234-123','1234-123',123,123);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (12345678,'nome',123456789,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','morada','morada_entrega',123,'1234-123','1234-123',123,123);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (12345678,'nome',123456789,'email@email.com','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','morada_entrega',123,'1234-123','1234-123',123,123);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (12345678,'nome',123456789,'email@email.com','morada','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',123,'1234-123','1234-123',123,123);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (12345678,'nome',123456789,'email@email.com','morada','morada_entrega',123,'12-12','1234-123',123,123);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (12345678,'nome',123456789,'email@email.com','morada','morada_entrega',123,'1234-123','12-12',123,123);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (12345678,'nome',123456789,'email@email.com','morada','morada_entrega',123,'1234-123','1234-123',1234,123);
-- FALHA (verificaçao de restriçoes)
INSERT INTO Cliente (id_cliente,nome,nif,email,morada,morada_entrega,plafond,cod_postal_entrega,cod_postal,n_encomendas,valor_total_encomendas) VALUES (12345678,'nome',123456789,'email@email.com','morada','morada_entrega',123,'1234-123','1234-123',123,12345678910);
-- FALHA (verificaçao de restriçoes)

-- EscalaoIva (verificaçao de restriçoes)
INSERT INTO EscalaoIva (id_escalao_iva,valor) VALUES (NULL,NULL);
-- FALHA (verificaçao de restriçoes)
INSERT INTO EscalaoIva (id_escalao_iva,valor) VALUES (999,10);
-- FALHA (verificaçao de restriçoes)

-- Setor (verificaçao de restriçoes)
INSERT INTO Setor (id_setor,designacao,area) VALUES (NULL,NULL,NULL);
-- FALHA
INSERT INTO Setor (id_setor,designacao,area) VALUES (12345678901,'designacao',100);
-- FALHA
INSERT INTO Setor (id_setor,designacao,area) VALUES (123456789,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',100);
-- FALHA
INSERT INTO Setor (id_setor,designacao,area) VALUES (123456789,'designacao',1000000000);
-- FALHA

-- Produtos (verificaçao de restriçoes)
INSERT INTO Produto (id_produto,designacao,preco,id_escalao_iva) VALUES (NULL,NULL,NULL,NULL);
-- FALHA
INSERT INTO Produto (id_produto,designacao,preco,id_escalao_iva) VALUES (123456789,'designacao',10,13);
-- FALHA
INSERT INTO Produto (id_produto,designacao,preco,id_escalao_iva) VALUES (12345678,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',10,13);
-- FALHA
INSERT INTO Produto (id_produto,designacao,preco,id_escalao_iva) VALUES (12345678,'designacao',10,999);
-- FALHA

-- TipoCultura (verificaçao de restriçoes)
INSERT INTO TipoCultura (id_tipo_cultura,tipo_cultura) VALUES (NULL,NULL);
-- FALHA
INSERT INTO TipoCultura (id_tipo_cultura,tipo_cultura) VALUES (999,'cultura');
-- FALHA
INSERT INTO TipoCultura (id_tipo_cultura,tipo_cultura) VALUES (1,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
-- FALHA

-- Cultura (verificaçao de restriçoes)
INSERT INTO Cultura (id_cultura,cultura,id_tipo_cultura) VALUES (NULL,NULL,NULL);
-- FALHA
INSERT INTO Cultura (id_cultura,cultura,id_tipo_cultura) VALUES (999,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',999);
-- FALHA

-- TipoFatorProducao (verificaçao de restrições)
INSERT INTO TipoFatorProducao (id_tipo_fator_producao,tipo_fator_producao) VALUES (NULL,NULL);
-- FALHA
INSERT INTO TipoFatorProducao (id_tipo_fator_producao,tipo_fator_producao) VALUES (999, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
-- FALHA

-- Substancia (verificaçao de restriçoes)
INSERT INTO Substancia (id_substancia,substancia) VALUES (NULL,NULL);
-- FALHA
INSERT INTO Substancia (id_substancia,substancia) VALUES (999,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
-- FALHA

-- TipoFormulacao (verificaçao de restriçoes)
INSERT INTO TipoFormulacao (id_tipo_formulacao,tipo_formulacao) VALUES (NULL,NULL);
-- FALHA
INSERT INTO TipoFormulacao (id_tipo_formulacao,tipo_formulacao) VALUES (999,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
-- FALHA

-- FatorProducao (verificaçao de restriçoes)
INSERT INTO FatorProducao (id_fator_producao,id_tipo_fator_producao,nome,id_tipo_formulacao) VALUES (NULL,NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO FatorProducao (id_fator_producao,id_tipo_fator_producao,nome,id_tipo_formulacao) VALUES (999,999,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',999);
-- FALHA (teste prova restricoes)

-- FatorProducaoSubstancia (verificaçao de restriçoes)
INSERT INTO FatorProducaoSubstancia (id_fator_producao,id_substancia,percentagem) VALUES (NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO FatorProducaoSubstancia (id_fator_producao,id_substancia,percentagem) VALUES (999,999,9999);
-- FALHA (teste prova restricoes)

-- TipoTubagem (verificaçao de restriçoes)
INSERT INTO TipoTubagem (id_tipo_tubagem,tipo_tubagem) VALUES (NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO TipoTubagem (id_tipo_tubagem,tipo_tubagem) VALUES (999,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
-- FALHA (teste prova restricoes)

-- TipoRega (verificaçao de restriçoes)
INSERT INTO TipoRega (id_tipo_rega,id_tipo_tubagem) VALUES (NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO TipoRega (id_tipo_rega,id_tipo_tubagem) VALUES (999,12345678910);
-- FALHA (teste prova restricoes)

-- PlanoRega (verificaçao de restriçoes)
INSERT INTO PlanoRega (id_setor,data_inicio,tempo,periodicidade,id_tipo_rega,data_fim) VALUES (NULL,NULL,NULL,NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO PlanoRega (id_setor,data_inicio,tempo,periodicidade,id_tipo_rega,data_fim) VALUES (12345678910,'20171-01-01',12345678910,'201712-01-01',999,'aa');
-- FALHA (teste prova restricoes)

-- TipoSensor (verificaçao de restriçoes)
INSERT INTO TipoSensor (id_tipo_sensor,tipo_sensor) VALUES (NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO TipoSensor (id_tipo_sensor,tipo_sensor) VALUES (999,'aaa');
-- FALHA (teste prova restricoes)

-- Sensor (verificaçao de restriçoes)
INSERT INTO Sensor (id_sensor,identificador,id_tipo_sensor,valor_referencia) VALUES (NULL,NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO Sensor (id_sensor,identificador,id_tipo_sensor,valor_referencia) VALUES (123456789,'aaaaaa',999,999);
-- FALHA (teste prova restricoes)


-- Encomenda (verificacao de restricoes)
INSERT INTO Encomenda (id_encomenda,id_cliente,data_vencimento_pagamento,data_registo,data_entrega,data_pagamento,morada_entrega,cod_postal_entrega) VALUES (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO Encomenda (id_encomenda,id_cliente,data_vencimento_pagamento,data_registo,data_entrega,data_pagamento,morada_entrega,cod_postal_entrega) VALUES (12345678910,123456789,'2017a-01-01','2017a-01-01','2017-a1-01','aaa','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','aaaaaaaaa');
-- FALHA (teste prova restricoes)

-- ProdutoEncomenda (verificacao de restricoes)
INSERT INTO ProdutoEncomenda (id_encomenda,id_produto,quantidade,preco_unitario,iva,designacao_produto) VALUES (NULL,NULL,NULL,NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO ProdutoEncomenda (id_encomenda,id_produto,quantidade,preco_unitario,iva,designacao_produto) VALUES (12345678910,12345678910,99999,999,999,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
-- FALHA (teste prova restricoes)

-- MedicaoSensor (verificacao de restricoes)
INSERT INTO MedicaoSensor (id_sensor,id_setor,medicao,data_hora) VALUES (NULL,NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO MedicaoSensor (id_sensor,id_setor,medicao,data_hora) VALUES (12345678910,12345678910,99999,'2017');
-- FALHA (teste prova restricoes)

-- Rega (verificacao de restricoes)
INSERT INTO Rega (id_setor,data,id_tipo_rega) VALUES (NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO Rega (id_setor,data,id_tipo_rega) VALUES (12345678910,'2017',12345678910);
-- FALHA (teste prova restricoes)

-- Colheita (verificacao de restricoes)
INSERT INTO Colheita (id_produto,data,quantidade,id_setor) VALUES (NULL,NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO Colheita (id_produto,data,quantidade,id_setor) VALUES (12345678910,'2017',9999999999,123456789101);
-- FALHA (teste prova restricoes)

-- Plantacao (verificacao de restricoes)
INSERT INTO Plantacao (id_setor,id_cultura,data_inicio) VALUES (NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO Plantacao (id_setor,id_cultura,data_inicio) VALUES (1234567891012,123,'2017');
-- FALHA (teste prova restricoes)

-- TipoEdificio (verificacao de restricoes)
INSERT INTO TipoEdificio (id_tipo_edificio,tipo_edificio) VALUES (NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO TipoEdificio (id_tipo_edificio,tipo_edificio) VALUES (999,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
-- FALHA (teste prova restricoes)

-- Edificio (verificacao de restricoes)
INSERT INTO Edificio (id_edificio,id_tipo_edificio) VALUES (NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO Edificio (id_edificio,id_tipo_edificio) VALUES (12345678910,999);
-- FALHA (teste prova restricoes)

-- TipoAplicacaoFatorProducao (verificacao de restricoes)
INSERT INTO TipoAplicacaoFatorProducao (id_tipo_aplicacao_fator_producao,tipo_aplicacao_fator_producao) VALUES (NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO TipoAplicacaoFatorProducao (id_tipo_aplicacao_fator_producao,tipo_aplicacao_fator_producao) VALUES (9999,'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
-- FALHA (teste prova restricoes)

-- AplicacaoFatorProducao (verificacao de restricoes)
INSERT INTO AplicacaoFatorProducao (id_setor,id_fator_producao,data,id_tipo_aplicacao_fator_producao) VALUES (NULL,NULL,NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO AplicacaoFatorProducao (id_setor,id_fator_producao,data,id_tipo_aplicacao_fator_producao) VALUES (12345678910,12345678910,'2017',9999);
-- FALHA (teste prova restricoes)

-- ProdutoCultura (verificacao de restricoes)
INSERT INTO ProdutoCultura (id_cultura,id_produto) VALUES (NULL,NULL);
-- FALHA (teste prova restricoes)
INSERT INTO ProdutoCultura (id_cultura,id_produto) VALUES (12345678910,12345678910);
-- FALHA (teste prova restricoes)

