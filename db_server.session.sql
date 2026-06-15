CREATE TABLE dbex.cidade
(
    id serial PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    estado CHAR(2) NOT NULL
); 

SELECT * FROM dbex.cidade
