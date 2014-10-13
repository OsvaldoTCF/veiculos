unit Raiz;

{$mode objfpc}{$H+}

interface

uses
  BrookAction;

type

  { TMyAction }

  TMyAction = class(TBrookAction)
  public
    procedure Get; override;
  end;

implementation

{ TMyAction }

procedure TMyAction.Get;
begin
  //write(self.TheRequest.URI);
  Write('Sistema de Controle de Frota');
end;

initialization
  TMyAction.Register('/');
  TMyAction.Register('/teste');

end.
