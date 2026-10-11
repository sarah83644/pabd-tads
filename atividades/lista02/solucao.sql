/* Lista de exercícios 02 */

-- Questão 01 - View de Performance da Equipe
drop view if exists v_staff_perfomance;
create view v_staff_perfomance as
select 
    s.staff_id funcionario_id, 
    s.first_name || ' ' || s.last_name nome_completo, 
    c.city cidade, 
    co.country pais,
    r.qtd_vendas_registradas,
    p.valor_total
    from staff s
    left join (select staff_id, count(rental_id) qtd_vendas_registradas from rental group by staff_id) r on r.staff_id = s.staff_id
    left join (select staff_id, sum(amount) valor_total from payment group by staff_id) p on p.staff_id = s.staff_id
    join address a on s.address_id = a.address_id
    join city c on c.city_id = a.city_id
    join country co on c.country_id = co.country_id
    group by s.staff_id, s.first_name, s.last_name, c.city, co.country, r.qtd_vendas_registradas, p.valor_total;

select * from v_staff_perfomance;


-- Questão 02 - View Materializada de Receita por Categoria
drop materialized view if exists mv_category_total_sales;
create materialized view mv_category_total_sales as
select cat.name, sum(p.receita) from film_category fc 
    join category cat on cat.category_id = fc.category_id
    join inventory i on fc.film_id = i.film_id
    join rental r on r.inventory_id = i.inventory_id
    join (select rental_id, sum(amount) receita from payment group by rental_id) p on p.rental_id = r.rental_id
    group by cat.name;

create unique index idx_mv_category_total_sales on mv_category_total_sales(name);

select * from mv_category_total_sales;

-- Questão 03 - Otimizando Filmes Atrasados
create index idx_check_open_rentals on rental(return_date) where return_date is null;

-- Questão 04 - Busca Inteligente de Sinopses

-- Questão 05 - Histórico do Cliente
create index idx_check_history on payment(customer_id, payment_date);

-- Questão 06 - Login Case-Insensitive
create index idx_login_case_sensitive on customer(lower(email));
select first_name || '' || last_name nome, email from customer where lower(email) = lower('MARY.SMITH@SAKILACUSTOMER.ORG');

-- Questão 07 - Validação de Datas
create or replace function check_return_date()
    returns trigger
    language plpgsql as 
    $$
    begin
        if NEW.return_date is not null and NEW.return_date < NEW.rental_date then
            raise exception 'data de retorno menor que a data da locação não existe, está errado. valor:%', NEW.return_date;
        end if;
        return NEW;
    end;
    $$;

drop trigger if exists trg_check_return_date on rental;
create trigger trg_check_return_date before insert or update on rental
for each row execute function check_return_date();

-- Questão 08 - Auditoria de Preços
create table film_cost_audit (
    film_id smallint primary key,
    old_cost numeric (7, 2),
    new_cost numeric (7, 2),
    change_at timestamptz default now()
);

create or replace function check_change_replacement_cost()
    returns trigger
    language plpgsql as 
    $$
    begin
        if NEW.replacement_cost != OLD.replacement_cost then 
            insert into film_cost_audit (film_id, old_cost, new_cost)
            values (OLD.film_id, OLD.replacement_cost, NEW.replacement_cost);
        end if;

        return NEW;
    end;
    $$;

drop trigger if exists trg_check_change_replacement_cost on film;
create trigger trg_check_change_replacement_cost 
after update on film
for each row
when (NEW.replacement_cost != OLD.replacement_cost)
execute function check_change_replacement_cost();

update film set replacement_cost = '676.67' where film_id = 3; -- teste

-- Questão 09 - Proteção de Catálogo
create or replace function check_movie_language()
    returns trigger
    language plpgsql as
    $$
    begin
        if exists (select 1 from film where language_id = OLD.language_id) then
            raise exception 'Não é possível excluir essa linguagem porque ela está vinculado à 1 ou mais filmes';
        end if;
    end;
    $$;

drop trigger if exists trg_check_movie_language on language;
create trigger trg_check_movie_language
before delete on language
for each row 
execute function check_movie_language();

delete from language where language_id = 1;

-- Questão 10 - Sincronização de Estatísticas
create table customer_rental_stats (
    customer_id smallint primary key,
    total_rentals int default 0
);

insert into customer_rental_stats (customer_id, total_rentals)
select c.customer_id, count(r.rental_id) from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id;

create or replace function change_quantity_rentals()
    returns trigger
    language plpgsql as 
    $$ 
    declare contagem_locacoes int; rental_stats int;
    begin
        select count(r.rental_id) into contagem_locacoes from customer c
        left join rental r on c.customer_id = r.customer_id;
        select crs.total_rentals into rental_stats from customer_rental_stats crs;

        if rental_stats < contagem_locacoes then
            rental_stats = rental_stats + 1;
            update customer_rental_stats set total_rentals = rental_stats;
        end if;
        return NEW;
    end;
    $$;

drop trigger if exists trg_change_quantity_rentals on rental;
create trigger trg_change_quantity_rentals 
after insert on rental
for each row
execute function change_quantity_rentals();

insert into rental (rental_date, inventory_id, customer_id, staff_id, return_date)
values (now(), 1, 1, 1, null);

select * from customer_rental_stats where customer_id = 1;