unit IMendes4D.Auth.Interfaces;

interface

type
  iAuthenticator<T> = interface
  ['{1A131A0E-2AB6-4E80-8EB1-D73AC5690479}']
    function URL(const Value: string): iAuthenticator<T>; Overload;
    function URL: string; Overload;
    function User(const Value: string): iAuthenticator<T>; Overload;
    function User: string; Overload;
    function Password(const Value: string): iAuthenticator<T>; Overload;
    function Password: string; Overload;
    function &End: T;
  end;

implementation

end.
