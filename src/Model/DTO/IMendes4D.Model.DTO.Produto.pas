unit IMendes4D.Model.DTO.Produto;

interface

uses
  System.SysUtils,
  System.JSON,
  IMendes4D.Model.Interfaces;

type
  TModelProdutoDTO<T: IInterface> = class(TInterfacedObject,
    iModelProdutoDTO<T>)
  private
    [weak]
    FParent: iEntity;
    FJsonPair: TJSONObject;
    FJsonArrayProdutos: TJSONArray;
    FJson: TJSONObject;
    constructor CreatePrivate(const Parent: iEntity; const JSON: TJSONObject);
  public
    constructor Create;
    destructor Destroy; override;
    function Codigo(const Value: string): iModelProdutoDTO<T>;
    function CodigoImendes(Value: integer): iModelProdutoDTO<T>;
    function Descricao(const Value: string): iModelProdutoDTO<T>;
    function Refeicao(value: Char): iModelProdutoDTO<T>;
    function TipoCodigo(value: integer): iModelProdutoDTO<T>;
    function NCM(const Value: string): iModelProdutoDTO<T>;    
    function Next: iModelProdutoDTO<T>;
    function &End: T;
    class function New(const Parent: iEntity; const JSON: TJSONObject)
      : iModelProdutoDTO<T>;
  end;

implementation

{ TModelProdutoDTO<T> }

function TModelProdutoDTO<T>.&End: T;
begin
  Result := FParent;
  FJsonArrayProdutos.AddElement(FJson);
  FJsonPair.AddPair('produto', FJsonArrayProdutos);
end;

function TModelProdutoDTO<T>.Codigo(const Value: string): iModelProdutoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('codigo', Value);
end;

function TModelProdutoDTO<T>.CodigoImendes(Value: integer): iModelProdutoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('codIMendes', Value.ToString);
end;

constructor TModelProdutoDTO<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelProdutoDTO<T>.CreatePrivate(const Parent: iEntity;
  const JSON: TJSONObject);
begin
  FParent := Parent;
  FJsonPair := JSON;
  FJsonArrayProdutos := TJSONArray.Create;
  FJson := TJSONObject.Create;
end;

function TModelProdutoDTO<T>.Descricao(
  const Value: string): iModelProdutoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('descricao', Value);
end;

destructor TModelProdutoDTO<T>.Destroy;
begin

  inherited;
end;

function TModelProdutoDTO<T>.NCM(const Value: string): iModelProdutoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('nCM', Value);
end;

class function TModelProdutoDTO<T>.New(const Parent: iEntity;
  const JSON: TJSONObject): iModelProdutoDTO<T>;
begin
  Result := Self.CreatePrivate(Parent, JSON);
end;

function TModelProdutoDTO<T>.Next: iModelProdutoDTO<T>;
begin
  Result := Self;
  FJsonArrayProdutos.AddElement(FJson);
  FJson := TJSONObject.Create;
end;

function TModelProdutoDTO<T>.Refeicao(value: Char): iModelProdutoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('refeicao', Value);
end;

function TModelProdutoDTO<T>.TipoCodigo(value: integer): iModelProdutoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('tipoCodigo', Value.ToString);
end;

end.
