CREATE TABLE Cliente (
CodCLI Serial PRIMARY KEY,
Nome Varchar(30),
Endereco Varchar(30),
Telefone Varchar(12),
InscE Varchar(10),
CNPJ Varchar(10),
Cidade Varchar(15),
UF Varchar(2)
);

CREATE TABLE Produto (
CodPROD Serial not null,
Descricao Varchar(20),
Valor Numeric(10,2),
Unidade Char(2),
constraint pk_prod primary key(CodPROD));

CREATE TABLE Pedido (
NumPED Serial PRIMARY KEY,
PrazoEntrega Integer,
Data Date,
CodCLI Integer,
CodVEND Integer,
FOREIGN KEY(CodCLI) REFERENCES Cliente (CodCLI)
);

CREATE TABLE Vendedor (
CodVEND Serial PRIMARY KEY,
Nome Varchar(30),
DataNasc Date,
SalarioFixo Numeric(12,2),
FaixaComissao Char(1)
);

CREATE TABLE ItensPedido (
NumPED Integer,
CodPROD Integer,
Quantidade Integer,
constraint pk_itens PRIMARY KEY(CodPROD,NumPED),
constraint fk_prod FOREIGN KEY(CodPROD) REFERENCES Produto (CodPROD),
constraint fk_ped FOREIGN KEY(NumPED) REFERENCES Pedido (NumPED)
);
 

ALTER TABLE Pedido ADD FOREIGN KEY(CodVEND) REFERENCES Vendedor (CodVEND);