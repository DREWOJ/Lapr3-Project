-- Snowflake data model --

-- Descrição do modelo de dados:
-- Fact table são as tabelas que contêm os dados de negócio. (Ex: Vendas, Produção, etc.)
-- Dimensões são tabelas que contêm os dados de contexto. (Ex: Tempo, ano, mes, Cliente, Produto, etc.)

-- O modelo de dados é composto por 8 dimensões e 2 fact tables.
-- A dimensão Tempo é composta por 3 atributos: ano, mes e id_tempo.
-- A dimensão Ano é composta por 1 atributo: ano.
-- A dimensão Mes é composta por 1 atributo: mes.
-- A dimensão Cliente é composta por 3 atributos: id_cliente, nome e nif.
-- A dimensão Produto é composta por 3 atributos: id_produto, tipo_cultura e cultura.
-- A dimensão Cultura é composta por 1 atributo: designacao.
-- A dimensão TipoCultura é composta por 1 atributo: tipo.
-- A dimensão Setor é composta por 2 atributos: id_setor e nome.
-- A fact table Venda é composta por 6 atributos: id_venda, id_cliente, id_produto, id_setor, id_tempo e quantidade.
-- A fact table Producao é composta por 5 atributos: id_producao, id_produto, id_setor, id_tempo e quantidade.

-- Este esquema 'SnowFlake' tem as hierarquias divididas em dimensões separadas.
-- Existe pouca redundância de dados, pois os atributos que se repetem são referenciados por chaves estrangeiras.
-- Para buscar os dados de uma fact table, é necessário fazer muitos joins com as dimensões.
-- É um DB complexa.

-- Estimativa de cardinalidades:
-- A estimativa da cardinalidade é importante porque ela afeta o design da base de dados e o desempenho das consultas.
-- Se a cardinalidade for subestimada, isso pode levar ao desperdício de recursos, como espaço em disco ou memória, ou ao uso excessivo de recursos.
-- Por outro lado, se a cardinalidade for sobrestimada, isso pode levar ao desperdício de espaço em disco e ao aumento do tempo de inserção de dados.
-- A cardinalidade de uma tabela é o número de linhas que ela pode conter. A cardinalidade de uma coluna é o número de valores distintos que ela pode conter.
-- Tempo: a dimensão Tempo pode ter cardinalidade de 12 (meses) * 100 (anos) = 1200.
-- ano: a dimensão ano pode ter cardinalidade de 100 (anos).
-- mes: a dimensão mes pode ter cardinalidade de 12 (meses).
-- Cliente: a dimensão Cliente pode ter cardinalidade de 100000 (clientes).
-- Produto: a dimensão Produto pode ter cardinalidade de 1000 (produtos).
-- Cultura: a dimensão Cultura pode ter cardinalidade de 100 (designações).
-- TipoCultura: a dimensão TipoCultura pode ter cardinalidade de 10 (tipos).
-- Setor: a dimensão Setor pode ter cardinalidade de 10 (setores).
-- Venda: a fact table Venda pode ter cardinalidade de 1000000 (vendas).
-- Producao: a fact table Producao pode ter cardinalidade de 1000000 (produções).


-- DROP TABLES --
DROP TABLE Cliente CASCADE CONSTRAINTS PURGE;
DROP TABLE Cultura CASCADE CONSTRAINTS PURGE;
DROP TABLE TipoCultura CASCADE CONSTRAINTS PURGE;
DROP TABLE Produto CASCADE CONSTRAINTS PURGE;
DROP TABLE Setor CASCADE CONSTRAINTS PURGE;
DROP TABLE ano CASCADE CONSTRAINTS PURGE;
DROP TABLE mes CASCADE CONSTRAINTS PURGE;
DROP TABLE Tempo CASCADE CONSTRAINTS PURGE;
DROP TABLE Venda CASCADE CONSTRAINTS PURGE;
DROP TABLE Producao CASCADE CONSTRAINTS PURGE;


-- Dimension tables --
CREATE TABLE Cliente (
  id_cliente NUMBER(8) NOT NULL,
  nome VARCHAR2(50) NOT NULL,
  nif NUMBER(9) NOT NULL,
  PRIMARY KEY (id_cliente),
  CONSTRAINT CHK_Nif    CHECK (nif > 100000000 AND nif < 999999999)
);

CREATE TABLE Cultura (
  designacao VARCHAR2(50) NOT NULL,
  PRIMARY KEY (designacao)
);

CREATE TABLE TipoCultura (
  tipo VARCHAR2(50) NOT NULL,
  PRIMARY KEY (tipo)
);

CREATE TABLE Produto (
  id_produto NUMBER(5) NOT NULL,
  tipo_cultura VARCHAR2(50) NOT NULL,
  cultura VARCHAR2(50) NOT NULL,
  PRIMARY KEY (id_produto),
  FOREIGN KEY (designacao) REFERENCES Cultura (designacao),
  FOREIGN KEY (tipo) REFERENCES TipoCultura (tipo)
);


CREATE TABLE Setor (
  id_setor NUMBER(2) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_setor)
);

CREATE TABLE Ano (
  ano NUMBER(4) NOT NULL,
  PRIMARY KEY (ano),
  CONSTRAINT CHK_Ano    CHECK (ano > 0)
);

CREATE TABLE Mes (
  mes NUMBER(2) NOT NULL,
  PRIMARY KEY (mes),
  CONSTRAINT CHK_Mes    CHECK (mes > 0 AND mes < 13)
);

CREATE TABLE Tempo (
  id_tempo NUMBER(5) NOT NULL,
  ano NUMBER(4) NOT NULL,
  mes NUMBER(2) NOT NULL,
  PRIMARY KEY (id_tempo),
  FOREIGN KEY (ano) REFERENCES ano (ano),
  FOREIGN KEY (mes) REFERENCES mes (mes)
);

-- Fact table --

CREATE TABLE Venda (
  id_venda NUMBER(10) NOT NULL,
  id_cliente NUMBER(8) NOT NULL,
  id_produto NUMBER(5) NOT NULL,
  id_setor NUMBER(2) NOT NULL,
  id_tempo NUMBER(5) NOT NULL,
  quantidade NUMBER(8) NOT NULL,
  PRIMARY KEY (id_venda),
  FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
  FOREIGN KEY (id_produto) REFERENCES Produto (id_produto),
  FOREIGN KEY (id_setor) REFERENCES Setor (id_setor),
  FOREIGN KEY (id_tempo) REFERENCES Tempo (id_tempo),
  CONSTRAINT CHK_Quantidade    CHECK (quantidade > 0)
);

CREATE TABLE Producao (
  id_producao NUMBER(10) NOT NULL,
  id_produto NUMBER(5) NOT NULL,
  id_setor NUMBER(2) NOT NULL,
  id_tempo NUMBER(5) NOT NULL,
  quantidade NUMBER(8) NOT NULL,
  PRIMARY KEY (id_producao),
  FOREIGN KEY (id_produto) REFERENCES Produto (id_produto),
  FOREIGN KEY (id_setor) REFERENCES Setor (id_setor),
  FOREIGN KEY (id_tempo) REFERENCES Tempo (id_tempo),
  CONSTRAINT CHK_Quantidade_Prod    CHECK (quantidade > 0)
);
