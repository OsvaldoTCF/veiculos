unit oficinav;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, Grids, com, fpjson, jsonparser, oficina;

type

  { TOficinaFrm }

  TOficinaFrm = class(TForm)
    btnFiltar: TBitBtn;
    btnExcluir: TBitBtn;
    btnIncluir1: TBitBtn;
    btnSalvar: TBitBtn;
    btnEditar: TBitBtn;
    btnCancelar: TBitBtn;
    btnIncluir: TBitBtn;
    Edit1: TEdit;
    edFiltro: TEdit;
    edId: TEdit;
    edNome: TEdit;
    edContato: TEdit;
    edTelefone: TEdit;
    edEndereco: TEdit;
    edObservacao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    stgLista: TStringGrid;
    tsLista: TTabSheet;
    tsRegistro: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFiltarClick(Sender: TObject);
    procedure btnIncluir1Click(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure stgListaDblClick(Sender: TObject);
    procedure tsListaShow(Sender: TObject);
  private
    VOficina: TOficina;
    VOperInsert: Boolean ;
    procedure clearcontrols;
    procedure enablecontrols;
    procedure copyobject2edits;
    procedure copyedits2objects(withid: boolean = false);
    procedure lll;
    procedure populategrid(filtrar: boolean = false; filtro: string='');
    { private declarations }
  public
    { public declarations }
  end;

var
  OficinaFrm: TOficinaFrm;

implementation

uses
  LJGridUtils, rutils, fpjsonrtti, MUtils, BrookHttpClient, HTTPDefs;

{$R *.lfm}

{ TOficinaFrm }

procedure TOficinaFrm.btnExcluirClick(Sender: TObject);
begin
if edId.Text<>'' then
 begin
  TMCom.comdelete('http://localhost:8080/oficina/',edid.Text);
  tsLista.show;
 end;
end;

procedure TOficinaFrm.btnFiltarClick(Sender: TObject);
begin
  populategrid(true,edfiltro.Text);
end;

procedure TOficinaFrm.btnCancelarClick(Sender: TObject);
begin
  clearcontrols;
    tsLista.Show;
end;

procedure TOficinaFrm.btnEditarClick(Sender: TObject);
begin
  enablecontrols;
  edNome.SetFocus;
  btnSalvar.Enabled:=true;
  VOperInsert:=false;
end;

procedure TOficinaFrm.btnIncluir1Click(Sender: TObject);
begin
  tsRegistro.Show;
  btnIncluirClick(sender);
end;

procedure TOficinaFrm.btnIncluirClick(Sender: TObject);
begin
  clearcontrols;
  enablecontrols;
  edid.Enabled:=false;
  edNome.SetFocus;
  btnSalvar.Enabled:=true;
  VOperInsert:=true;
end;

procedure TOficinaFrm.btnSalvarClick(Sender: TObject);
var
  nome, form: string;
  st: TStringStream;
  http: TBrookHttpClient;
begin

if VOperInsert then
 copyedits2objects
 else
 copyedits2objects(true);


  http := TBrookHttpClient.Create('fclweb');
  st := TStringStream.Create('');
  try

  with VOficina do
  begin
    form :=  HTTPEncode('nome='+nome)+'&'+
             HTTPEncode('contato='+contato)+'&'+
             HTTPEncode('telefone='+telefone)+'&'+
             HTTPEncode('endereco='+endereco)+'&'+
             HTTPEncode('observacao='+observacao);
  end;
  if VOperInsert then
    http.PostForm('http://localhost:8080/oficina', form, st)
    else
    begin
     form := HTTPEncode('id='+inttostr(VOficina.Id))+'&'+form;
     http.PutForm('http://localhost:8080/oficina', form, st);
    end;


    memo1.Text := StringReplace(st.DataString, '<br />', LineEnding, [rfReplaceAll]);
  finally
    st.Free;
    http.Free;
  end;
  tsLista.show;
end;

procedure TOficinaFrm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TOficinaFrm.FormCreate(Sender: TObject);
begin
  VOficina := TOficina.Create;
end;

procedure TOficinaFrm.FormDestroy(Sender: TObject);
begin
  VOficina.free;
end;

procedure TOficinaFrm.stgListaDblClick(Sender: TObject);
begin
  lll;
end;

procedure TOficinaFrm.tsListaShow(Sender: TObject);
begin
  populategrid;
end;

procedure TOficinaFrm.clearcontrols;
var
  i: integer;
begin
 For i:=0 to componentcount -1 do
begin
if (Components[i] is TEdit) then
(Components[i] as TEdit).text := '';
end;
  btnSalvar.Enabled:=false;
end;

procedure TOficinaFrm.enablecontrols;
var
  i: integer;
begin
 For i:=0 to componentcount -1 do
begin
if (Components[i] is TEdit) then
begin
 if not ((Components[i] as TEdit).Name = 'edId') then
 begin
 (Components[i] as TEdit).enabled := true;
 (Components[i] as TEdit).Color:=cldefault;
 end;
 end;
end;

end;

procedure TOficinaFrm.copyobject2edits;
begin
     with VOficina do
   begin
     edid.Text:=inttostr(id);
     edNome.Text:=nome;
     edContato.Text:=contato;
     edTelefone.Text:=telefone;
     edEndereco.Text:=endereco;
     edObservacao.Text:=observacao;
   end;
end;

procedure TOficinaFrm.copyedits2objects(withid: boolean = false);
begin
with VOficina do
begin
if withid then
id := strtoint(edid.Text);
nome := edNome.Text;
contato := edContato.Text;
telefone := edTelefone.Text;
endereco := edEndereco.Text;
observacao := edObservacao.Text;
end;

end;

procedure TOficinaFrm.lll;
var
  jData: TJSONData;
  VJObject: TJSONObject = nil;
begin

   VJObject := TJsonObject.Create;
   try
   VJObject := (GetSelectedRows(stgLista)).Objects[0];
   tsRegistro.Show;
   JSONToObject(VJObject, VOficina);

   copyobject2edits;

   finally
     VJObject := nil;
     VJObject.free;
   end;

end;

procedure TOficinaFrm.populategrid(filtrar: boolean; filtro: string);
var
     VParser : TJSONParser;
     arjson: TJSONArray;
     uri: string;
begin
  uri := 'http://localhost:8080/oficina';

  if filtrar then
   uri := uri+filtro;

  VParser := TJSONParser.Create(tmcom.comget(uri));
  try
    ArJSON := VParser.Parse as TJSONArray;
  finally
    VParser.free;
  end;
  LoadJSON(stgLista, ArJSON.Clone);
end;

end.

