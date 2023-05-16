-- Allan Amancio - 12/03/2023

CREATE TABLE Filme (
   	CodFILME   	Serial  NOT NULL,
   	Titulo      	Varchar(25),
   	Ano         	integer,
   	Duracao   	  integer,
   	CodCATEG   	integer,
   	CodEst     	integer);
CREATE TABLE Artista (
   	CodART  	Serial  NOT NULL,
   	NomeART	Varchar(25),
   	Cidade      	Varchar(20),
   	Pais        	Varchar(20),
   	DataNasc   	Date);
CREATE TABLE Estudio (
   	CodEst 	serial  NOT NULL,
   	NomeEst	Varchar(25));
CREATE TABLE Categoria (
   	CodCATEG   	serial  NOT NULL,
   	DescCATEG VARCHAR(25));
CREATE TABLE Personagem (
   	CodART 	integer  NOT NULL,
   	CodFILME   integer  NOT NULL,
   	NomePers  VARCHAR(25),
   	Cache       	numeric(15,2));
ALTER TABLE Filme ADD CONSTRAINT PKFilme PRIMARY KEY(CodFILME);
ALTER TABLE Artista ADD CONSTRAINT PKArtista PRIMARY KEY(CodART);
ALTER TABLE Estudio ADD CONSTRAINT PKEst PRIMARY KEY(CodEst);
ALTER TABLE Categoria ADD CONSTRAINT PKCategoria PRIMARY KEY(CodCATEG);
ALTER TABLE Personagem ADD CONSTRAINT PKPersonagem PRIMARY KEY(CodART,CodFILME);
ALTER TABLE Filme ADD CONSTRAINT FKFilme1Categ FOREIGN KEY(CodCATEG) REFERENCES Categoria;
ALTER TABLE Filme ADD CONSTRAINT FKFilme2Estud FOREIGN KEY(CodEst) REFERENCES Estudio;
ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem2Artis FOREIGN KEY(CodART) REFERENCES Artista;
ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem1Filme FOREIGN KEY(CodFILME) REFERENCES Filme;
