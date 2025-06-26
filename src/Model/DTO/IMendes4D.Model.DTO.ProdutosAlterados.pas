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
    FCNPJ: string;
    FUF: string;
    FLimite: string;
    constructor CreatePrivate(const Parent: iEntity);
    function MontarDados: string;
    procedure AddDados(const Value: string; var StrDestino: string);
  public
    constructor Create;
    destructor Destroy; override;
    function CNPJ(const Value: string): iModelProdutosAlteradosDTO<T>;
    function UF(const Value: string): iModelProdutosAlteradosDTO<T>;
    function Limite(const Value: integer): iModelProdutosAlteradosDTO<T>;
    function &End: T;
    class function New(const Parent: iEntity): iModelProdutosAlteradosDTO<T>;
  end;

implementation

{ TModelProdutosAlteradosDTO }

procedure TModelProdutosAlteradosDTO<T>.AddDados(const Value: string; var StrDestino: string);
begin
  if not StrDestino.IsEmpty then
    StrDestino := StrDestino + '|';
  StrDestino := StrDestino + Value;
end;

function TModelProdutosAlteradosDTO<T>.MontarDados: string;
begin
  Result := EmptyStr;
  if not FCNPJ.IsEmpty then
    AddDados(FCNPJ, Result);
  if not FUF.IsEmpty then
    AddDados(FUF, Result);
  if not FLimite.IsEmpty then
    AddDados(FLimite, Result);
end;

function TModelProdutosAlteradosDTO<T>.CNPJ(const Value: string)
  : iModelProdutosAlteradosDTO<T>;
begin
  Result := Self;
  FCNPJ := Value;
end;

function TModelProdutosAlteradosDTO<T>.&End: T;
begin
  FJson.AddPair('nomeServico', 'ALTERADOS');
  FJson.AddPair('dados', MontarDados);
  Result := FParent.AsJson(FJson.Tojson);
end;

function TModelProdutosAlteradosDTO<T>.Limite(
  const Value: integer): iModelProdutosAlteradosDTO<T>;
begin
  Result := self;
  if Value > 0 then
    FLimite := IntToStr(Value);
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

function TModelProdutosAlteradosDTO<T>.UF(
  const Value: string): iModelProdutosAlteradosDTO<T>;
begin
  Result := Self;
  FUF := Value;
end;

end.
