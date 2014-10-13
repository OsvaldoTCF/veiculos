unit OficinaRest;

{$mode objfpc}{$H+}

interface

uses
 Classes,
 SysUtils,
 BrookAction,
 fpjson,
 rutils,
 OficinaMap;

type

    { TOficinaAction }

    TOficinaAction = class(specialize TBrookGAction<TOficinadb>)
    private
      FMap: TOficinaMap;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TOficinaMap read FMap;
    end;


implementation

{ TOficinaAction }

constructor TOficinaAction.Create;
begin
  inherited Create;
  FMap := TOficinaMap.Create;
end;

destructor TOficinaAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TOficinaAction.Get;
 var
      VOficina: TOficinadb;
      VOficinas: TOficinaMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
begin

        ts := tstringlist.create;
      VJObject := TJSONObject.Create;


      if Params.Count > 0 then
      begin
      VJArray := TJSONArray.Create;
      VOficinas := TOficinaMap.TEntities.Create;
      try
        FMap.Entity.nome := '%'+Params.Values['nome']+'%';
        FMap.Find(VOficinas, 'nome like (:nome)');
        for VOficina in VOficinas do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VOficina, VJObject,
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
      VOficinas := TOficinaMap.TEntities.Create;
      try
        FMap.List(VOficinas);
        for VOficina in VOficinas do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VOficina, VJObject,
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

procedure TOficinaAction.Post;
begin
  //inherited Post;
  //Entity.Validate;
 // Write(Entity);
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TOficinaAction.Put;
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

procedure TOficinaAction.Delete;
begin
  Entity.Id := StrToIntDef(Variables.Values['id'], 0);
  FMap.Remove(Entity);
  FMap.Apply;
end;

initialization
  TOficinaAction.Register('/oficina');
  TOficinaAction.Register('/oficina/:id');
end.

