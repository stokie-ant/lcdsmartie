unit URLThread;

interface

uses
  DataThread,IdHTTP;

type
  PHttp = ^TIdHttp;

  TURLThread = class(TDataThread)
  private
    httpCopy: PHttp;   // so we can cancel the request.
  protected
  public
    constructor Create(AInterval : longint);
    destructor Destroy; override;
    function GetUrl(Url: String; maxfreq: Cardinal = 0): String; virtual;
  end;


implementation

uses
  DateUtils,SysUtils,Classes,UConfig,UUtils;

constructor TURLThread.Create(AInterval : longint);
begin
  httpCopy := nil;
  inherited;
end;

destructor TURLThread.Destroy;
begin
  fDataLock.Enter();
  if assigned(httpCopy) then
    httpCopy^.DisconnectSocket();
  fDataLock.Leave();
  inherited;
end;

// Download URL and return file location.
// Just return cached file if newer than maxfreq minutes.
function TURLThread.GetUrl(Url: String; maxfreq: Cardinal = 0): String;
var
  HTTP: TIdHTTP;
  sl: TStringList;
  Filename: String;
  lasttime: TDateTime;
  toonew: Boolean;
  sRest: String;
  iRest: Integer;
  i: Integer;

begin
  // Generate a filename for the cached Rss stream.
  Filename := copy(LowerCase(Url),1,30);
  sRest := copy(LowerCase(Url),30,length(Url)-30);

  Filename := StringReplace(Filename, 'http://', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '\', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, ':', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '/', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '"', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '|', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '<', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '>', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '&', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '?', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '=', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '.', '_', [rfReplaceAll]);
  Filename := StringReplace(Filename, '%', '_', [rfReplaceAll]);
  iRest := 0;
  for i := 1 to length(sRest) do
  begin
     iRest := iRest + (Ord(sRest[i]) xor i);
  end;
  Filename := Filename + IntToHex(iRest, 0);
  Filename :=  extractfilepath(paramstr(0)) + 'cache\\' + Filename + '.cache';

  try
    toonew := false;
    sl := TStringList.create;
    HTTP := TIdHTTP.Create(nil);

    try
      // Only fetch new data if it's newer than the cache files' date.
      // and if it's older than maxfreq hours.
      if FileExists(Filename) then
      begin
        lasttime := FileDateToDateTime(FileAge(Filename));
        if (MinutesBetween(Now, lasttime) < maxfreq) then toonew := true;
        HTTP.Request.LastModified := lasttime;
      end;

      if (not toonew) then
      begin
        HTTP.HandleRedirects := True;
        if (config.httpProxy <> '') and (config.httpProxyPort <> 0) then
        begin
          HTTP.ProxyParams.ProxyServer := config.httpProxy;
          HTTP.ProxyParams.ProxyPort := config.httpProxyPort;
        end;
        HTTP.ReadTimeout := 30000;  // 30 seconds

        if (Terminated) then raise EExiting.Create('');

        fDataLock.Enter();
        httpCopy := @HTTP;
        fDataLock.Leave();
        sl.Text := HTTP.Get(Url);
        // the get call can block for a long time so check if smartie is exiting
        if (Terminated) then raise EExiting.Create('');

        sl.savetofile(Filename);
      end;
    finally
      fDataLock.Enter();
      httpCopy := nil;
      fDataLock.Leave();

      sl.Free;
      HTTP.Free;
    end;
  except
    on E: EIdHTTPProtocolException do
    begin
      if (Terminated) then raise EExiting.Create('');
      if (E.ReplyErrorCode <> 304) then   // 304=Not Modified.
        raise;
    end;

    else
    begin
      if (Terminated) then raise EExiting.Create('');
      raise;
    end;
  end;

  // Even if we fail to download - give the filename so they can use the old data.
  Result := filename;
end;

end.
