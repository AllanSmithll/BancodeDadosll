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
