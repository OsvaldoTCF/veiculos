unit oficinav;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, LR_DSet, LR_PGrid, LR_View,
  lr_e_pdf, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  Buttons, Grids, fpjson, jsonparser, oficinamap;

type

  { TOficinaFrm }

  TOficinaFrm = class(TForm)
    btnFiltar: TBitBtn;
    btnExcluir: TBitBtn;
    btnIncluir1: TBitBtn;
    btnIncluir2: TBitBtn;
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
    frReport1: TfrReport;
    frTNPDFExport1: TfrTNPDFExport;
    filas: TfrUserDataset;
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
    procedure btnIncluir2Click(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
    procedure filasCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure filasFirst(Sender: TObject);
    procedure filasNext(Sender: TObject);
    procedure stgListaDblClick(Sender: TObject);
    procedure tsListaShow(Sender: TObject);
  private
    fila : longint;
    FMap: TOficinaMap;
    VOficinadb: TOficinadb;
    VOperInsert: Boolean ;
    procedure clearcontrols;
    procedure enablecontrols;
    procedure disablecontrols;
    procedure copyobject2edits;
    procedure copyedits2objects(withid: boolean = false);
    procedure LoadObjectOnControls;
    procedure populategrid(filtrar: boolean = false; filtro: string='');
    { private declarations }
  public
    { public declarations }
  end;

var
  OficinaFrm: TOficinaFrm;

implementation

uses
  LJGridUtils, rutils, fpjsonrtti, MUtils;

{$R *.lfm}

{ TOficinaFrm }

procedure TOficinaFrm.btnExcluirClick(Sender: TObject);
begin
if edId.Text<>'' then
 begin
//  TMCom.comdelete('http://localhost:8080/oficina/',edid.Text);

 FMap.Remove(VOficinadb);
  FMap.Apply;

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
  disablecontrols;
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

procedure TOficinaFrm.btnIncluir2Click(Sender: TObject);
begin
    frReport1.ShowReport
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
 // http: TBrookHttpClient;
begin

if VOperInsert then
 copyedits2objects
 else
 copyedits2objects(true);


//  http := TBrookHttpClient.Create('fclweb');
  st := TStringStream.Create('');
  try

  //with VOficina do
  //begin
  //  form :=  HTTPEncode('nome='+nome)+'&'+
  //           HTTPEncode('contato='+contato)+'&'+
  //           HTTPEncode('telefone='+telefone)+'&'+
  //           HTTPEncode('endereco='+endereco)+'&'+
  //           HTTPEncode('observacao='+observacao);
  //end;
  if VOperInsert then
   begin
   FMap.add(VOficinadb);
   FMap.Apply;
   end
  else
  begin
  FMap.Modify(VOficinadb);
  FMap.Apply;
  end;
    //http.PostForm('http://localhost:8080/oficina', form, st)
    //else
    //begin
    // form := HTTPEncode('id='+inttostr(VOficina.Id))+'&'+form;
    // http.PutForm('http://localhost:8080/oficina', form, st);
    //end;


    memo1.Text := StringReplace(st.DataString, '<br />', LineEnding, [rfReplaceAll]);
  finally
    st.Free;
    //http.Free;
  end;
  tsLista.show;
end;

procedure TOficinaFrm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TOficinaFrm.FormCreate(Sender: TObject);
begin
  FMap := TOficinaMap.Create;
  VOficinadb := TOficinadb.Create;
end;

procedure TOficinaFrm.FormDestroy(Sender: TObject);
begin
     FMap.free;
     VOficinadb.free;
end;

procedure TOficinaFrm.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
    if ParName = 'cliente' then  // customer
    ParValue := 'Brisanet';

  if ParName = 'direccion' then  // address
    ParValue := 'Sei lá';

  if ParName = 'nome' then // product
    ParValue := stgLista.Cells[0, fila];
  if ParName = 'contato' then // price
    ParValue := stgLista.Cells[1, fila];
  if ParName = 'telefone' then // price
    ParValue := stgLista.Cells[2, fila];
  if ParName = 'endereco' then // price
    ParValue := stgLista.Cells[3, fila];
  if ParName = 'observacao' then // price
    ParValue := stgLista.Cells[4, fila];

  if ParName = 'Total' then
    ParValue := '$ ' + 'Edit5.Text';
end;

procedure TOficinaFrm.filasCheckEOF(Sender: TObject; var Eof: Boolean);
begin
    Eof := fila > stgLista.RowCount - 1;
end;

procedure TOficinaFrm.filasFirst(Sender: TObject);
begin
    fila := 1; {fila por la cual empieza. En este caso la 1 porque la 0 es para los títulos}
             {starting row. In this case 1 because row 0 it's for title}

end;

procedure TOficinaFrm.filasNext(Sender: TObject);
begin
    Inc(fila);
end;

procedure TOficinaFrm.stgListaDblClick(Sender: TObject);
begin
  LoadObjectOnControls;
end;

procedure TOficinaFrm.tsListaShow(Sender: TObject);
begin
  populategrid;
end;

procedure TOficinaFrm.clearcontrols;
var
  i: integer;
begin
 For i:=0 to tsRegistro.componentcount -1 do
begin
if (tsRegistro.Components[i] is TEdit) then
(tsRegistro.Components[i] as TEdit).text := '';
end;
  btnSalvar.Enabled:=false;
end;

procedure TOficinaFrm.enablecontrols;
var
  i: integer;
begin
 For i:=0 to tsRegistro.componentcount -1 do
begin
if (tsRegistro.Components[i] is TEdit) then
begin
 if not ((Components[i] as TEdit).Name = 'edId') then
 begin
 (tsRegistro.Components[i] as TEdit).enabled := true;
 (tsRegistro.Components[i] as TEdit).Color:=cldefault;
 end;
 end;
end;

end;

procedure TOficinaFrm.disablecontrols;
var
  i: integer;
begin
 For i:=0 to componentcount -1 do
begin
if (Components[i] is TEdit) then
begin
 if not ((Components[i] as TEdit).Name = 'edId') then
 begin
 (Components[i] as TEdit).enabled := false;
 (Components[i] as TEdit).Color:=clsilver;
 end;
 end;
end;

end;

procedure TOficinaFrm.copyobject2edits;
begin
     with VOficinadb do
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
with VOficinadb do
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

procedure TOficinaFrm.LoadObjectOnControls;
var
  jData: TJSONData;
  VJObject: TJSONObject = nil;
begin

   VJObject := TJsonObject.Create;
   try
   VJObject := (GetSelectedRows(stgLista)).Objects[0];
   tsRegistro.Show;
   mJSONToObject(VJObject, VOficinadb);

   copyobject2edits;

   finally
     VJObject := nil;
     VJObject.free;
   end;

end;

procedure TOficinaFrm.populategrid(filtrar: boolean; filtro: string);
var
      VOficina: TOficinadb;
      VOficinas: TOficinaMap.TEntities;
      VJArray: TJSONArray;
      VJObject: TJSONObject;
      ts: tstrings;
      VParser: TJSONParser;
           arjson: TJSONArray;
begin

     ts := tstringlist.create;
     VJObject := TJSONObject.Create;


      VJArray := TJSONArray.Create;
      VOficinas := TOficinaMap.TEntities.Create;
      try
        FMap.Entity.nome := '%'+edFiltro.text+'%';
        FMap.Find(VOficinas, 'nome like (:nome)');
        for VOficina in VOficinas do
          begin
          VJObject.Clear;
          ObjectToJSON(FMap.Table.PropList, FMap.Table.PropCount , VOficina,
          VJObject, ts);
          VJArray.Add(VJObject.Clone);
          end;
        //////////
//
//
//            VParser := VJArray.AsJSON;
//  try
//    ArJSON := VParser.Parse as TJSONArray;
//  finally
//    VParser.free;
//  end;
  LoadJSON(stgLista , VJArray.Clone);



        ///////////
             finally
              VJObject.free;
              ts.Free;
              VJArray.Free;
            end;
   exit;





//var
//     VParser : TJSONParser;
//     arjson: TJSONArray;
//     uri: string;
//begin
//  //uri := 'http://localhost:8080/oficina';
//  //
//  if filtrar then
//   uri := uri+filtro;
//
//  VParser := TJSONParser.Create(tmcom.comget(uri));
//  try
//    ArJSON := VParser.Parse as TJSONArray;
//  finally
//    VParser.free;
//  end;
//  LoadJSON(stgLista, ArJSON.Clone);
//end;

end;


end.

