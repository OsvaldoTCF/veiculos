unit OficinaMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Oficina;

type
    TOficinadb = class(TOficina)
    private
    public
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

