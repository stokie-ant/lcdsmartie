unit UUtils;

interface
  function errMsg(uError: Cardinal): String;

implementation

uses Windows, SysUtils;

function errMsg(uError: Cardinal): String;
var
  psError: pointer;
  sError: String;
begin
  if (uError <> 0) then
  begin
    FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
      nil, uError, 0, @psError, 0, nil );
    sError := '#' + IntToStr(uError) + ': ' + PChar(psError);
    LocalFree(Cardinal(psError));
    Result := sError;
  end
  else
    Result := '#0'; // don't put "operation completed successfully!" It's too confusing!
end;

end.
