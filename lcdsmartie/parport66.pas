// I used DriverLinx, but it should be self-explainatory (right word?! = i am a german ...)

unit parport66;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, StdCtrls, IdGlobal, ExtCtrls;

type
  Byt8 = array[1..8] of Byte;
  TInt64 = TLargeInteger;
  TForm1 = class(TForm)
    io: TDLPortIO;
    Button1: TButton;
    lb: TListBox;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit2: TEdit;
    Button7: TButton;
    Timer1: TTimer;
    lcd: TLCDLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Button8: TButton;
    Button9: TButton;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    procedure write_command(c:byte);
    procedure write_data(c:byte);
    procedure write_string(s:string);
    procedure usleep(delay:longint);
    procedure init_lcd;
    procedure init_cgram;
    procedure pos_cursor(col,line:Word);
    procedure wr_cgram(which:Word; chars:Byt8);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


const
 HD66712        = 1;
 HD44780        = 2;

 LCD_RS         = $02;
 LCD_EN         = $01;
 // functions for RS = 1
 LCD_CLEAR      = $01;
 LCD_HOME       = $02;
 LCD_MODESET    = $04;
 LCD_ONOFF      = $08;
 LCD_EXTFUNC    = $08;          // RE must be 1
 LCD_SHIFT      = $10;
 LCD_SCRL_EN    = $10;          // RE = 1
 LCD_FUNCSET    = $20;
 LCD_SETCGRAM   = $40;
 LCD_SETSEGRAM  = $40;          // RE = 1
 LCD_SETDDRAM   = $80;
 LCD_SETSCRL    = $80;          // RE = 1

// Defaults
 LCD_COLS       = 24;
 LCD_LINES      = 1;
 TIME_SHORT     = 50;
 TIME_LONG      = 1700;
 LCD_ADDRESS    = $378;

 VBAR1 : Byt8 = (16,16,16,16,16,16,16,16);
 VBAR2 : Byt8 = (24,24,24,24,24,24,24,24);
 VBAR3 : Byt8 = (28,28,28,28,28,28,28,28);
 VBAR4 : Byt8 = (30,30,30,30,30,30,30,30);
 VBAR5 : Byt8 = (31,31,31,31,31,31,31,31);
 BAR1  : Byt8 = (0,0,0,0,0,0,0,31);
 BAR2  : Byt8 = (0,0,0,0,0,0,31,31);
 BAR3  : Byt8 = (0,0,0,0,0,31,31,31);
 BAR4  : Byt8 = (0,0,0,0,31,31,31,31);
 BAR5  : Byt8 = (0,0,0,31,31,31,31,31);
 BAR6  : Byt8 = (0,0,31,31,31,31,31,31);
 BAR7  : Byt8 = (0,31,31,31,31,31,31,31);
 BAR8  : Byt8 = (31,31,31,31,31,31,31,31);

var
 dline,dcol :Integer;
 lcdtyp:Integer;

procedure TForm1.FormCreate(Sender: TObject);
begin
   IO.DriverPath:=ExtractFileDir(ParamStr(0));
   IO.OpenDriver();
   if (not IO.ActiveHW) then
      MessageDlg('Could not open the DriverLINX driver.', mtError, [mbOK], 0)
   else
    lb.items.add('DriverLINX driver gestartet.');
   dcol:=0; dline:=0;
   lcdtyp:=HD44780;
end;

procedure tform1.usleep(delay:longint);
var
 D:LongInt;
 lpPerformanceCount1,lpPerformanceCount2,Frequency: TLargeInteger;
begin
 QueryPerformanceCounter(TInt64((@lpPerformanceCount1)^));
 QueryPerformanceCounter(TInt64((@lpPerformanceCount2)^));
 QueryPerformanceFrequency(TInt64((@Frequency)^));
  while Round(1000000 * (lpPerformanceCount2 - lpPerformanceCount1) / Frequency) < delay do
    begin
    QueryPerformanceCounter(TInt64((@lpPerformanceCount2)^));
    Application.ProcessMessages;
    end;
end;

procedure tform1.write_command(c:byte);
begin
 case lcdtyp of
        HD66712,
        HD44780: begin
                 io.Port[LCD_ADDRESS+2]:=LCD_RS OR LCD_EN;
                 usleep(Time_Short);
                 io.Port[LCD_ADDRESS+2]:=LCD_RS;
                 usleep(Time_Short);
                 io.Port[LCD_ADDRESS]:=c;
                 usleep(Time_short);
                 io.Port[LCD_ADDRESS+2]:=LCD_RS OR LCD_EN;
                 usleep(Time_Short);
                 if c = LCD_CLEAR then usleep(time_long);
                 end;
 end;
end;

