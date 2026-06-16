
-- 1. Criação da tabela e dados de exemplo
CREATE TABLE notas (
    aluno_id INT,
    nota DECIMAL(5,2)
);


INSERT INTO notas VALUES
(1, 8.5),
(1, 7.0),
(2, 9.0);


-- 2. Criação do procedimento armazenado
-- O DELIMITER é usado para que o banco entenda onde termina a procedure [1, 3]
DELIMITER $$


CREATE PROCEDURE MediaNotasAluno(IN p_aluno_id INT)
BEGIN
    DECLARE media DECIMAL(5,2); -- Variável local para guardar o resultado [4]


    -- Atribuição de valor com SELECT INTO [4, 5]
    SELECT AVG(nota) INTO media
    FROM notas
    WHERE aluno_id = p_aluno_id;


    -- Controle de erros para IDs inexistentes [5-7]
    IF media IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Aluno não encontrado';
    ELSE
        SELECT media AS media_final;
    END IF;
END $$


DELIMITER ;


-- 3. Execução do procedimento
CALL MediaNotasAluno(99); 
