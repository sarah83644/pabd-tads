/* Revisão de comandos DDL - 12/08 */

-- Deleta tabela e todos os objetos relacionados a ela
drop table if exists funcionario cascade;
drop table if exists departamento cascade;

create table funcionario(
    cpf char(11) primary key, 
    pnome varchar(50) not null,
    unome varchar(50) not null,
    email varchar(50) not null unique,
    endereco varchar(100),
    salario numeric(7,2), 
    data_nasc date,
    sexo char(1),
    cpf_supervisor char(11),
    num_departamento smallint, 

    constraint funcionario_salario_check
    check (salario >= 2000 and salario <= 15000)
);

create table departamento(
    num smallint primary key,
    nome varchar(50) unique,
    cpf_gerente char(11),
    data_ini date not null
);


/*
-- Adicionar uma restrição padrão
alter table funcionario
alter column endereco set default 'Macaíba-RN';

-- Adiciona coluna
alter table departamento
add column data_inicio date;

-- Altera coluna
alter table departamento
alter column data_inicio set not null;

-- Deleta coluna
alter table departamento
drop column data_inicio;

-- Excluir um valor padrão DEFAULT
alter table funcionario
alter column endereco drop default;

-- Adicionar constraint CHECK
alter table funcionario
add constraint funcionario_sexo_check
check (lower(sexo) = 'm' or lower(sexo) = 'f' or lower(sexo) = 't');

-- Excluir constraint
alter table funcionario
drop constraint if exists funcionario_sexo_check;

-- Adicionar restrições de chave estrangeira
alter table funcionario
add constraint funcionario_num_dep_fk
foreign key (num_departamento) references departamento(num)
on delete no action
on update cascade;

alter table departamento
add constraint departamento_cpf_gerente_fk
foreign key (cpf_gerente) references funcionario(cpf)
on delete set null
on update cascade;
*/