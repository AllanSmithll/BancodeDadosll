-- Tarefa 10 - Exercícios Pgplsql - 18/05/2023
-- Questão 1
select 123.456::decimal;
select 123::smallint;
Select coalesce(null,'Nada');

-- Questão 2
select * from empregado;
select matricula, salario from empregado order by salario;
insert into Empregado values (14,'João', 'Guedes',current_date,'Analista de Sistemas Junior',940.00,null,1);
insert into Empregado values (15,'Jose', 'Batista',current_date,'Analista de Sistemas Pleno',1200.00,1,1);
 
Do $$
Declare
  cursor_emp cursor for select salario from empregado;
  total_emp_recebe_menos integer default 0;
  total_emp integer default 0;
  percentual decimal;
Begin
  select count(*) into total_emp from empregado;
  for i in cursor_emp loop
  	If i.salario < 1350.00
  	 	then total_emp_recebe_menos = total_emp_recebe_menos + 1;
  	  end if;
  end loop;
  raise notice 'Empregados que recebem menos que o salário: %',total_emp_recebe_menos;
  raise notice 'Total de Empregados: %',total_emp;
  percentual = round((total_emp_recebe_menos::decimal /total_emp::decimal) *100);
  raise notice 'Percentual de empregados que recebem menos que o salário: % %%',percentual;
 end; $$;

-- b)
create or replace procedure empRecebeMenosSalario()
language plpgsql as $$
Declare
  cursor_emp cursor for select salario from empregado;
  total_emp_recebe_menos integer default 0;
  total_emp integer default 0;
  percentual decimal;
Begin
  select count(*) into total_emp from empregado;
  for i in cursor_emp loop
  	If i.salario < 1350.00
  	 	then total_emp_recebe_menos = total_emp_recebe_menos + 1;
  	  end if;
  end loop;
  raise notice 'Empregados que recebem menos que o salário: %',total_emp_recebe_menos;
  raise notice 'Total de Empregados: %',total_emp;
  percentual = round((total_emp_recebe_menos::decimal /total_emp::decimal) *100);
  raise notice 'Percentual de empregados que recebem menos que o salário: % %%',percentual;
 end$$;
 
 call empRecebeMenosSalario();
 
 -- Questão 3
 alter table empregado disable trigger all;
 
 -- Questão 4
 CREATE OR REPLACE function testa_salario() returns trigger
as $$
Begin
	If new.salario > 20000 then
    	raise exception 'salario alto';
	end if;
	return new;
	exception
   	when raise_exception then
       	Raise notice 'Tentativa de aumento exagerada!!! %', new.salario;
       	return null;
 end;
$$ LANGUAGE plpgsql; 
 
create trigger verSalario
 	BEFORE INSERT OR UPDATE OF salario ON empregado
 FOR EACH ROW
 Execute procedure testa_salario();

insert into empregado(matricula,primeironome,salario,gerente,coddepto)  values (16,'Poliana16',7000,2,2);
insert into empregado(matricula,primeironome,salario,gerente,coddepto)  values (17,'Poliana17',27000,2,2);

select * from empregado where primeironome like 'Poliana%';

-- Questão 5.1
CREATE TABLE testeINC (
 	 ID           integer	NOT NULL,
      Descricao  VARCHAR(50)  NOT NULL);
ALTER TABLE testeINC ADD CONSTRAINT testepk PRIMARY KEY (ID);

-- a)
create or replace function autoIncrementar()
returns trigger as $$
declare
    novo_id testeINC.id%type;
begin
    select coalesce(max(id),0)+1 into novo_id 
    from testeINC;
    new.id = novo_id;
    return new;
end; $$ language plpgsql;

create or replace trigger triggerAutoIncremento
before insert on testeINC
for each row execute procedure autoIncrementar();
-- testes
insert into testeINC(descricao) values('X');
insert into testeINC(descricao) values('Y');
insert into testeINC(descricao) values('Z');

select * from testeINC;

-- 5.2
alter table empregado add column datanasc date;
select * from empregado;

-- Atualizar datas aleatórias dos epregados, para que tenham mais de 21 anos
UPDATE empregado
SET data_nascimento = CURRENT_DATE - INTERVAL '1 years' * random() * 50
WHERE date_part('year', age(data_nascimento)) < 21;

select primeironome, datanasc
from empregado;

-- Questão 6
create or replace function calculaIdade()
returns trigger as $$
declare 
	idade int;
	c_empregados cursor for
		select * from empregado;
begin
	for empregados in c_empregados loop
		select abs(extract(year from age(new.datanasc))) into idade;
		if idade < 21 then
			raise exception 'Muito jovem para o cargo!';
		end if;
	end loop;
	return new;
end $$ language 'plpgsql';

create or replace trigger calculaIdadeTrigger
before insert or update on empregado for each row
execute function calculaIdade();

update empregado
set datanasc = '20-10-2020'
where primeironome = 'Ricardo';

-- Questão 7
create or replace function showEmpregado()
returns void as $$
declare
    nome_empregado empregado.primeironome%type;
begin
    for nome_empregado in select primeironome from empregado LOOP
        raise notice 'Nome do empregado: %', nome_empregado;
    end loop;
end;
$$ language plpgsql;

select showEmpregado();