-- No cenário de ecommerce
--Exemplo de criação de procedimento armazenado para inserir um novo cliente:

DELIMITER //
CREATE PROCEDURE InsertNewClient(
    IN p_fname VARCHAR(255),
    IN p_lname VARCHAR(255),
    IN p_tipo_cliente VARCHAR(2),
    IN p_cpf_cnpj VARCHAR(14),
    IN p_endereco VARCHAR(255),
    IN p_telefone VARCHAR(20),
    IN p_email VARCHAR(255),
    IN p_inscricao_estadual VARCHAR(20),
    IN p_razao_social VARCHAR(255),
    IN p_nome_responsavel VARCHAR(255),
    IN p_data_nascimento DATE
)
BEGIN
    INSERT INTO cliente (fname, lname, tipo_cliente, cpf_cnpj, endereco, telefone, email, inscricao_estadual, razao_social, nome_responsavel, data_nascimento)
    VALUES (p_fname, p_lname, p_tipo_cliente, p_cpf_cnpj, p_endereco, p_telefone, p_email, p_inscricao_estadual, p_razao_social, p_nome_responsavel, p_data_nascimento);
END;
//
DELIMITER ;

-- Exemplo de criação de procedimento armazenado para atualizar o status de um pedido:
DELIMITER //
CREATE PROCEDURE UpdateOrderStatus(
    IN p_order_id INT,
    IN p_new_status VARCHAR(50)
)
BEGIN
    UPDATE orders
    SET orderStatus = p_new_status
    WHERE idOrder = p_order_id;
END;
//
DELIMITER ;


-- criação de indices

CREATE INDEX idx_cliente_cpf_cnpj ON cliente (cpf_cnpj);

CREATE INDEX idx_orders_idOrderClient ON orders (idOrderClient);

CREATE INDEX idx_productOrder_idPOproduct_idPOorder ON productOrder (idPOproduct, idPOorder);


