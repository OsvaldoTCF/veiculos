unit ProdutoRest;

{$mode objfpc}{$H+}

interface

uses
 Classes,
 SysUtils,
 BrookAction,
 fpjson,
 rutils,
 ProdutoMap;

type

    { TProdutoAction }

    TProdutoAction = class(specialize TBrookGAction<TProdutodb>)
    private
      FMap: TProdutoMap;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TProdutoMap read FMap;
    end;


implementation

{ TProdutoAction }

constructor TProdutoAction.Create;
begin
  inherited Create;
  FMap := TProdutoMap.Create;
end;

destructor TProdutoAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TProdutoAction.Get;
 var
      VProduto: TProdutodb;
      VProdutos: TProdutoMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
begin

        ts := tstringlist.create;
      VJObject := TJSONObject.Create;


      if Params.Count > 0 then
      begin
      VJArray := TJSONArray.Create;
      VProdutos := TProdutoMap.TEntities.Create;
      try
        FMap.Entity.descricao := '%'+Params.Values['descricao']+'%';
        FMap.Find(VProdutos, 'descricao like (:descricao)');
        for VProduto in VProdutos do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VProduto, VJObject,
           ts);
          VJArray.Add(VJObject.Clone);
          end;
          Write(VJArray.AsJSON);

             finally
              VJObject.free;
              ts.Free;
              VJArray.Free;
            end;
   exit;
  end;


      if Variables.Values['id'] <> '' then
      begin
        FMap.Entity.Id := StrToIntDef(Variables.Values['id'], 0);
        FMap.Get;
        VJObject.Clear;
        ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , FMap.Entity, VJObject,
        ts);
        Write(VJObject.AsJSON);
      end
      else
      begin

      VJArray := TJSONArray.Create;
      VProdutos := TProdutoMap.TEntities.Create;
      try
        FMap.List(VProdutos);
        for VProduto in VProdutos do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VProduto, VJObject,
           ts);
          VJArray.Add(VJObject.Clone);
          end;
          Write(VJArray.AsJSON);

             finally
              VJObject.free;
              ts.Free;
              VJArray.Free;
            end;
      end;
end;

procedure TProdutoAction.Post;
begin
  //inherited Post;
  //Entity.Validate;
 // Write(Entity);
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TProdutoAction.Put;
begin
  //with Entity do
  //begin
  //id := StrToIntDef(Values.Values['id'], 0);
  //shortname := Variables.Values['shortname'];
  //end;
  //Entity.Validate;
  //Write(Entity);
  FMap.Modify(Entity);
  FMap.Apply;
end;

procedure TProdutoAction.Delete;
begin
  Entity.Id := StrToIntDef(Variables.Values['id'], 0);
  FMap.Remove(Entity);
  FMap.Apply;
end;

initialization
  TProdutoAction.Register('/produto');
  TProdutoAction.Register('/roduto/:id');
end.

