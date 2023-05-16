-- 2a parte Aula Triggers (Empregados e departamentos)

-- Exemplo 3

Select * from departamento order by coddepto; 

CREATE OR REPLACE FUNCTION verificaop_Depto() RETURNS TRIGGER AS $$
    BEGIN 
        -- Utiliza a variável TG_OP para descobrir a operação sendo realizada.
        IF (TG_OP = 'DELETE') THEN
            raise notice 'Operação Delete sobre %', TG_TABLE_NAME;
            RETURN null;
        ELSIF (TG_OP = 'UPDATE') THEN
            raise notice 'Operação Update sobre %', TG_TABLE_NAME;
            RETURN null;
        ELSIF (TG_OP = 'INSERT') THEN
            raise notice 'Operação Insert sobre %', TG_TABLE_NAME;
            RETURN null;
        END IF;
    END;
    $$ language plpgsql; 
	
-- drop trigger TestaDepto_audit on departamento; 

CREATE TRIGGER TestaDepto_audit
  AFTER INSERT OR UPDATE OR DELETE ON departamento
    FOR EACH ROW EXECUTE PROCEDURE verificaop_Depto();

select * from departamento; 

Insert into departamento values (6,'Compras','Sede');   
update departamento set local = 'Patos' where coddepto = 6; 
delete from departamento where coddepto = 6; 

-- 2a parte do teste 

update departamento 
set local = 'Outro';

drop trigger TestaDepto_audit on departamento;

-- Retire o “for each row”
CREATE TRIGGER TestaDepto_audit2
  AFTER INSERT OR UPDATE OR DELETE ON Departamento
    EXECUTE PROCEDURE verificaop_Depto();

update departamento 
set local = 'teste';

-- drop trigger TestaDepto_audit2 on departamento;

select * from departamento; 

-- Exemplo 6

CREATE OR REPLACE FUNCTION impedeAlteração() RETURNS TRIGGER AS $$
Declare
  v_hoje integer;
  v_agora integer;
Begin
    v_hoje := to_number(to_char(current_timestamp,'d'),'99');
    v_agora := to_number(to_char(current_timestamp,'hh24mi'),'9999');
    If v_agora >  1830 then
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

select * from empregado order by matricula; 
-- delete from empregado where matricula > 12; 

INSERT INTO empregado VALUES (1,'TESTE','Morais','12-03-2020',
							  'Gerente',10000,1,1); 							
select * from empregado order by matricula; 
select current_timestamp; 

select * from empregado order by primeironome; 

SELECT * FROM INFORMATION_SCHEMA.TRIGGERS
