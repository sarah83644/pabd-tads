# LISTA DE EXERCÍCIOS 1 — Sistema de E-commerce

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
4.	Exclua todos os produtos que sejam do tipo `Macbook`.
5.	Exclua um produto que não possua pedidos associados.
6.	Liste todos os pedidos realizados nos últimos 30 dias.
7.	Liste os pedidos e os respectivos nomes de usuário.
8.	Liste todos os usuários e seus pedidos, inclusive usuários sem pedidos.
9.	Liste todos os usuários (id, nome e email) que realizaram pelo menos um pedido.
10.	Liste produtos que nunca foram vendidos.
11.	Liste usuários que nunca realizaram pedidos.
12.	Liste os produtos com preço acima da média em ordem decrescente.
13.	Liste a quantidade de pedidos realizados por cada usuário.
14.	Listar os três produtos mais vendidos.
15.	Gerar um relatório com: usuários, quantidade de pedidos e valor total comprado.