unit VeiculoMap;

{$mode objfpc}{$H+}

interface

uses
 dSQLdbBroker,
 dbutils,
 veiculo,
 marca;

type

    { TVeiculoTb }

    TVeiculoTb = class(TVeiculo)
    private
    FMarcId: LongInt;
    public
    published
     property MarcId: LongInt read FMarcId  write FMarcId;
  end;

    { TVeiculoMap }

    TVeiculoMap = class(specialize TdGSQLdbEntityOpf<TVeiculoTb>)
    private
      FMarcaMap: TMarcaMap ;
      FMarcId: LongInt;

    public


      //constructor Create;
      destructor Destroy; override;
      //procedure Adicionar(APedido: TPedido);
      property marcabo: TMarcaMap read FMarcaMap;
    constructor Create; //overload;
    published
       property MarcId: LongInt read FMarcId write FMarcId;

  end;





implementation


{ TVeiculoTb }

destructor TVeiculoMap.Destroy;
begin
  FMarcaMap.free;
  inherited Destroy;
end;

constructor TVeiculoMap.Create;
begin
      inherited Create(dbutils.con, 'veiculo');
     // Query.Field('marcid'). AsTipo := marcid;
      FMarcaMap := TMarcaMap.Create;

end;


end.

