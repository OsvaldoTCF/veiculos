unit Alocacao;

{$mode objfpc}{$H+}

interface

uses
veiculo,
Funcionario;

type
  TAlocacao = class
    private
    FId: LongInt;
    FInicio: TDatetime;
    FFim: TDatetime;
    FData: TDatetime;
    FFinalidade: string;
    FMotorista: TMotorista;
    FVeiculo: TVeiculo;

    public
    property Motorista: TMotorista read FMotorista write FMotorista;
    property Veiculo: TVeiculo read FVeiculo write FVeiculo;

    published
    property Id: LongInt read FId write FId;
    property Inicio: TDatetime read FInicio write FInicio;
    property Fim: TDatetime read FFim write FFim;
    property Data: TDatetime read FData write FData;
    property Finalidade: string read FFinalidade write FFinalidade;

  end;

implementation

end.

