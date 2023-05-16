-- Aula sobre Funções do Postgres - 10/04/2023
-- 1.Funções
-- 1.1 Principais funções para números
select abs(-15) "Absoluto";
Select ABS(-15);
Select CEIL(15.7); -- Maior inteiro
Select FLOOR(15.7); -- Menor inteiro
Select MOD(10,4);
Select power(3,2);
Select ROUND(15.193,1) “Round”;
Select round(42.4382, 2);
Select trunc(42.8);
Select trunc(42.4382, 2);

-- 1.2 Principais funções para caracteres
-- CONCAT() OU ||
Select CONCAT(CONCAT(primeironome,' é
'),cargo)
From empregado
Where matricula = 1;

Select primeironome || ' é '||cargo
From empregado
Where matricula = 1;
-- initcap()
Select INITCAP('si');
-- Lower()
Select LOWER('SI') Minúsculas;
-- Replace() - pega a, tira b e concatena c COM a
Select REPLACE('Juliana','Juli','00000');
-- Substr()
Select SUBSTR('Juliana',0,4);
-- Upper()
Select UPPER('Informática');
-- length()
Select LENGTH('Informatica');
-- lpad() - left
Select LPAD('1234',10,'0');
-- rpad() - right
Select RPAD('1234',10,'0');

-- 1.3 Funções de Conversão
-- To_Char(date)
Select
to_char(current_date,'MONTH,DD,YYYY,HH2
4:MI:SS');
Select to_char(current_timestamp,
'HH12:MI:SS');
-- To_Char(integer)
Select to_char(10000,'L99G999D99') "Valor";
-- To_date
Select To_date('12-01-2016','MM/DD/YYYY');
-- To_number
SELECT to_number('12.730', '99999.99');
--To_timestamp(text, text)
Select to_timestamp('05 Dec 2017',
'DD Mon YYYY');

-- 1.4 Principais funções para datas
-- Current_date
Select TO_CHAR(Current_date,'MM-DD-
YYYY') "Hoje";
select current_date;
-- Age(timestamp,timestamp)
Select age(current_date, timestamp
'2004-11-04');
Select age(timestamp '2016-04-10', timestamp
'1999-06-13');

Select age(timestamp '1999-06-13');
-- Current_time
Select current_time;
-- Now
Select now();
-- Extract
select primeironome,
extract(year from dataadmissao) Ano from
empregado;

-- 1.5 Algumas Funções Genéricas
-- Coalesce(exp1,exp2,exp3)
Select coalesce(null,'Nao preenchido','Nada');
-- Case
Select primeironome, salario,
case when salario < 1000 then 'Baixa'
when salario > 1000 and salario < 2000
then 'Média'
when salario > 2000 then 'Boa'
end faixa
From empregado;

select descricao as "Descrição", valor as
"Valor atual",
case
when valor < 10 then
valor * 0.3
when valor >=10 and valor < 13 then
valor * .2
else
valor * .1
end as "Percentual"
from produto;
-- Greatest
SELECT GREATEST (2, 4, 3, 6) "Greatest";
-- Least
SELECT LEAST(2,4,3,6) "LEAST";