

-- Criação da tabela de produtos
CREATE TABLE produtos (
    id INT,
    nome VARCHAR(255),
    estoque INT
);


-- Inserindo dados de exemplo
INSERT INTO produtos VALUES
(1, 'Caneta', 10),
(2, 'Caderno', 5);


-- Criação do procedimento armazenado
DELIMITER $$


CREATE PROCEDURE AtualizarEstoque(IN produto_id INT, IN quantidade INT)
BEGIN
    DECLARE estoque_atual INT;


    SELECT estoque INTO estoque_atual
    FROM produtos
    WHERE id = produto_id;


    IF estoque_atual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Produto não encontrado';
    ELSEIF estoque_atual < quantidade THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente';
    ELSE
        UPDATE produtos
        SET estoque = estoque - quantidade
        WHERE id = produto_id;
    END IF;
END $$


DELIMITER ;


-- Execução do procedimento
CALL AtualizarEstoque(99, 1); 


-- Verificação do resultado
SELECT * FROM produtos;
