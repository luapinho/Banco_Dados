-- exercicios 1
-- criando base de dados 
CREATE DATABASE dbVeterinaria;
CREATE DATABASE dbOficina;
CREATE DATABASE dbEscolaIdiomas;
CREATE DATABASE dbMaterias;

SHOW DATABASES; -- verificando os banco de dados existentes

USE dbOficina; -- usando o banco de dados, pq necessariamente quando for utilzado não comprova se esta sendo utilizado

-- exercicio 2
CREATE DATABASE dbAcademia;
SHOW DATABASES; -- mostrar as databases existentes(criadas)
 
USE dbAcademia; -- deixar pronto para utilização

-- exercicio 3
USE dbOficina; -- usando a base de dados da oficina

CREATE TABLE tbVeiculo (
id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
placa VARCHAR(10) NOT NULL UNIQUE,
modelo VARCHAR(100) NOT NULL,
ano YEAR,
valor_estimado DECIMAL(10,2),
ativo CHAR(20) DEFAULT 'Ativo'
);

SHOW TABLES;
DESC tbVeiculo;

-- exércicio 4
SHOW CREATE TABLE tbVeiculo;

-- exécicio 5
USE dbOficina;

ALTER TABLE tbVeiculo
ADD marca VARCHAR(50) NOT NULL;

ALTER TABLE tbVeiculo
ADD cor VARCHAR(30) NULL;

ALTER TABLE tbVeiculo
MODIFY modelo VARCHAR(150);

ALTER TABLE tbVeiculo
RENAME COLUMN valor_estimado TO valor_mercado;

SHOW CREATE TABLE tbVeiculo;

-- exercicio 6
DROP DATABASE IF EXISTS dbVeterinaria;

-- exercicio 7 

CREATE DATABASE dbOficinaHomologacao;
CREATE DATABASE dbEscolaHomologacao;

SHOW DATABASES;

USE dbOficinaHomologacao;
USE dbEscolaHomologacao;

DROP DATABASE IF EXISTS dbOficinaHomologacao;
DROP DATABASE IF EXISTS dbEscolaHomologacao;

-- exercicio 8

SHOW DATABASES;

USE dbOficina;

SHOW TABLES;

DESC veiculo;

USE dbEscolasIdiomas;

SHOW TABLES;

USE dbOficina;

-- exercicio 9
 
USE dbEscolaIdiomas;
 
CREATE TABLE tbCurso(
	id_curso INT PRIMARY KEY,
    nome varchar(100) NOT NULL UNIQUE,
    carga_horaria INT NOT NULL,
    valor DECIMAL(10,2) CHECK (valor >= 0),
    ativo BOOLEAN DEFAULT TRUE
 );
 
CREATE TABLE tbProfessor(
	id_professor INT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    data_admissao DATE NOT NULL,
    ativo VARCHAR(10) DEFAULT 'Ativo'
 );
 
SHOW TABLES;
 
DESCRIBE tbCurso;
DESCRIBE tbProfessor;

-- exercicio 10

CREATE TABLE tbTurma (
    id_turma INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    data_inicio DATE NOT NULL,
    horario TIME NOT NULL,
    id_curso INT NOT NULL,
    
    FOREIGN KEY (id_curso)
        REFERENCES tbCurso(id_curso)
);

DESCRIBE tbTurma;

-- exercicio 11

ALTER TABLE tbTurma
ADD COLUMN id_professor INT NOT NULL,
ADD CONSTRAINT fk_turma_professor
	FOREIGN KEY(id_professor)
    REFERENCES tbProfessor(id_professor);
    
DESCRIBE tbTurma;

-- exercicio 12

USE dbEscolasIdiomas;

CREATE TABLE tbaluno(
	id_aluno INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf BIGINT NOT NULL UNIQUE,
    data_nascimento DATE,
    email VARCHAR(150) UNIQUE,
    data_cadastro DATETIME,
    ativo VARCHAR(10) DEFAULT 'Ativo'
);

 -- exercício 13
USE dbEscolaIdiomas;

CREATE TABLE tbMatricula (
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    data_matricula DATE NOT NULL,
    situacao VARCHAR(20) NOT NULL,

    PRIMARY KEY (id_aluno, id_turma), -- chave primária composta

    FOREIGN KEY (id_aluno)
        REFERENCES tbaluno(id_aluno),

    FOREIGN KEY (id_turma)
        REFERENCES tbturma(id_turma)
);

