program dcfrota;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols, lazreportpdfexport, telai, dbutils, MUtils,
  manutencao, produto, alocacao, veiculo, oficina, funcionario, manutencaomap,
  produtomap, alocacaomap, funcionariomap, oficinamap, oficinav,
  veiculov, Marca, marcav;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TTelaInicialFrm, TelaInicialFrm);
  Application.Run;
end.

