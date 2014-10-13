unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  oficinav, funcionariov;

type

  { TTelaiFrm }

  TTelaiFrm = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  TelaiFrm: TTelaiFrm;

implementation


{$R *.lfm}


{ TTelaiFrm }

procedure TTelaiFrm.MenuItem6Click(Sender: TObject);
begin
  close;
end;

procedure TTelaiFrm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:= false;
  if QuestionDlg('Confirmação', 'Deseja terminar a aplicação?', mtWarning,
  [mrYes, 'Sim', mrNo, 'Não', mrCancel, 'Cancelar'], 0) = mrYes then
  CanClose:=true;

end;

procedure TTelaiFrm.MenuItem2Click(Sender: TObject);
begin
  // oficina

  OficinaFrm := TOficinaFrm.create(application);
  try
    OficinaFrm.ShowModal;
  finally
    FreeAndNil(OficinaFrm);
  end;
end;

procedure TTelaiFrm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   Application.Terminate;
end;

procedure TTelaiFrm.MenuItem3Click(Sender: TObject);
begin
  //funcionario

  FuncionarioFrm := TFuncionarioFrm.Create(application);
  try
   FuncionarioFrm.ShowModal;
  finally
    FreeAndNil(FuncionarioFrm);
  end;

end;

procedure TTelaiFrm.MenuItem4Click(Sender: TObject);
begin
  // produto

end;

procedure TTelaiFrm.MenuItem5Click(Sender: TObject);
begin
 // pedido
end;

end.

