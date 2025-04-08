unit IMendes4D;

interface

uses
  System.SysUtils,
  IMendes4D.Interfaces,
  IMendes4D.Auth.Interfaces,
  IMendes4D.Auth.Authenticator,
  IMendes4D.HttpClient.Interfaces,
  IMendes4D.HttpClient.IMendesAPI,
  IMendes4D.Model.Interfaces,
  IMendes4D.Model.Entity;

type
  TIMendes4D = class(TInterfacedObject, iIMendes4D)
  private
    FAuth: iAuthenticator<iImendes4D>;
    constructor CreatePrivate;
  public
    constructor Create;
    destructor Destroy; override;
    function Auth: iAuthenticator<iImendes4D>;
    function Entity: iEntity;
    function Resources: iIMendesAPI;
    class function New: iIMendes4D;
  end;

implementation

{ TIMendes4D }

function TIMendes4D.Auth: iAuthenticator<iImendes4D>;
begin
  if not Assigned(FAuth) then
    FAuth := TAuthenticator<iImendes4D>.New(Self);
  Result := FAuth;
end;

constructor TIMendes4D.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TIMendes4D.CreatePrivate;
begin
  inherited Create;
end;

destructor TIMendes4D.Destroy;
begin

  inherited;
end;

function TIMendes4D.Entity: iEntity;
begin
  Result := TEntity.New;
end;

class function TIMendes4D.New: iIMendes4D;
begin
  result := Self.CreatePrivate;
end;

function TIMendes4D.Resources: iIMendesAPI;
begin
  Result := TIMendesAPI.New(Self.Auth);
end;

end.
