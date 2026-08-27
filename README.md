## [Site para exercitar SQL](https://pgexercises.com/)

## Diretório para os exemplos de Programação e Administração de Banco de Dados - 4º período

### Configurando PostgreSQL no GitHub Codespaces

#### 1. Instalando o Postgres

```bash
sudo apt update
sudo apt install -y postgresql postgresql-client postgresql-contrib
sudo service postgresql start
```

#### 2. Adicionar Permissão

```bash
echo "codespace ALL=(postgres) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/codespace-postgres
sudo chmod 440 /etc/sudoers.d/codespace-postgres
```

#### 3. Testar a Instalação


```bash
sudo -u postgres psql -c "SELECT version();"
```

#### 4. Criar um Novo Usuário e Banco de Dados

```bash
sudo -u postgres psql <<'SQL'
CREATE ROLE admin LOGIN PASSWORD 'root' SUPERUSER;
CREATE DATABASE pabd OWNER admin;
SQL
```

#### 5. Conectar com o Novo Usuário

```bash
psql -h 127.0.0.1 -p 5432 -U admin -d pabd
```

##### Detalhes dos Parâmetros:
* `-h`: Especifica o host.
* `-p`: Especifica a porta.
* `-U`: Especifica o usuário.
* `-d`: Especifica o banco de dados.
* `-W`: *(Opcional)* Força o prompt de senha (em vez de confiar em variáveis `PGPASSWORD` ou no arquivo `.pgpass`).
* `-c`: Executa um comando SQL direto sem abrir o terminal interativo.

> [!IMPORTANT]
> **Diferença Importante (127.0.0.1 vs localhost):**  
> Utilizamos explicitamente o IP `127.0.0.1` em vez de `localhost`. No PostgreSQL, o termo `localhost` pode tentar realizar a conexão via socket Unix (utilizando autenticação do tipo `peer`), enquanto o IP `127.0.0.1` força uma conexão de rede via TCP/IP. Isso garante que a autenticação por senha seja exigida e funcione corretamente para a role que acabamos de criar.

#### 6. Exibir Todas as Tabelas

Após se conectar ao banco de dados, você pode listar todas as tabelas criadas no esquema público utilizando a seguinte consulta SQL:

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE';
```