unit IMendes4D.Model.DTO.HistoricoAcesso;

interface

uses
  System.SysUtils,
  System.JSON,
  REST.JSON,
  IMendes4D.Model.Interfaces;

type
  TModelHistoricoAcessoDTO<T: IInterface> = class(TInterfacedObject,
    iModelHistoricoAcessoDTO<T>)
  private
    [weak]
    FParent: iEntity;
    FJson: TJSONObject;
    constructor CreatePrivate(Parent: iEntity);
  public
    constructor Create;
    destructor Destroy; override;
    function CNPJ(const Value: string): iModelHistoricoAcessoDTO<T>;
    function &End: T;
    class function New(Parent: iEntity): iModelHistoricoAcessoDTO<T>;
  end;

implementation

{ TModelHistoricoAcessoDTO }

function TModelHistoricoAcessoDTO<T>.CNPJ(
  const Value: string): iModelHistoricoAcessoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('dados', Value);
end;

function TModelHistoricoAcessoDTO<T>.&End: T;
begin
  FJson.AddPair('nomeServico', 'HISTORICOACESSO');
  Result := FParent.AsJson(FJson.Tojson);
end;

constructor TModelHistoricoAcessoDTO<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelHistoricoAcessoDTO<T>.CreatePrivate(Parent: iEntity);
begin
  inherited Create;
  FParent := Parent;
  FJson := TJSONObject.Create;
end;

destructor TModelHistoricoAcessoDTO<T>.Destroy;
begin
  FJson.Free;
  inherited;
end;

class function TModelHistoricoAcessoDTO<T>.New(Parent: iEntity)
  : iModelHistoricoAcessoDTO<T>;
begin
  result := Self.CreatePrivate(Parent);
end;

end.
