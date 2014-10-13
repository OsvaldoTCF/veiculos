unit BusinessObject;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils,
fpjson, fpjsonrtti, jsonparser;

type
  TBusinessObject = class(TPersistent)
    private
    public
      //constructor Create;  virtual; abstract;
      //destructor Destroy;   virtual; abstract;
      //procedure datasave;    virtual; abstract;
      //procedure dataload(key: longint);  virtual; abstract;
      //procedure datadelete;   virtual; abstract;
      //procedure datafind(filter: string);   virtual; abstract;
      //function datalistasjson(filter: string): TJSONArray;    virtual; abstract;
    published
  end;

implementation

end.

