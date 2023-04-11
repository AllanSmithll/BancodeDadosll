-- Tarefa 5 - Allan Alves Amâncio
-- Parte 1
-- CREATE TABLE
Begin;
Create table testeTransacao (coluna1 serial,coluna2 varchar(10));
Alter table testeTransacao add constraint pk_t primary key(coluna1);
commit;

-- INSERTS, SAVEPOINT
Begin;
Insert into testeTransacao values (default,'AAA');
Insert into testeTransacao values (default,'ABC');
Insert into testeTransacao values (default,'BBB');
Insert into testeTransacao values (default,'BCD');
Insert into testeTransacao values (default,'CCC');
Insert into testeTransacao values (default,'CDE');
Select * from testeTransacao;
savepoint spt1;
Insert into testeTransacao values (default,'DDD');
Insert into testeTransacao values (default,'DEF');
Insert into testeTransacao values (default,'EEE');
Select * from testeTransacao;

-- Letra a
-- 9 registros

-- Letra b
Rollback to spt1;

-- Letra c
-- 6 registros

-- Parte 2
Insert into testeTransacao values (default,'EFG');
Insert into testeTransacao values (default,'FFF');
Insert into testeTransacao values (default,'FGH');
Select * from testeTransacao;

-- Letra d
-- 9 registros

-- Letra e - Com rollback
Rollback;

-- Letra f
Insert into testeTransacao values (default,'GGG');
Insert into testeTransacao values (default,'GHI');
Insert into testeTransacao values (default,'HHH');
Insert into testeTransacao values (default,'HIJ');
Insert into testeTransacao values (default,'III');
Insert into testeTransacao values (default,'IJK');

-- Letra g
commit;

-- Letra h
-- Salvou todas as inserções feitas após o Rollback da Letra e.