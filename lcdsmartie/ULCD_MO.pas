unit ULCD_MO;

interface

uses ULCD;

type
  TLCD_MO = class(TLCD)
  public
    procedure customChar(character: Integer; data: array of Byte); override;
    procedure setPosition(x, y: Integer);  override;
    procedure write(str: String); override;
    procedure setbacklight(on: Boolean); override;
    function readKey(var key: Char):Boolean; override;
    procedure setFan(t1,t2: Integer); override;
    procedure setGPO(gpo: Byte; on: Boolean); override;
    procedure setContrast(level: Integer); override;
    procedure setBrightness(level: Integer); override;
    constructor Create; override;
    destructor Destory; override;
  end;

implementation

uses UMain, SysUtils;

constructor TLCD_MO.Create;
var
  g: Integer;
begin
  with form1.VaComm1 do begin
    for g:= 1 to 8 do begin
      setGPO(g, false);
    end;

    WriteChar(chr($0FE));   //Cursor blink off
    WriteChar('T');

    WriteChar(chr($0FE));   //clear screen
    WriteChar('X');

    WriteChar(chr($0FE));   //Cursor off
    WriteChar('K');

    WriteChar(chr($0FE));   //auto scroll off
    WriteChar('R');

    WriteChar(chr($0FE));   //auto line wrap off
    WriteChar('D');

    WriteChar(chr($0FE));   //keypad polling on
    WriteChar('O');

    WriteChar(chr($0FE));   //auto repeat off
    WriteChar('`');

    setbacklight(true);
  end;
  inherited;
end;

destructor TLCD_MO.Destory;
var
  g: Integer;
begin
  setbacklight(false);

  for g:= 1 to 8 do begin
    setGPO(g, false);
  end;

  with form1.VaComm1 do begin
    WriteChar(chr($0FE));  //clear screen
    WriteChar('X');
  end;

  inherited;
end;

procedure TLCD_MO.setContrast(level: Integer);
begin
  with form1.VaComm1 do begin
    WriteChar(Chr($0FE));
    WriteChar('P');
    WriteChar(chr(level));
  end;
end;

procedure TLCD_MO.setBrightness(level: Integer);
begin
  with form1.VaComm1 do begin
    WriteChar(Chr($0FE));
    WriteChar(Chr($098));
    WriteChar(chr(level));
  end;
end;

procedure TLCD_MO.setGPO(gpo: Byte; on: Boolean);
begin
  with form1.VaComm1 do begin
    WriteChar(chr($0FE));
    if (on) then WriteChar('W')
    else WriteChar('V');
    WriteChar(chr(gpo));
  end;
end;

procedure TLCD_MO.setFan(t1,t2: Integer);
begin
  with form1.VaComm1 do begin
    WriteChar(chr($FE));                         //set speed
    WriteChar(chr($C0));
    WriteChar(chr(t1));
    WriteChar(chr(t2));
  end;

  {
    form1.VaComm1.WriteChar(chr($FE));                         //remember startup state
    form1.VaComm1.WriteChar(chr($C3));
    form1.VaComm1.WriteChar(chr(StrToInt(temp1)));
    form1.VaComm1.WriteChar(chr(strToInt(temp2)));
  }
end;

function TLCD_MO.readKey(var key: Char): Boolean;
var
  gotkey: Boolean;
begin
  gotkey:=False;

{  form1.VaComm1.WriteChar(chr($0FE));
  form1.VaComm1.WriteChar(chr($026));
  Sleep(200);
  }
  if form1.VaComm1.ReadBufUsed>0 then begin
    if (form1.VaComm1.ReadChar(key)) then gotkey:=true;
  end;

  {
  if (config.mx3Usb) then begin
    for teller:=1 to 3 do begin
      VaComm1.WriteChar(chr($FE));
      VaComm1.WriteChar(chr($C1));
      VaComm1.WriteChar(chr($03));

      temp1:='';
      while form1.VaComm1.ReadBufUsed>=1 do begin
        form1.VaComm1.ReadChar(kar);
        temp1:=temp1+kar;
      end;
    end;
  end;
  }

  Result:=gotkey;
end;

procedure TLCD_MO.setbacklight(on: Boolean);
begin
  with form1.VaComm1 do begin
    if (not on) then begin
      WriteChar(chr($0FE));
      WriteChar('F');
    end else begin
      WriteChar(chr($0FE));
      WriteChar('B');
      WriteChar(chr($00));
    end;
  end;
end;

procedure TLCD_MO.setPosition(x, y: Integer);
begin
  with Form1.VaComm1 do begin
    WriteChar(Chr($0FE));
    WriteChar('G');
    WriteChar(Chr(x));
    WriteChar(Chr(y));
  end;

  inherited;
end;


procedure TLCD_MO.write(str: String);
begin
  str:=StringReplace(str,'\','/',[rfReplaceAll]);
  str:=StringReplace(str,'°',chr(0),[rfReplaceAll]);
  str:=StringReplace(str,'ž',chr(1),[rfReplaceAll]);
  str:=StringReplace(str,chr(131),chr(2),[rfReplaceAll]);
  str:=StringReplace(str,chr(132),chr(3),[rfReplaceAll]);
  str:=StringReplace(str,chr(133),chr(4),[rfReplaceAll]);
  str:=StringReplace(str,chr(134),chr(5),[rfReplaceAll]);
  str:=StringReplace(str,chr(135),chr(6),[rfReplaceAll]);
  str:=StringReplace(str,chr(136),chr(7),[rfReplaceAll]);
  Form1.VaComm1.WriteText(str);
end;

procedure TLCD_MO.customChar(character: Integer; data: array of Byte);
begin
  with Form1.VaComm1 do begin
    WriteChar(Chr($0FE));     //command prefix
    WriteChar(Chr($04E));     //this starts the custom characters
    WriteChar(Chr(character-1));    //00 to 07 for 8 custom characters.
    WriteChar(Chr(data[0]));
    WriteChar(Chr(data[1]));
    WriteChar(Chr(data[2]));
    WriteChar(Chr(data[3]));
    WriteChar(Chr(data[4]));
    WriteChar(Chr(data[5]));
    WriteChar(Chr(data[6]));
    WriteChar(Chr(data[7]));
  end;
end;

end.
