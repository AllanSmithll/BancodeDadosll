-- Teste de índice
-- drop table testafilme; 

--Criando nova tabela
create table testaFilme as select * from filme;
select * from testafilme;

-- Populando nova tabela
DO $$DECLARE i int:= 0;
BEGIN
    WHILE I <= 200000 LOOP
        INSERT INTO testafilme select * from filme;
        I := I + 1;
    END LOOP;
END$$;

Explain select titulo from testafilme order by titulo;
select titulo from testafilme order by titulo; 

--- criando índice
create index testaFilmeindex on testafilme(titulo);
---

explain select titulo from testafilme order by titulo; 
select titulo from testafilme order by titulo; 
select distinct titulo from testafilme order by titulo; 