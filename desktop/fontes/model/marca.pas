unit Marca;

{$mode objfpc}{$H+}

interface

uses
 Classes, SysUtils,
 dSQLdbBroker,
 dbutils,
 BusinessObject,
 fgl,
 contnrs,
  fpjson,
 jsonparser,
 rutils,
 fpjsonrtti,
 MUtils;
type

  TMarca = class;

//   TMarcaLista = specialize TFPGObjectList<TMarca>;


    { TMarcaMap }

    TMarcaMap = class(specialize TdGSQLdbEntityOpf<TMarca>)
    public
      constructor Create; overload;
    end;

  { TMarca }
  TMarca = class(TBusinessObject)
  private
    FId: LongInt;
    FNome: string;
    FMap: TMarcaMap;

  public
    constructor Create;
    destructor Destroy;
    procedure datasave;    virtual; abstract;
    procedure dataload(var vMarca: TMarca; key: longint);
    procedure datadelete;   virtual; abstract;
    procedure datafind(filter: string);   virtual; abstract;
    function datalist: TObjectList;//TMarcaLista;
    property Map: TMarcaMap read FMap write FMap;
    function datalistasjson(filter: string): TJSONArray;//    virtual; abstract;
  published
    property Id: LongInt read Fid write FId;
    property Nome: string read FNome write FNome;
  end;


  //TMarcaLista = TMarca.Map.TEntities;

  { TMarcaListagem }
//
//  TMarcaListagem = class
//    private
//      FItens: TMarcaLista;
//    public
//      procedure populate;
//    published
//      property Itens: TMarcaLista read FItens;
//  end;




implementation

{ TMarcaListagem }

//procedure TMarcaListagem.populate;
//var
//     VMap: TMarcaMap;
//     vmarca: TMarca;
//
//begin
//     VMarca := TMarca.create;
//     VMap := TMarcaMap.Create;
//     VMap.Entity.id := 1;
//     VMap.get;
//   //  VMap.List(FItens);
//   VMarca := VMap.Entity;
//     itens.Add(VMarca);
//end;

{ TMarca }

//constructor TMarcaTB.Create;
//begin
//  FMap := TMarcaMap.create;
//end;
//
//destructor TMarcaTB.Destroy;
//begin
//  FMap.free;
//end;

constructor TMarca.Create;
begin
 // FMap := TMarcaMap.create;
end;

destructor TMarca.Destroy;
begin
 // FMap.free;
end;

procedure TMarca.dataload(var vMarca: TMarca; key: longint);
begin

  if not Assigned(FMap) then
  FMap := TMarcaMap.Create;

  FMap.Entity.id := key;
  FMap.get;//(vmarca, 'id = (:id)');
  vmarca := FMap.Entity;

end;

function TMarca.datalist: TObjectList;
var
  marcas : TMarcaMap.TEntities;
  marcam: TMarcaMap;
  marca: TMarca;
  obl : TObjectList;
begin
 //   if not Assigned(FMap) then
  obl := TObjectList.create;
  marcas:= TMarcaMap.TEntities.create;
  marca := tmarca.create;
  Marcam := TMarcaMap.Create;
  marcam.list(marcas);
  for marca in marcas do
  begin
    obl.Add(marca);
  end;

  result := obl;

    //opf.Entity.Name := '%a%';
    //opf.Find(pers, 'name like (:name)');

end;

function TMarca.datalistasjson(filter: string): TJSONArray;
var
  marcas : TMarcaMap.TEntities;
  marcam: TMarcaMap;
  marca: TMarca;
  VJArray: TJSONArray;
  VJObject: TJSONObject;
  ts: tstrings;
begin
  //try
  ts := tstringlist.create;
  VJObject := TJSONObject.Create;
  VJArray := TJSONArray.Create;
  marcas:= TMarcaMap.TEntities.create;
  marca := tmarca.create;
  Marcam := TMarcaMap.Create;
  //marcam.list(marcas);
  marcam.Entity.nome := '%F%';
  marcam.Find(marcas, 'nome like (:nome)');
  for marca in marcas do
  begin
  VJObject.Clear;
  ObjectToJSON(Marcam.Table.PropList, Marcam.Table.PropCount , marca,
               VJObject, ts);
  VJArray.Add(VJObject.Clone);
  end;
  result :=  tJsonArray(VJArray.Clone);
  // finally
    //VJObject.free;
    //ts.Free;
    //VJArray.Free;
    //marcas.free;
    //marcam.free;
    //marca.free;
 //   end;

end;

{ TMarcaMap }

constructor TMarcaMap.Create;
begin
  inherited Create(dbutils.con, 'marca');
end;

end.

