unit telai;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TTelaInicialFrm }

  TTelaInicialFrm = class(TForm)
    btAlocacao: TButton;
    btManutencao: TButton;
    brMarca: TButton;
    btVeiculo: TButton;
    btOperador: TButton;
    btMotorista: TButton;
    btOficina: TButton;
    procedure brMarcaClick(Sender: TObject);
    procedure btOficinaClick(Sender: TObject);
    procedure btVeiculoClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  TelaInicialFrm: TTelaInicialFrm;

implementation

uses oficinav, veiculov, marcav;

{$R *.lfm}

{ TTelaInicialFrm }

procedure TTelaInicialFrm.btOficinaClick(Sender: TObject);
begin
  OficinaFrm := TOficinaFrm.create(application);
  try
    OficinaFrm.ShowModal;
  finally
    FreeAndNil(OficinaFrm);
  end;
end;

procedure TTelaInicialFrm.brMarcaClick(Sender: TObject);
begin
  MarcaFrm := TMarcaFrm.create(application);
  try
    MarcaFrm.ShowModal;
  finally
    FreeAndNil(MarcaFrm);
  end;
end;

procedure TTelaInicialFrm.btVeiculoClick(Sender: TObject);
begin
  VeiculoFrm := TVeiculoFrm.create(application);
  try
    VeiculoFrm.ShowModal;
  finally
    FreeAndNil(OficinaFrm);
  end;
end;

end.

