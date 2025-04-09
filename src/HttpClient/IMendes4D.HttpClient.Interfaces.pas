unit IMendes4D.HttpClient.Interfaces;

interface

uses
  IMendes4D.Types,
  IMendes4D.Model.Interfaces;

type
  iHttpClient = interface
  ['{8F78B900-8FA9-4289-BFCA-7B00C112DAF4}']
    function URL(AURL: string): iHttpClient;
    function Headers(aKey: String; aValue : String) : ihttpClient;
    function POST(const EndPoint: string): iHttpClient;
    function Body(Value: string): iHttpClient;
    function Content: string;
    function StatusCode: integer;
  end;

  iIMendesAPI = interface
  ['{B04A6FEA-82C6-41E8-80DA-DD0D55D8599C}']
    function POST(const EndPoint: TEndpointBaseType): iIMendesAPI;
    function Body(Value: iEntity): iIMendesAPI;
    function Content: string;
    function StatusCode: integer;
  end;

implementation

end.
