## Diretório para os exemplos de Banco de Dados - 3º período

Diretório destinado a armazenar as coisas de Banco de Dados do 3º período

### Sumário

* [A - Executando o docker-compose.yml](#a---executando-o-docker-composeyml)
* [B - Usando o SQL Notebook / SQLTools](#b---usando-o-sql-notebook--sqltools)
* [C - DevContainer com Python 3 & Postgres & psql](#c---devcontainer-com-python-3--postgres--psql)

---

#### A - Executando o docker-compose.yml

1. Crie um fork no GitHub (Web) do repositório template `dbdevcontainer`.
2. Clone o repositório localmente:
```bash
   git clone [meu_fork_do_dbdevcontainer]
```

3. Abra o PowerShell (Terminal) e posicione-se no diretório `.devcontainer`:
```powershell
cd [meu_fork_do_db_devcontainer]\.devcontainer

```


4. Execute o comando do Docker:
```bash
docker compose up

```



---

### B - Usando o SQL Notebook / SQLTools

#### Criando a conexão

1. Selecione a extensão **SQL Notebook / SQLTools**.
2. Na aba da extensão, preencha os parâmetros de conexão:
* **Display name:** `"db_server"`
* **Database Driver:** `"postgres"`
* **Database Host:** `"localhost"`
* **Database Port:** `"5432"`
* **Database User:** `"postgres"`
* **Database Password:** `"postgres"`
* **Database Name:** `"postgres"`


3. E, finalmente, clique em **"Create"**.

#### Executando os comandos em um script SQL no SQL Notebook

1. Clique com o botão esquerdo do mouse no script SQL.
2. Selecione **"Abrir com"** e, em seguida, **"SQL Notebook"**.
3. Observe que cada comando pode ser executado individualmente usando o ícone do **"play"**.

---

### C - DevContainer com Python 3 & Postgres & psql

#### Configuração do DevContainer

1. Na barra de comandos do VS Code (`Ctrl+Shift+P` ou `F1`), digite:
```text
> Dev Containers: Add Dev Container Configuration File...
```


2. Em seguida, selecione a opção **"Create a new configuration..."**.
3. Procure por **Python 3 & Postgres**.
4. Escolha a versão *default*.
5. Acrescente o pacote **PostgreSQL Client**.
6. Siga as instruções na tela para a finalização do processo e do *rebuild*.

### Configuração do CloudBeaver

Para mais informações sobre a implantação do CloudBeaver via Docker, consulte os links oficiais da comunidade:

* [[1] Wiki do CloudBeaver - Run Docker Container](https://github.com/dbeaver/cloudbeaver/wiki/Run-Docker-Container)
* [[2] Wiki do CloudBeaver - Community Deployment from Docker Image](https://github.com/dbeaver/cloudbeaver/wiki/CloudBeaver-Community-deployment-from-docker-image)