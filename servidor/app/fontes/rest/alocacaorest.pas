unit AlocacaoRest;

{$mode objfpc}{$H+}

interface

uses
 Classes,
 SysUtils,
 BrookAction,
 fpjson,
 rutils,
 AlocacaoMap;

type

    { TAlocacaoAction }

    TAlocacaoAction = class(specialize TBrookGAction<TAlocacaodb>)
    private
      FMap: TAlocacaoMap;
    public
      constructor Create; overload; override;
      destructor Destroy; override;
      procedure Get; override;
      procedure Post; override;
      procedure Put; override;
      procedure Delete; override;
      property Map: TAlocacaoMap read FMap;
    end;


implementation

{ TAlocacaoAction }

constructor TAlocacaoAction.Create;
begin
  inherited Create;
  FMap := TAlocacaoMap.Create;
end;

destructor TAlocacaoAction.Destroy;
begin
  FMap.free;
  inherited Destroy;
end;

procedure TAlocacaoAction.Get;
 var
      VAlocacao: TAlocacaodb;
      VAlocacaos: TAlocacaoMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
begin

        ts := tstringlist.create;
      VJObject := TJSONObject.Create;


      if Params.Count > 0 then
      begin
      VJArray := TJSONArray.Create;
      VAlocacaos := TAlocacaoMap.TEntities.Create;
      try
        FMap.Entity.Finalidade := '%'+Params.Values['finalidade']+'%';
        FMap.Find(VAlocacaos, 'finalidade like (:finalidade)');
        for VAlocacao in VAlocacaos do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VAlocacao, VJObject,
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
      VAlocacaos := TAlocacaoMap.TEntities.Create;
      try
        FMap.List(VAlocacaos);
        for VAlocacao in VAlocacaos do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VAlocacao, VJObject,
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

procedure TAlocacaoAction.Post;
begin
  //inherited Post;
  //Entity.Validate;
 // Write(Entity);
  FMap.Add(Entity);
  FMap.Apply;
end;

procedure TAlocacaoAction.Put;
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

procedure TAlocacaoAction.Delete;
begin
  Entity.Id := StrToIntDef(Variables.Values['id'], 0);
  FMap.Remove(Entity);
  FMap.Apply;
end;

initialization
  TAlocacaoAction.Register('/alocacao');
  TAlocacaoAction.Register('/alocacao/:id');
end.

