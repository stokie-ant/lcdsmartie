unit DISPFORM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ImgList;

const
  MaxWidth = 40;
  MaxHeight = 4;
  CharWidth = 5;
  CharHeight = 8;

type
  TFontArray = array[0..255] of TBitmap;

  TLCDDisplayForm = class(TForm)
    RootPanel: TPanel;
    LCDPanel: TPanel;
    DefaultFont: TImageList;
    PaintBox: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
  private
    { Private declarations }
    MyWidth,MyHeight : integer;
    WidthOffset,HeightOffset : integer;
    CurrentX,CurrentY : integer;
    Font : TFontArray;
    BackgroundBitmap : TBitmap;
    BackgroundColor : TColor;
    FrameBuffer : array[1..MaxWidth*MaxHeight] of byte;
    procedure LoadFont;
    procedure SendChar(C : byte);
    procedure ClearDisplay;
  public
    { Public declarations }
    procedure SetSize(X,Y : integer);
    procedure SetPosition(X,Y : integer);
    procedure ScreenWrite(S : string);
    procedure SetBacklight(LightOn : boolean);
    procedure CustomChar(Index : byte; Bytes : array of byte);
  end;

implementation

{$R *.dfm}

uses
  Math;

procedure TLCDDisplayForm.LoadFont;
var
  Loop : longint;
begin
  for Loop := 0 to 255 do begin
    Font[Loop] := TBitmap.Create;
    Font[Loop].Width := CharWidth;
    Font[Loop].Height := CharHeight;
    if (Loop >= 32) or (Loop <= 127) then begin
      DefaultFont.GetBitmap(Loop-32,Font[Loop]);
    end;
  end;
end;

procedure TLCDDisplayForm.FormCreate(Sender: TObject);
begin
  BackgroundColor := clLime;
  BackgroundBitmap := TBitmap.Create;
  CurrentX := 1;
  CurrentY := 1;
  MyWidth := 40;
  MyHeight := 4;
  WidthOffset := Width - PaintBox.Width;
  HeightOffset := Height - PaintBox.Height;
  fillchar(Font,sizeof(Font),$00);
  fillchar(FrameBuffer,sizeof(FrameBuffer),32);
  LoadFont;
end;

procedure TLCDDisplayForm.SetPosition(X,Y : integer);
begin
  CurrentX := X;
  CurrentY := Y;
end;

procedure TLCDDisplayForm.ClearDisplay;
begin
  LCDPanel.Color := BackgroundColor;
  with BackgroundBitmap.Canvas do begin
    CopyMode := cmMergeCopy;
    Pen.Color := BackgroundColor;
    Pen.Mode := pmCopy;
    Pen.Style := psSolid;
    Pen.Width := 1;
    Brush.Color := BackgroundColor;
    Brush.Style := bsSolid;
    Rectangle(0,0,Width,Height);
  end;
end;

procedure TLCDDisplayForm.SetSize(X,Y : integer);
begin
  X := min(MaxWidth,X);
  Y := min(MaxHeight,Y);
  MyWidth := X;
  MyHeight := Y;
  Width := WidthOffset + (X*(CharWidth+1)*2);
  Height := HeightOffset + (Y*(CharHeight+1)*2);
  Constraints.MinWidth := WidthOffset + X*(CharWidth+1);
  Constraints.MinHeight := HeightOffset + Y*(CharHeight+1);
  if assigned(BackgroundBitmap) then BackgroundBitmap.Free;
  BackgroundBitmap := TBitmap.Create;
  with BackgroundBitmap do begin
    Width := X*(CharWidth+1);
    Height := Y*(CharHeight+1);
    ClearDisplay;
  end;
end;

procedure TLCDDisplayForm.PaintBoxPaint(Sender: TObject);
var
  DestRect : TRect;
begin
  with DestRect do begin
    Top := 2;
    Bottom := PaintBox.Height+1;
    Left := 2;
    Right := PaintBox.Width+1;
  end;
  PaintBox.Canvas.StretchDraw(DestRect,BackgroundBitmap);
end;

procedure TLCDDisplayForm.SendChar(C : byte);
var
  CurChar : TBitmap;
  DestRect : TRect;
  SrcRect : TRect;
begin
  FrameBuffer[CurrentX+(CurrentY-1)*MyWidth] := C;
  CurChar := Font[C];
  with SrcRect do begin
    Left := 0;
    Right := CharWidth;
    Top := 0;
    Bottom := CharHeight;
  end;
  with DestRect do begin
    Top := (CurrentY-1)*(CharHeight+1);
    Bottom := Top + CharHeight;
    Left := (CurrentX-1)*(CharWidth+1);
    Right := Left + CharWidth;
  end;
  BackgroundBitmap.Canvas.CopyRect(DestRect,CurChar.Canvas,SrcRect);
  inc(CurrentX);
  if (CurrentX > MyWidth) then begin
    CurrentX := 1;
    inc(CurrentY);
    if (CurrentY > MyHeight) then
      CurrentY := 1;
  end;
end;

procedure TLCDDisplayForm.ScreenWrite(S : string);
var
  C : byte;
  Loop : integer;
begin
  for Loop := 1 to length(S) do begin
    C := ord(S[Loop]);
    SendChar(C);
  end;
  PaintBoxPaint(nil);
end;

procedure TLCDDisplayForm.SetBacklight(LightOn : boolean);
var
  Loop,OldPosX,OldPosY : longint;
begin
  if LightOn then BackgroundColor := clLime
  else BackgroundColor := clGreen;
  ClearDisplay;
  OldPosX := CurrentX;
  OldPosY := CurrentY;
  CurrentX := 1;
  CurrentY := 1;
  for Loop := 1 to MyHeight*MyWidth do begin
    SendChar(FrameBuffer[Loop]);
  end;
  CurrentX := OldPosX;
  CurrentY := OldPosY;
  PaintBoxPaint(nil);
end;

procedure TLCDDisplayForm.CustomChar(Index : byte; Bytes : array of byte);
var
  X,Y : byte;
begin
  with Font[Index].Canvas do begin
    for X := 0 to CharWidth-1 do begin
      for Y := 0 to CharHeight do begin
        if ((Bytes[Y] and (1 shl X)) > 0) then
          Pixels[X,Y] := clBlack
        else
          Pixels[X,Y] := clWhite;
      end;
    end;
  end;
  SetBacklight(BackgroundColor = clLime);
end;

end.
