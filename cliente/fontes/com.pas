unit com;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rutils, fpjson;

type

  { TMCom }

  TMCom = class

    private

    public
    class function comget(url:string):string;
    class function compost(url, sdata:string):boolean;
    class function comput(url, sdata:string):boolean;
    class function comdelete(url, sdata:string):boolean;
  end;

implementation

uses
  BrookHttpClient, HTTPDefs;

{ TMCom }

class function TMCom.comget(url: string): string;
var
  st: TStringStream;
  http: TBrookHttpClient;

begin
  http := TBrookHttpClient.Create('fclweb');
  st := TStringStream.Create('');
  try
    http.Get(url, st);
    result := st.DataString;
  finally
    st.Free;
    http.Free;
  end;
end;

class function TMCom.compost(url, sdata: string): boolean;
var
  encdata, nome, form, s: string;
  st: TStringStream;
  http: TBrookHttpClient;
begin
  nome := '';
  http := TBrookHttpClient.Create('fclweb');
  st := TStringStream.Create('');
  try
    form := HTTPEncode(sdata);
    result :=  http.PostForm(Url, form, st);
    s := StringReplace(st.DataString, '<br />', LineEnding, [rfReplaceAll]);
    //ShowMessage(s);
  finally
    st.Free;
    http.Free;
  end;
end;

class function TMCom.comput(url, sdata:string):boolean;
var
  s, form, d1, d2: string;
  st: TStringStream;
  http: TBrookHttpClient;
begin
  http := TBrookHttpClient.Create('fclweb');
  st := TStringStream.Create('');
  form := HTTPEncode(sdata);
  try
    result := http.PutForm(url, form, st);
    s := StringReplace(st.DataString, '<br />', LineEnding, [rfReplaceAll]);
  //  ShowMessage(s);
  finally
    st.Free;
    http.Free;
  end;
end;

class function TMCom.comdelete(url, sdata:string):boolean;
var
  st: TStringStream;
  http: TBrookHttpClient;
  uri: string;
begin
  uri := url+sdata;
  http := TBrookHttpClient.Create('fclweb');
  st := TStringStream.Create('');
  try
    result :=  http.Delete(uri, st);
    //ShowMessage(st.DataString);
  finally
    st.Free;
    http.Free;
  end;
end;

end.

