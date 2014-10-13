unit Veiculo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
type

  TVeiculo = class
    private
    FId: LongInt;
    FPlaca: string;
    FMarca: string;
    FModelo: string;
    FRenavan: string;
    FCnhClasse: string;
    FIdencificacao: string;
    FAno: string;
    FKmetragem: integer;
    published
    property Id: LongInt read FId write FId;
    property Placa: string read FPlaca write FPlaca;
    property Marca: string read FMarca write FMarca;
    property Modelo: string read FModelo write FModelo;
    property Renavan: string read FRenavan write FRenavan;
    property CnhClasse: string read FCnhClasse write FCnhClasse;
    property Identificacao: string read FIdencificacao write FIdencificacao;
    property Ano: string read FAno write FAno;
    property Kmetragem: integer read FKmetragem write FKmetragem;


  end;

implementation

end.