/*
DESCRIBE matricula;
SHOW CREATE TABLE matricula;*/

-- exercício 14
/*
Não foi necessário criar curso1, curso 2 e Curso 3 dentro da tabela aluno, porque um aluno pode participar de várias turmas. 
A utilização das tabelas aluno, turma e matrícula permite representar esse relacionamento de forma organizada e evita repetir informações dentro da tabela aluno*/

/*
Não foi necessário criar curso1, curso2 e curso3
dentro da tabela ALUNO porque a normalização
separou essas informações em estruturas próprias.

A tabela MATRICULA permite relacionar os alunos
às turmas, evitando várias colunas para representar
os cursos.
*/

DESCRIBE aluno;

DESCRIBE matrícula;

-- exercício 15
CREATE DATABASE dbTreinamento;

USE dbTreinamento;

CREATE TABLE tbCliente(
Id_cliente INT,
Nome VARCHAR(100),
CPF CHAR(11),
Ativo BOOLEAN
);

-- CORREÇÕES 
ALTER TABLE tbCliente 
MODIFY id_cliente INT 
PRIMARY KEY;

ALTER TABLE tbCliente 
MODIFY nome VARCHAR(100)
NOT NULL;

ALTER TABLE tbCliente 
MODIFY CPF CHAR(11) NOT NULL UNIQUE;

ALTER TABLE tbCliente 
MODIFY ativo BOOLEAN DEFAULT TRUE;


-- ETAPA 3
-- EXERCÍCIO 16

CREATE DATABASE dbLocadoraTeste;

USE dbLocadoraTeste;

CREATE TABLE tbCliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    documento VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    situacao BOOLEAN DEFAULT TRUE
);

CREATE TABLE tbCategoria (
    id_categoria INT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE tbEquipamento (
    id_equipamento INT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    id_categoria INT NOT NULL,
    valor_diario DECIMAL(10,2) NOT NULL CHECK (valor_diario >= 0),
    situacao VARCHAR(20) DEFAULT 'DISPONIVEL',
    
    FOREIGN KEY (id_categoria)
        REFERENCES tbcategoria(id_categoria)
);

CREATE TABLE tbLocacao (
    id_locacao INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    retirada DATETIME NOT NULL,
    data_prevista_devolucao DATE,
    situacao VARCHAR(20),
    
    FOREIGN KEY (id_cliente)
        REFERENCES tbcliente(id_cliente)
);

CREATE TABLE tbItem_locacao (
    id_locacao INT NOT NULL,
    id_equipamento INT NOT NULL,
    valor_diario DECIMAL(10,2) NOT NULL CHECK (valor_diario >= 0),
    
    PRIMARY KEY (id_locacao, id_equipamento),
    
    FOREIGN KEY (id_locacao)
        REFERENCES tblocacao(id_locacao),
        
    FOREIGN KEY (id_equipamento)
        REFERENCES tbequipamento(id_equipamento)
);

SHOW TABLES;

DESCRIBE tbCliente;
DESCRIBE tbCategoria;
DESCRIBE tbEquipamento;
DESCRIBE tbLocacao;
DESCRIBE tbItem_locacao;


-- EXERCÍCIO 17

ALTER TABLE tbEquipamento
MODIFY nome VARCHAR(180) NOT NULL;

ALTER TABLE tbEquipamento
ADD marca VARCHAR(80) NOT NULL;

ALTER TABLE tbCliente
DROP COLUMN telefone;

ALTER TABLE tbEquipamento
RENAME COLUMN valor_diario TO valor_locacao;
RENAME TABLE categoria TO tipo_equipamento;

DESCRIBE tbEquipamento;
DESCRIBE tbCliente;
DESCRIBE tbTipo_equipamento;


-- EXERCÍCIO 18

CREATE TABLE tbEquipamento_importacao (
    codigo INT,
    descricao VARCHAR(180),
    quantidade INT
);

-- Situação A
-- limpando os dados na tabela mas mantendo a estrutura 
TRUNCATE TABLE tbEquipamento_importacao;

-- Situação B
-- apagando completamente tudo
DROP TABLE tbEquipamento_importacao;


-- EXERCÍCIO 19

SHOW DATABASES;

DROP DATABASE IF EXISTS dbVeterinaria;
DROP DATABASE IF EXISTS dbOficina;
DROP DATABASE IF EXISTS dbEscolaIdiomas;
DROP DATABASE IF EXISTS dbMateriais;
DROP DATABASE IF EXISTS dbAcademia;
DROP DATABASE IF EXISTS dbOficinaHomologacao;
DROP DATABASE IF EXISTS dbEscolaHomologacao;
DROP DATABASE IF EXISTS dbLocadoraTeste;

SHOW DATABASES;

-- ETAPA 4
-- EXERCÍCIO 20

/*
Analisar as principais entidades do projeto,
os relacionamentos, as relações 1:N e N:N,
as tabelas associativas e a normalização.

Não criar tabelas neste exercício.
*/


-- EXERCÍCIO 21

/*
Analisar o modelo conceitual e lógico da Horizonte Comercial.

Estado possui cidades.
Cidade pertence a estado.
Cliente pode possuir endereço.
Funcionário possui cargo.
Produto pertence a categoria.
Fornecedor fornece produtos.
Produto pode possuir vários fornecedores.
Produto possui controle de estoque.
Cliente realiza pedidos.
Pedido possui funcionário responsável.
Pedido possui produtos.
Pedido pode possuir pagamentos.
Pagamento possui forma de pagamento.
Pedido pode gerar entrega.

Não criar tabela*/


-- exercício 22
CREATE DATABASE dbHorizonte;

SHOW DATABASES;

USE dbHorizonte;

-- EXERCÍCIO 23 - ESTADO E CIDADE
   

CREATE TABLE estado (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    sigla CHAR(2) NOT NULL UNIQUE,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE cidade (
    id_cidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_estado INT NOT NULL,

    FOREIGN KEY (id_estado)
        REFERENCES estado(id_estado)
);

SHOW TABLES;

DESCRIBE estado;
DESCRIBE cidade;


-- EXERCÍCIO 24 - CLIENTE E ENDEREÇO 

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_razao_social VARCHAR(150) NOT NULL,
    documento VARCHAR(14) NOT NULL UNIQUE,
    tipo_pessoa CHAR(1) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150),
    data_nascimento DATE,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    situacao BOOLEAN NOT NULL DEFAULT TRUE,

    CHECK (tipo_pessoa IN ('F', 'J'))
);

CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    logradouro VARCHAR(150) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(100),
    cep VARCHAR(8) NOT NULL,
    id_cidade INT NOT NULL,

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),

    FOREIGN KEY (id_cidade)
        REFERENCES cidade(id_cidade)
);

SHOW TABLES;

DESCRIBE cliente;
DESCRIBE endereco;


-- EXERCÍCIO 25 - CARGO E FUNCIONÁRIO


CREATE TABLE cargo (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    salario_base DECIMAL(10,2) NOT NULL,

    CHECK (salario_base >= 0)
);

CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    data_admissao DATE NOT NULL,
    horario_entrada TIME,
    id_cargo INT NOT NULL,
    situacao BOOLEAN NOT NULL DEFAULT TRUE,

    FOREIGN KEY (id_cargo)
        REFERENCES cargo(id_cargo)
);

DESCRIBE cargo;
DESCRIBE funcionario;



-- EXERCÍCIO 26 - CATEGORIA E PRODUTO


CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    id_categoria INT NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    ano_fabricacao YEAR,
    estoque_minimo INT NOT NULL DEFAULT 0,
    situacao BOOLEAN NOT NULL DEFAULT TRUE,

    CHECK (preco_venda >= 0),
    CHECK (estoque_minimo >= 0),

    FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
);

DESCRIBE categoria;
DESCRIBE produto;



-- EXERCÍCIO 27 - FORNECEDOR E PRODUTO


CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(150) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(150),
    situacao BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE produto_fornecedor (
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    codigo_fornecedor VARCHAR(100),
    preco_custo DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_produto, id_fornecedor),

    FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto),

    FOREIGN KEY (id_fornecedor)
        REFERENCES fornecedor(id_fornecedor),

    CHECK (preco_custo >= 0)
);

DESCRIBE fornecedor;
DESCRIBE produto_fornecedor;



-- EXERCÍCIO 28 - ESTOQUE


CREATE TABLE estoque (
    id_produto INT PRIMARY KEY,
    quantidade_atual INT NOT NULL DEFAULT 0,
    data_hora_atualizacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto),

    CHECK (quantidade_atual >= 0)
);

DESCRIBE estoque;



