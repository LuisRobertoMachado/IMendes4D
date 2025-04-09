unit IMendes4D.Model.Entity;

interface

uses
  System.SysUtils,
  System.JSON,
  IMendes4D.Model.Interfaces;

type
  TEntity = class(TInterfacedObject, iEntity)
  private
    FJson: string;
    constructor CreatePrivate;
  public
    constructor Create;
    destructor Destroy; override;
    function RegrasFiscais: iModelRegrasFiscaisDTO;
    function EnviaRecebeDados: iModelEnviaRecebeDadosDTO<iEntity>;
    function AsJson(const Value: string): iEntity; Overload;
    function AsJson: string; Overload;
    class function New: iEntity;
  end;

implementation

uses
  IMendes4D.Model.DTO.RegrasFiscais, IMendes4D.Model.DTO.EnviaRecebeDados;

{ TEntity }

function TEntity.AsJson: string;
begin
  Result := FJson;
end;

function TEntity.AsJson(const Value: string): iEntity;
begin
  Result := Self;
  FJson := Value;
end;

constructor TEntity.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TEntity.CreatePrivate;
begin
  inherited Create;

end;

destructor TEntity.Destroy;
begin

  inherited;
end;

function TEntity.EnviaRecebeDados: iModelEnviaRecebeDadosDTO<iEntity>;
begin
  Result := TModelEnviaRecebeDadosDTO<iEntity>.New(Self);
end;

class function TEntity.New: iEntity;
begin
  result := Self.CreatePrivate;
end;

function TEntity.RegrasFiscais: iModelRegrasFiscaisDTO;
begin
  Result := TModelRegrasFiscaisDTO.New(Self);
end;

end.
