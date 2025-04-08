unit IMendes4D.HttpClient.IMendesAPI;

interface

uses
  System.SysUtils,
  IMendes4D.Interfaces,
  IMendes4D.HttpClient.interfaces,
  IMendes4D.HttpClient.RestHttpClient,
  IMendes4D.Auth.Interfaces,
  IMendes4D.Model.Interfaces;

type
  TIMendesAPI = class(TInterfacedObject, iIMendesAPI)
  private
    FHttpClient: iHttpClient;
    constructor CreatePrivate(const Auth: iAuthenticator<IImendes4D>);
  public
    constructor Create;
    destructor Destroy; override;
    function POST: iIMendesAPI;
    function Body(Value: iEntity): iIMendesAPI;
    function Content: string;
    function StatusCode: integer;
    class function New(const Auth: iAuthenticator<IImendes4D>): iIMendesAPI;
  end;

implementation

{ TIMendesAPI }

function TIMendesAPI.Body(Value: iEntity): iIMendesAPI;
begin
  result := Self;
  FHttpClient.Body(Value.AsJson);
end;

function TIMendesAPI.Content: string;
begin
  Result := FHttpClient.Content;
end;

constructor TIMendesAPI.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor TIMendesAPI.CreatePrivate(const Auth: iAuthenticator<IImendes4D>);
begin
  inherited Create;
  FHttpClient :=
    THttpClient
      .New
      .URL(Auth.URL)
      .Headers('login', Auth.User)
      .Headers('senha',Auth.Password);
end;

destructor TIMendesAPI.Destroy;
begin

  inherited;
end;

class function TIMendesAPI.New(const Auth: iAuthenticator<IImendes4D>): iIMendesAPI;
begin
  result := Self.CreatePrivate(Auth);
end;

function TIMendesAPI.POST: iIMendesAPI;
begin
  result := Self;
  FHttpClient.POST;
end;

function TIMendesAPI.StatusCode: integer;
begin
  Result := FHttpClient.StatusCode;
end;

end.
