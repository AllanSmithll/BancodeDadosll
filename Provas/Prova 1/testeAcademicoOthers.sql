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

select * from disciplina order by coddisc;
select * from professor; 

-- Teste do update 
Update disciplina 
Set coddisc = 11 
where coddisc = 1;

Select * from disciplina;
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

insert into professor values (default, 'Allan', current_date, null, 3000); -- Dá errado por conta do check de salário