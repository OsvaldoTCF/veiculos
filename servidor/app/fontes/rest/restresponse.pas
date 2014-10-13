unit RestResponse;

{$mode objfpc}{$H+}

interface

uses
 Classes,
 SysUtils,
 BrookAction,
 fpjson,
 rutils,
 Funcionario,
 FuncionarioMap;

type

    { TOperadorAction }

    TOperadorAction = class(specialize TBrookGAction<TOperador>)
    private
      FMap: TOperadordb;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TOperadordb read FMap;
    end;


    { TMotoristaAction }

    TMotoristaAction = class(specialize TBrookGAction<TMotorista>)
    private
      FMap: TMotoristadb;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TMotoristadb read FMap;
    end;


implementation

{ TOperadorAction }

constructor TOperadorAction.Create;
begin
  inherited Create;
  FMap := TOperadordb.Create;
end;

destructor TOperadorAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TOperadorAction.Get;
 var
      VFuncionario: TFuncionario;
      VFuncionarios: TOperadordb.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
    begin
      ts := tstringlist.create;
      VJObject := TJSONObject.Create;
      if Values.Values['id'] <> '' then
      begin
        FMap.Entity.Id := StrToIntDef(Values.Values['id'], 0);
        FMap.Get;
        VJObject.Clear;
        ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , FMap.Entity, VJObject,
        ts);
        Write(VJObject.AsJSON);
      end
      else
      begin

      VJArray := TJSONArray.Create;
      VFuncionarios := TOperadordb.TEntities.Create;
      try
        FMap.List(VFuncionarios);
        for VFuncionario in VFuncionarios do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VFuncionario, VJObject,
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
  //inherited Post;
  //Entity.Validate;
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TOperadorAction.Put;
begin
  inherited Put;
end;

procedure TOperadorAction.Delete;
begin
  inherited Delete;
end;

constructor TMotoristaAction.Create;
begin
  inherited Create;
  FMap := TMotoristadb.Create;
end;

destructor TMotoristaAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TMotoristaAction.Get;
 var
      VFuncionario: TFuncionario;
      VFuncionarios: TMotoristadb.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
    begin
      ts := tstringlist.create;
      VJObject := TJSONObject.Create;
      if Values.Values['id'] <> '' then
      begin
        FMap.Entity.Id := StrToIntDef(Values.Values['id'], 0);
        FMap.Get;
        VJObject.Clear;
        ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , FMap.Entity, VJObject,
        ts);
        Write(VJObject.AsJSON);
      end
      else
      begin

      VJArray := TJSONArray.Create;
      VFuncionarios := TMotoristadb.TEntities.Create;
      try
        FMap.List(VFuncionarios);
        for VFuncionario in VFuncionarios do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VFuncionario, VJObject,
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
 // inherited Post;
  //Entity.Validate;
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TMotoristaAction.Put;
begin
  inherited Put;
end;

procedure TMotoristaAction.Delete;
begin
  inherited Delete;
end;


initialization
  TMotoristaAction.Register('/motorista');
  TMotoristaAction.Register('/motorista/:id');
  TOperadorAction.Register('/operador');
  TOperadorAction.Register('/operador/:id');
end.

