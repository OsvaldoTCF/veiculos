unit Produto;

{$mode objfpc}{$H+}

interface

//uses
//  Classes, SysUtils;
type
  TProduto = class
    private
    FId: LongInt;
    FDescricao: string;
    public
    published
    property Id: LongInt read Fid write FId;
    property Descricao: string read FDescricao write FDescricao;
  end;

implementation

end.

