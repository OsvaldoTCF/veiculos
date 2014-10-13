CREATE TABLE Oficina (
Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
Nome varchar(250),
Contato varchar(50),
Telefone varchar(10),
Endereco varchar(250),
Observacao varchar(250)
);
CREATE TABLE Funcionario (
Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
Nome varchar(250),
CnhClasse CHARACTER(1),
Cnh CHARACTER(11),
Senha caracter(8)
);
CREATE TABLE marca (
Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 Nome varchar(250) NOT NULL  DEFAULT ('FIAT')
);
CREATE TABLE veiculo (
    Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "MarcId" INTEGER NOT NULL DEFAULT (1),
    "Placa" CHARACTER(7),
    "CnhClasse" CHARACTER(1),
    "Ano" CHARACTER(4),
    "Renavan" CHARACTER(11),
    "Identificacao" VARCHAR(250),
    "Modelo" VARCHAR(250),
    "kmetragem" INTEGER,
    FOREIGN KEY(MarcId) REFERENCES Marca (Id)
);
CREATE TABLE Alocacao (
Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
Inicio DateTime,
Finalidade varchar(250),
Fim DateTime,
Lancamento DateTime,
Destino varchar(250),
MotId INTEGER,
VeicId INTEGER,
OperId INTEGER,
FOREIGN KEY(MotId) REFERENCES Funcionario (Id),
FOREIGN KEY(VeicId) REFERENCES Veiculo (Id),
FOREIGN KEY(OperId) REFERENCES Funcionario (Id)
);
CREATE TABLE ProdutoEServico (
Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
Descricao varchar(250)
);
CREATE TABLE Manutencao (
Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
Lancamento DateTime,
OfId INTEGER,
VeicId INTEGER,
FuncId INTEGER,
FOREIGN KEY(VeicId) REFERENCES Veiculo (Id),
FOREIGN KEY(OfId) REFERENCES Oficina (Id),
FOREIGN KEY(FuncId) REFERENCES Funcionario (Id)
);
CREATE TABLE ManutencaoItem (
ManId  INTEGER NOT NULL,
ProdId  INTEGER NOT NULL,
PrecoUnit Currency,
Qtd real,
PRIMARY KEY (ManId,ProdId ),
FOREIGN KEY(ManId) REFERENCES Manutencao (Id),
FOREIGN KEY(ProdId) REFERENCES ProdutoEServico (Id)
);