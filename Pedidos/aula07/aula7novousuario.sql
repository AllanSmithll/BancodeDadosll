2-- Criação de novo usuário

Select * from pedido; 

Create table cidade(
cod integer,
nome varchar(30),
constraint codpk primary key(cod)); 

select * from cidade; 

-- Insira duas cidades
Insert into cidade values(1,'João Pessoa');
Insert into cidade values (2,'Campina Grande');
insert into cidade values (3, 'Cajazeiras');

select * from cidade; 

-- crie um outro usuário chamado BD2

Create role bd2 login password 'bd2'; 

Grant select on cidade to aaa; 
Revoke select on cidade from aaa;
Grant insert on cidade to bd2; 

