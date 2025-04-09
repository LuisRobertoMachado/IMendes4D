unit IMendes4D.Model.DTO.RemoveDevolvidos.Produtos;

interface

uses
  System.SysUtils,
  System.JSON,
  IMendes4D.Model.Interfaces;

type
  TModelRemoveDevolvidosProdutosDTO<T: IInterface> = class(TInterfacedObject,
    iModelRemoveDevolvidosProdutosDTO<T>)
  private
    [weak]
    FParent: T;
    FJsonPair: TJSONObject;
    FJsonArrayProdutos: TJSONArray;
    FJson: TJSONObject;
    constructor CreatePrivate(const Parent: T;
      const JSON: TJSONObject);
  public
    constructor Create;
    destructor Destroy; override;
    function ID(const Value: Int64): iModelRemoveDevolvidosProdutosDTO<T>;
    function Next: iModelRemoveDevolvidosProdutosDTO<T>;
    function &End: T;
    class function New(const Parent: T; const JSON: TJSONObject)
      : iModelRemoveDevolvidosProdutosDTO<T>;
  end;

implementation

{ TModelRemoveDevolvidosProdutosDTO<T> }

function TModelRemoveDevolvidosProdutosDTO<T>.&End: T;
begin
  Result := FParent;
  FJsonArrayProdutos.AddElement(FJson);
  FJsonPair.AddPair('produtos', FJsonArrayProdutos);
end;

constructor TModelRemoveDevolvidosProdutosDTO<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelRemoveDevolvidosProdutosDTO<T>.CreatePrivate
  (const Parent: T; const JSON: TJSONObject);
begin
  inherited Create;
  FParent := Parent;
  FJsonPair := JSON;
  FJsonArrayProdutos := TJSONArray.Create;
  FJson := TJSONObject.Create;
end;

destructor TModelRemoveDevolvidosProdutosDTO<T>.Destroy;
begin

  inherited;
end;

function TModelRemoveDevolvidosProdutosDTO<T>.ID(
  const Value: Int64): iModelRemoveDevolvidosProdutosDTO<T>;
begin
  Result := Self;
  FJson.AddPair('id', TJSONNumber.Create(Value));
end;

class function TModelRemoveDevolvidosProdutosDTO<T>.New(const Parent: T;
  const JSON: TJSONObject): iModelRemoveDevolvidosProdutosDTO<T>;
begin
  result := Self.CreatePrivate(Parent, JSON);
end;

function TModelRemoveDevolvidosProdutosDTO<T>.Next: iModelRemoveDevolvidosProdutosDTO<T>;
begin
  Result := Self;
  FJsonArrayProdutos.AddElement(FJson);
  FJson := TJSONObject.Create;
end;

end.
