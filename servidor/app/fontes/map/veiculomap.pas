unit VeiculoMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 veiculo;

type
    TVeiculodb = class(TVeiculo)
    private
    public
    published
  end;

    { TVeiculoMap }

    TVeiculoMap = class(specialize TdGSQLdbEntityOpf<TVeiculodb>)

  public
    constructor Create; overload;
  end;



implementation


constructor TVeiculoMap.Create;
begin
      inherited Create(dbutils.con, 'veiculo');
end;


end.

