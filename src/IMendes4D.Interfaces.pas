unit IMendes4D.Interfaces;

interface

uses
  IMendes4D.Auth.Interfaces,
  IMendes4D.HttpClient.Interfaces,
  IMendes4D.Model.Interfaces;

type
  iIMendes4D = interface
  ['{49A73739-C0FC-4580-B790-3C445D7044B8}']
    function Auth: iAuthenticator<iIMendes4D>;
    function Entity: iEntity;
    function Resources: iIMendesAPI;
  end;

implementation

end.
