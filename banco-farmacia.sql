-- Criando a tabela FARMACIA
CREATE TABLE FARMACIA (
    CNPJ_farmacia VARCHAR(20) PRIMARY KEY,
    tel_farmacia VARCHAR(15),
    nome_farmacia VARCHAR(100),
    end_farmacia VARCHAR(200)
);

-- Criando a tabela PRODUTO (com chave estrangeira para Farmácia)
CREATE TABLE PRODUTO (
    cod_produto INTEGER PRIMARY KEY,
    qtd_produto INTEGER,
    valor_produto DECIMAL(10,2),
    CNPJ_farmacia VARCHAR(20),
    FOREIGN KEY (CNPJ_farmacia) REFERENCES FARMACIA (CNPJ_farmacia)
);

-- Criando a tabela FARMACEUTICO (com chave estrangeira para Farmácia)
CREATE TABLE FARMACEUTICO (
    RG_farmaceutico VARCHAR(20) PRIMARY KEY,
    nome_farmaceutico VARCHAR(100),
    CNPJ_farmacia VARCHAR(20),
    FOREIGN KEY (CNPJ_farmacia) REFERENCES FARMACIA (CNPJ_farmacia)
);
