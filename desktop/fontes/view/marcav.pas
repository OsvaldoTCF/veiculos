unit marcav;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, RTTICtrls, RTTIGrids, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Grids, ExtCtrls, Marca, contnrs, LJGridUtils;

type

  { TMarcaFrm }

  TMarcaFrm = class(TForm)
    Button2: TButton;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
    FMarca: TMarca;
  public
    { public declarations }
  published
     property Marca: TMarca read FMarca write FMarca;
  end;

var
  MarcaFrm: TMarcaFrm;

implementation

{$R *.lfm}

{ TMarcaFrm }

procedure TMarcaFrm.Button1Click(Sender: TObject);
begin
  //if not Assigned(FMarca) then
  //FMarca := TMarca.create;
  //FMarca.dataload(Fmarca,strtoint(edit1.text));
  //NomeEdit.Link.TIObject := Marca;
  //NomeEdit.Link.TIPropertyName := 'Nome';
  //IdEdit.Link.TIObject := Marca;
  //IdEdit.Link.TIPropertyName := 'Id';
end;

procedure TMarcaFrm.Button2Click(Sender: TObject);
//var
//  obl : TObjectList;
begin
  //obl:= TObjectList.create;
  //
  //obl := (FMarca.datalist) as TObjectList;
  //
  //ShowMessage(inttostr(obl.Count));
  //
  //grid.ListObject := (obl);
  //grid.ReloadTIList;

  LoadJSON(StringGrid1,FMarca.datalistasjson('F'));

end;

end.

