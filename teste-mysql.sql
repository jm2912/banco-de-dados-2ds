-- Criação da tabela
CREATE TABLE Clientes (
    ID INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Data_Cadastro DATE NOT NULL,
    PRIMARY KEY (ID)
);

-- Inserção da 1ª linha
INSERT INTO Clientes (Nome, Email, Data_Cadastro)
VALUES ('Ana Silva', 'ana.silva@example.com', CURDATE());

-- Inserção das linhas 2 e 3 em um único comando
INSERT INTO Clientes (Nome, Email, Data_Cadastro)
VALUES
('Bruno Souza', 'bruno.souza@example.com', '2025-01-15'),
('Carla Mendes', 'carla.mendes@example.com', '2025-02-20');

-- Consulta da tabela
SELECT * FROM Clientes;

-- Exclusão da tabela
DROP TABLE Clientes;

-- Consulta para confirmar exclusão
SELECT * FROM Clientes;
