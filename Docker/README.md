# Docker - Sistema de Idosas

## Estrutura dos arquivos

```
docker/
  docker-compose.yml       <- orquestra os containers
  .env                     <- senhas e configurações (NÃO versionar!)
  .env.example             <- modelo do .env (pode versionar)
  .gitignore               <- protege o .env do Git
  config.ini               <- configuração para o Delphi (copiar para pasta do .exe)
  init/
    01_criar_tabelas.sql   <- executado automaticamente na 1ª subida
    02_dados_iniciais.sql  <- medicamentos e procedimentos de exemplo
```

---

## Primeiros passos

### 1. Configurar o ambiente

Edite o arquivo `.env` com suas senhas antes de subir os containers.

### 2. Subir os containers

```bash
docker-compose up -d
```

### 3. Verificar se está tudo OK

```bash
docker-compose ps
# Status esperado: Up (healthy)
```

### 4. Acessar o pgAdmin

Abra o navegador: http://localhost:5050

- Login: admin@idosas.local
- Senha: (definida no .env)

No pgAdmin, registre o servidor com:
- Host: **postgres** (nome do serviço, não localhost!)
- Porta: 5432
- Banco: cuidado_idosas
- Usuário/Senha: conforme .env

### 5. Configurar o Delphi

Copie o arquivo `config.ini` para a pasta do executável:
- Desenvolvimento: `Win32\Debug\`
- Produção: `Win32\Release\`

---

## Comandos do dia a dia

```bash
# Subir
docker-compose up -d

# Parar (preserva dados)
docker-compose stop

# Reiniciar
docker-compose start

# Ver logs
docker-compose logs -f postgres

# Backup do banco
docker exec idosas_postgres pg_dump -U postgres cuidado_idosas > backup.sql

# Restore
docker exec -i idosas_postgres psql -U postgres cuidado_idosas < backup.sql

# CUIDADO: apaga tudo incluindo dados
docker-compose down -v
```

---

## Portas utilizadas

| Serviço    | Porta host | Porta container |
|------------|------------|-----------------|
| PostgreSQL | 5432       | 5432            |
| pgAdmin    | 5050       | 80              |

Se a porta 5432 já estiver em uso, altere `DB_PORT` no `.env`.