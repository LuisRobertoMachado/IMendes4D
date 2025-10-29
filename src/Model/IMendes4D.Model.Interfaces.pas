unit IMendes4D.Model.Interfaces;

interface

uses
  System.JSON;

type
  iEntity = interface;

  iModelCabecalhoDTO<T> = interface
    ['{E4046F91-AC58-4BE6-B399-0BD5C4C4857F}']
    function CNPJ(const Value: string): iModelCabecalhoDTO<T>;
    function cnae(const Value: string): iModelCabecalhoDTO<T>;
    function CRT(Value: integer): iModelCabecalhoDTO<T>;
    function CodFaixa(Value: integer): iModelCabecalhoDTO<T>;
    function Regime(Value: char): iModelCabecalhoDTO<T>;
    function Ambiente(Value: integer): iModelCabecalhoDTO<T>;
    function Contribuinte(Value: integer): iModelCabecalhoDTO<T>;
    function &End: T;
  end;

  iModelUFDTO<T> = interface
    ['{97A355F2-A607-4AD4-B6CF-1F00FE85E3A0}']
    function Sigla(const Value: string): iModelUFDTO<T>;
    function Next: iModelUFDTO<T>;
    function &End: T;
  end;

  iModelProdutoDTO<T> = interface
    ['{5CB105CA-190D-4513-94EA-003E9331F5F6}']
    function Codigo(const Value: string): iModelProdutoDTO<T>;
    // function CodigoImendes(Value: integer): iModelProdutoDTO<T>;
    function Descricao(const Value: string): iModelProdutoDTO<T>;
    // function Refeicao(value: Char): iModelProdutoDTO<T>;
    function TipoCodigo(value: integer): iModelProdutoDTO<T>;
    function NCM(const Value: string): iModelProdutoDTO<T>;
    function Next: iModelProdutoDTO<T>;
    function &End: T;
  end;

  iModelRegrasFiscaisDTO = interface
    ['{ACC93F7C-249B-4FCB-9F0E-601083F6A191}']
    function Cabecalho: iModelCabecalhoDTO<iModelRegrasFiscaisDTO>;
    function UFs: iModelUFDTO<iModelRegrasFiscaisDTO>;
    function Produtos: iModelProdutoDTO<iModelRegrasFiscaisDTO>;
    function &End: iEntity;
  end;

  iModelProdutosAlteradosDTO<T> = interface
    ['{B18585E2-ABD0-48F3-9F1A-B8F978525019}']
    function CNPJ(const Value: string): iModelProdutosAlteradosDTO<T>;
    function UF(const Value: string): iModelProdutosAlteradosDTO<T>;
    function Limite(const Value: integer): iModelProdutosAlteradosDTO<T>;
    function &End: T;
  end;

//  iModelDescrProdutos<T> = interface
//    ['{E363CAE7-E9A9-43D8-895B-256AE4CCA8A5}']
//  end;

  iModelHistoricoAcessoDTO<T> = interface
    ['{A272E9C3-EAE2-4229-90E6-EA5152073452}']
    function CNPJ(const Value: string): iModelHistoricoAcessoDTO<T>;
    function &End: T;
  end;


  iModelRemoveDevolvidosProdutosDTO<T> = interface
    ['{4E7520AE-7726-4EAA-BD68-E88A55691E39}']
    function ID(const Value: Int64): iModelRemoveDevolvidosProdutosDTO<T>;
    function Next: iModelRemoveDevolvidosProdutosDTO<T>;
    function &End: T;
  end;

  iModelRemoveDevolvidosDTO<T> = interface
    ['{4E7520AE-7726-4EAA-BD68-E88A55691E39}']
    function CNPJ(const Value: string): iModelRemoveDevolvidosDTO<T>;
    function Produtos: iModelRemoveDevolvidosProdutosDTO<iModelRemoveDevolvidosDTO<T>>;
    function &End: T;
  end;

  iModelEnviaRecebeDadosDTO<T> = interface
    ['{71BF3C75-EB9C-49F0-AE91-B51D25DC65FD}']
    function HistoricoAcesso: iModelHistoricoAcessoDTO<T>;
    function ProdutosAlterados: iModelProdutosAlteradosDTO<T>;
//    function DescrProdutos: iModelDescrProdutos<iEntity>;
    function RemoveDevolvidos: iModelRemoveDevolvidosDTO<T>;
  end;

  iEntity = interface
    ['{F0A5F422-F5B8-4A84-96B9-F65ABC8E1B98}']
    function RegrasFiscais: iModelRegrasFiscaisDTO;
    function EnviaRecebeDados: iModelEnviaRecebeDadosDTO<iEntity>;
    function AsJson(const Value: string): iEntity; Overload;
    function AsJson: string; Overload;
  end;

implementation

end.
