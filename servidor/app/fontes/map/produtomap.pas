unit ProdutoMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 Produto;

type
    TProdutodb = class(TProduto)
    private
    public
    published
  end;

    { TProdutoMap }

    TProdutoMap = class(specialize TdGSQLdbEntityOpf<TProdutodb>)

  public
    constructor Create; overload;
  end;



implementation

{ TOperadordb }

constructor TProdutoMap.Create;
begin
      inherited Create(dbutils.con, 'produto');
end;


end.

