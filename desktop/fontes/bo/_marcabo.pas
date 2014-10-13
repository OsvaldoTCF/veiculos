unit MarcaBO;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Marca;

type
    TMarcaMap = class;

    { TMarcaBO }

    ///////////qq
                    { VeiculoBO }

    TVeiculoBO = class(TVeiculo)
    private
    FMap: TVeiculoMap;
    public

    published
    end;
    ///////////q

    TMarcaBO = class(TMarca)
    private
      FMap: TMarcaMap;
    public
    published
  end;

    { TMarcaMap }

    TMarcaMap = class(specialize TdGSQLdbEntityOpf<TMarcadb>)

  public
    constructor Create; overload;
  end;



implementation


constructor TMarcaMap.Create;
begin
      inherited Create(dbutils.con, 'marca');
end;


end.

