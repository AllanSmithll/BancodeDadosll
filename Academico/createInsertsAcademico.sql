-- Allan Amancio - 12/03/2023

-- Aula 03 - DDL e constraints

-- Vamos criar um esquema com algumas tabelas de um "sistema acadêmico"

CREATE TABLE Aluno(
	MatricAlu	serial NOT NULL,
	NomeAlu		VARCHAR(40),
	DataAniver	DATE default '01/01/1998',
	Sexo		CHAR(1),
	CONSTRAINT PKAluno PRIMARY KEY(MatricAlu));
	
CREATE TABLE Disciplina ( 
    CodDISC    serial  NOT NULL,
    NomeDISC   VARCHAR(30),
    CONSTRAINT PKDisciplina PRIMARY KEY(CodDISC));

--Nesta próxima tabela, vamos criar a constraint de PK usando o alter table

CREATE TABLE Professor ( 
      	 MatricProf      serial     NOT NULL,
    	 NomeProf        VARCHAR(40),
      	 DataAdmissao    DATE  	 );

ALTER TABLE Professor ADD CONSTRAINT PKProfessor PRIMARY KEY(MatricProf);

--Testando a integridade referencial

--Teste 01: NO ACTION (default) 

ALTER TABLE professor add codDisc integer;
ALTER TABLE professor ADD CONSTRAINT FKprofdisc FOREIGN KEY(codDisc) REFERENCES Disciplina;

Insert into disciplina(nomeDisc) values ('BDII'); 
insert into disciplina(nomeDisc) values ('Sistemas Operacionais');

Select * from disciplina; 

Insert into professor(nomeProf, dataadmissao,coddisc) values('Crishane', null, 1);
Insert into professor(nomeProf, dataadmissao,coddisc) values('Damires', null, 1);
Insert into professor(nomeProf, dataadmissao,coddisc) values('Luciana', null, 2);

select * from professor; 

Delete from disciplina where codDisc = 1;

--Teste 02: on delete set null 

Alter table professor drop constraint fkprofdisc;
ALTER TABLE professor ADD CONSTRAINT FK2_prof_disc FOREIGN KEY(codDisc) REFERENCES Disciplina on delete set null;

Select * from disciplina;

Select * from professor;

Delete from disciplina where codDisc = 1;

Select * from disciplina;

Select * from professor;

--Teste 03: ON DELETE CASCADE

Alter table professor drop constraint fk2_prof_disc;
ALTER TABLE professor ADD CONSTRAINT 
FK3_prof_disc FOREIGN KEY(coddisc) REFERENCES Disciplina ON DELETE CASCADE;

Select * from disciplina;
Select * from professor;

Insert into disciplina(coddisc,nomeDisc) values (1,'BDII'); 
Update professor
set coddisc = 1
where matricprof = 1 or matricprof = 2; 

Select * from disciplina;
Select * from professor;

Delete from disciplina where codDisc = 1;

Select * from disciplina;
Select * from professor;


--Teste 04: ON UPDATE CASCADE

--Inserir dados novamente
Insert into disciplina(coddisc,nomeDisc) values (1,'BDII'); 
Insert into professor(nomeProf, dataadmissao,coddisc) values('Crishane', null, 1);
Insert into professor(nomeProf, dataadmissao,coddisc) values('Damires', null, 1);

Alter table professor drop constraint fk3_prof_disc;
ALTER TABLE professor ADD CONSTRAINT 
FK4_prof_disc FOREIGN KEY(coddisc) REFERENCES Disciplina ON UPDATE CASCADE;

select * from disciplina; 
select * from professor; 

-- Teste do update 
Update disciplina 
Set coddisc = 11 
where coddisc = 1;

Select * from disciplina;
Select * from professor;

--Voltando disciplinas a seu valor correto de PK
Update disciplina
Set coddisc = 1
Where coddisc = 11;

select * from disciplina; 
select * from professor; 

-- Checks de validação

CREATE TABLE nota_aluno 
    (Matricalu integer,
     NumNota integer,
     Nota numeric(3,1) CHECK (nota > 0),
     constraint pk_alu_nota primary key(Matricalu,Numnota),
     constraint FK_alu foreign Key(Matricalu) references Aluno);

select * from aluno; 
Select * from nota_aluno; 

-- Insira dados em aluno e em nota_aluno 
-- Teste a validação 

Insert into aluno values(default,'Jonas Melo','12/02/2000','M'); 
Insert into nota_aluno values(1,1,10);
Insert into nota_aluno values(1,2,0);

 
-- Check de validação na Tabela Professor
ALTER TABLE professor ADD salario numeric(15,2) 
CHECK (salario >= 4000.00 and salario <=  20000.00);