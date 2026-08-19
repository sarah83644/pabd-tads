/* Revisão de comandos DML - 18/08 */

-- Inserir elementos
-- nesses exemplos, os dois últimos atributos desse insert ficam null porque ainda não existe supervisor nem departamento
insert into funcionario values 
('12345678901', 'João', 'Silva', 'joao@tads.ifrn', 'Natal-RN', 9990, '2000-01-01', 'M', null, 1), 
('12345678902', 'Joana', 'Silva', 'joana@tads.ifrn', 'Parnamirim-RN', 8990, '2000-01-01', 'F', null, 2), 
('12345678903', 'José', 'Silva', 'jose@tads.ifrn', 'Macaíba-RN', 7990, '2000-01-01', 'M', null, 3);

insert into funcionario values
('12345678904', 'Ronielson', 'Silva', 'ronielson@tads.ifrn', 'Macaíba-RN', 6990, '2000-01-01', 'M', null, 3);

insert into funcionario values
('12345678905', 'Judson', 'Silva', 'judson@tads.ifrn', 'Teresina-PI', 10990, '2000-01-01', 'M', null, 3);

insert into funcionario(cpf, pnome, unome, email, salario, data_nasc, sexo) values
('12345678999', 'Jobson', 'Soares', 'jobson@tads.ifrn', 6990, '2003-03-03', 'M');

insert into departamento values
(1, 'TI', '11111111111', current_date), -- current_date pega a data atual
(2, 'Financeiro', '22222222222', current_date - interval '3 days'),
(3, 'RH', '33333333333', current_date - interval '5 days');

/*
-- Atualizar elementos
update funcionario set sexo='F' where cpf='12345678902' -- atualiza por filtragem
returning cpf, pnome, unome, sexo; -- retorna no terminal os dados que você inserir depois do 'returning'

-- Remover elementos
delete from funcionario where cpf='12345678999';
*/

update funcionario set cpf_supervisor='12345678901' where cpf <> '12345678901'; 