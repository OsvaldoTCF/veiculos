unit Manutencao;

{$mode objfpc}{$H+}

interface

uses
Fgl, Produto;
//  Classes, SysUtils;
type
  TManutencaoitem = class
    FProduto: TProduto;
    FQtd: real;
    FPrecoUnit: currency;

  end;
  TManutencaoItens = class(specialize TFPGObjectList<TManutencaoitem>);

  TManutencao = class
    FId: Int64;
    FLancamento: TDatetime;
    FItens: TManutencaoItens;
  end;



implementation

end.

