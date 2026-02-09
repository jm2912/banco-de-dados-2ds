-- Criação do Banco de Dados Escola
-- Data: 2026-02-09
-- Descrição: Script para criar o banco de dados e tabelas iniciais sem inserção de dados

-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS escola;
USE escola;

-- Tabela de Alunos
CREATE TABLE IF NOT EXISTS alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(15),
    endereco VARCHAR(255),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(8),
    data_inscricao DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'ATIVO'
);

-- Tabela de Professores
CREATE TABLE IF NOT EXISTS professores (
    id_professor INT PRIMARY KEY AUTO_INCREMENT,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(15),
    endereco VARCHAR(255),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(8),
    data_contratacao DATE NOT NULL,
    especialidade VARCHAR(100),
    status VARCHAR(20) DEFAULT 'ATIVO'
);

-- Tabela de Disciplinas
CREATE TABLE IF NOT EXISTS disciplinas (
    id_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    carga_horaria INT NOT NULL,
    ementa TEXT,
    status VARCHAR(20) DEFAULT 'ATIVA'
);

-- Tabela de Turmas
CREATE TABLE IF NOT EXISTS turmas (
    id_turma INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    ano_letivo INT NOT NULL,
    semestre INT NOT NULL,
    id_professor INT NOT NULL,
    capacidade INT DEFAULT 30,
    periodo VARCHAR(20),
    status VARCHAR(20) DEFAULT 'ATIVA',
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

-- Tabela de Matrículas
CREATE TABLE IF NOT EXISTS matriculas (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    data_matricula DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'ATIVA',
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma),
    UNIQUE KEY unique_aluno_turma (id_aluno, id_turma)
);

-- Tabela de Notas
CREATE TABLE IF NOT EXISTS notas (
    id_nota INT PRIMARY KEY AUTO_INCREMENT,
    id_matricula INT NOT NULL,
    id_disciplina INT NOT NULL,
    bimestre INT NOT NULL,
    nota DECIMAL(5, 2),
    data_lancamento DATE,
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);

-- Tabela de Presença
CREATE TABLE IF NOT EXISTS presenca (
    id_presenca INT PRIMARY KEY AUTO_INCREMENT,
    id_matricula INT NOT NULL,
    id_disciplina INT NOT NULL,
    data_aula DATE NOT NULL,
    presente BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);

-- Tabela de Cursos
CREATE TABLE IF NOT EXISTS cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    duracao_meses INT,
    carga_horaria INT,
    status VARCHAR(20) DEFAULT 'ATIVO'
);

-- Tabela de Alocação de Disciplinas em Turmas
CREATE TABLE IF NOT EXISTS turma_disciplinas (
    id_turma_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    id_turma INT NOT NULL,
    id_disciplina INT NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina),
    UNIQUE KEY unique_turma_disciplina (id_turma, id_disciplina)
);

-- Índices para melhorar performance
CREATE INDEX idx_alunos_status ON alunos(status);
CREATE INDEX idx_professores_status ON professores(status);
CREATE INDEX idx_turmas_ano_semestre ON turmas(ano_letivo, semestre);
CREATE INDEX idx_matriculas_aluno ON matriculas(id_aluno);
CREATE INDEX idx_matriculas_turma ON matriculas(id_turma);
CREATE INDEX idx_notas_matricula ON notas(id_matricula);
CREATE INDEX idx_presenca_matricula ON presenca(id_matricula);

-- Criação de Views úteis

-- View de Alunos por Turma
CREATE VIEW vw_alunos_turma AS
SELECT 
    t.nome AS turma,
    a.matricula,
    a.nome AS aluno,
    a.email,
    m.data_matricula
FROM turmas t
JOIN matriculas m ON t.id_turma = m.id_turma
JOIN alunos a ON m.id_aluno = a.id_aluno
WHERE m.status = 'ATIVA'
ORDER BY t.nome, a.nome;

-- View de Turmas por Professor
CREATE VIEW vw_turmas_professor AS
SELECT 
    p.nome AS professor,
    t.nome AS turma,
    t.ano_letivo,
    t.semestre,
    COUNT(m.id_aluno) AS total_alunos
FROM professores p
JOIN turmas t ON p.id_professor = t.id_professor
LEFT JOIN matriculas m ON t.id_turma = m.id_turma AND m.status = 'ATIVA'
WHERE t.status = 'ATIVA'
GROUP BY p.id_professor, t.id_turma;
