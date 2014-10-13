unit FuncionarioMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Funcionario;

type

    { TOperadordb }

    TOperadordb = class(specialize TdGSQLdbEntityOpf<TOperador>)
  public
    constructor Create; overload;
  end;


    { TMotoristadb }

    TMotoristadb = class(specialize TdGSQLdbEntityOpf<TMotorista>)
  public
    constructor Create; overload;
  end;


    { TMotoristaAction }


implementation

{ TOperadordb }

constructor TOperadordb.Create;
begin
      inherited Create(dbutils.con, 'funcionario');
end;

{ TMotoristadb }

constructor TMotoristadb.Create;
begin
    inherited Create(dbutils.con, 'funcionario');

end;

end.

