unit DataThread;

interface

uses
  Classes,SyncObjs;

type
  TDataThread = class(TThread)
  private
    fRefresh : boolean;
    fInterval : longint;
    fActive : boolean;
  protected
    fDataLock : TCriticalSection;  // Protects mail, data + main thread
    procedure  DoUpdate; virtual;
    procedure SetActive(Value : boolean); virtual;
  public
    constructor Create(AInterval : longint);
    destructor Destroy; override;
    procedure  Execute; override;
    procedure  Refresh;
    procedure  ResolveVariables(var Line : string); virtual;
    property Active : boolean read fActive write SetActive;
  end;

implementation

uses
  Windows;

constructor TDataThread.Create(AInterval : longint);
begin
  fInterval := AInterval;
  fDataLock := TCriticalSection.Create;
  FreeOnTerminate := false;
  inherited Create(true);  // create in suspended mode;
end;

destructor TDataThread.Destroy;
begin
  inherited;
  fDataLock.Free;
end;

procedure TDataThread.SetActive(Value : boolean);
begin
  fActive := Value;
end;

procedure TDataThread.Refresh;
begin
  fRefresh := true;
end;

procedure TDataThread.Execute;
var
  WaitLoop : longint;
begin
  while not Terminated do begin
    DoUpdate;
    fRefresh := false;
    for WaitLoop := 1 to (fInterval div 10)-20 do begin
      sleep(10);
      if Terminated or fRefresh then break;
    end;
    if not Terminated then sleep(200);  // minimum sleep interval upon external refresh call
  end;
end;

procedure TDataThread.DoUpdate;
begin
  // stub, override this virtual method
end;

procedure TDataThread.ResolveVariables(var Line : string);
begin
  // stub, override this virtual method
end;

end.
