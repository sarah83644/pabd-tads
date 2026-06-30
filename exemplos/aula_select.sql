/* Mostra todos os dados de todas as colunas da tabela que você quer ver */
/* Desse modo ele vai mostrar as colunas na ordem em que foram criadas */
SELECT * FROM nome_tabela;

/* Com schema */
SELECT * FROM schema_corresponde.nome_tabela;

/* Para filtrar por coluna (ou várias colunas) de uma tabela */
SELECT coluna1, coluna2, coluna3 FROM nome_tabela;

/* Referência para uma tabela - alias (uma variável que instancia e acessa um objeto, por exemplo) */
SELECT r.nome_tabela AS "nome da tabela",
    r.coluna1 AS "coluna 1",
    r.coluna2 AS "coluna 2",
    r.coluna3 AS "coluna 3"
FROM nome_tabela r;
