unit UUtils;

interface

uses SyncObjs, Classes;

type
  TThreadMethod = procedure of object;

  TMyThread = class(TTHREAD)
  private
    method: TThreadMethod;
  published
    procedure Execute; override;
  public
    exited: TEvent;
    property Terminated;
    constructor Create(myMethod: TThreadMethod);
    destructor Destroy;  override;
  end;

  Function CenterText(const sLine: String; iWidth: Integer): String;
  procedure AddPluginsToPath;
  procedure CreateShortcut(const sName, FileName,Args: string; uninstall: Boolean = False);
  function errMsg(uError: Cardinal): String;
  function decodeArgs(const str: String; const funcName: String; maxargs: Cardinal; var
      args: Array of String; var prefix: String; var postfix: String; var
      numArgs: Cardinal): Boolean;
  function StrToIntN(const sStr: String; iStart: Integer; iSize: Integer): Integer;
  function StrToFloatN(const sStr: String; iStart: Integer; iSize: Integer): double;


implementation

uses Windows, SysUtils, Registry, ShlObj, ActiveX, ComObj, Forms, StrUtils;

constructor TMyThread.Create(myMethod: TThreadMethod);
begin
  method := myMethod;
  exited := TEvent.Create(nil, true, false, '');
  inherited Create(true);   // Create suspended.
end;

destructor TMyThread.Destroy;
begin
  exited.Free();
  inherited;
end;

procedure TMyThread.Execute;
begin
  method();
  exited.SetEvent();
end;

function StrToIntN(const sStr: String; iStart: Integer; iSize: Integer): Integer;
var
  num: Integer;
  i: Integer;
begin
  num := 0;
  // skip space space
  while (iSize > 0) and (sStr[iStart] = ' ') do
  begin
    iStart := iStart + 1;
    iSize := iSize - 1;
  end;

  if (iSize <= 0) then
    raise Exception.Create('invalid number');

  for i := iStart to iStart+iSize-1 do
  begin
    if (sStr[i] < '0') or (sStr[i] > '9') then
      raise Exception.Create('invalid number: ' + MidStr(sStr,iStart,iSize));
    num := num * 10 + Ord(sStr[i]) - Ord('0');
  end;
  Result := num;
end;

function StrToFloatN(const sStr: String; iStart: Integer; iSize: Integer): double;
var
  iDecPoint: Integer;
begin
  iDecPoint := PosEx('.', sStr, iStart);

  if (iDecPoint = 0) or (iDecPoint > iStart+iSize) then
    Result := StrToIntN(sStr, iStart, iSize)
  else
    Result := StrToIntN(sStr, iStart, iDecPoint-iStart)
      + StrToIntN(sStr, iDecPoint+1, (iStart+iSize)-(iDecPoint+1)) /
      (10.0 * ((iStart+iSize)-(iDecPoint+1)));

end;

function errMsg(uError: Cardinal): String;
var
  psError: pointer;
  sError: String;
begin
  if (uError <> 0) then
  begin
    if (FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
      nil, uError, 0, @psError, 0, nil ) = 0) then psError := nil;

    if (psError <> nil) then
    begin
      sError := '#' + IntToStr(uError) + ': ' + PChar(psError);
      LocalFree(Cardinal(psError));
    end
    else
      sError := '#' + IntToStr(uError);
    Result := sError;
  end
  else
    Result := '#0'; // don't put "operation completed successfully!" It's too confusing!
end;



// Takes a string like: 'C:$Bar(20,30,10) jterlktjer(fsdfs)sfsdf(sdf)'
// with funcName '$Bar'
// and returns true(found) and numArgs=3 and an array with: '20', '30', '10'
// postfix=' jterlktjer(fsdfs)sfsdf(sdf)'
// prefix='C:'
function decodeArgs(const str: String; const funcName: String; maxargs: Cardinal;
  var args: Array of String; var prefix: String; var postfix: String; var
  numArgs: Cardinal): Boolean;
var
  posFuncStart, posArgsStart, posArgsEnd, posComma, posComma2: Integer;
  posTemp: Integer;
  uiLevel: Cardinal;
  iStrLen: Integer;
