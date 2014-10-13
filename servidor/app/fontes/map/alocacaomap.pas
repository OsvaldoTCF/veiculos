unit AlocacaoMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Alocacao;

type
    TAlocacaodb = class(TAlocacao)
    private
      FOperadorId: LongInt;
      FMotoristaId: LongInt;
      FVeiculoId: LongInt;
    public
    published
      property OperId: LongInt read FOperadorId write FOperadorId;
      property MotId: LongInt read FMotoristaId write FMotoristaId;
      property VeicId: LongInt read FVeiculoId write FVeiculoId;

  end;

    { TOficinaMap }

    TAlocacaoMap = class(specialize TdGSQLdbEntityOpf<TAlocacaodb>)

  public
    constructor Create; overload;
  end;



implementation

{ TOperadordb }

constructor TAlocacaoMap.Create;
begin
      inherited Create(dbutils.con, 'oficina');
end;


end.

