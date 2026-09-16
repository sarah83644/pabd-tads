/* Índices - 08/09 */

-- Índices: estruturas auxiliares que oferecem caminhos alternativos de acesso aos registros, geralmente baseados em árvores ou hash (Árvore B, que faz com que a busca seja log n)
-- índice comum: CREATE INDEX
    -- Objetivo: acelerar buscas em colunas específicas
    -- Permite valores duplicados em várias linhas
-- Em tabelas pequenas, a busca continua sendo sequencial, mesmo que haja um índice
-- Em tabelas grandes, é mais vantajoso usar um índice
-- índice único: CREATE UNIQUE INDEX
    -- Objetivo: acelerar buscas e impor a regra de unicidade

-- Exibe esquema, índice e definição (ver os índices da tabela)
select schemaname, indexname, indexdef from pg_indexes where tablename = 'address' order by tablename, indexname;
select address_id, address, district, phone from address where phone = '223664661973';
explain analyze select address_id, address, district, phone from address where phone = '223664661973'; -- rodar explain analyze duas vezes

drop index if exists idx_address_phone;
create index idx_address_phone on address(phone);

select customer_id, first_name, last_name from customer where last_name = 'Purdy';
explain analyze select customer_id, first_name, last_name from customer where last_name = 'Purdy';
/*  Index Scan using idx_last_name on customer  (cost=0.28..8.29 rows=1 width=17) (actual time=0.029..0.031 rows=1 loops=1)
        Index Cond: ((last_name)::text = 'Purdy'::text)
        Planning Time: 0.125 ms
        Execution Time: 0.050 ms
        (4 rows) 
*/
/*   Seq Scan on customer  (cost=0.00..16.49 rows=1 width=17) (actual time=1.690..2.547 rows=1 loops=1)
        Filter: ((last_name)::text = 'Purdy'::text)
        Rows Removed by Filter: 598
        Planning Time: 0.129 ms
        Execution Time: 2.561 ms
        (5 rows)
*/
select customer_id, first_name, last_name from customer where lower(last_name) = 'purdy';
explain analyze select customer_id, first_name, last_name from customer where lower(last_name) = 'purdy';
drop index if exists idx_customer_last_name;
create index idx_customer_last_name_lower on customer(lower(last_name));
/* Bitmap Heap Scan on customer  (cost=4.30..11.15 rows=3 width=17) (actual time=0.025..0.026 rows=1 loops=1)
   Recheck Cond: (lower((last_name)::text) = 'purdy'::text)
   Heap Blocks: exact=1
   ->  Bitmap Index Scan on idx_customer_last_name_lower  (cost=0.00..4.30 rows=3 width=0) (actual time=0.017..0.017 rows=1 loops=1)
         Index Cond: (lower((last_name)::text) = 'purdy'::text)
 Planning Time: 0.091 ms
 Execution Time: 0.045 ms
(7 rows) 
*/

-- Índices parciais
-- visualizar clientes inativos (sem busca por índice)
select customer_id, first_name from customer where active = 0; -- where active = 0: predicado
-- criando índice para busca otimizada
drop index if exists idx_customer_active;
create index idx_customer_active on customer(active) where active = 0;

-- Índices multicolunas
where column1 = v1 and column2 = v2 and column3 = v3;
where column1 = v1 and column2 = v2;
where column1 = v1;

-- scripts/script_index_fts.sql
select id, first_name, last_name from people where last_name = 'Adams';
drop index if exists idx_people_names;
create index idx_people_names on people(last_name, first_name);

select id, first_name, last_name from people where last_name = 'Adams' and first_name = 'Lou';

-- índice Hash
-- Só suporta igualdade
drop index if exists idx_customer_email_hash;
create index idx_customer_email_hash on customer using hash (email);

select first_name from customer where email = 'ab@tads.ifrn';
/*  Index Scan using idx_customer_email_hash on customer  (cost=0.00..8.02 rows=1 width=6) (actual time=0.013..0.013 rows=0 loops=1)
   Index Cond: ((email)::text = 'ab@tads.ifrn'::text)
 Planning Time: 0.074 ms
 Execution Time: 0.025 ms */

-- índice GIN
select 
     to_tsvector('watches'),
     to_tsvector('watched'),
     to_tsvector('watching');

select to_tsvector('The quick brown fox jumps over the lazy dog');
-- retorna as posições das palavras
/*                       to_tsvector                      
-------------------------------------------------------
 'brown':3 'dog':9 'fox':4 'jump':5 'lazi':8 'quick':2  */

