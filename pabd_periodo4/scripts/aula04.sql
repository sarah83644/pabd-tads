/* Revisão de comandos DQL - 19/08 */

-- Exibe toda a tabela
select * from funcionario;

-- Exibe informações específicas de uma tabela
select pnome, unome, num_departamento from funcionario;

-- Concatena informações e define alias (apelido) para a "nova coluna"
-- as: palavra reservada para alias
select pnome || ' ' || unome as "nome_completo", num_departamento from funcionario;

-- Sem a palavra reservada "as"
select pnome || ' ' || unome nome, num_departamento from funcionario;

select num_departamento from funcionario;

-- Exibe valores distintos
select distinct num_departamento from funcionario;

-- Calcula valor e exibe na tabela
select pnome || ' ' || unome nome, salario, round(salario*0.11, 2) inss from funcionario;

-- Filtro
select cpf, pnome || ' ' || unome nome from funcionario where endereco='Natal-RN';

-- Filtros mais específicos
select cpf, pnome || ' ' || unome nome from funcionario where num_departamento=1 and salario > 9000;
select cpf, pnome || ' ' || unome nome from funcionario where salario>=8000 and salario <=10000;
select cpf, pnome || ' ' || unome nome from funcionario where salario between 8000 and 10000; -- mesma coisa do select de cima
select cpf, pnome || ' ' || unome nome from funcionario where salario not between 8000 and 10000; -- tem um not agora
select cpf, pnome || ' ' || unome nome from funcionario where endereco like '%PI'; -- se a cadeia de caracteres for aparecer no final
select cpf, pnome || ' ' || unome nome from funcionario where pnome like '%ana%'; -- se você quer filtrar por uma cadeia que pode aparecer em qualquer lugar, use '%cadeia%' 
select cpf, pnome || ' ' || unome nome from funcionario where endereco ilike '%pi'; -- ilike: desconsidera case sensitive
select cpf, pnome || ' ' || unome nome from funcionario where endereco like '%R_'; -- _: substitui qualquer caractere