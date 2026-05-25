USE mydb;

-- DESAFIO 
SELECT
    f.id AS funcionario_id,
    f.salario,
    c.nome AS cargo,
    e.titulo AS equipe
FROM funcionario f
INNER JOIN cargo c ON f.id_cargo = c.id
INNER JOIN equipe e ON f.id_equipe = e.id
ORDER BY f.salario DESC
LIMIT 5;

SELECT
    c.nome AS cargo,
    AVG(f.salario) AS media_salarial
FROM funcionario f
INNER JOIN cargo c ON f.id_cargo = c.id
GROUP BY c.nome
ORDER BY media_salarial DESC;

SELECT
    e.id,
    e.titulo AS equipe
FROM equipe e
LEFT JOIN funcionario f ON f.id_equipe = e.id
WHERE f.id IS NULL;

SELECT
    f.id AS funcionario_id,
    f.salario
FROM funcionario f
LEFT JOIN equipe e ON f.id_equipe = e.id
WHERE e.id IS NULL;

SELECT
    e.titulo AS equipe,
    COUNT(f.id) AS total_funcionarios,
    SUM(f.salario) AS total_salarios,
    AVG(f.salario) AS media_salarial
FROM equipe e
INNER JOIN funcionario f ON f.id_equipe = e.id
GROUP BY e.titulo
ORDER BY total_salarios DESC;

SELECT
    UPPER(c.nome) AS nome_cargo_maiusculo,
    CHAR_LENGTH(c.nome) AS tamanho_nome_cargo
FROM cargo c
WHERE CHAR_LENGTH(c.nome) > 3;

SELECT
    f.id AS funcionario_id,
    f.salario AS salario_atual,
    f.salario * 1.10 AS salario_com_reajuste_10pct
FROM funcionario f
WHERE f.salario >= 5000 AND f.salario <= 12000
ORDER BY f.salario DESC;

-- PRÁTICA

SELECT
    e.titulo AS equipe,
    COUNT(f.id) AS qtd_funcionarios,
    ROUND(AVG(f.salario), 2) AS media_salarial,
    MAX(f.salario) AS maior_salario,
    MIN(f.salario) AS menor_salario
FROM equipe e
INNER JOIN funcionario f ON f.id_equipe = e.id
GROUP BY e.titulo
HAVING AVG(f.salario) > (SELECT AVG(salario) FROM funcionario)
ORDER BY media_salarial DESC;

CREATE OR REPLACE VIEW vw_clientes_formatado AS
SELECT
    UPPER(c.nome) AS nome_cliente,
    ci.nome AS cidade,
    es.uf AS estado,
    CONCAT(en.logradouro, ', ', en.numero, ' - ', en.bairro, ', ', ci.nome, ' - ', es.uf, ', CEP: ', en.cep) AS endereco_completo
FROM cliente c
INNER JOIN endereco en ON c.id_endereco = en.id
INNER JOIN cidade ci ON en.id_cidade = ci.id
INNER JOIN estado es ON ci.id_estado = es.id;

SELECT * FROM vw_clientes_formatado;

SELECT
    c.nome AS nome_cliente,
    REVERSE(c.nome) AS nome_invertido,
    CHAR_LENGTH(c.nome) AS tamanho_nome
FROM cliente c
ORDER BY tamanho_nome DESC;

CREATE OR REPLACE VIEW vw_total_funcionarios_cargo AS
SELECT
    ca.nome AS cargo,
    COUNT(f.id) AS qtd_funcionarios,
    ROUND(AVG(f.salario), 2) AS media_salarial
FROM cargo ca
INNER JOIN funcionario f ON f.id_cargo = ca.id
GROUP BY ca.nome;

SELECT * FROM vw_total_funcionarios_cargo;