procedure tform1.write_data(c:byte);
begin
 case lcdtyp of
        HD66712: begin
                 io.Port[LCD_ADDRESS+2]:=$00;
                 usleep(Time_Short);
                 io.Port[LCD_ADDRESS]:=c;
                 usleep(Time_short);
                 io.Port[LCD_ADDRESS+2]:=LCD_EN;
                 usleep(Time_Short);
                 end;
        HD44780: begin
                  io.Port[LCD_ADDRESS+2]:=$06;
                  usleep(Time_short);
                  io.Port[LCD_ADDRESS]:=c;
                  usleep(Time_short);
                  io.Port[LCD_ADDRESS+2]:=$07;
                  usleep(Time_short);
                 end;
 end;
end;

procedure tform1.init_lcd;
begin
 case lcdtyp of
        HD44780: begin
                 write_command($38);
                 write_command($06);
                 write_command($0C);
                 write_command($01);
                 end;
        HD66712: begin
                 usleep(50000);
                 write_command(LCD_FUNCSET OR $10);
                 usleep(50000);
                 write_command(LCD_FUNCSET OR $10);
                 usleep(Time_long);
                 write_command(LCD_FUNCSET OR $10);
                 usleep(Time_long);
                 write_command(LCD_FUNCSET OR $10 OR $08);
                 usleep(Time_long);
                 write_command(LCD_ONOFF);
                 usleep(Time_long);
                 write_command(LCD_ONOFF OR $04);      // Cursor off
                 usleep(Time_long);
                 write_command(LCD_MODESET OR $02);
                 usleep(Time_long);
                 write_command(LCD_FUNCSET OR $10 OR $07 OR $04);
                 usleep(Time_long);
                 write_command(LCD_EXTFUNC OR $01);
                 usleep(Time_long);
                 write_command(LCD_FUNCSET OR $10 OR $08);
                 end;
 end;
 usleep(Time_long);
 write_command(LCD_CLEAR);
end;

procedure tform1.init_cgram;
var
 a,b:Integer;
begin
 write_command(LCD_SETCGRAM);
 for a:=0 to 7 do
  for b:= 0 to 7 do
   write_data(0);
 pos_cursor(dcol,dline);
end;

procedure tform1.write_string(s:String);
var
 i:integer;
begin
 for i:= 1 to length(S) do
  Write_data(Ord(S[i]));
end;

procedure tform1.pos_cursor(col,line:word);
var
 offset,pos:Byte;
begin
 offset:=0; pos:=0;
 if line > 3 then line:=0;
 if col > 19 then col:=0;
 case line of
  0:    offset:=0;
  1:    offset:=$20;
  2:    offset:=$40;
  3:    offset:=$60;
 end;
 pos:= LCD_SETDDRAM + offset + col;
 dline := line;
 dcol := col;
 write_command(pos);
end;

procedure tform1.wr_cgram(which:Word; chars:Byt8);
var
 i:Integer;
begin
 write_command(LCD_SETCGRAM + (8*which));
 for i:=1 to 8 do
  write_data(chars[i]);
 usleep(time_short);
 pos_cursor(0,0);
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
 lb.Items.add('Init LCD');
 init_lcd;
lb.Items.add('Init CGRAM');
 init_cgram;
 lb.items.add('Defining 5-User Def. Chars');
 wr_cgram(1,BAR1);
 wr_cgram(2,BAR2);
 wr_cgram(3,BAR3);
 wr_cgram(4,BAR4);
 wr_cgram(5,BAR5);
 wr_cgram(6,BAR6);
 wr_cgram(7,BAR7);
 wr_cgram(8,BAR8);
 lb.Items.add('Done.');
 write_string('R.LCD');
end;

procedure TForm1.Button2Click(Sender: TObject);
var i:integer;
begin
 for i:= 1 to Length(Edit1.text) do
 Write_data(Ord(Edit1.Text[i]));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 write_command(LCD_CLEAR);
 pos_cursor(0,0);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 write_command(LCD_ONOFF OR $04);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 write_command(LCD_ONOFF OR $04 OR $02 OR $01);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 write_command(LCD_ONOFF OR $04 OR 02);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
 i:Integer;
begin
 lcd.caption:=Copy(lcd.caption,2,LCD_COLS)+lcd.caption[1];
 pos_cursor(0,0);
  for i:= 1 to LCD_COLS do
  Write_data(Ord(lcd.caption[i]));
end;

procedure TForm1.Button7Click(Sender: TObject);
var
 I:Integer;
begin
 if Length(Edit2.Text) < LCD_COLS then
  for i:=Length(Edit2.Text) to LCD_COLS-1 do
   Edit2.Text:=Edit2.text+' ';
 lcd.Caption:=edit2.Text;
 Timer1.Enabled:= not Timer1.Enabled;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
 pos_cursor(StrToInt(Edit3.Text),StrToInt(Edit4.Text));
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
 Timer2.Enabled:= not timer2.enabled;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
 a,b,i:Integer;
 c:array[1..LCD_COLS]of Byte;
begin
 pos_cursor(0,0);
 for i:=1 to LCD_COLS do c[i]:=Random(7)+1;
 for i:=1 to LCD_COLS do write_data(c[i]);
end;

end.
