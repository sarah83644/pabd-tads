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


/* Aula 25/08 */

-- Order by
select pnome, unome from funcionario order by pnome, unome;

-- Ordena em ordem decrescente
select pnome, unome from funcionario order by pnome desc, unome desc;

-- Funções de agregação: count, sum, avg, min, max
select count(*) total_funcionarios from funcionario; -- tá contando tudo
select count(distinct num_departamento) from funcionario; -- tá contando valores distintos de uma coluna
select sum(salario) folha_salarial from funcionario; -- somando salários
select sum(salario) folha_salarial from funcionario where num_departamento=1; -- somando salário por departamento
select avg(salario) as "Média Salarial" from funcionario; -- média dos salários
select round(avg(salario), 2) as "Média Salarial" from funcionario; -- arredonda o valor
select min(salario) maior_salario, max(salario) menor_salario from funcionario;
select pnome as "Nome", unome as "Sobrenome" from funcionario where salario = (select min(salario) from funcionario); -- exemplo de subconsulta onde se pega o nome do funcionário com menor salário
select pnome as "Nome", unome as "Sobrenome" from funcionario where salario > (select avg(salario) from funcionario); -- exemplo de subconsulta onde se pega o nome do funcionário com salário acima da média

-- Total de funcionários, folha salarial, média salarial, menor salário e maior salário
select count(*) total_funcionarios, sum(salario) folha_salarial, round(avg(salario), 2) media_salarial, min(salario) menor_salario, max(salario) maior_salario from funcionario;

-- Quanto o funcionário paga de INSS
select sum(salario)*0.11 inss from funcionario;

-- Listar nome dos funcionários e seus respectivos nomes de departamentos
select f.pnome nome, f.unome sobrenome, d.nome departamento from funcionario f join departamento d on f.num_departamento = d.num;