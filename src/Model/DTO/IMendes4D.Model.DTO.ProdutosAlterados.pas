unit IMendes4D.Model.DTO.ProdutosAlterados;

interface

uses
  System.SysUtils,
  System.JSON,
  IMendes4D.Model.Interfaces;

type
  TModelProdutosAlteradosDTO<T: IInterface> = class(TInterfacedObject,
    iModelProdutosAlteradosDTO<T>)
  private
    [weak]
    FParent: iEntity;
    FJson: TJsonObject;
    constructor CreatePrivate(const Parent: iEntity);
  public
    constructor Create;
    destructor Destroy; override;
    function CNPJ(const Value: string): iModelProdutosAlteradosDTO<T>;
    function &End: T;
    class function New(const Parent: iEntity): iModelProdutosAlteradosDTO<T>;
  end;

implementation

{ TModelProdutosAlteradosDTO }

function TModelProdutosAlteradosDTO<T>.CNPJ(const Value: string)
  : iModelProdutosAlteradosDTO<T>;
begin
  Result := Self;
  FJson.AddPair('dados', Value);
end;

function TModelProdutosAlteradosDTO<T>.&End: T;
begin
  FJson.AddPair('nomeServico', 'ALTERADOS');
  Result := FParent.AsJson(FJson.Tojson);
end;

constructor TModelProdutosAlteradosDTO<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelProdutosAlteradosDTO<T>.CreatePrivate(const Parent: iEntity);
begin
  inherited Create;
  FParent := Parent;
  FJson := TJSONObject.Create;
end;

destructor TModelProdutosAlteradosDTO<T>.Destroy;
begin
  FJson.Free;
  inherited;
end;

class function TModelProdutosAlteradosDTO<T>.New(const Parent: iEntity)
  : iModelProdutosAlteradosDTO<T>;
begin
  Result := Self.CreatePrivate(Parent);
end;

end.
