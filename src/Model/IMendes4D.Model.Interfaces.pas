unit IMendes4D.Model.Interfaces;

interface

type
  iModelCabecalhoDTO<T> = interface
  ['{E4046F91-AC58-4BE6-B399-0BD5C4C4857F}']
    function CNPJ(const Value: string): iModelCabecalhoDTO<T>;
    function cnae(const Value: string): iModelCabecalhoDTO<T>;
    function CRT(Value: integer): iModelCabecalhoDTO<T>;
    function CodFaixa(Value: integer): iModelCabecalhoDTO<T>;
    function Regime(Value: char): iModelCabecalhoDTO<T>;
    function Ambiente(Value: Integer): iModelCabecalhoDTO<T>;
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
//    function CodigoImendes(Value: integer): iModelProdutoDTO<T>;
    function Descricao(const Value: string): iModelProdutoDTO<T>;
//    function Refeicao(value: Char): iModelProdutoDTO<T>;
//    function TipoCodigo(value: integer): iModelProdutoDTO<T>;
    function NCM(const Value: string): iModelProdutoDTO<T>;
    function Next: iModelProdutoDTO<T>;
    function &End: T;
  end;

  iEntity = interface
  ['{F0A5F422-F5B8-4A84-96B9-F65ABC8E1B98}']
    function AsJson: string;
    function Cabecalho: iModelCabecalhoDTO<iEntity>;
    function UFs: iModelUFDTO<iEntity>;
    function Produtos: iModelProdutoDTO<iEntity>;
  end;

implementation

end.
