CREATE OR REPLACE PACKAGE gestao_clientes AS
  FUNCTION fn_RegistarCliente(
      nome IN CLIENTE.nome%TYPE,
      nif IN CLIENTE.nif%TYPE,
      email IN CLIENTE.email%TYPE,
      morada IN CLIENTE.morada%TYPE,
      morada_entrega IN CLIENTE.morada_entrega%TYPE,
      postal IN CLIENTE.cod_postal%TYPE,
      postal_entrega IN CLIENTE.cod_postal_entrega%TYPE,
      plafond IN CLIENTE.plafond%TYPE)
    RETURN CLIENTE.id_cliente%TYPE;

  PROCEDURE pr_AtualizarEncomendasCliente(
    cliente_id IN CLIENTE.id_cliente%TYPE);

END gestao_clientes;
