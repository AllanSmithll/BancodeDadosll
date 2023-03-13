create table departamento (
   CodDepto                      serial not null, 
   Nome                          varchar(20),
   Local                         varchar(20));

alter table departamento add constraint pkdepto primary key(coddepto);

create table empregado (
       Matricula               serial not null,
       PrimeiroNome            varchar(15),
       Sobrenome   	           varchar(15),
       Dataadmissao            date,
       Cargo                   varchar(30),
       Salario                 numeric(13,2),
       gerente		             integer,
       CodDepto                integer);

alter table empregado add constraint pkEmp primary key(matricula);

Alter table empregado add constraint fkgerente foreign key(gerente) references Empregado;
Alter table Empregado add constraint fkdepto foreign key(coddepto) references Departamento;
