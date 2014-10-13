unit dbutils;

{$mode objfpc}{$H+}

interface

uses
  dSQLdbBroker, SysUtils, PQConnection, sqlite3conn;

function con: TdSQLdbConnector;

implementation

var
  _con: TdSQLdbConnector = nil;

function con: TdSQLdbConnector;
begin
  if not Assigned(_con) then
  begin
    _con := TdSQLdbConnector.Create(nil);
    _con.Driver := 'SQLite3';
    _con.Host := '';
    _con.Database := './db/veiculos.sqlite3';
    _con.User := '';
    _con.Password := '';
    _con.Logger.active := True;
    _con.Logger.filename := './db/log.txt';
  end;
  Result := _con;
end;

finalization
  FreeAndNil(_con);

end.

