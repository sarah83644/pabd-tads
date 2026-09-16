/* JSON Search */
-- json: armazena o texto json exatamente como foi digitado, preservando espaço em branco, ordem de chaves e chaves duplicadas. Menos eficiente
-- jsonb: armazena os dados json em um formato binário decomposto. Mais eficiente em consultas e manipulação
    -- Operadores de extração: retornam um subconjunto do documento, mas não filtram linhas por si só. São usados em combinação com os operadores relacionais em uma condição de WHERE
    -- Operadores de contenção e existência: expressam diretamente uma condição booleana sobre a estrutura do documento e são operadores otimizáveis para índice GIN

-- operador -> extrai os dados de um determinado campo como json/jsonb
select id, data -> 'position' position from testes_json.employee_json;
/*  id |   posicao   
----+-------------
  1 | "Developer"
  2 | "Developer"
  3 | "Analyst"
  4 | "Manager"
  5 | "Developer" */

-- operador ->> extrai os dados de um determinado campo como texto
select id, data ->> 'position' position from testes_json.employee_json;
/*  id | position  
----+-----------
  1 | Developer
  2 | Developer
  3 | Analyst
  4 | Manager
  5 | Developer */

-- retorna quem são os desenvolvedores pela chave position = Developer. operador de extração dentro do WHERE
select id, data ->> 'first_name' dev from testes_json.employee_json where data ->> 'position' = 'Developer';

-- fazendo cast
-- ::tipoDeDado é o cast do postgresql
select id, data ->> 'first_name' nome, data ->> 'salary' salario from testes_json.employee_json where (data ->> 'salary')::numeric > 5000; 

-- operador de extração de aninhamento
-- operador #> extrai em jsonb
select id, data #> '{address, country}' pais from testes_json.employee_json;
-- operador #>> extrai em texto
select id, data ->> 'first_name' nome, data #>> '{address, country}' pais from testes_json.employee_json;
-- filtra pelo país = Brasil
select id, data ->> 'first_name' nome, data #>> '{address, country}' pais from testes_json.employee_json where data #>> '{address, country}' = 'Brasil';

-- operador @> verifica se o json contém algo. vai dentro do WHERE
-- where data @> '{"first_name": "Gael"}': comando quando o operador for de contenção
-- já converte para texto
select id, data ->> 'first_name' nome from testes_json.employee_json where data @> '{"first_name": "Gael"}';