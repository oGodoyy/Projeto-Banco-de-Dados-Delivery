-- Parte 1
-- 1. TABELA CLIENTE

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);

-- 2. TABELA RESTAURANTE

CREATE TABLE Restaurante (
    id_restaurante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    categoria VARCHAR(50) NOT NULL,
    telefone VARCHAR(20),
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    bairro VARCHAR(60) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(9),
    taxa_entrega DECIMAL(10,2) NOT NULL,
    tempo_medio_entrega INT
);

-- 3. TABELA CARDAPIO

CREATE TABLE Cardapio (
    id_cardapio INT AUTO_INCREMENT PRIMARY KEY,
    id_restaurante INT NOT NULL,
    nome VARCHAR(100) NOT NULL,

    FOREIGN KEY (id_restaurante)
        REFERENCES Restaurante(id_restaurante)
);

-- 4. TABELA PRODUTO

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_cardapio INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    disponivel BOOLEAN NOT NULL,

    FOREIGN KEY (id_cardapio)
        REFERENCES Cardapio(id_cardapio)
);

-- 5. TABELA STATUS_PEDIDO

CREATE TABLE Status_Pedido (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- 6. TABELA ENDERECO

CREATE TABLE Endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(60),
    bairro VARCHAR(60) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(9),

    FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
);

-- 7. TABELA PEDIDO

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_restaurante INT NOT NULL,
    id_endereco INT NOT NULL,
    id_status INT NOT NULL,
    data_hora DATETIME NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    taxa_entrega DECIMAL(10,2) NOT NULL,
    observacao VARCHAR(255),

    FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente),

    FOREIGN KEY (id_restaurante)
        REFERENCES Restaurante(id_restaurante),

    FOREIGN KEY (id_endereco)
        REFERENCES Endereco(id_endereco),

    FOREIGN KEY (id_status)
        REFERENCES Status_Pedido(id_status)
);

-- 8. TABELA ITEM_PEDIDO

CREATE TABLE Item_Pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_pedido, id_produto),

    FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido),

    FOREIGN KEY (id_produto)
        REFERENCES Produto(id_produto)
);

-- Parte 2
-- 1. INSERINDO CLIENTES

INSERT INTO Cliente (nome, cpf, email, telefone)
VALUES
('Ana Souza', '111.111.111-11', 'ana@example.com', '11900000001'),
('Bruno Lima', '222.222.222-22', 'bruno@example.com', '11900000002'),
('Carla Mendes', '333.333.333-33', 'carla@example.com', '11900000003');

-- 2. INSERINDO RESTAURANTES

INSERT INTO Restaurante (
    nome, cnpj, categoria, telefone,
    logradouro, numero, bairro, cidade,
    estado, cep, taxa_entrega, tempo_medio_entrega
)
VALUES
(
    'Sabor da Vila', '12.345.678/0001-90',
    'Brasileira', '11900000011',
    'Rua das Flores', '100', 'Centro',
    'Guarulhos', 'SP', '07000-000', 5.00, 35
),
(
    'Pizzaria Horizonte', '23.456.789/0001-01',
    'Pizzaria', '11900000012',
    'Avenida Brasil', '250', 'Jardim Maia',
    'Guarulhos', 'SP', '07000-100', 7.00, 45
),
(
    'Cantinho Caseiro', '34.567.890/0001-12',
    'Brasileira', '11900000013',
    'Rua Central', '50', 'Vila Galvão',
    'Guarulhos', 'SP', '07000-200', 4.50, 30
);

-- 3. INSERINDO CARDAPIOS

INSERT INTO Cardapio (id_restaurante, nome)
VALUES
(1, 'Cardápio Principal'),
(2, 'Cardápio de Pizzas'),
(3, 'Cardápio Caseiro');

-- 4. INSERINDO PRODUTOS

INSERT INTO Produto (
    id_cardapio, nome, descricao,
    preco, categoria, disponivel
)
VALUES
(
    1, 'Prato feito de frango',
    'Arroz, feijao, frango e salada',
    25.00, 'Prato feito', TRUE
),
(
    2, 'Pizza de mussarela',
    'Pizza grande de mussarela',
    45.00, 'Pizza', TRUE
),
(
    3, 'Marmita de carne',
    'Arroz, feijao e carne assada',
    22.00, 'Marmita', FALSE
);

-- 5. INSERINDO STATUS DOS PEDIDOS

INSERT INTO Status_Pedido (nome)
VALUES
('Recebido'),
('Em preparo'),
('Saiu para entrega'),
('Entregue'),
('Cancelado');

-- 6. INSERINDO ENDERECOS

