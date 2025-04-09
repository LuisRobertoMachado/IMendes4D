unit IMendes4D.Model.DTO.RemoveDevolvidos;

interface

uses
  System.SysUtils,
  System.JSON,
  IMendes4D.Model.Interfaces;

type
  TModelRemoveDevolvidosDTO<T: IInterface> = class(TInterfacedObject,
    iModelRemoveDevolvidosDTO<T>)
  private
    [weak]
    FParent: iEntity;
    FJson: TJSONObject;
    FJsonPair: TJSONObject;
    constructor CreatePrivate(const Parent: iEntity);
  public
    constructor Create;
    destructor Destroy; override;
    function CNPJ(const Value: string): iModelRemoveDevolvidosDTO<T>;
    function Produtos: iModelRemoveDevolvidosProdutosDTO<iModelRemoveDevolvidosDTO<T>>;
    function &End: T;
    class function New(const Parent: iEntity): iModelRemoveDevolvidosDTO<T>;
  end;

implementation

uses
  IMendes4D.Model.DTO.RemoveDevolvidos.Produtos;

{ TModelRemoveDevolvidosDTO<T> }

function TModelRemoveDevolvidosDTO<T>.CNPJ(
  const Value: string): iModelRemoveDevolvidosDTO<T>;
begin
  Result := Self;
  FJson.AddPair('cnpj', Value);
end;

function TModelRemoveDevolvidosDTO<T>.&End: T;
begin
  FJsonPair.AddPair('nomeServico', 'REMOVEDEVOLVIDOS');
  FJsonPair.AddPair('dados', TJSONString.Create(FJson.ToJSON));
  Result := FParent.AsJson(FJsonPair.Tojson);
end;

constructor TModelRemoveDevolvidosDTO<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelRemoveDevolvidosDTO<T>.CreatePrivate(const Parent: iEntity);
begin
  inherited Create;
  FParent := Parent;
  FJson := TJSONObject.Create;
  FJsonPair := TJSONObject.Create;
end;

destructor TModelRemoveDevolvidosDTO<T>.Destroy;
begin
  FJson.Free;
  FJsonPair.Free;
  inherited;
end;

class function TModelRemoveDevolvidosDTO<T>.New(const Parent: iEntity)
  : iModelRemoveDevolvidosDTO<T>;
begin
  result := Self.CreatePrivate(Parent);
end;

function TModelRemoveDevolvidosDTO<T>.Produtos: iModelRemoveDevolvidosProdutosDTO<iModelRemoveDevolvidosDTO<T>>;
begin
//  Result := TModelRemoveDevolvidosProdutosDTO<T>.New(Self, FJSon);
  Result := TModelRemoveDevolvidosProdutosDTO < iModelRemoveDevolvidosDTO < T >>
    .New(Self, FJson);
end;

end.
