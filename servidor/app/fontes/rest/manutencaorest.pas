unit ManutencaoRest;

{$mode objfpc}{$H+}

interface

uses
 Classes,
 SysUtils,
 BrookAction,
 fpjson,
 rutils,
 ManutencaoMap;

type

    { TManutencaoAction }

    TManutencaoAction = class(specialize TBrookGAction<TManutdb>)
    private
      FMap: TManutencaoMap;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TManutencaoMap read FMap;
    end;


implementation

{ TManutencaoAction }

constructor TManutencaoAction.Create;
begin
  inherited Create;
  FMap := TManutencaoMap.Create;
end;

destructor TManutencaoAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TManutencaoAction.Get;
 var
      VManutencao: TManutdb;
      VManutencaos: TManutencaoMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
begin

        ts := tstringlist.create;
      VJObject := TJSONObject.Create;


      if Params.Count > 0 then
      begin
      VJArray := TJSONArray.Create;
      VManutencaos := TManutencaoMap.TEntities.Create;
      try
        FMap.Entity.id := strtoint(Params.Values['id']);
        FMap.Find(VManutencaos, 'id = (:id)');
        for VManutencao in VManutencaos do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VManutencao, VJObject,
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
      VManutencaos := TManutencaoMap.TEntities.Create;
      try
        FMap.List(VManutencaos);
        for VManutencao in VManutencaos do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VManutencao, VJObject,
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

procedure TManutencaoAction.Post;
begin
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TManutencaoAction.Put;
begin
  FMap.Modify(Entity);
  FMap.Apply;
end;

procedure TManutencaoAction.Delete;
begin
  Entity.Id := StrToIntDef(Variables.Values['id'], 0);
  FMap.Remove(Entity);
  FMap.Apply;
end;

initialization
  TManutencaoAction.Register('/manutencao');
  TManutencaoAction.Register('/manutencao/:id');
  TManutencaoAction.Register('/manutencao/:id/produto');
  TManutencaoAction.Register('/manutencao/:id/produto/:id');
end.

