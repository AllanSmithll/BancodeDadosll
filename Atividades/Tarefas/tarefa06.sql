-- Tarefa 6 sobre Índices - Allan Alves Amancio
-- Questão 1
Explain select * from empregado
where salario > 4000;

-- Questão 2
create table testaEMP as select * from empregado;
select * from testaEMP;
-- execute o bloco anônimo seguinte completo (do DO até o $$;) e não linha a linha
DO $$DECLARE i int:= 0;
BEGIN
    WHILE I <= 1000000 LOOP
         	INSERT INTO testaEMP select * from empregado;
         	I := I + 1;
    END LOOP;
END$$;
 
EXPLAIN Select primeironome from testaEmp where gerente = 2;
Select primeironome from testaEmp where gerente = 2;
 
---
create index testaEmpindex on testaEmp(gerente);
—
EXPLAIN Select primeironome from testaEmp where gerente = 2;
Select primeironome from testaEmp where gerente = 2;

select relpages from pg_class where relname = 'empregado';
select relpages from pg_class where relname = 'testaemp';

-- Questão 3
select * from pg_indexes where tablename = 'empregado';