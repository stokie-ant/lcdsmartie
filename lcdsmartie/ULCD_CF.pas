unit ULCD_CF;

interface

uses ULCD;

type
  TLCD_CF = class(TLCD)
    procedure customChar(character: Integer; data: array of Byte); override;
    procedure setPosition(x, y: Integer);  override;
    procedure write(str: String);  override;
    procedure setbacklight(on: Boolean); override;
    procedure setContrast(level: Integer);  override;
    procedure setBrightness(level: Integer);   override;
    constructor Create;  override;
    destructor Destory;  override;
  end;                  

implementation

uses UMain, SysUtils;

constructor TLCD_CF.Create;
begin
  with form1.VaComm1 do begin
    WriteChar(Chr(3));
    WriteChar(Chr(4));
    WriteChar(Chr(20));
  end;

  inherited;
end;

destructor TLCD_CF.Destory;
begin
  setbacklight(false);
  inherited;
end;

procedure TLCD_CF.setContrast(level: Integer);
begin
  Form1.VaComm1.WriteChar(chr(15));
  Form1.VaComm1.WriteChar(chr(level));
end;

procedure TLCD_CF.setBrightness(level: Integer);
begin
  Form1.VaComm1.WriteChar(chr(14));
  Form1.VaComm1.WriteChar(chr(level));
end;




procedure TLCD_CF.setbacklight(on: Boolean);
begin
  with form1.VaComm1 do begin
    if (on) then begin
      WriteChar(chr(14));
      WriteChar(chr(100));
    end else begin
      WriteChar(chr(14));
      WriteChar(chr(0));
    end;
  end;
end;

procedure TLCD_CF.setPosition(x, y: Integer);
begin
  with form1.VaComm1 do begin
    WriteChar(chr(17));
    WriteChar(chr(x-1));
    WriteChar(chr(y-1));
  end;
end;

procedure TLCD_CF.write(str: String);
begin
  str:=StringReplace(str,'°',chr(128),[rfReplaceAll]);
  str:=StringReplace(str,'ž',chr(129),[rfReplaceAll]);
  str:=StringReplace(str,chr(131),chr(130),[rfReplaceAll]);
  str:=StringReplace(str,chr(132),chr(131),[rfReplaceAll]);
  str:=StringReplace(str,chr(133),chr(132),[rfReplaceAll]);
  str:=StringReplace(str,chr(134),chr(133),[rfReplaceAll]);
  str:=StringReplace(str,chr(135),chr(134),[rfReplaceAll]);
  str:=StringReplace(str,chr(136),chr(135),[rfReplaceAll]);
  str:=StringReplace(str,'{',chr(253),[rfReplaceAll]);
  str:=StringReplace(str,'|',chr(254),[rfReplaceAll]);
  str:=StringReplace(str,'}',chr(255),[rfReplaceAll]);
  str:=StringReplace(str,'$',chr(202),[rfReplaceAll]);
  str:=StringReplace(str,'@',chr(160),[rfReplaceAll]);
  str:=StringReplace(str,'_','Ä',[rfReplaceAll]);
  str:=StringReplace(str,'’',chr(39),[rfReplaceAll]);
  str:=StringReplace(str,'`',chr(39),[rfReplaceAll]);
  str:=StringReplace(str,'~',chr(206),[rfReplaceAll]);
  str:=StringReplace(str,'[','ú',[rfReplaceAll]);
  str:=StringReplace(str,']','ü',[rfReplaceAll]);
  str:=StringReplace(str,'\','û',[rfReplaceAll]);
  str:=StringReplace(str,'^',chr(206),[rfReplaceAll]);

 { VaComm2.WriteChar(Chr(3));
  VaComm2.WriteChar(Chr(4));
  VaComm2.WriteChar(Chr(20));
  }

  Form1.VaComm1.WriteText(str);
end;


procedure TLCD_CF.customChar(character: Integer; data: array of Byte);
begin
  with Form1.VaComm1 do begin
    WriteChar(chr(25));           //this starts the custom characters
    WriteChar(chr(character-1));  //00 to 07 for 8 custom characters.
    WriteChar(chr(data[0]));
    WriteChar(chr(data[1]));
    WriteChar(chr(data[2]));
    WriteChar(chr(data[3]));
    WriteChar(chr(data[4]));
    WriteChar(chr(data[5]));
    WriteChar(chr(data[6]));
    WriteChar(chr(data[7]));
  end;
end;

end.

