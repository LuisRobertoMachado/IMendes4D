unit IMendes4D.Auth.Authenticator;

interface

uses
  System.SysUtils,
  IMendes4D.Interfaces,
  IMendes4D.Auth.Interfaces;

type
  TAuthenticator<T: IInterface> = class(TInterfacedObject, iAuthenticator<T>)
  private
    [weak]
    FParent: IImendes4D;
    FURL: string;
    FUser: string;
    FPassword: string;
    constructor CreatePrivate(Parent: IImendes4D);
  public
    constructor Create;
    destructor Destroy; override;
    function URL(const Value: string): iAuthenticator<T>; Overload;
    function URL: string; Overload;
    function User(const Value: string): iAuthenticator<T>; Overload;
    function User: string; Overload;
    function Password(const Value: string): iAuthenticator<T>; Overload;
    function Password: string; Overload;
    function &End: T;
    class function New(Parent: IImendes4D): iAuthenticator<T>;
  end;

implementation

{ TAuthenticator }

function TAuthenticator<T>.&End: T;
begin
  Result := FParent;
end;

constructor TAuthenticator<T>.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TAuthenticator<T>.CreatePrivate(Parent: IImendes4D);
begin
  inherited Create;
  FParent := Parent;
end;

destructor TAuthenticator<T>.Destroy;
begin

  inherited;
end;

class function TAuthenticator<T>.New(Parent: IImendes4D): iAuthenticator<T>;
begin
  result := Self.CreatePrivate(Parent);
end;

function TAuthenticator<T>.Password(const Value: string): iAuthenticator<T>;
begin
  Result := Self;
  FPassword := Value;
end;

function TAuthenticator<T>.Password: string;
begin
  Result := FPassword;
end;

function TAuthenticator<T>.URL(const Value: string): iAuthenticator<T>;
begin
  Result := Self;
  FURL := Value;
end;

function TAuthenticator<T>.URL: string;
begin
  Result := FURL;
end;

function TAuthenticator<T>.User(const Value: string): iAuthenticator<T>;
begin
  Result := Self;
  FUser := Value;
end;

function TAuthenticator<T>.User: string;
begin
  Result := FUser;
end;

end.
