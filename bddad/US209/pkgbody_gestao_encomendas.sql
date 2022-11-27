CREATE OR REPLACE PACKAGE BODY gestao_encomendas AS
  FUNCTION registar_encomenda(id_cliente CLIENTE.id_cliente%TYPE, 
    lista_produtos produtos) 
  RETURN ENCOMENDA.id_encomenda%TYPE IS
    id_encomenda ENCOMENDA.id_encomenda%TYPE;
    id_produto PRODUTO.id_produto%TYPE;
    preco_produto PRODUTO.preco%TYPE;
    iva_produto ESCALAOIVA.valor%TYPE;
    designacao_produto PRODUTO.designacao%TYPE;
    morada_entrega CLIENTE.morada_entrega%TYPE;
    cod_postal_entrega CLIENTE.cod_postal_entrega%TYPE;
    plafond_cliente CLIENTE.plafond%TYPE;
    valor_encomenda NUMBER;
    valor_por_pagar NUMBER;
  BEGIN
    SAVEPOINT inicio;

    SELECT morada_entrega, cod_postal_entrega, plafond 
    INTO morada_entrega, cod_postal_entrega, plafond_cliente 
    FROM cliente 
    WHERE id_cliente = id_cliente;
  
    IF morada_entrega IS NULL THEN
      RAISE cliente_inexistente;
    END IF;

    INSERT INTO encomenda (id_cliente, data_vencimento_pagamento, morada_entrega, cod_postal_entrega)
    VALUES (id_cliente, SYSDATE + 30, morada_entrega, cod_postal_entrega)
    RETURNING id_encomenda INTO id_encomenda;

    valor_encomenda := 0;

    id_produto := lista_produtos.FIRST;

    WHILE id_produto IS NOT NULL LOOP
      SELECT preco, designacao 
      INTO preco_produto, designacao_produto 
      FROM produto 
      WHERE id_produto = id_produto;
  
      IF preco_produto IS NULL THEN
        RAISE produto_inexistente;
      END IF;
  
      SELECT valor
      INTO iva_produto
      FROM escalaoiva e, produto p
      WHERE p.id_produto = id_produto AND e.id_escalao_iva = p.id_escalao_iva;

      INSERT INTO produtoencomenda (id_encomenda, id_produto, quantidade, preco_unitario, iva, designacao_produto)
      VALUES (id_encomenda, id_produto, lista_produtos(id_produto), preco_produto, iva_produto, designacao_produto);

      id_produto := lista_produtos.NEXT(id_produto);
    END LOOP;
    
    SELECT SUM(preco_unitario * quantidade * (1 + iva/100))
    INTO valor_encomenda
    FROM produtoencomenda 
    WHERE id_encomenda = id_encomenda;

    SELECT SUM(preco_unitario * quantidade * (1 + iva/100))
    INTO valor_por_pagar
    FROM produtoencomenda 
    WHERE id_encomenda IN (SELECT id_encomenda FROM encomenda WHERE id_cliente = id_cliente AND data_pagamento IS NULL);

    IF (valor_encomenda + valor_por_pagar) > plafond_cliente THEN
      RAISE sem_plafond;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Encomenda ' || id_encomenda || ' registada com sucesso.');

    COMMIT;
    RETURN id_encomenda;
  EXCEPTION
    WHEN cliente_inexistente THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cliente inexistente.');
      ROLLBACK TO inicio;
    WHEN produto_inexistente THEN
      RAISE_APPLICATION_ERROR(-20002, 'Produto inexistente.');
      ROLLBACK TO inicio;
    WHEN sem_plafond THEN
      RAISE_APPLICATION_ERROR(-20003, 'Sem plafond.');
      ROLLBACK TO inicio;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20005, 'Erro ao registar encomenda.');
      ROLLBACK TO inicio;
  END registar_encomenda;

  FUNCTION registar_encomenda(id_cliente CLIENTE.id_cliente%TYPE, 
    lista_produtos produtos, 
    morada_entrega ENCOMENDA.morada_entrega%TYPE, 
    cod_postal_entrega ENCOMENDA.cod_postal_entrega%TYPE) 
  RETURN ENCOMENDA.id_encomenda%TYPE IS
    id_encomenda ENCOMENDA.id_encomenda%TYPE;
    id_produto PRODUTO.id_produto%TYPE;
    preco_produto PRODUTO.preco%TYPE;
    iva_produto ESCALAOIVA.valor%TYPE;
    designacao_produto PRODUTO.designacao%TYPE;
    plafond_cliente CLIENTE.plafond%TYPE;
    valor_encomenda NUMBER;
    valor_por_pagar NUMBER;
  BEGIN
    SAVEPOINT inicio;

    SELECT plafond 
    INTO plafond_cliente 
    FROM cliente 
    WHERE id_cliente = id_cliente;
  
    IF plafond_cliente IS NULL THEN
      RAISE cliente_inexistente;
    END IF;

    INSERT INTO encomenda (id_cliente, data_vencimento_pagamento, valor, morada_entrega, cod_postal_entrega)
    VALUES (id_cliente, SYSDATE + 30, 0, morada_entrega, cod_postal_entrega)
    RETURNING id_encomenda INTO id_encomenda;

    valor_encomenda := 0;

    id_produto := lista_produtos.FIRST;

    WHILE id_produto IS NOT NULL LOOP
      SELECT preco, designacao 
      INTO preco_produto, designacao_produto 
      FROM produto 
      WHERE id_produto = id_produto;
  
      IF preco_produto IS NULL THEN
        RAISE produto_inexistente;
      END IF;
  
      SELECT valor
      INTO iva_produto
      FROM escalaoiva e, produto p
      WHERE p.id_produto = id_produto AND e.id_escalao_iva = p.id_escalao_iva;

      INSERT INTO produtoencomenda (id_encomenda, id_produto, quantidade, preco_unitario, iva, designacao_produto)
      VALUES (id_encomenda, id_produto, lista_produtos(id_produto), preco_produto, iva_produto, designacao_produto);

      id_produto := lista_produtos.NEXT(id_produto);
    END LOOP;
    
    SELECT SUM(preco_unitario * quantidade * (1 + iva/100))
    INTO valor_encomenda
    FROM produtoencomenda 
    WHERE id_encomenda = id_encomenda;

    SELECT SUM(preco_unitario * quantidade * (1 + iva/100))
    INTO valor_por_pagar
    FROM produtoencomenda 
    WHERE id_encomenda IN (SELECT id_encomenda FROM encomenda WHERE id_cliente = id_cliente AND data_pagamento IS NULL);

    IF (valor_encomenda + valor_por_pagar) > plafond_cliente THEN
      RAISE sem_plafond;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Encomenda ' || id_encomenda || ' registada com sucesso.');

    COMMIT;
    RETURN id_encomenda;
  EXCEPTION
    WHEN cliente_inexistente THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cliente inexistente.');
      ROLLBACK TO inicio;
    WHEN produto_inexistente THEN
      RAISE_APPLICATION_ERROR(-20002, 'Produto inexistente.');
      ROLLBACK TO inicio;
    WHEN sem_plafond THEN
      RAISE_APPLICATION_ERROR(-20003, 'Sem plafond.');
      ROLLBACK TO inicio;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20005, 'Erro ao registar encomenda.');
      ROLLBACK TO inicio;
  END registar_encomenda;

  PROCEDURE registar_entrega(id_encomenda ENCOMENDA.id_encomenda%TYPE, 
    data_entrega ENCOMENDA.data_entrega%TYPE) IS
    cont NUMBER;
  BEGIN
    SAVEPOINT inicio;

    SELECT COUNT(*) 
    INTO cont
    FROM encomenda
    WHERE id_encomenda = id_encomenda AND data_entrega IS NULL;

    IF cont = 0 THEN
      RAISE encomenda_inexistente;
    END IF;

    UPDATE encomenda
    SET (data_entrega) = (data_entrega)
    WHERE id_encomenda = id_encomenda;

    DBMS_OUTPUT.PUT_LINE('Entrega da encomenda ' || id_encomenda || ' registada com sucesso.');

    COMMIT;
  EXCEPTION
    WHEN encomenda_inexistente THEN
      RAISE_APPLICATION_ERROR(-20004, 'Encomenda inexistente.');
      ROLLBACK TO inicio;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20005, 'Erro ao registar entrega.');
      ROLLBACK TO inicio;
  END registar_entrega;

  PROCEDURE registar_pagamento(id_encomenda ENCOMENDA.id_encomenda%TYPE, 
    data_pagamento ENCOMENDA.data_pagamento%TYPE) IS
    cont NUMBER;
  BEGIN
    SAVEPOINT inicio;

    SELECT COUNT(*) 
    INTO cont
    FROM encomenda
    WHERE id_encomenda = id_encomenda AND data_entrega IS NULL;

    IF cont = 0 THEN
      RAISE encomenda_inexistente;
    END IF;

    UPDATE encomenda
    SET (data_pagamento) = (data_pagamento)
    WHERE id_encomenda = id_encomenda;

    DBMS_OUTPUT.PUT_LINE('Pagamento da encomenda ' || id_encomenda || ' registado com sucesso.');

    COMMIT;
  EXCEPTION
    WHEN encomenda_inexistente THEN
      RAISE_APPLICATION_ERROR(-20004, 'Encomenda inexistente.');
      ROLLBACK TO inicio;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20005, 'Erro ao registar pagamento.');
      ROLLBACK TO inicio;
  END registar_pagamento;

  PROCEDURE listar_encomendas IS
    CURSOR encomendas IS
      SELECT id_encomenda, id_cliente, valor, data_entrega, data_pagamento
      FROM encomenda
      ORDER BY id_encomenda;
    id_encomenda ENCOMENDA.id_encomenda%TYPE;
    id_cliente ENCOMENDA.id_cliente%TYPE;
    nome_cliente CLIENTE.nome%TYPE;
    valor FLOAT;
    data_entrega ENCOMENDA.data_entrega%TYPE;
    data_pagamento ENCOMENDA.data_pagamento%TYPE;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Encomendas:');
    DBMS_OUTPUT.PUT_LINE('');

    FOR encomenda IN encomendas LOOP
      id_encomenda := encomenda.id_encomenda;
      id_cliente := encomenda.id_cliente;
      data_entrega := encomenda.data_entrega;
      data_pagamento := encomenda.data_pagamento;

      SELECT SUM(preco_unitario * quantidade * (1 + iva/100))
      INTO valor
      FROM produtoencomenda 
      WHERE id_encomenda = id_encomenda;

      SELECT nome
      INTO nome_cliente
      FROM cliente
      WHERE id_cliente = id_cliente;

      DBMS_OUTPUT.PUT_LINE('Encomenda ' || id_encomenda || ' do cliente ' || nome_cliente || ' no valor de ' || TRUNC(valor, 2) || ' euros.');

      IF data_entrega IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Entregue a ' || TO_CHAR(data_entrega, 'DD/MM/YYYY') || '.');
      END IF;

      IF data_pagamento IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Pagamento registado a ' || TO_CHAR(data_pagamento, 'DD/MM/YYYY') || '.');
      END IF;

      IF data_pagamento IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Estado: PAGA.');
      ELSIF data_entrega IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Estado: ENTREGUE.');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Estado: REGISTADA.');
      END IF;

      DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
  END listar_encomendas;
END gestao_encomendas;