unit FuncionarioMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Funcionario;

type

    TOperadordb = class(TOperador)

    end;

    TMotoristadb = class(TMotorista)

    end;



    { TOperadordb }

    TOperadorMap = class(specialize TdGSQLdbEntityOpf<TOperadordb>)
  public
    constructor Create; overload;
  end;


    { TMotoristadb }

    TMotoristaMap = class(specialize TdGSQLdbEntityOpf<TMotoristadb>)
  public
    constructor Create; overload;
  end;


    { TMotoristaAction }


implementation

{ TOperadordb }

constructor TOperadorMap.Create;
begin
      inherited Create(dbutils.con, 'funcionario');
end;

{ TMotoristadb }

constructor TMotoristaMap.Create;
begin
    inherited Create(dbutils.con, 'funcionario');

end;

end.

