unit Manutencao;

{$mode objfpc}{$H+}

interface

uses
Veiculo,
Funcionario,
Oficina,
Produto,
fgl;

type
  TManutencaoItem = class
  private
  FProduto: TProduto;
  FQtd: Integer;
  FPreco: Currency;
  public
  property Produto: TProduto read FProduto write FProduto;
  published
  property Qtd: Integer read FQtd write FQtd;
  property Preco: Currency read FPreco write FPreco;

  end;

  TManutencaoItens = class(specialize TFPGObjectList<TmanutencaoItem>);

  TManutencao = class
    private
    FId: LongInt;
    FLancamento: TDatetime;
    FOperador: TOperador;
    FVeiculo: TVeiculo;
    FOficina: TOficina;
    FItens: TManutencaoItens;

    public
    property Operador: TOperador read FOperador write FOperador;
    property Veiculo: TVeiculo read FVeiculo write FVeiculo;
    property Oficina: TOficina read FOficina write FOficina;

    published
    property Id: LongInt read FId write FId;
    property Lancamento: TDatetime read FLancamento write FLancamento;

  end;

implementation

end.

