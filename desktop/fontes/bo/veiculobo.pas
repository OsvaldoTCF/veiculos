unit veiculobo;

{$mode objfpc}{$H+}

interface

uses
 sysutils,
 classes,
 dSQLdbBroker,
 dbutils,
 veiculo,
 veiculomap,
 marca,
 fpjson,
 jsonparser,
 rutils,
 fpjsonrtti,
 MUtils;

type

    { VeiculoBO }

    TVeiculoBO = class(TVeiculo)
    private
    FMap: TVeiculoMap;
    public
    constructor Create;
    destructor Destroy;  override;
    procedure datasave;
    procedure dataload(key: longint);
    procedure datadelete;
    procedure datafind(filter: string);
    function datalistasjson(filter: string): TJSONArray;
    published
    end;



implementation

{ VeiculoBO }

constructor TVeiculoBO.Create;
begin
  //
end;

destructor TVeiculoBO.Destroy;
begin
  inherited Destroy;
end;

procedure TVeiculoBO.datasave;
begin
  //
end;

procedure TVeiculoBO.dataload(key: longint);
begin
  //
end;

procedure TVeiculoBO.datadelete;
begin
   //
end;

procedure TVeiculoBO.datafind(filter: string);
begin
  //
end;

function TVeiculoBO.datalistasjson(filter: string): TJSONArray;
var
      VVeiculo: TVeiculoBO;
      VVeiculos: TVeiculoMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
      VParser: TJSONParser;
           arjson: TJSONArray;
begin
//
//     ts := tstringlist.create;
//     VJObject := TJSONObject.Create;
//
//
//      VJArray := TJSONArray.Create;
//      VVeiculos := TVeiculoMap.TEntities.Create;
//      try
//        FMap.Entity.identificacao := '%'+filter+'%';
//        FMap.Find(VVeiculos, 'identificacao like (:identificacao)');
//        for VVeiculo in VVeiculos do
//          begin
//          VJObject.Clear;
//          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VVeiculo,
//          VJObject, ts);
//          VJArray.Add(VJObject.Clone);
//          end;
//
//  result :=  VJArray.Clone;
//
//             finally
//              VJObject.free;
//              ts.Free;
//              VJArray.Free;
//            end;
end;


end.

