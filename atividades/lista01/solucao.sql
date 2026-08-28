/* Lista de exercícios 01 - Sistema de E-commerce */

-- 1. Liste os produtos com preço superior a R$ 1000.
select p.name produto from products p where p.price > 1000;

-- 2. Liste os produtos ordenados pelo preço, do maior para o menor
select p.name produto, p.price preco from products p order by p.price desc;

-- 3. Aumente o preço de todos os produtos da Dell em 10%
update products set price = (price*0.10) + price where name ilike '%dell%';

-- 4. Exclua todos os produtos que sejam do tipo Macbook.
delete from products where name ilike '%macbook%';

-- 5. Exclua um produto que não possua pedidos associados.
-- Busquei produtos que não possuiam pedidos associados e o resultado foi zero, pois não existia nenhum que já não estivesse associado a um pedido
select p.id from products p where not exists (select * from orders_products op where op.product_id = p.id);
-- Inseri um novo produto apenas para fazer a questão
insert into products (name, price, stock) values ('Tablet Samsung Galaxy Tab S10', 3999.00, 15);
-- Resposta final da questão
delete from products p where not exists (select * from orders_products op where op.product_id = p.id);

-- 6. Liste todos os pedidos realizados nos últimos 30 dias.

-- 7. Liste os pedidos e os respectivos nomes de usuário.
select od.id as "ID do pedido", od.status as "Status do pedido", u.name as "Usuário correspondente" from orders od join users u on u.id = od.user_id; 