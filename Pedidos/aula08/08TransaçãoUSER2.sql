-- Aula 08 Transações
-- User 2: dysf
-- deixe o autocommit desabilitado
--Iniciando a transação
select * from vendedor;
insert into vendedor values(30,'Amelia Paulo', '12/03/1996', 5300.80,'A');
Select * from vendedor; 
commit;
select * from vendedor;

-- novo teste de transação
insert into vendedor values(40,'Augusto Paulo', '12/03/1996', 5300.80,'A');

