unit OficinaMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Oficina;

type

    { TOficinadb }

    TOficinadb = class(specialize TdGSQLdbEntityOpf<TOficina>)
  public
    constructor Create; overload;
  end;



implementation

{ TOperadordb }

constructor TOficinadb.Create;
begin
      inherited Create(dbutils.con, 'oficina');
end;


end.

