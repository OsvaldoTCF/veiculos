unit ManutencaoMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Manutencao;

type
    TManutItdb = class(TManutencaoItem)
    private
      FManId: LongInt;
      FProdId: LongInt;
    public
    published
      property ManId: LongInt read FManId write FManId;
      property ProdId: LongInt read FProdId write FProdId;
    end;

    { TManutencaoItemMap }

    TManutencaoItemMap = class(specialize TdGSQLdbEntityOpf<TManutItdb>)
  public
    constructor Create; overload;
  end;


  TManutdb = class(TManutencao)
    private
    public
    published
  end;

  TManutencaoMap = class(specialize TdGSQLdbEntityOpf<TManutdb>)
  public
    constructor Create; overload;
  end;



implementation


constructor TManutencaoItemMap.Create;
begin
      inherited Create(dbutils.con, 'manutencaoitem');
end;


constructor TManutencaoMap.Create;
begin
      inherited Create(dbutils.con, 'manutencao');
end;


end.

