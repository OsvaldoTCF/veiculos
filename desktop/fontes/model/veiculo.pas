unit Veiculo;

{$mode objfpc}{$H+}

interface

uses
//  Classes, SysUtils
 dSQLdbBroker,
 dbutils,
BusinessObject,
fgl,
contnrs,
 marca;

type
  TVeiculo = class;

      { TVeiculoMap }

    TVeiculoMap = class(specialize TdGSQLdbEntityOpf<TVeiculo>)
    private
      FMarcId: LongInt;
      FMap: TVeiculoMap;

    public
            //constructor Create;
      //destructor Destroy; override;
      //procedure Adicionar(APedido: TPedido);
      property Map: TVeiculoMap read FMap;
    constructor Create; //overload;
    published
       property MarcId: LongInt read FMarcId write FMarcId;

  end;

  TVeiculo = class
    private
    FId: LongInt;
    FMarca: TMarca;
    FPlaca: string;
    FModelo: string;
    FRenavan: string;
    FCnhClasse: string;
    FIdencificacao: string;
    FAno: string;
    FKmetragem: integer;
    FMap: TVeiculoMap;
    public
      constructor Create;
      destructor Destroy;
      procedure datasave;    virtual; abstract;
      procedure dataload(var vVeiculo: TVeiculo; key: longint);
      procedure datadelete;   virtual; abstract;
      procedure datafind(filter: string);   virtual; abstract;
      function datalist: TObjectList;//TMarcaLista;
      property Map: TVeiculoMap read FMap write FMap;
      //property Marca: TMarca read FMarca write FMarca;
     // function datalistasjson(filter: string): TJSONArray;    virtual; abstract;
    published
    property Id: LongInt read FId write FId;
    property Placa: string read FPlaca write FPlaca;
    property Modelo: string read FModelo write FModelo;
    property Renavan: string read FRenavan write FRenavan;
    property CnhClasse: string read FCnhClasse write FCnhClasse;
    property Identificacao: string read FIdencificacao write FIdencificacao;
    property Ano: string read FAno write FAno;
    property Kmetragem: integer read FKmetragem write FKmetragem;


  end;

implementation

{ TVeiculo }

constructor TVeiculo.Create;
begin
  //
end;

destructor TVeiculo.Destroy;
begin
  //
end;

procedure TVeiculo.dataload(var vVeiculo: TVeiculo; key: longint);
begin
   if not Assigned(FMap) then
  FMap := TVeiculoMap.Create;

  FMap.Entity.id := key;
  FMap.get;//(vmarca, 'id = (:id)');
  vVeiculo := FMap.Entity;
end;

function TVeiculo.datalist: TObjectList;
var
  vVeiculos : TVeiculoMap.TEntities;
  vMap: TVeiculoMap;
  vVeiculo: TVeiculo;
  obl : TObjectList;
begin
 //   if not Assigned(FMap) then
  obl := TObjectList.create;
  try
  vVeiculos := TVeiculoMap.TEntities.create;
  vVeiculo := TVeiculo.create;
  vMap := TVeiculoMap.Create;
  vMap.list(vVeiculos);
  for vVeiculo in vVeiculos do
  begin
    obl.Add(vVeiculo);
  end;
  result := obl;
  finally
    obl.free;
  end;

end;

constructor TVeiculoMap.Create;
begin
      inherited Create(dbutils.con, 'veiculo');
end;

end.

