-- views:

CREATE USER gerente WITH PASSWORD 'senha_gerente';

CREATE VIEW numero_empregados_por_departamento_localidade AS
SELECT departamento, localidade, COUNT(*) AS numero_empregados
FROM empregados
GROUP BY departamento, localidade;

GRANT SELECT ON numero_empregados_por_departamento_localidade TO gerente;

-- view
CREATE VIEW rh_view AS
SELECT idSeller , SocialName , CPF , contact , data_admissao
FROM funcionarios;

CREATE USER analista_rh WITH PASSWORD 'senha_gerente';

GRANT SELECT ON rh_view TO analista_rh;


-- exemplo de criação de trigger
-- qual é a importância de uma trigger? Basicamente é implantar lógica a um banco de dados.

CREATE TRIGGER impede_exclusao_produto
BEFORE DELETE ON produtos
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM pedidos WHERE produto_id = OLD.id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir, existem pedidos relacionados';
    END IF;
END;

-- atualizar o estoque automaticamente
CREATE TRIGGER atualiza_estoque
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;
END;


