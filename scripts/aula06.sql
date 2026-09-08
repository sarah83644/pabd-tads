/* Índices - 08/09 */

-- Índices: estruturas auxiliares que oferecem caminhos alternativos de acesso aos registros, geralmente baseados em árvores ou hash (Árvore B, que faz com que a busca seja log n)
-- índice comum: CREATE INDEX
    -- Objetivo: acelerar buscas em colunas específicas
    -- Permite valores duplicados em várias linhas
-- Em tabelas pequenas, a busca continua sendo sequencial, mesmo que haja um índice
-- Em tabelas grandes, é mais vantajoso usar um índice
-- índice único: CREATE UNIQUE INDEX
    -- Objetivo: acelerar buscas e impor a regra de unicidade

-- Exibe esquema, índice e definição
select schemaname, indexname, indexdef from pg_indexes where tablename = 'address' order by tablename, indexname;
select address_id, address, district, phone from address where phone = '223664661973';
explain analyze select address_id, address, district, phone from address where phone = '223664661973'; -- rodar explain analyze duas vezes

drop index if exists idx_address_phone;

create index idx_address_phone on address(phone);