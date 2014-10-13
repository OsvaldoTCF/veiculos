unit veiculov;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, LR_DSet, LR_PGrid, LR_View,
  lr_e_pdf, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  Buttons, Grids, fpjson, jsonparser, Marca, veiculo;

type

  { TVeiculoFrm }

  TVeiculoFrm = class(TForm)
    btnFiltar: TBitBtn;
    btnExcluir: TBitBtn;
    btnIncluir1: TBitBtn;
    btnIncluir2: TBitBtn;
    btnSalvar: TBitBtn;
    btnEditar: TBitBtn;
    btnCancelar: TBitBtn;
    btnIncluir: TBitBtn;
    cbMarca: TComboBox;
    edKilometragem: TEdit;
    edAno: TEdit;
    Edit1: TEdit;
    edFiltro: TEdit;
    edId: TEdit;
    edPlaca: TEdit;
    edModelo: TEdit;
    edrenavan: TEdit;
    edCnhClasse: TEdit;
    edIdentificacao: TEdit;
    frReport1: TfrReport;
    frTNPDFExport1: TfrTNPDFExport;
    filas: TfrUserDataset;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
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
    FMap: TVeiculoMap;
    VVeiculo: TVeiculo;
    VOperInsert: Boolean ;
    procedure clearcontrols;
    procedure enablecontrols;
    procedure disablecontrols;
    procedure copyobject2edits;
    procedure copyedits2objects(withid: boolean = false);
    procedure LoadObjectOnControls;
    procedure populategrid(filtrar: boolean = false; filtro: string='');
    procedure populateMarcaBox;
    { private declarations }
  public
    { public declarations }
  end;

var
  VeiculoFrm: TVeiculoFrm;

implementation

uses
  LJGridUtils, rutils, fpjsonrtti, MUtils;

{$R *.lfm}

{ TVeiculoFrm }

procedure TVeiculoFrm.btnExcluirClick(Sender: TObject);
begin
if edId.Text<>'' then
 begin

 FMap.Remove(VVeiculo);
  FMap.Apply;

  tsLista.show;
 end;
end;

procedure TVeiculoFrm.btnFiltarClick(Sender: TObject);
begin
  populategrid(true,edfiltro.Text);
end;

procedure TVeiculoFrm.btnCancelarClick(Sender: TObject);
begin
  clearcontrols;
  disablecontrols;
    tsLista.Show;
end;

procedure TVeiculoFrm.btnEditarClick(Sender: TObject);
begin
  enablecontrols;
  edPlaca.SetFocus;
  btnSalvar.Enabled:=true;
  VOperInsert:=false;
end;

procedure TVeiculoFrm.btnIncluir1Click(Sender: TObject);
begin
  tsRegistro.Show;
  btnIncluirClick(sender);
end;

procedure TVeiculoFrm.btnIncluir2Click(Sender: TObject);
begin
    frReport1.ShowReport
end;

procedure TVeiculoFrm.btnIncluirClick(Sender: TObject);
begin
  clearcontrols;
  enablecontrols;
  edid.Enabled:=false;
  edPlaca.SetFocus;
  btnSalvar.Enabled:=true;
  VOperInsert:=true;
end;

procedure TVeiculoFrm.btnSalvarClick(Sender: TObject);
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

  if VOperInsert then
   begin
   FMap.add(VVeiculo);
   FMap.Apply;
   end
  else
  begin
  FMap.Modify(VVeiculo);
  FMap.Apply;
  end;


    memo1.Text := StringReplace(st.DataString, '<br />', LineEnding, [rfReplaceAll]);
  finally
    st.Free;
    //http.Free;
  end;
  tsLista.show;
end;

procedure TVeiculoFrm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TVeiculoFrm.FormCreate(Sender: TObject);
begin
  VVeiculo := TVeiculo.Create;
  populateMarcaBox;
end;

procedure TVeiculoFrm.FormDestroy(Sender: TObject);
begin
     FMap.free;
     VVeiculo.free;
end;

procedure TVeiculoFrm.frReport1GetValue(const ParName: String;
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

procedure TVeiculoFrm.filasCheckEOF(Sender: TObject; var Eof: Boolean);
begin
    Eof := fila > stgLista.RowCount - 1;
end;

procedure TVeiculoFrm.filasFirst(Sender: TObject);
begin
    fila := 1; {fila por la cual empieza. En este caso la 1 porque la 0 es para los títulos}
             {starting row. In this case 1 because row 0 it's for title}

end;

procedure TVeiculoFrm.filasNext(Sender: TObject);
begin
    Inc(fila);
end;

procedure TVeiculoFrm.stgListaDblClick(Sender: TObject);
begin
  LoadObjectOnControls;
end;

procedure TVeiculoFrm.tsListaShow(Sender: TObject);
begin
  populategrid;
end;

procedure TVeiculoFrm.clearcontrols;
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

procedure TVeiculoFrm.enablecontrols;
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

procedure TVeiculoFrm.disablecontrols;
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

procedure TVeiculoFrm.copyobject2edits;
begin
     with VVeiculo do
   begin
     edid.Text:=inttostr(id);
     edPlaca.Text:=placa;
     edModelo.Text:=modelo;
     edrenavan.Text:=renavan;
     edCnhClasse.Text:=CnhClasse;
     edIdentificacao.Text:=Identificacao;
   end;
end;

procedure TVeiculoFrm.copyedits2objects(withid: boolean = false);
begin
with VVeiculo do
begin
if withid then
id := strtoint(edid.Text);
placa := edPlaca.Text;
modelo := edModelo.Text;
renavan := edrenavan.Text;
CnhClasse := edCnhClasse.Text;
Identificacao := edIdentificacao.Text;
end;

end;

procedure TVeiculoFrm.LoadObjectOnControls;
var
  jData: TJSONData;
  VJObject: TJSONObject = nil;
begin

   VJObject := TJsonObject.Create;
   try
   VJObject := (GetSelectedRows(stgLista)).Objects[0];
   tsRegistro.Show;
   mJSONToObject(VJObject, VVeiculo);

   copyobject2edits;

   finally
     VJObject := nil;
     VJObject.free;
   end;

end;

procedure TVeiculoFrm.populategrid(filtrar: boolean; filtro: string);
begin

end;

procedure TVeiculoFrm.populateMarcaBox;
//var
//      VMarca: TMarcadb;
//      VMarcas: TMarcaMap.TEntities;
//      MMap: TMarcaMap;
begin
     //MMap := TMarcaMap.Create;
     //VMarcas := TMarcaMap.TEntities.Create;
     //MMap.List(VMarcas);
     //   for VMarca in VMarcas do
     //     begin
     //       cbMarca.Items.Add(VMarca.Nome);
     //     end;
end;


end.

