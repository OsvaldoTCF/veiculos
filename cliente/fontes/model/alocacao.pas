unit Alocacao;

{$mode objfpc}{$H+}

interface

uses
//  Classes, SysUtils;
funcionario, veiculo;
type
  TAlocacao = class
    FId: Int64;
    FInicio: TDatetime;
    FFim: TDatetime;
    FData: TDatetime;
    FFinalidade: string;
    FMotorista: TMotorista;
    FVeiculo: TVeiculo;

  end;

implementation

end.