INSERT INTO Endereco (
    id_cliente, logradouro, numero, complemento,
    bairro, cidade, estado, cep
)
VALUES
(
    1, 'Rua das Palmeiras', '100', 'Casa',
    'Centro', 'Guarulhos', 'SP', '07000-000'
),
(
    2, 'Avenida Central', '250', 'Apto 12',
    'Jardim Maia', 'Guarulhos', 'SP', '07000-100'
),
(
    3, 'Rua Primavera', '50', NULL,
    'Vila Galvão', 'Guarulhos', 'SP', '07000-200'
);

-- 7. INSERINDO PEDIDOS

INSERT INTO Pedido (
    id_cliente, id_restaurante, id_endereco,
    id_status, data_hora, valor_total,
    taxa_entrega, observacao
)
VALUES
(
    1, 1, 1, 1, '2026-11-26 12:00:00',
    30.00, 5.00, 'Sem cebola'
),
(
    2, 2, 2, 2, '2026-11-26 12:30:00',
    52.00, 7.00, NULL
),
(
    3, 3, 3, 5, '2026-11-26 13:00:00',
    26.50, 4.50, NULL
);

-- 8. INSERINDO ITENS DOS PEDIDOS

INSERT INTO Item_Pedido (
    id_pedido, id_produto, quantidade, preco_unitario
)
VALUES
(1, 1, 1, 25.00),
(2, 2, 1, 45.00),
(3, 3, 1, 22.00);

-- Parte 3
-- Comandos 

SELECT *
FROM Cliente;
-- ===================
SELECT
    id_restaurante,
    nome,
    categoria,
    cidade
FROM Restaurante
ORDER BY id_restaurante;
-- ===================
SELECT
    id_cardapio,
    id_restaurante,
    nome
FROM Cardapio
ORDER BY id_cardapio;
-- ====================
SELECT
    id_produto,
    id_cardapio,
    nome,
    preco,
    disponivel
FROM Produto
ORDER BY id_produto;
-- ===================
SELECT
    id_status,
    nome
FROM Status_Pedido
ORDER BY id_status;
-- ====================
SELECT
    id_endereco,
    id_cliente,
    logradouro,
    numero,
    cep
FROM Endereco
ORDER BY id_endereco;
-- ===================
SELECT
    id_pedido,
    id_cliente,
    id_restaurante,
    id_endereco,
    id_status,
    valor_total,
    taxa_entrega
FROM Pedido
ORDER BY id_pedido;
-- ==================
SELECT
    id_pedido,
    id_produto,
    quantidade,
    preco_unitario
FROM Item_Pedido
ORDER BY id_pedido;

-- CONSULTA 1: SELECT + WHERE

SELECT
    id_produto,
    nome,
    preco
FROM Produto
WHERE preco > 30.00;

-- CONSULTA 2: ORDER BY

SELECT
    id_produto,
    nome,
    preco
FROM Produto
ORDER BY preco DESC;

-- CONSULTA 3: COUNT

SELECT COUNT(*) AS total_produtos
FROM Produto;

-- CONSULTA 4: SUM

SELECT SUM(preco) AS soma_precos
FROM Produto;

-- CONSULTA 5: GROUP BY

SELECT
    categoria,
    COUNT(*) AS total_restaurantes
FROM Restaurante
GROUP BY categoria;

-- CONSULTA 6: AVG

SELECT AVG(preco) AS preco_medio
FROM Produto;

-- UPDATE: VERIFICANDO O PREÇO ORIGINAL

SELECT
    id_produto,
    nome,
    preco AS preco_antes
FROM Produto
WHERE id_produto = 2;

-- UPDATE: ALTERANDO O PREÇO

UPDATE Produto
SET preco = 48.50
WHERE id_produto = 2;

-- UPDATE: CONFERINDO O NOVO PREÇO

SELECT
    id_produto,
    nome,
    preco AS preco_depois
FROM Produto
WHERE id_produto = 2;

-- DELETE: CADASTRANDO PRODUTO DE TESTE

INSERT INTO Produto (
    id_cardapio,
    nome,
    descricao,
    preco,
    categoria,
    disponivel
)
VALUES (
    1,
    'Produto de teste',
    'Cadastro utilizado para testar DELETE',
    10.00,
    'Teste',
    TRUE
);

SELECT
    id_produto,
    nome,
    preco
FROM Produto
WHERE nome = 'Produto de teste';

-- DELETE: EXCLUINDO O PRODUTO DE TESTE

DELETE FROM Produto
WHERE id_produto = 4;
-- DELETE: CONFERINDO A EXCLUSAO

SELECT COUNT(*) AS produtos_teste_restantes
FROM Produto
WHERE id_produto = 4;