begin
  Result := true;
  numArgs := 0;
  iStrLen := Length(str);

  // For speed reasons this is instead of: posFuncStart = Pos(funcName + '(', str):
  posFuncStart := 0;
  repeat
    posFuncStart := PosEx(funcName, str, posFuncStart+1);
    if (posFuncStart <> 0) and (posFuncStart < iStrLen)
      and (str[posFuncStart+length(funcName)] = '(') then break;
  until (posFuncStart = 0);

  if (posFuncStart <> 0) then
  begin
    posArgsStart := posFuncStart + length(funcName);

    // find end of function and cope with nested brackets
    posTemp := posArgsStart + 1;
    uiLevel := 1;
    repeat
      case (str[posTemp]) of
      '(': Inc(uiLevel);
      ')': Dec(uiLevel);
      end;
      Inc(posTemp);
    until (uiLevel = 0) or (posTemp > iStrLen);

    if (uiLevel = 0) then
      posArgsEnd := posTemp-1
    else
      posArgsEnd := iStrLen;

    prefix := AnsiMidStr(str, 1, posFuncStart-1);
    postfix := AnsiMidStr(str, posArgsEnd + 1, iStrLen-posArgsEnd + 1);

    if (posArgsStart <> 0) and (posArgsEnd <> 0) then
    begin
      Dec(posArgsEnd);

      // between posArgsStart+1 and posArgsEnd  is now something like: '20,30,10'
      posComma2 := posArgsStart;
      repeat
        // Find next comma ignoring those in brackets.
        uiLevel := 0;
        posComma := posComma2;
        repeat
          Inc(posComma);
          case (str[posComma]) of
          '(': Inc(uiLevel);
          ')': Dec(uiLevel);
          end;
        until (posComma >= posArgsEnd)
          or ((uiLevel = 0) and (str[posComma] = ','));

        if (posComma >= posArgsEnd) then
        begin
          args[numArgs] := AnsiMidStr(str, posComma2+1, posArgsEnd-PosComma2);
          Inc(numArgs);
        end
        else
        begin
          args[numArgs] := AnsiMidStr(str, posComma2+1, PosComma-(PosComma2+1));
          Inc(numArgs);
        end;
        posComma2 := posComma;
      until (poscomma >= posArgsEnd) or (numArgs >= maxArgs);
    end;
  end
  else Result := false;

end;




// ** This code was posted on http://www.experts-exchange.com by 'inthe'
// ** which was based on code by 'madshi'.
procedure CreateShortcut(const sName, FileName,Args: string; uninstall: Boolean = False);
var
  LPUnknown : IUnknown;
  pShlLnk : IShellLink;
  pszFileName : IPersistFile;
  Dir : string;
  FullPath : WideString;
  R : TRegIniFile;
begin
  LPUnknown := CreateComObject(CLSID_ShellLink);
  pShlLnk := LPUnknown as IShellLink;
  pszFileName := LPUnknown as IPersistFile;
  pShlLnk.SetPath(PChar(FileName));
  pShlLnk.SetArguments(PChar(Args));
  pShlLnk.SetDescription(PChar('Automatically created by LCD Smartie'));
  pShlLnk.SetWorkingDirectory(PChar(ExtractFilePath(FileName)));

  R := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
  try
    Dir := R.ReadString('Shell Folders', 'Startup', '');
    if Dir <> '' then
    begin
      FullPath := Dir + '\'+sName+'.lnk';
      if uninstall then
        DeleteFile(FullPath)
      else
        pszFileName.Save(PWChar(FullPath), False);
    end;
  finally
    R.Free;
  end;
end;

procedure AddPluginsToPath;
var
  Reg: TRegistry;
  sName: String;
begin
  try
    Reg := TRegistry.Create;

    sName := 'Software\Microsoft\Windows\CurrentVersion\App Paths\' +
      extractfilename(application.exename);

    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey(sName, true) then
      begin
        Reg.WriteString('Path',
          extractfilepath(application.exename)+'plugins');
        Reg.CloseKey;
      end;
    finally
      Reg.Free;
    end;
  except
  end;
end;

Function CenterText(const sLine: String; iWidth: Integer): String;
var
  sSpace: String;
begin
  if (length(sLine) < iWidth) then
  begin
    sSpace := DupeString(' ', iWidth - length(sLine) );
    Insert(sLine, sSpace, (Length(sSpace) div 2)+1);

    result := sSpace;
  end
  else
    result := sLine;
end;

end.

