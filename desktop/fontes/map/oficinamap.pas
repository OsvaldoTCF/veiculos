unit OficinaMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Oficina;

type
    TOficinaMap = class;

    { TOficinadb }

    TOficinadb = class(TOficina)
    private
      FMap: TOficinaMap;
    public
      property Map: TOficinaMap read FMap write FMap;
    published
  end;

    { TOficinaMap }

    TOficinaMap = class(specialize TdGSQLdbEntityOpf<TOficinadb>)

  public
    constructor Create; overload;
  end;



implementation

{ TOperadordb }

constructor TOficinaMap.Create;
begin
      inherited Create(dbutils.con, 'oficina');

end;


end.

