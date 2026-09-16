select 
    (select count(*) from orders as total_orders),
    (select count(*) from orders_products as total_orders_products),
    (select count(*) from products as total_products),
    (select count(*) from users as total_users);

-- tive que desativar a busca sequencial para forçar o postgres a usar o índice, porque as tabelas tem poucos elementos
set enable_seqscan = off;

-- para eu conferir se os índices que eu estou criando estão realmente sendo criados (para funcionar, estou sempre seguindo o padrão de prefixo 'idx')
select schemaname, indexname, indexdef from pg_indexes where indexname like '%idx%';

-- índice para a tabela 'orders'
drop index if exists idx_orders;
create index idx_orders on orders(total);
select user_id, total from orders where total >= 1000;
/*  Index Scan using idx_orders on orders  (cost=0.14..8.19 rows=3 width=20) (actual time=0.017..0.019 rows=4 loops=1)
   Index Cond: (total >= '1000'::numeric)
 Planning Time: 0.096 ms
 Execution Time: 0.031 ms */

-- índice para a tabela 'orders_products'
drop index if exists idx_orders_products_unit_price;
create index idx_orders_products_unit_price on orders_products(unit_price);
select product_id, unit_price from orders_products where unit_price >= 900;
/*  Index Scan using idx_orders_products_unit_price on orders_products  (cost=0.14..8.21 rows=4 width=20) (actual time=0.018..0.020 rows=4 loops=1)
   Index Cond: (unit_price >= '900'::numeric)
 Planning Time: 0.076 ms
 Execution Time: 0.031 ms */

-- índice para a tabela 'products'
drop index if exists idx_products_stock;
create index idx_products_stock on products(stock);
select name, price, stock from products where stock >= 30;
/*  Index Scan using idx_products_stock on products  (cost=0.14..8.19 rows=3 width=52) (actual time=0.082..0.084 rows=3 loops=1)
   Index Cond: (stock >= 30)
 Planning Time: 0.069 ms
 Execution Time: 0.098 ms */

-- índice para a tabela 'users'
drop index if exists idx_users_name;
create index idx_users_name on users(name);
select name, email from users where name = 'Felipe Silva';
/*  Index Scan using idx_users_name on users  (cost=0.13..8.15 rows=1 width=64) (actual time=0.024..0.026 rows=1 loops=1)
   Index Cond: (name = 'Felipe Silva'::text)
 Planning Time: 0.091 ms
 Execution Time: 0.042 ms */