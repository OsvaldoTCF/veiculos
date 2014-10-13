unit Oficina;

{$mode objfpc}{$H+}

interface

//uses
//  Classes, SysUtils;
type

  { TOficina }

  TOficina = class
  private
    FId: Int64;
    FContato: string;
    FEndereco: string;
    FNome: string;
    FObservacao: string;
    FTelefone: string;
  public
  published
    property Id: Int64 read Fid write FId;
    property Nome: string read fnome write FNome;
    property Contato: string read FContato write FContato;
    property Telefone: string read FTelefone write FTelefone;
    property Endereco: string read FEndereco write FEndereco;
    property Observacao: string read FObservacao write FObservacao;

end;

implementation

end.

