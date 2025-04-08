unit IMendes4D.HttpClient.RestHttpClient;

interface

uses
  System.SysUtils,
  REST.Client,
  REST.Types,
  IMendes4D.HttpClient.Interfaces;

type
  THttpClient = class(TInterfacedObject, iHttpClient)
  private
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    FRestResponse: TRESTResponse;
    FBody : String;
    constructor CreatePrivate;
    procedure DoBeforeExecute;
    procedure SetRestClient;
    Procedure SetRestRequest;
    procedure SetRestResponse;
  public
    constructor Create;
    destructor Destroy; override;
    function URL(AURL: string): iHttpClient;
    function Headers(aKey: String; aValue: String): iHttpClient;
    function POST: iHttpClient;
    function Body(Value: string): iHttpClient;
    function Content: string;
    function StatusCode: integer;
    class function New: iHttpClient;
  end;

implementation

uses
  GravarLog;

{ THttpClient }

function THttpClient.Body(Value: string): iHttpClient;
begin
  Result := Self;
  FBody := Value;
end;

function THttpClient.Content: string;
begin
  Result := FRestResponse.Content;
end;

constructor THttpClient.Create;
begin
  raise Exception.Create('Para obter uma instancia, utiliza a função New');
end;

constructor THttpClient.CreatePrivate;
begin
  inherited Create;
  FRestClient := TRESTClient.Create(nil);
  FRestResponse := TRESTResponse.Create(FRestClient);
  FRestRequest := TRESTRequest.Create(FRestClient);
end;

destructor THttpClient.Destroy;
begin
  FRestClient.Free;
  inherited;
end;

procedure THttpClient.DoBeforeExecute;
begin
  if (DebugHook > 0) then
    TGravarLog.New.DoSaveLog(FBody);

  SetRestClient;
  SetRestResponse;
  SetRestRequest;
end;

function THttpClient.Headers(aKey, aValue: String): iHttpClient;
begin
  Result := Self;
  FRestRequest.AddParameter(aKey,aValue,pkHTTPHEADER);
end;

class function THttpClient.New: iHttpClient;
begin
  result := Self.CreatePrivate;
end;

function THttpClient.POST: iHttpClient;
begin
  DoBeforeExecute;

  FRestRequest.Method := rmPOST;
  FRestRequest.Execute;
end;

procedure THttpClient.SetRestClient;
begin
  FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestClient.AcceptEncoding := '';
  FRestClient.AutoCreateParams := true;
  FRestClient.AllowCookies := true;
  FRestClient.ContentType := 'application/json';
  FRestClient.FallbackCharsetEncoding := 'utf-8';
  FRestClient.HandleRedirects := true;
end;

procedure THttpClient.SetRestRequest;
var
  IdxParam: integer;
begin
  FRestRequest.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestRequest.AcceptEncoding := '';
  FRestRequest.AutoCreateParams := true;
  FRestRequest.Client := FRestClient;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Response := FRestResponse;

  IdxParam := FRestRequest.Params.Count;
  FRestRequest.Params.Add;
  FRestRequest.Params[IdxParam].ContentType := ctAPPLICATION_JSON;
  FRestRequest.Params[IdxParam].Kind := pkREQUESTBODY;
  FRestRequest.Params[IdxParam].Name := 'body';
  FRestRequest.Params[IdxParam].Value := FBody;
  FRestRequest.Params[IdxParam].Options := [poDoNotEncode];
end;

procedure THttpClient.SetRestResponse;
begin
  FRestResponse.ContentType := 'application/json';
end;

function THttpClient.StatusCode: integer;
begin
  Result := FRestResponse.StatusCode;
end;

function THttpClient.URL(AURL: string): iHttpClient;
begin
  Result := Self;
  FRestClient.BaseURL := AURL;
end;

end.
