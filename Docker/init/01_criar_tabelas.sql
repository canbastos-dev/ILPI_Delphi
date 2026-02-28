-- =============================================================
-- Sistema de Gerenciamento - Cuidado de Idosas
-- Script 01: Criação das tabelas
-- Executado automaticamente pelo Docker na primeira inicialização
-- =============================================================

-- Extensões úteis
CREATE EXTENSION IF NOT EXISTS unaccent;

-- =============================================================
-- IDOSA (entidade central)
-- =============================================================
CREATE TABLE IF NOT EXISTS idosa (
  id            SERIAL PRIMARY KEY,
  nome          VARCHAR(150) NOT NULL,
  cpf           VARCHAR(14)  UNIQUE NOT NULL,
  rg            VARCHAR(20),
  data_nasc     DATE         NOT NULL,
  sexo          CHAR(1)      DEFAULT 'F',
  estado_civil  VARCHAR(20),
  telefone      VARCHAR(20),
  celular       VARCHAR(20),
  email         VARCHAR(100),
  cep           VARCHAR(10),
  logradouro    VARCHAR(150),
  numero        VARCHAR(10),
  complemento   VARCHAR(80),
  bairro        VARCHAR(80),
  cidade        VARCHAR(80),
  uf            CHAR(2),
  foto          BYTEA,
  observacoes   TEXT,
  ativo         BOOLEAN      DEFAULT TRUE,
  criado_em     TIMESTAMP    DEFAULT NOW(),
  atualizado_em TIMESTAMP    DEFAULT NOW()
);

-- =============================================================
-- FAMILIAR / CONTATO
-- =============================================================
CREATE TABLE IF NOT EXISTS familiar_contato (
  id            SERIAL PRIMARY KEY,
  idosa_id      INTEGER NOT NULL REFERENCES idosa(id) ON DELETE CASCADE,
  nome          VARCHAR(150) NOT NULL,
  parentesco    VARCHAR(150) NOT NULL,
  telefone      VARCHAR(20),
  celular       VARCHAR(20),
  email         VARCHAR(100),
  principal     BOOLEAN      DEFAULT FALSE,
  observacoes   TEXT
);

-- =============================================================
-- MEDICAMENTO (tabela base / catálogo)
-- =============================================================
CREATE TABLE IF NOT EXISTS medicamento (
  id                  SERIAL PRIMARY KEY,
  nome                VARCHAR(150) NOT NULL,
  nome_generico       VARCHAR(150),
  principio_ativo     VARCHAR(150),
  fabricante          VARCHAR(100),
  forma_administracao VARCHAR(50),
  apresentacao        VARCHAR(100),
  observacoes         TEXT,
  ativo               BOOLEAN DEFAULT TRUE
);

-- =============================================================
-- PROCEDIMENTO (tabela base / catálogo)
-- =============================================================
CREATE TABLE IF NOT EXISTS procedimento (
  id          SERIAL PRIMARY KEY,
  nome        VARCHAR(150) NOT NULL,
  descricao   TEXT,
  tipo        VARCHAR(80),
  ativo       BOOLEAN DEFAULT TRUE
);

-- =============================================================
-- AREA_PROFISSIONAL
-- =============================================================
CREATE TABLE IF NOT EXISTS area_profisional (
  id          SERIAL PRIMARY KEY,
  descricao   VARCHAR(150) NOT NULL,
  ativo       BOOLEAN DEFAULT TRUE
);

-- =============================================================
-- PROFISSIONAL
-- =============================================================
CREATE TABLE IF NOT EXISTS profissional (
  id                       SERIAL PRIMARY KEY,
  area_profissional_id     INTEGER      NOT NULL REFERENCES area_profisional(id) ON DELETE CASCADE,  
  descricao                VARCHAR(150) NOT NULL,
  ativo                    BOOLEAN DEFAULT TRUE
);


-- =============================================================
-- TRATAMENTO
-- =============================================================
CREATE TABLE IF NOT EXISTS tratamento (
  id                SERIAL PRIMARY KEY,
  idosa_id          INTEGER      NOT NULL REFERENCES idosa(id) ON DELETE CASCADE,
  descricao         VARCHAR(200) NOT NULL,
  diagnostico       TEXT,
  data_inicio       DATE         NOT NULL,
  data_fim_prevista DATE,
  data_encerramento DATE,
  profissional_id   INTEGER NOT NULL REFERENCES profissional(id) ON DELETE CASCADE,
  especialidade     VARCHAR(100),
  situacao          VARCHAR(20)  DEFAULT 'ATIVO',  -- ATIVO, ENCERRADO, SUSPENSO
  observacoes       TEXT,
  criado_em         TIMESTAMP    DEFAULT NOW()
);

-- =============================================================
-- TRATAMENTO x MEDICAMENTO (vínculo N:N)
-- =============================================================
CREATE TABLE IF NOT EXISTS tratamento_medicamento (
  id             SERIAL PRIMARY KEY,
  tratamento_id  INTEGER     NOT NULL REFERENCES tratamento(id)  ON DELETE CASCADE,
  medicamento_id INTEGER     NOT NULL REFERENCES medicamento(id),
  dosagem        VARCHAR(80),
  frequencia     VARCHAR(80),
  horarios       VARCHAR(150),
  data_inicio    DATE,
  data_fim       DATE,
  observacoes    TEXT
);

-- =============================================================
-- TRATAMENTO x PROCEDIMENTO (vínculo N:N)
-- =============================================================
CREATE TABLE IF NOT EXISTS tratamento_procedimento (
  id              SERIAL PRIMARY KEY,
  tratamento_id   INTEGER     NOT NULL REFERENCES tratamento(id)   ON DELETE CASCADE,
  procedimento_id INTEGER     NOT NULL REFERENCES procedimento(id),
  data_realizacao DATE,
  profissional    VARCHAR(150),
  resultado       TEXT,
  observacoes     TEXT
);

-- =============================================================
-- ÍNDICES para performance de busca
-- =============================================================
CREATE INDEX IF NOT EXISTS idx_idosa_nome        ON idosa(nome);
CREATE INDEX IF NOT EXISTS idx_idosa_cpf         ON idosa(cpf);
CREATE INDEX IF NOT EXISTS idx_idosa_ativo       ON idosa(ativo);
CREATE INDEX IF NOT EXISTS idx_familiar_idosa    ON familiar_contato(idosa_id);
CREATE INDEX IF NOT EXISTS idx_trat_idosa        ON tratamento(idosa_id);
CREATE INDEX IF NOT EXISTS idx_trat_situacao     ON tratamento(situacao);
CREATE INDEX IF NOT EXISTS idx_tratmed_trat      ON tratamento_medicamento(tratamento_id);
CREATE INDEX IF NOT EXISTS idx_tratproc_trat     ON tratamento_procedimento(tratamento_id);

-- =============================================================
-- FUNÇÃO: atualizar campo atualizado_em automaticamente
-- =============================================================
CREATE OR REPLACE FUNCTION fn_atualizar_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.atualizado_em = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_idosa_atualizado
  BEFORE UPDATE ON idosa
  FOR EACH ROW EXECUTE FUNCTION fn_atualizar_timestamp();

-- Mensagem de confirmação
DO $$
BEGIN
  RAISE NOTICE 'Script 01: Tabelas criadas com sucesso!';
END $$;

