-- executando Statements de Consultas e Modificações de Dados via Transações:

-- a medida que um pedido é gerado é feito automaticamente a mudança da quantidade do produto no estoque:
BEGIN;
UPDATE productStorage SET quantity = quantity - 5 WHERE idProdStorage = 1;
INSERT INTO orders (idOrderClient, orderDescription, sendValue) VALUES (2, 'Novo pedido', 20);
COMMIT;

-- transação com procedure:

DELIMITER //

CREATE PROCEDURE criar_pedido(
    IN cliente_id INT,
    IN produto_id INT,
    IN quantidade INT
)
BEGIN
    DECLARE preco_produto DECIMAL(10, 2);
    
    -- Obter o preço do produto
    SELECT sendValue INTO preco_produto FROM orders WHERE idOrder = produto_id;
    
    START TRANSACTION;
    
    -- Criar novo pedido
    INSERT INTO orders (idOrderClient, orderDescription, sendValue) VALUES (cliente_id, 'Novo pedido', preco_produto * quantidade);
    SET @novo_pedido_id = LAST_INSERT_ID();
    
    -- Atualizar estoque
    UPDATE productStorage SET quantity = quantity - quantidade WHERE idProdStorage = produto_id;
    
    COMMIT;
END;
//

DELIMITER ;

-- chamando a procedure para criar um pedido
CALL criar_pedido(3, 1, 2); -- Cria um pedido com 2 unidades do produto de ID 1 para o cliente de ID 3

-- backup

mysqldump -u localhost@ -p company_constrainst > backup.sql

-- recovery

mysql -u localhost@ -p company_constrainst < backup.sql















