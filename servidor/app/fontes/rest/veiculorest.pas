unit VeiculoRest;

{$mode objfpc}{$H+}

interface

uses
 Classes,
 SysUtils,
 BrookAction,
 fpjson,
 rutils,
 VeiculoMap;

type

    { TVeiculoAction }

    TVeiculoAction = class(specialize TBrookGAction<TVeiculodb>)
    private
      FMap: TVeiculoMap;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TVeiculoMap read FMap;
    end;


implementation

{ TVeiculoAction }

constructor TVeiculoAction.Create;
begin
  inherited Create;
  FMap := TVeiculoMap.Create;
end;

destructor TVeiculoAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TVeiculoAction.Get;
 var
      VVeiculo: TVeiculodb;
      VVeiculos: TVeiculoMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
begin

        ts := tstringlist.create;
      VJObject := TJSONObject.Create;


      if Params.Count > 0 then
      begin
      VJArray := TJSONArray.Create;
      VVeiculos := TVeiculoMap.TEntities.Create;
      try
        FMap.Entity.identificacao := '%'+Params.Values['identificacao']+'%';
        FMap.Find(VVeiculos, 'identificacao like (:nome)');
        for VVeiculo in VVeiculos do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VVeiculo, VJObject,
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
      VVeiculos := TVeiculoMap.TEntities.Create;
      try
        FMap.List(VVeiculos);
        for VVeiculo in VVeiculos do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VVeiculo, VJObject,
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

procedure TVeiculoAction.Post;
begin
  //inherited Post;
  //Entity.Validate;
 // Write(Entity);
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TVeiculoAction.Put;
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

procedure TVeiculoAction.Delete;
begin
  Entity.Id := StrToIntDef(Variables.Values['id'], 0);
  FMap.Remove(Entity);
  FMap.Apply;
end;

initialization
  TVeiculoAction.Register('/veiculo');
  TVeiculoAction.Register('/veiculo/:id');
end.

