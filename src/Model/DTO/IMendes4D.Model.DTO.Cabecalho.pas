unit IMendes4D.Model.DTO.Cabecalho;

interface

uses
  System.SysUtils,
  System.JSON,
  IMendes4D.Model.Interfaces;

type
  TModelCabecalhoDTO<T: IInterface> = class(TInterfacedObject,
    iModelCabecalhoDTO<T>)
  private
    [weak]
    FParent: iModelRegrasFiscaisDTO;
    FJsonPair: TJSONObject;
    FJson: TJSONObject;
    constructor CreatePrivate(Parent: iModelRegrasFiscaisDTO; JSON: TJSONObject);
  public
    constructor Create;
    destructor Destroy; override;
    function CNPJ(const Value: string): iModelCabecalhoDTO<T>;
    function cnae(const Value: string): iModelCabecalhoDTO<T>;
    function CRT(Value: integer): iModelCabecalhoDTO<T>;
    function CodFaixa(Value: integer): iModelCabecalhoDTO<T>;
    function Regime(Value: char): iModelCabecalhoDTO<T>;
    function Ambiente(Value: integer): iModelCabecalhoDTO<T>;
    function Contribuinte(Value: integer): iModelCabecalhoDTO<T>;
    function &End: T;
    class function New(Parent: iModelRegrasFiscaisDTO; JSON: TJSONObject)
      : iModelCabecalhoDTO<T>;
  end;

implementation

{ TModelCabecalhoDTO }

function TModelCabecalhoDTO<T>.&End: T;
begin
  Result := FParent;
  FJsonPair.AddPair('cabecalho', FJson);
end;

function TModelCabecalhoDTO<T>.Ambiente(Value: integer): iModelCabecalhoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('amb', Value.ToString);
end;

function TModelCabecalhoDTO<T>.cnae(const Value: string): iModelCabecalhoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('cnae', Value);
end;

function TModelCabecalhoDTO<T>.CNPJ(const Value: string): iModelCabecalhoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('cnpj', Value);
end;

function TModelCabecalhoDTO<T>.CodFaixa(Value: integer): iModelCabecalhoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('codFaixa', Value.ToString);
end;

function TModelCabecalhoDTO<T>.Contribuinte(Value: integer)
  : iModelCabecalhoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('contribuinte', Value.ToString);
end;

constructor TModelCabecalhoDTO<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelCabecalhoDTO<T>.CreatePrivate(Parent: iModelRegrasFiscaisDTO;
  JSON: TJSONObject);
begin
  FParent := Parent;
  FJsonPair := JSON;
  FJson := TJSONObject.Create;
end;

function TModelCabecalhoDTO<T>.CRT(Value: integer): iModelCabecalhoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('crt', Value.ToString);
end;

destructor TModelCabecalhoDTO<T>.Destroy;
begin
//  FJson.Free;
  inherited;
end;

class function TModelCabecalhoDTO<T>.New(Parent: iModelRegrasFiscaisDTO; JSON: TJSONObject)
  : iModelCabecalhoDTO<T>;
begin
  Result := Self.CreatePrivate(Parent, JSON);
end;

function TModelCabecalhoDTO<T>.Regime(Value: char): iModelCabecalhoDTO<T>;
begin
  Result := Self;
  FJson.AddPair('regimeTrib', Value);
end;

end.
