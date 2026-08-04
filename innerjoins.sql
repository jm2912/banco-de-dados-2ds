-- Criação das tabelas
CREATE TABLE produtos (
  id INT PRIMARY KEY,
  nome VARCHAR(50),
  categoria VARCHAR(30),
  preco DECIMAL(10, 2),
  em_estoque BOOLEAN
);

CREATE TABLE clientes (
  id INT PRIMARY KEY,
  nome VARCHAR(50),
  cidade VARCHAR(30),
  vip BOOLEAN
);

CREATE TABLE vendas (
  id INT PRIMARY KEY,
  produto_id INT,
  cliente_id INT,
  quantidade INT,
  data_venda DATE,
  FOREIGN KEY (produto_id) REFERENCES produtos(id),
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Inserindo dados
INSERT INTO produtos
VALUES (1, 'Notebook', 'Informática', 3500.00, TRUE),
       (2, 'Mouse', 'Informática', 45.00, TRUE),
       (3, 'Cadeira', 'Móveis', 850.00, FALSE),
       (4, 'Teclado', 'Informática', 120.00, TRUE);

INSERT INTO clientes
VALUES (201, 'Ana', 'Curitiba', TRUE),
       (202, 'Bruno', 'São Paulo', FALSE),
       (203, 'Carla', 'Curitiba', TRUE),
       (204, 'Diego', 'Rio de Janeiro', FALSE);

INSERT INTO vendas
VALUES (101, 1, 201, 2, '2023-10-01'),
       (102, 2, 202, 15, '2023-10-02'),
       (103, 3, 203, 1, '2023-10-02'),
       (104, 4, 204, 3, '2023-10-03');

-- Consultas simples
SELECT * FROM produtos;
SELECT * FROM clientes;
SELECT * FROM vendas;
-- Consulta simples das tabelas (em Query SQL)
SELECT * FROM produtos;
SELECT * FROM vendas;
SELECT * FROM clientes;

-- Junção de tabelas produto e vendas
SELECT p.nome, v.quantidade, v.data_venda
FROM produtos p
INNER JOIN vendas v ON p.id = v.produto_id
WHERE v.quantidade >= 3;

-- Junção das tabelas clientes, produto, vendas
SELECT c.nome AS cliente, p.nome AS produto, v.data_venda
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id
INNER JOIN produtos p ON v.produto_id = p.id
WHERE c.vip = TRUE;

-- Junção de tabelas clientes e produtos
SELECT c.nome, c.cidade, p.nome AS produto
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id
INNER JOIN produtos p ON v.produto_id = p.id
WHERE c.cidade = 'Curitiba' AND p.categoria = 'Informática';

-- Junção de tabelas com uso de aliases (apelidos) e booleano
SELECT c.nome AS cliente, p.nome AS produto, p.em_estoque
FROM clientes c
INNER JOIN produtos p ON c.id = p.id
WHERE p.em_estoque = TRUE;

-- Junção de tabelas produtos e vendas com OR
SELECT p.nome, v.quantidade, v.data_venda FROM produtos p INNER JOIN vendas v ON p.id = v.produto_id WHERE p.categoria = 'Móveis' OR v.quantidade > 10;

-- Junção das tabelas clientes e vendas - filtro por data e cidade
SELECT c.nome, c.cidade, v.data_venda FROM clientes c INNER JOIN vendas v ON c.id = v.cliente_id WHERE v.data_venda = '2023-10-02' AND c.cidade = 'Curitiba';

-- Filtro de produto comprado por cliente VIP
SELECT p.nome, v.quantidade, c.vip FROM produtos p INNER JOIN vendas v ON p.id = v.produto_id INNER JOIN clientes c ON c.id = v.cliente_id WHERE p.preco > 100 AND c.vip = TRUE;

-- Filtro por colunas de tabelas diferentes
SELECT c.nome AS cliente, p.nome AS produto, v.quantidade FROM clientes c INNER JOIN vendas v ON c.id = v.cliente_id INNER JOIN produtos p ON v.produto_id = p.id WHERE (p.categoria = 'Informática' AND v.quantidade >= 3) OR c.vip = TRUE;

-- Junção de tabelas produtos e vendas - filtro por quantidade vendida
SELECT p.categoria, SUM(v.quantidade) AS total_vendido
FROM produtos p
INNER JOIN vendas v ON p.id = v.produto_id
GROUP BY p.categoria
HAVING SUM(v.quantidade) > 5;
