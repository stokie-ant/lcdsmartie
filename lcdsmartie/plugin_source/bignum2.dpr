library bignum2;

uses
  SysUtils, Classes;

{$R *.res}

const
  CustomChar1 = '$CustomChar(1,31,16,16,16,16,16,16,16)';
  CustomChar2 = '$CustomChar(2,31,1,1,1,1,1,1,1)';
  CustomChar3 = '$CustomChar(3,16,16,16,16,16,16,16,31)';
  CustomChar4 = '$CustomChar(4,1,1,1,1,1,1,1,31)';
  CustomChar5 = '$CustomChar(5,31,16,16,16,16,16,16,31)';
  CustomChar6 = '$CustomChar(6,31,1,1,1,1,1,1,31)';
  CustomChar7 = '$CustomChar(7,0,0,0,0,0,0,0,31)';
  CustomChar8 = '$CustomChar(8,31,0,0,0,0,0,0,0)';

  AllChars = CustomChar1 + CustomChar2 + CustomChar3 + CustomChar4 +
             CustomChar5 + CustomChar6 + CustomChar7 + CustomChar8;

  BoldChar1 = '$CustomChar(1,31,31,24,24,24,24,24,24)';
  BoldChar2 = '$CustomChar(2,31,31,3,3,3,3,3,3)';
  BoldChar3 = '$CustomChar(3,24,24,24,24,24,24,31,31)';
  BoldChar4 = '$CustomChar(4,3,3,3,3,3,3,31,31)';
  BoldChar5 = '$CustomChar(5,31,31,24,24,24,24,31,31)';
  BoldChar6 = '$CustomChar(6,31,31,3,3,3,3,31,31)';
  BoldChar7 = '$CustomChar(7,0,0,0,0,0,0,31,31)';
  BoldChar8 = '$CustomChar(8,31,31,0,0,0,0,0,0)';

  BoldChars = BoldChar1 + BoldChar2 + BoldChar3 + BoldChar4 +
              BoldChar5 + BoldChar6 + BoldChar7 + BoldChar8;

function function1(param1:pchar;param2:pchar):pchar; stdcall;
var
  SFont,P1,S,S2 : string;
  P,B,Line : byte;
  Index : integer;
  Font : byte;
begin
  P1 := string(param1);
  P := pos('#',P1);
  Font := 1;
  if (P > 0) then begin
    SFont := P1;
    delete(SFont,1,P);
    P1 := copy(P1,1,P-1);
    try
      Font := StrToInt(SFont);
    except
      Font := 1;
    end;
  end;
  S := string(param2);
  try
    Line := StrToInt(P1);
  except
    Line := 0;
  end;
  Index := 1;
  while (Index <= length(S)) do begin                                       
    S2 := ' ';
    B := ord(S[Index]);
    if (B >= 48) and (B <= 57) then B := B - 48;
    if (Line = 1) then begin
      S2 := ' ';
      case B of
        0 : S2 := #1#2;
        1 : S2 := #2#32;
        2 : S2 := #8#6;
        3 : S2 := #8#6;
        4 : S2 := #3#4;
        5 : S2 := #5#8;
        6 : S2 := #1#8;
        7 : S2 := #8#2;
        8 : S2 := #5#6;
        9 : S2 := #5#6;
        45 : S2 := #7;
        58 : S2 := '.';
      end;
    end else if (Line = 2) then begin
      S2 := S[Index];
      case B of
        0 : S2 := #3#4;
        1 : S2 := #4#7;
        2 : S2 := #5#7;
        3 : S2 := #7#4;
        4 : S2 := #32#2;
        5 : S2 := #7#6;
        6 : S2 := #5#6;
        7 : S2 := #32#2;
        8 : S2 := #3#4;
        9 : S2 := #7#4;
        45 : S2 := ' ';
        58 : S2 := '.';
      end;
    end;
    delete(S,Index,1);
    insert(S2,S,Index);
    Index := Index + length(S2);
  end;
  try
    if (Line = 1) then begin
      case Font of
        1 : S := AllChars+S;
        2 : S := BoldChars+S;
      end;
    end;
    result := pchar(S);
  except
    on E: Exception do
      result := PChar('bignum2 exception: ' + E.Message);
  end;
end;

exports
  function1;
begin
end.

