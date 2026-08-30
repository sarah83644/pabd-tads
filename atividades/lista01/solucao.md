# Lista de exercícios 01 — Sistema de E-commerce

## Visão geral

Este documento descreve o modelo relacional de um sistema de e-commerce composto pelas relações:

- `users`: usuários ou clientes cadastrados.
- `products`: produtos disponíveis para venda.
- `orders`: pedidos realizados pelos usuários.
- `orders_products`: itens que compõem cada pedido.

O relacionamento entre as tabelas é representado por chaves primárias e estrangeiras:

```text
users 1 ───────── N orders
orders 1 ──────── N orders_products
products 1 ────── N orders_products
```

## Prática DML/DQL

1.	Liste os produtos com preço superior a R$ 1000.
```sql
select p.name produto from products p where p.price > 1000;
```
2.	Liste os produtos ordenados pelo preço, do maior para o menor.
```sql
select p.name produto, p.price preco from products p order by p.price desc;
```
3.	Aumente o preço de todos os produtos da `Dell` em 10%.
```sql
update products set price = (price*0.10) + price where name ilike '%dell%';
```
4.	Exclua todos os produtos que sejam do tipo `Macbook`.
```sql
delete from products where name ilike '%macbook%';
```
5.	Exclua um produto que não possua pedidos associados.
```sql
/* Explicação do processo de resolução dessa questão */

-- Busquei produtos que não possuiam pedidos associados e o resultado foi zero, pois não existia nenhum que já não estivesse associado a um pedido
select p.id from products p where not exists (select * from orders_products op where op.product_id = p.id);
-- Inseri um novo produto apenas para fazer a questão
insert into products (name, price, stock) values ('Tablet Samsung Galaxy Tab S10', 3999.00, 15);
-- Resposta final da questão
delete from products p where not exists (select * from orders_products op where op.product_id = p.id);
```
6.	Liste todos os pedidos realizados nos últimos 30 dias.
7.	Liste os pedidos e os respectivos nomes de usuário.
```sql
select od.id as "ID do pedido", od.status as "Status do pedido", u.name as "Usuário correspondente" from orders od join users u on u.id = od.user_id; 
```
8.	Liste todos os usuários e seus pedidos, inclusive usuários sem pedidos.
```sql
select u.name usuario, od.id id_pedido, od.status status_pedido from users u left join orders od on od.user_id = u.id;
```
9.	Liste todos os usuários (id, nome e email) que realizaram pelo menos um pedido.
```sql
select distinct u.id, u.name nome_usuario, u.email from users u join orders od on u.id = od.user_id order by u.id;
```
10.	Liste produtos que nunca foram vendidos.
```sql
/* Explicação do processo de resolução dessa questão */

-- Inseri um produto novo, pois todos os produtos atuais estavam associados à uma venda
insert into products (name, price, stock) values ('Tablet Samsung Galaxy Tab S10', 3999.00, 15);
-- Realizei a consulta
select p.name from products p where not exists (select op.product_id from orders_products op where op.product_id = p.id);
```
11.	Liste usuários que nunca realizaram pedidos.
```sql
select u.name from users u where not exists (select o.user_id from orders o where o.user_id = u.id);
```
12.	Liste os produtos com preço acima da média em ordem decrescente.
```sql
select p.name produto, p.price preco from products p where p.price > (select avg(p.price) from products p) order by p.price desc;
```
13.	Liste a quantidade de pedidos realizados por cada usuário.
```sql
select u.name nome, count(*) qtd_pedidos from orders o join users u on u.id = o.user_id group by o.user_id, u.name order by o.user_id;
```
14.	Listar os três produtos mais vendidos.
15.	Gerar um relatório com: usuários, quantidade de pedidos e valor total comprado.
```sql
select u.name nome, count(*) qtd_pedidos, sum(o.total) total from orders o join users u on u.id = o.user_id group by o.user_id, u.name;
```