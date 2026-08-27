/* Lista de exercícios 01 - Sistema de E-commerce */

-- 1. Liste os produtos com preço superior a R$ 1000.
select p.name produto from products p where p.price > 1000;

-- 2. Liste os produtos ordenados pelo preço, do maior para o menor
select p.name produto, p.price preco from products p order by p.price desc;