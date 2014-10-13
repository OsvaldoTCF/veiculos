program cr;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazdbexport, brokers, Constantes, dbutils, main, oficinav,
  funcionariov, alocacao, funcionario, manutencao, oficina, produto, veiculo;

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TTelaiFrm, TelaiFrm);
  Application.Run;
end.
