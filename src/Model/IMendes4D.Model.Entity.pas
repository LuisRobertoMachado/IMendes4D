unit IMendes4D.Model.Entity;

interface

uses
  System.SysUtils,
  System.JSON,
  IMendes4D.Model.Interfaces;

type
  TEntity = class(TInterfacedObject, iEntity)
  private
    FJson: TJsonObject;
    constructor CreatePrivate;
  public
    constructor Create;
    destructor Destroy; override;
    function AsJson: string;
    function Cabecalho: iModelCabecalhoDTO<iEntity>;
    function UFs: iModelUFDTO<iEntity>;
    function Produtos: iModelProdutoDTO<iEntity>;
    class function New: iEntity;
  end;

implementation

uses
  IMendes4D.Model.DTO.Cabecalho,
  IMendes4D.Model.DTO.UF,
  IMendes4D.Model.DTO.Produto;

{ TEntity }

function TEntity.AsJson: string;
begin
  Result := FJson.ToString;
end;

function TEntity.Cabecalho: iModelCabecalhoDTO<iEntity>;
begin
  result := TModelCabecalhoDTO<iEntity>.New(Self, FJSon);
end;

constructor TEntity.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TEntity.CreatePrivate;
begin
  inherited Create;
  FJson := TJSONObject.Create;
end;

destructor TEntity.Destroy;
begin
  FJson.Free;
  inherited;
end;

class function TEntity.New: iEntity;
begin
  result := Self.CreatePrivate;
end;

function TEntity.Produtos: iModelProdutoDTO<iEntity>;
begin
  Result := TModelProdutoDTO<iEntity>.New(Self, FJSon);
end;

function TEntity.UFs: iModelUFDTO<iEntity>;
begin
  result := TModelUFDTO<iEntity>.New(Self, FJSon);
end;

end.
