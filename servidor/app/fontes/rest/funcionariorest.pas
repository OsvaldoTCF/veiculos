unit FuncionarioRest;

{$mode objfpc}{$H+}

interface

uses
 Classes,
 SysUtils,
 BrookAction,
 fpjson,
 rutils,
 FuncionarioMap;

type

    { TOperadorAction }

    TOperadorAction = class(specialize TBrookGAction<TOperadordb>)
    private
      FMap: TOperadorMap;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TOperadorMap read FMap;
    end;


    { TMotoristaAction }

    TMotoristaAction = class(specialize TBrookGAction<TMotoristadb>)
    private
      FMap: TMotoristaMap;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TMotoristamap read FMap;
    end;


implementation

{ TOperadorAction }

constructor TOperadorAction.Create;
begin
  inherited Create;
  FMap := TOperadorMap.Create;
end;

destructor TOperadorAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TOperadorAction.Get;
 var
      VOperador: TOperadordb;
      VOperadores: TOperadorMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
    begin
      ts := tstringlist.create;
      VJObject := TJSONObject.Create;
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
      VOperadores := TOperadorMap.TEntities.Create;
      try
        FMap.List(VOperadores);
        for VOperador in VOperadores do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VOperador, VJObject,
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

procedure TOperadorAction.Post;
begin
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TOperadorAction.Put;
begin
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TOperadorAction.Delete;
begin
  Entity.Id := StrToIntDef(Variables.Values['id'], 0);
  FMap.Remove(Entity);
  FMap.Apply;
end;

constructor TMotoristaAction.Create;
begin
  inherited Create;
  FMap := TMotoristaMap.Create;
end;

destructor TMotoristaAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TMotoristaAction.Get;
 var
      VMotorista: TMotoristadb;
      VMotoristas: TMotoristaMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
    begin
      ts := tstringlist.create;
      VJObject := TJSONObject.Create;
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
      VMotoristas := TMotoristaMap.TEntities.Create;
      try
        FMap.List(VMotoristas);
        for VMotorista in VMotoristas do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VMotorista, VJObject,
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

procedure TMotoristaAction.Post;
begin
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TMotoristaAction.Put;
begin
  FMap.Modify(Entity);
  FMap.Apply;
end;

procedure TMotoristaAction.Delete;
begin
  Entity.Id := StrToIntDef(Variables.Values['id'], 0);
  FMap.Remove(Entity);
  FMap.Apply;
end;


initialization
  TMotoristaAction.Register('/motorista');
  TMotoristaAction.Register('/motorista/:id');
  TOperadorAction.Register('/operador');
  TOperadorAction.Register('/operador/:id');
end.

