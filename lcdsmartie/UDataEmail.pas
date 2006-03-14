unit UDataEmail;

interface

uses
  SyncObjs,Classes,UConfig,IdPOP3,DataThread;

const
  EmailKeyPrefix = '$Email';
  EmailCountKey = EmailKeyPrefix;
  EmailSubjectKey = EmailKeyPrefix + 'Sub';
  EmailFromKey = EmailKeyPrefix + 'From';

type
  PPop3 = ^TIdPop3;

  TEmail = Record
    messages: Integer;
    lastSubject: String;
    lastFrom: String;
  end;

  TEmailDataThread = class(TDataThread)
  private
    fGotEmail : boolean;            // data+main threads
    fPOP3Copy : PPop3;   // so we can cancel the request. Guarded by httpCs
    fMail : array [0..MaxEmailAccounts-1] of TEmail; // Guarded by mailCs, data+main thread
  protected
    procedure  DoUpdate; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure  ResolveVariables(var Line : string); override;
    property GotEmail : boolean read fGotEmail write fGotEmail;
  end;

implementation

uses
  IdGlobal,UUtils,SysUtils,IdMessage;

constructor TEmailDataThread.Create;
begin
  fGotEmail := false;
  fPOP3Copy := nil;
  inherited Create(config.emailPeriod*60000);
end;

destructor TEmailDataThread.Destroy;
begin
  if assigned(fPOP3Copy) then
    fPOP3Copy^.DisconnectSocket();
  inherited;
end;

procedure TEmailDataThread.DoUpdate;
var
  CheckForMail: array[0..MaxEmailAccounts-1] of boolean;
  AccountLoop,ScreenLoop,LineLoop : integer;
  screenline: String;
  pop3: TIdPOP3;
  msg: TIdMessage;
  myGotEmail: Boolean;
  messages: Integer;
begin
  fillchar(CheckForMail,sizeof(CheckForMail),$00);

  // figure out which accounts we have to check
  // this should be called with a TStringList from externally not to break encapsulation -MVM
  for ScreenLoop := 1 to MaxScreens do
  begin
    for LineLoop := 1 to config.height do
    begin
      screenline := config.screen[ScreenLoop][LineLoop].text;
      for AccountLoop := 0 to MaxEmailAccounts-1 do
      begin
        if (pos(EmailCountKey + IntToStr(AccountLoop), screenline) <> 0)
          or (pos(EmailSubjectKey + IntToStr(AccountLoop), screenline) <> 0)
          or (pos(EmailFromKey + IntToStr(AccountLoop), screenline) <> 0) then
        begin
          CheckForMail[AccountLoop] := true;
        end;
      end;
    end;
  end;

  myGotEmail := False;
  // now go check the active accounts
  for AccountLoop := 0 to MaxEmailAccounts-1 do
  begin
    if CheckForMail[AccountLoop] then
    begin
      if Terminated then raise EExiting.Create('');
      try
        if config.pop[AccountLoop].server <> '' then
        begin
          pop3 := TIdPOP3.Create(nil);
          msg := TIdMessage.Create(nil);
          pop3.host := config.pop[AccountLoop].server;
          pop3.MaxLineAction := maSplit;
          pop3.ReadTimeout := 15000;   //15 seconds
          pop3.username := config.pop[AccountLoop].user;
          pop3.Password := config.pop[AccountLoop].pword;

          try
            fPOP3Copy := @pop3;
            if (Terminated) then raise EExiting.Create('');
            pop3.Connect(30000);   // 30 seconds
            if (Terminated) then raise EExiting.Create('');

            messages := pop3.CheckMessages;
            fDataLock.Enter();
            try
              fMail[AccountLoop].messages := messages;
              if (fMail[AccountLoop].messages > 0) and
                (pop3.RetrieveHeader(fMail[AccountLoop].messages, msg)) then
              begin
                fMail[AccountLoop].lastSubject := msg.Subject;
                fMail[AccountLoop].lastFrom := msg.From.Name;
              end
              else
              begin
                fMail[AccountLoop].lastSubject := '[none]';
                fMail[AccountLoop].lastFrom := '[none]';
              end;
            finally
              fDataLock.Leave();
            end;

          finally
            fpop3Copy := nil;
            pop3.Disconnect;
            pop3.Free;
            msg.Free;
          end;

          if (fMail[AccountLoop].messages > 0) then myGotEmail := true;

        end;

      except
        on EExiting do raise;
        on E: Exception do
        begin
          fDataLock.Enter();
          try
            fMail[AccountLoop].messages := 0;
            fMail[AccountLoop].lastSubject := '[email: ' + E.Message + ']';
            fMail[AccountLoop].lastFrom := '[email: ' + E.Message + ']';
          finally
            fDataLock.Leave();
          end;
        end;
      end;
    end;
  end;
  GotEmail := myGotEmail;
end;

procedure TEmailDataThread.ResolveVariables(var Line : string);
var
  AccountLoop : integer;
begin
  if (pos(EmailKeyPrefix, line) <> 0) then
  begin
    fDataLock.Enter();
    try
      for AccountLoop := 0 to MaxEmailAccounts-1 do
      begin
        line := StringReplace(line, EmailCountKey + IntToStr(AccountLoop),
          IntToStr(fMail[AccountLoop].messages), [rfReplaceAll]);
        line := StringReplace(line, EmailSubjectKey + IntToStr(AccountLoop),
          fMail[AccountLoop].lastSubject, [rfReplaceAll]);
        line := StringReplace(line, EmailFromKey + IntToStr(AccountLoop),
          fMail[AccountLoop].lastFrom, [rfReplaceAll]);
      end;
    finally
      fDataLock.Leave();
    end;
  end;
end;

end.
