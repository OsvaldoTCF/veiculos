program cfrota;

{$mode objfpc}{$H+}

uses
  BrookApplication, Brokers, dbutils, funcionario, Veiculo, Produto, Oficina,
  alocacao, Raiz, FuncionarioMap, FuncionarioRest, OficinaRest, OficinaMap,
  veiculomap, VeiculoRest, AlocacaoMap, AlocacaoRest, Manutencao, ManutencaoMap,
  ProdutoMap, ProdutoRest, ManutencaoRest;

begin
  BrookApp.Run;
end.