-- EXERCÍCIO 29 - PEDIDO


CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    percentual_desconto DECIMAL(5,2) NOT NULL DEFAULT 0,
    situacao VARCHAR(30) NOT NULL,

    CHECK (
        percentual_desconto >= 0
        AND percentual_desconto <= 100
    ),

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),

    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
);

DESCRIBE pedido;

-- EXERCÍCIO 30 - ITEM DO PEDIDO


CREATE TABLE item_pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_pedido, id_produto),

    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto),

    CHECK (quantidade > 0),
    CHECK (valor_unitario >= 0)
);

DESCRIBE item_pedido;

-- EXERCÍCIO 31 - PAGAMENTO

CREATE TABLE forma_pagamento (
    id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL UNIQUE,
    situacao BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    situacao VARCHAR(30) NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    FOREIGN KEY (id_forma_pagamento)
        REFERENCES forma_pagamento(id_forma_pagamento),

    CHECK (valor_pago > 0)
);

DESCRIBE forma_pagamento;
DESCRIBE pagamento;

-- EXERCÍCIO 32 - ENTREGA

CREATE TABLE entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_endereco INT NOT NULL,
    data_prevista DATE NOT NULL,
    data_envio DATE,
    data_efetiva_entrega DATE,
    situacao VARCHAR(30) NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    FOREIGN KEY (id_endereco)
        REFERENCES endereco(id_endereco)
);

DESCRIBE entrega;

-- EXERCÍCIO 33 - AUDITORIA

SELECT DATABASE();

SHOW TABLES;

DESCRIBE cliente;
DESCRIBE produto;
DESCRIBE pedido;
DESCRIBE item_pedido;
DESCRIBE pagamento;
DESCRIBE entrega;

-- EXERCÍCIO 34 - ALTERAÇÕES

ALTER TABLE cliente
MODIFY nome_razao_social VARCHAR(200) NOT NULL;

ALTER TABLE cliente
ADD observacao VARCHAR(250);

ALTER TABLE fornecedor
DROP COLUMN telefone;

ALTER TABLE produto
RENAME COLUMN ano_fabricacao TO ano;

DESCRIBE cliente;
DESCRIBE fornecedor;
DESCRIBE produto;

-- EXERCÍCIO 35 - PESO E MARCA

ALTER TABLE produto
ADD peso DECIMAL(10,3);

ALTER TABLE produto
ADD marca VARCHAR(80) NOT NULL;

DESCRIBE produto;

-- EXERCÍCIO 36 - PESO OBRIGATÓRIO

ALTER TABLE produto
MODIFY peso DECIMAL(10,3) NOT NULL;

DESCRIBE produto;

-- EXERCÍCIO 37 - REMOVER ANO

ALTER TABLE produto
DROP COLUMN ano;

DESCRIBE produto;

-- EXERCÍCIO 38 - TABELA TEMPORÁRIA

CREATE TABLE produto_importacao (
    codigo INT,
    descricao VARCHAR(150),
    quantidade INT
);

DESCRIBE produto_importacao;


/* SITUAÇÃO A:
   Apagar os dados e manter a tabela */

TRUNCATE TABLE produto_importacao;


/* SITUAÇÃO B:
   Apagar a tabela inteira */

DROP TABLE produto_importacao;

-- EXERCÍCIO 39 - RENOMEAR ENTREGA

ALTER TABLE entrega
RENAME TO expedicao;

SHOW TABLES;

DESCRIBE expedicao;

-- EXERCÍCIO 40 - AUDITORIA FINAL

SELECT DATABASE();

SHOW DATABASES;

SHOW TABLES;

DESCRIBE estado;
DESCRIBE cidade;
DESCRIBE cliente;
DESCRIBE endereco;
DESCRIBE cargo;
DESCRIBE funcionario;
DESCRIBE categoria;
DESCRIBE produto;
DESCRIBE fornecedor;
DESCRIBE produto_fornecedor;
DESCRIBE estoque;
DESCRIBE pedido;
DESCRIBE item_pedido;
DESCRIBE forma_pagamento;
DESCRIBE pagamento;
DESCRIBE expedicao;


-- Conferindo a criação completa das tabelas 

SHOW CREATE TABLE produto;
SHOW CREATE TABLE pedido;
SHOW CREATE TABLE item_pedido;
SHOW CREATE TABLE pagamento;
SHOW CREATE TABLE expedicao;

