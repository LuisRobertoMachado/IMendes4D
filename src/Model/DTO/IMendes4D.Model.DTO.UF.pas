unit IMendes4D.Model.DTO.UF;

interface

uses
  System.SysUtils,
  System.JSON,
  IMendes4D.Model.Interfaces;

type
  TModelUFDTO<T: IInterface> = class(TInterfacedObject, iModelUFDTO<T>)
  private
    [weak]
    FParent: iEntity;
    FJsonPair: TJsonObject;
    FJson: TJsonArray;
    constructor CreatePrivate(const Parent: iEntity; JSON: TJsonObject);
  public
    constructor Create;
    destructor Destroy; override;
    function Sigla(const Value: string): iModelUFDTO<T>;
    function Next: iModelUFDTO<T>;
    function &End: T;
    class function New(const Parent: iEntity; JSON: TJsonObject)
      : iModelUFDTO<T>;
  end;

implementation

{ TModelUFDTO }

function TModelUFDTO<T>.&End: T;
begin
  Result := FParent;
  FJsonPair.AddPair('uf', FJson);
end;

constructor TModelUFDTO<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelUFDTO<T>.CreatePrivate(const Parent: iEntity;
  JSON: TJsonObject);
begin
  FParent := Parent;
  FJsonPair := JSON;
  FJson := TJsonArray.Create;
end;

destructor TModelUFDTO<T>.Destroy;
begin

  inherited;
end;

class function TModelUFDTO<T>.New(const Parent: iEntity; JSON: TJsonObject)
  : iModelUFDTO<T>;
begin
  Result := Self.CreatePrivate(Parent, JSON);
end;

function TModelUFDTO<T>.Next: iModelUFDTO<T>;
begin
  Result := Self;
end;

function TModelUFDTO<T>.Sigla(const Value: string): iModelUFDTO<T>;
begin
  Result := Self;
  FJson.Add(Value);
end;

end.
