unit IMendes4D.Types;

interface

uses
  TypInfo,
  SysUtils;

type
  TEndpointBaseType = (REGRASFISCAIS, ENVIARECEBEDADOS);

  TEndpointBaseTypeHelper = record helper for TEndpointBaseType
    function GetValue : String;
  end;

implementation

{ TEndpointBaseTypeHelper }

function TEndpointBaseTypeHelper.GetValue: String;
begin
  case Self of
    REGRASFISCAIS: Result := 'RegrasFiscais';
    ENVIARECEBEDADOS: Result := 'EnviaRecebeDados';
  end;
end;

end.
