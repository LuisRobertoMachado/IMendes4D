unit IMendes4D.Model.DTO.RegrasFiscais;

interface

uses
  System.SysUtils,
  System.JSON,
  REST.Json,
  IMendes4D.Model.Interfaces;

type
  TModelRegrasFiscaisDTO = class(TInterfacedObject, iModelRegrasFiscaisDTO)
  private
    [weak]
    FParent: iEntity;
    FJson: TJsonObject;
    constructor CreatePrivate(Parent: iEntity);
  public
    constructor Create;
    destructor Destroy; override;
    function Cabecalho: iModelCabecalhoDTO<iModelRegrasFiscaisDTO>;
    function UFs: iModelUFDTO<iModelRegrasFiscaisDTO>;
    function Produtos: iModelProdutoDTO<iModelRegrasFiscaisDTO>;
    function &End: iEntity;
    class function New(Parent: iEntity): iModelRegrasFiscaisDTO;
  end;

implementation

uses
  IMendes4D.Model.DTO.Cabecalho,
  IMendes4D.Model.DTO.UF,
  IMendes4D.Model.DTO.Produto;

{ TModelRegrasFiscaisDTO }

function TModelRegrasFiscaisDTO.&End: iEntity;
begin
  Result := FParent.AsJson(FJSON.ToJSON);
end;

function TModelRegrasFiscaisDTO.Cabecalho: iModelCabecalhoDTO<iModelRegrasFiscaisDTO>;
begin
  result := TModelCabecalhoDTO<iModelRegrasFiscaisDTO>.New(Self, FJSon);
end;

constructor TModelRegrasFiscaisDTO.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelRegrasFiscaisDTO.CreatePrivate(Parent: iEntity);
begin
  inherited Create;
  FParent := Parent;
  FJson := TJSONObject.Create;
end;

destructor TModelRegrasFiscaisDTO.Destroy;
begin
  FJson.Free;
  inherited;
end;

class function TModelRegrasFiscaisDTO.New(Parent: iEntity): iModelRegrasFiscaisDTO;
begin
  result := Self.CreatePrivate(Parent);
end;

function TModelRegrasFiscaisDTO.Produtos: iModelProdutoDTO<iModelRegrasFiscaisDTO>;
begin
  Result := TModelProdutoDTO<iModelRegrasFiscaisDTO>.New(Self, FJSon);
end;

function TModelRegrasFiscaisDTO.UFs: iModelUFDTO<iModelRegrasFiscaisDTO>;
begin
  result := TModelUFDTO<iModelRegrasFiscaisDTO>.New(Self, FJSon);
end;

end.
