unit MUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, Sysutils, FPJSON, JSONParser, fpjsonrtti;

Function ProcStringToJSData(St : String) : TJSonData ;



///////////////

function ObjectToJSON(AObject: TObject): TJSONObject;
procedure JSONToObject(AJSON: TJSONObject; AObject: TObject);

implementation

function ObjectToJSON(AObject: TObject): TJSONObject;
var
  VStreamer: TJSONStreamer;
begin
  VStreamer := TJSONStreamer.Create(nil);
  try
    try
      Result := VStreamer.ObjectToJSON(AObject);
    except
      FreeAndNil(Result);
      raise;
    end;
  finally
    VStreamer.Free;
  end;
end;

procedure JSONToObject(AJSON: TJSONObject; AObject: TObject);
var
  VDeStreamer: TJSONDeStreamer;
begin
  VDeStreamer := TJSONDeStreamer.Create(nil);
  try
    VDeStreamer.CaseInsensitive := True;
    VDeStreamer.JSONToObject(AJSON, AObject);
  finally
    VDeStreamer.Free;
  end;
end;


///////////////

Function ProcStringToJSData(St : String) : TJSonData ;

Var
  S : TStream;
  P : TJSONParser;
  D : TJSONData;
begin
  S:=TStringStream.Create(St);
  try
    P:=TJSONParser.Create(S);
    try
      D:=P.Parse;
    finally
      P.Free;
    end;
  finally
    S.Free;
  end;
  result := D;
//  FreeAndNil(AJSON);

end;




    {
      [{ "mac" : "00:27:22:90:6F:F0", "name" : "cjzufcgar3b", "lastip" : "172.16.197.233",
      "associd" : 8, "aprepeater" : 0, "tx" : 130, "rx" : 130, "signal" : -57, "ccq" : 91,
      "idle" : 0, "uptime" : 196959, "ack" : 27, "distance" : 750, "txpower" : 30,
      "noisefloor" : -94, "airmax" : { "priority" : 3, "quality" : 0, "beam" : 255,
      "signal" : -96, "capacity" : 0 },
      "stats" : { "rx_data" : 4692135, "rx_bytes" : 4286755229, "rx_pps" : 1,
      "tx_data" : 3389920, "tx_bytes" : 1245374602, "tx_pps" : 0 },
      "rates" : ["MCS0", "MCS1", "MCS2", "MCS3", "MCS4", "MCS5", "MCS6", "MCS7",
      "MCS8", "MCS9", "MCS10", "MCS11", "MCS12", "MCS13", "MCS14", "MCS15"],
      "signals" : [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }]

    }

    //{ AP Info }
    //Str.Add((( ajson.Items[1] as tjsonobject).Strings['apmac']));
    //Str.Add((( ajson.Items[1] as tjsonobject).Strings['essid']));
    //
    //
    //{ Estação Info }
    //Str.Add((( ajson.Items[0] as tjsonobject).Strings['hostname']));
    //
    //
    //Str.Add((( ajson.Items[6].Items[3] as tjsonobject).Strings['hwaddr']));
    //
    //if (( ajson.Items[6].Items[1].Items[3] as tjsonobject).Booleans['plugged']) then
    //Str.Add('Ligado')
    //else
    //Str.Add('Desligado');
    //
    //tc := StrToInt(( ajson.Items[0] as tjsonobject).Strings['uptime']);
    //tcm := tc div 60;
    //if tcm >= 60 then
    //begin
    //tch := tcm div 60;
    //tcm := tcm mod 60;
    //Str.Add(inttostr(tch)+':'+ inttostr(tcm)+' h');
    //end
    //else
    //Str.Add(inttostr(tcm)+' m');
    //





end.

