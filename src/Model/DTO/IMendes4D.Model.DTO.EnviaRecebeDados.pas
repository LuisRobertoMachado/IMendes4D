unit IMendes4D.Model.DTO.EnviaRecebeDados;

interface

uses
  System.SysUtils,
  System.JSON,
  REST.Json,
  IMendes4D.Model.Interfaces;

type
  TModelEnviaRecebeDadosDTO<T: IInterface> = class(TInterfacedObject,
    iModelEnviaRecebeDadosDTO<T>)
  private
    [weak]
    FParent: iEntity;
    constructor CreatePrivate(Parent: iEntity);
  public
    constructor Create;
    destructor Destroy; override;
    function HistoricoAcesso: iModelHistoricoAcessoDTO<T>;
    function ProdutosAlterados: iModelProdutosAlteradosDTO<T>;
//    function DescrProdutos: iModelDescrProdutos<T>;
    function RemoveDevolvidos: iModelRemoveDevolvidosDTO<T>;
    class function New(Parent: iEntity): iModelEnviaRecebeDadosDTO<T>;
  end;

implementation

uses
  IMendes4D.Model.DTO.HistoricoAcesso,
  IMendes4D.Model.DTO.ProdutosAlterados,
  IMendes4D.Model.DTO.RemoveDevolvidos;


{ TModelEnviaRecebeDadosDTO }

constructor TModelEnviaRecebeDadosDTO<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TModelEnviaRecebeDadosDTO<T>.CreatePrivate(Parent: iEntity);
begin
  inherited Create;
  FParent := Parent;
end;

//function TModelEnviaRecebeDadosDTO<T>.DescrProdutos: iModelDescrProdutos<iModelEnviaRecebeDadosDTO>;
//begin
//
//end;

destructor TModelEnviaRecebeDadosDTO<T>.Destroy;
begin
  inherited;
end;

function TModelEnviaRecebeDadosDTO<T>.HistoricoAcesso: iModelHistoricoAcessoDTO<T>;
begin
  Result := TModelHistoricoAcessoDTO<T>.New(FParent);
end;

class function TModelEnviaRecebeDadosDTO<T>.New(Parent: iEntity): iModelEnviaRecebeDadosDTO<T>;
begin
  result := Self.CreatePrivate(Parent);
end;

function TModelEnviaRecebeDadosDTO<T>.ProdutosAlterados: iModelProdutosAlteradosDTO<T>;
begin
  Result := TModelProdutosAlteradosDTO<T>.New(FParent);
end;
function TModelEnviaRecebeDadosDTO<T>.RemoveDevolvidos: iModelRemoveDevolvidosDTO<T>;
begin
  Result := TModelRemoveDevolvidosDTO<T>.New(FParent);
end;

end.