select id, to_tsvector('portuguese', body) body_search from posts;
/*  id |                                                                        body_search                                                                        
----+-----------------------------------------------------------------------------------------------------------------------------------------------------------
  1 | 'abert':8 'chav':12 'codig':7 'complex':16 'consult':15 'estrangeir':13 'postgresql':1 'relacional':5 'sgbd':4 'suport':10 'transaco':11
  2 | 'avanc':16 'customiz':13 'extenso':11 'full':8 'full-text':7 'indexaca':15 'jsonb':6 'oferec':3 'postgresql':2 'search':10 'suport':4 'text':9 'tip':12
  3 | 'banc':15,16,18 'busc':12 'configuraca':8 'lexem':13 'portugues':9 'possivel':11 'to':2,5 'tsquery':6 'tsvector':3
  4 | 'armazen':3 'busc':15 'chav':17 'document':4 'faz':14 'gin':10 'index':6 'json':5 'jsonb':1,12 'permit':2 'pod':8 'usar':9 'valor':19 'voc':7
  5 | 'comec':3 'consistenc':13 'joins':14 'migr':7 'muit':1 'nosql':5 'postgresql':9 'precis':11 'projet':2 'transaco':16
  6 | 'aceler':10 'ajud':8 'analyz':14 'b':3 'b-tre':2 'consult':11 'entend':16 'execuca':20 'explain':13 'gin':5 'gist':7 'indic':1 'plan':18 'tre':4 'use':12
  7 | 'backup':10,13 'dump':4 'faz':9 'ferrament':1 'fisic':14 'logic':11 'permit':8 'pg':3,6 'replicaca':18 'restor':7 'use':15 'wal':16
  8 | 'conexo':14 'criptograf':10 'grants':4 'import':12 'level':7 'oferec':2 'postgresql':1 'proteg':13 'rol':3 'row':6 'row-level':5 'security':8 'ssl':16
  9 | 'adicion':2 'consult':11 'espac':7 'funco':6 'geograf':4 'geolocaliz':12 'permit':10 'postg':1 'postgresql':9 'tip':3
 10 | 'banc':6 'comun':12 'escolh':8 'estabil':11 'frequent':7 'outr':5 'postgresql':9 'projet':1 'recurs':14 'saem':3 */

select id, to_tsvector('portuguese', title || ' ' || body) search from posts;

drop index if exists idx_posts_search_gin;
create index idx_posts_search_gin on posts using gin(to_tsvector('portuguese', title || ' ' || body));

select id, title, body from posts where to_tsvector('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', 'postgresql & recursos');

    -- 1) Busca título e corpo que contenham as palavras 'postgresql' E 'recursos'
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', 'postgresql & recursos');

    -- 2) Busca título e corpo que contenham as palavras 'eficiente' OU 'recursos'
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', 'eficiente | recursos');

    -- 3) Busca título e corpo que contenha a frase "full-text search"
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', '''full-text search''');

    -- 4) Busca título e corpo que NÃO contenha a palavra 'eficiente'
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', '!eficiente');

    -- 5) Busca título e corpo por prefixo 'con'
    -- to_tsvector ('portuguese', title || ' ' || body) @@ to_tsquery('portuguese', 'con:*');

-- para tabelas muito grandes
/* CREATE TABLE
    posts (
        id serial PRIMARY KEY,
        title text NOT NULL,
        body text NOT NULL,
        search_vector tsvector GENERATED ALWAYS AS (
            setweight(to_tsvector('portuguese', title), 'A') ||
            setweight(to_tsvector('portuguese', body), 'B')) stored,
        created_at timestamptz NOT NULL DEFAULT now ()
    ); */

select
    id,
    title,
    body,
    ts_rank(
        -- não preciso passar o setweight aqui pois ele já foi criado no ato da criação da tabela. basta passar o search_vector que foi criado na tabela
        search_vector,
        to_tsquery('portuguese', 'postgresql')
    ) rank
from posts
where search_vector @@ to_tsquery('portuguese', 'postgresql')    
order by rank desc;

drop index if exists idx_search_vector_gin;
create index idx_search_vector_gin on posts using gin (search_vector);

/*  Sort  (cost=12.58..12.58 rows=1 width=72) (actual time=0.023..0.024 rows=0 loops=1)
   Sort Key: (ts_rank(search_vector, '''postgresql'''::tsquery)) DESC
   Sort Method: quicksort  Memory: 25kB
   ->  Bitmap Heap Scan on posts  (cost=8.55..12.57 rows=1 width=72) (actual time=0.018..0.019 rows=0 loops=1)
         Recheck Cond: (search_vector @@ '''postgresql'''::tsquery)
         ->  Bitmap Index Scan on idx_search_vector_gin  (cost=0.00..8.55 rows=1 width=0) (actual time=0.006..0.007 rows=0 loops=1)
               Index Cond: (search_vector @@ '''postgresql'''::tsquery)
 Planning Time: 0.166 ms
 Execution Time: 0.066 ms */