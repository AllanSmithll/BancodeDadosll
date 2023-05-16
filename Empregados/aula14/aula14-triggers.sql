-- Aula 14 - Triggers

select * from empregado; 
select * from departamento; 
-- delete from departamento where coddepto > 3; 

-- Exemplo 1

CREATE TABLE empaudit (matemp integer NOT NULL, dataalter varchar NOT NULL );

select * from empaudit; 
-- truncate table empaudit; 

CREATE OR REPLACE FUNCTION geralogemp()
  RETURNS trigger AS $$ 
  BEGIN 
       INSERT INTO empaudit (matemp, dataalter)  
       VALUES (new.matricula, current_timestamp); 
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql;  

-- drop trigger logEmptrigger on empregado; 

CREATE TRIGGER logEmptrigger AFTER INSERT 
  ON empregado FOR EACH ROW 
  EXECUTE PROCEDURE geralogEmp();
select * from empregado order by matricula; 
select * from empaudit;

INSERT INTO empregado VALUES (10,'Patricia', 'Novais','03-01-2022','Analista de Requisitos', 6000, 1, 2);

select * from empaudit; 

-- Exemplo 2

create table depto_backup as 
select * from departamento where 1= 2; 

-- truncate table depto_backup; 

select * from departamento;
select * from depto_backup;

CREATE OR REPLACE FUNCTION gerareplicaDepto()
  RETURNS trigger AS $$ 
  BEGIN 
     Insert into depto_backup values
	 (new.coddepto, new.nome, new.local);
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 

-- drop trigger replicaInsDepto on departamento; 

CREATE TRIGGER replicaInsDepto
	After INSERT ON  departamento
For each row Execute procedure gerareplicaDepto();

Insert into departamento values (4,'Marketing','Campina Grande');

select * from departamento;
select * from depto_backup;

-- 2a parte - próxima aula

-- Exemplo 3

Select * from departamento; 
CREATE OR REPLACE FUNCTION verificaop_Depto() RETURNS TRIGGER AS $$
    BEGIN 
        -- Utiliza a variável TG_OP para descobrir a operação sendo realizada.
        IF (TG_OP = 'DELETE') THEN
            raise notice 'Operação Delete sobre %', TG_TABLE_NAME;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            raise notice 'Operação Update sobre %', TG_TABLE_NAME;
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            raise notice 'Operação Insert sobre %', TG_TABLE_NAME;
            RETURN NEW;
        END IF;
        RETURN NULL; 
    END;
    $$ language plpgsql; 

CREATE TRIGGER TestaDepto_audit
  AFTER INSERT OR UPDATE OR DELETE ON departamento
    FOR EACH ROW EXECUTE PROCEDURE verificaop_Depto();

select * from departamento; 

Insert into departamento values (8,'Compras','Sede');   
update departamento set local = 'Patos' where coddepto = 8; 
delete from departamento where coddepto = 8; 

-- 2a parte do trigger

update departamento 
set local = 'Outro';

drop trigger TestaDepto_audit on departamento;
drop trigger TestaDepto on departamento; 

-- Retire o “for each row”
CREATE TRIGGER TestaDepto
  AFTER INSERT OR UPDATE OR DELETE ON Departamento
    EXECUTE PROCEDURE verificaop_Depto();

update departamento 
set local = 'teste';

-- Exemplo 6

CREATE OR REPLACE FUNCTION impedeAlteração() RETURNS TRIGGER AS $$
Declare
  v_hoje integer;
  v_agora integer;
Begin
    v_hoje := to_number(to_char(current_timestamp,'d'),'99');
    v_agora := to_number(to_char(current_timestamp,'hh24mi'),'9999');
    If v_agora >  0930 then
       RAISE EXCEPTION '%', 'Hora proibida para atualizações' USING ERRCODE = 45000;
    End if;
    If v_hoje = 1 then
       RAISE EXCEPTION '%', 'Dia proibido para atualizações' USING ERRCODE = 45001;    
    End if;
    return new; 
End;
$$ language plpgsql; 

-- drop trigger empnotifTrig on empregado; 

CREATE TRIGGER empnotifTrig
  BEFORE INSERT OR UPDATE ON empregado
    FOR EACH ROW EXECUTE PROCEDURE impedeAlteração();

INSERT INTO empregado VALUES (18,'TESTE','Morais','12-03-2020','Gerente',10000,1,1); 							
select * from empregado; 
select current_timestamp; 

select * from empregado order by primeironome; 



