unit UConfig;
{******************************************************************************
 *
 *  LCD Smartie - LCD control software.
 *  Copyright (C) 2000-2003  BassieP
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/UConfig.pas,v $
 *  $Revision: 1.3 $ $Date: 2004/11/14 22:35:25 $
 *****************************************************************************}

interface

type
  TScreenLine = record
    text: String;
    enabled: Boolean;
    skip: Integer;
    noscroll: Boolean;
    contNextLine: Boolean;
    theme: Integer;
    interaction: Integer;
    interactionTime: Integer;
    showTime: Integer;
    center: Boolean;
  end;

  TPopAccount = record
    server: String;
    user: String;
    pword: String;
  end;

  TConfig = class(TObject)
    private
      P_sizeOption: Integer;
      P_width: Integer;
      P_height: Integer;
    public
        pop: array [0..9] of TPopAccount;
        comPort: Integer;
        baudrate: Integer;
        refreshRate: Integer;
        bootDriverDelay: Integer;
        emailPeriod: Integer;
        dllPeriod: Integer;
        scrollPeriod: Integer;
        parallelPort: Integer;
        colorOption: Integer;
        alwaysOnTop: Boolean;
        mx3Usb: Boolean;
        httpProxy: String;
        httpProxyPort: Integer;
        brightness: Integer;
        CF_contrast: Integer;
        CF_brightness: Integer;
        newsRefresh: Integer;
        randomScreens: Boolean;
        gameRefresh: Integer;
        mbmRefresh: Integer;
        foldUsername: String;
        isMO: Boolean;
        isCF: Boolean;
        isHD: Boolean;
        isHD2: Boolean; // not used.
        checkUpdates: Boolean;
        distLog: String;
        screen: array[1..20] of array[1..4] of TScreenLine;
        winampLocation: String;
        setiEmail: String;
        contrast: Integer;
        function load: Boolean;
        procedure save;
        function getSizeOption: Integer;
        function getHeight: Integer;
        function getWidth: Integer;
        procedure setSizeOption(con: Integer);
        property sizeOption: Integer read P_sizeOption write setSizeOption;
        property width: Integer read P_width;
        property height: Integer read P_height;
        constructor Create;
        destructor Destroy;    override;
    end;

implementation

uses
  SysUtils, Forms;

constructor TConfig.Create;
begin
  inherited;
end;

destructor TConfig.Destroy;
begin
  inherited;
end;

function TConfig.getHeight: Integer;
begin
  result:=P_height;
end;

function TConfig.getWidth: Integer;
begin
  result:=P_width;
end;

function TConfig.getSizeOption: Integer;
begin
  result:=P_sizeOption;
end;

procedure TConfig.setSizeOption(con: Integer);
begin
  P_sizeOption:=con;
  if P_sizeOption=1 then begin P_height:=1; P_width:=10; end;
  if P_sizeOption=2 then begin P_height:=1; P_width:=16; end;
  if P_sizeOption=3 then begin P_height:=1; P_width:=20; end;
  if P_sizeOption=4 then begin P_height:=1; P_width:=24; end;
  if P_sizeOption=5 then begin P_height:=1; P_width:=40; end;
  if P_sizeOption=6 then begin P_height:=2; P_width:=16; end;
  if P_sizeOption=7 then begin P_height:=2; P_width:=20; end;
  if P_sizeOption=8 then begin P_height:=2; P_width:=24; end;
  if P_sizeOption=9 then begin P_height:=2; P_width:=40; end;
  if P_sizeOption=10 then begin P_height:=4; P_width:=16; end;
  if P_sizeOption=11 then begin P_height:=4; P_width:=20; end;
  if P_sizeOption=12 then begin P_height:=4; P_width:=40; end;
end;

function TConfig.load: Boolean;
var
  initfile:textfile;
  x, y:Integer;
  configline: String;
  configarray: array[1..100] of String;
begin
  try
    assignfile(initfile, extractfilepath(application.exename)+'config.cfg');
    reset(initfile);
  except
    result := false;
    Exit;
  end;

  for x:= 1 to 100 do
    readln(initfile, configarray[x]);

  closefile(initfile);

  baudrate := StrToInt(configarray[100]);
  comPort := StrToInt(configarray[99]);

  refreshRate := StrToInt(copy(configarray[1],1,pos('¿',configarray[1])-1));
  winampLocation := copy(configarray[1],pos('¿',configarray[1])+1,
                         length(configarray[1]));

  bootDriverDelay:=StrToInt(copy(configarray[2],1,pos('¿',configarray[2])-1));
  setiEmail:=copy(configarray[2],pos('¿',configarray[2])+1,length(configarray[2]));

  for x:= 1 to 20 do
  begin
    for y:= 1 to 4 do
    begin
      configline:=configarray[x*4+(y-1)];
      screen[x][y].enabled:=copy(configline,pos('¿',configline)+1,1)='1';
      screen[x][y].theme:=StrToInt(copy(configline,pos('¿',configline)+5,1));
      screen[x][y].showTime:=StrToInt(copy(configline,pos('¿',configline)+9,length(configline)));
      screen[x][y].skip:=StrToInt(copy(configline,pos('¿',configline)+2,1));
      screen[x][y].interactionTime:=StrToInt(copy(configline,pos('¿',configline)+7,2));
      screen[x][y].interaction:=StrToInt(copy(configline,pos('¿',configline)+6,1));
      screen[x][y].noscroll:=copy(configline,pos('¿',configline)+3,1)='1';
      screen[x][y].contNextLine:=copy(configline,pos('¿',configline)+4,1)='1';
      screen[x][y].center:=copy(configline,1,3)='%c%';
      if (screen[x][y].center) then screen[x][y].text:=copy(configline,4,pos('¿',configline)-4)
      else screen[x][y].text:=copy(configline,1,pos('¿',configline)-1);

    end;
  end;

  distLog := configarray[88];
  emailPeriod := StrToInt(copy(configarray[89],1,pos('¿',configarray[89])-1));
  dllPeriod:=StrToInt(copy(configarray[89],pos('¿',configarray[89])+1,pos('¿¿',configarray[89])-pos('¿',configarray[89])-1));
  scrollPeriod:=StrToInt(copy(configarray[89],pos('¿¿',configarray[89])+2,length(configarray[89])));
  parallelPort:=StrToInt(configarray[91]);

  if (copy(configarray[92],2,1)='1') then mx3Usb:=true
  else mx3Usb:=false;

  if (copy(configarray[92],1,1)='1') then alwaysOnTop:=true
  else alwaysOnTop:=false;

  httpProxy:=configarray[93];
  httpProxyPort:=StrToInt(configarray[94]);

  isMO:=false;
  isCF:=false;
  isHD:=false;
  isHD2:=false;
  case StrToInt(configarray[98]) of
    1: isHD:=true;
    2: isMO:=true;
    3: isCF:=true;
    4: isHD2:=true;
  end;

  setSizeOption(strtoInt(copy(configarray[3], 1, pos('¿1',configarray[3])-1)));

  contrast:=strtoint(copy(configarray[3],pos('¿1',configarray[3])+2,pos('¿2',configarray[3])-pos('¿1',configarray[3])-2));
  brightness:=strtoint(copy(configarray[3],pos('¿2',configarray[3])+2,pos('¿3',configarray[3])-pos('¿2',configarray[3])-2));

  CF_contrast:=strtoint(copy(configarray[3],pos('¿3',configarray[3])+2,pos('¿4',configarray[3])-pos('¿3',configarray[3])-2));
  CF_brightness:=strtoint(copy(configarray[3],pos('¿4',configarray[3])+2,3));

  newsRefresh:=StrToInt(copy(configarray[84],2,length(configarray[84])));
  randomScreens:=copy(configarray[84],1,1)='1';

  foldUsername:=copy(configarray[85],1,pos('¿', configarray[85])-1);
  gameRefresh:=StrToInt(copy(configarray[85],pos('¿', configarray[85])+1,length(configarray[85])));

  mbmRefresh:=StrToInt(copy(configarray[86],2,length(configarray[86])));
  checkUpdates:=copy(configarray[86],1,1)='1';

  colorOption:=StrToInt(configarray[87]);

  // Pop accounts
  pop[1].server:=copy(configarray[95],1,pos('¿0', configarray[95])-1);
  pop[1].user:=copy(configarray[96],1,pos('¿0', configarray[96])-1);
  pop[1].pword:=copy(configarray[97],1,pos('¿0', configarray[97])-1);

  pop[2].server:=copy(configarray[95],pos('¿0', configarray[95])+2,pos('¿1', configarray[95])-pos('¿0', configarray[95])-2);
  pop[2].user:=copy(configarray[96],pos('¿0', configarray[96])+2,pos('¿1', configarray[96])-pos('¿0', configarray[96])-2);
  pop[2].pword:=copy(configarray[97],pos('¿0', configarray[97])+2,pos('¿1', configarray[97])-pos('¿0', configarray[97])-2);

  pop[3].server:=copy(configarray[95],pos('¿1', configarray[95])+2,pos('¿2', configarray[95])-pos('¿1', configarray[95])-2);
  pop[3].user:=copy(configarray[96],pos('¿1', configarray[96])+2,pos('¿2', configarray[96])-pos('¿1', configarray[96])-2);
  pop[3].pword:=copy(configarray[97],pos('¿1', configarray[97])+2,pos('¿2', configarray[97])-pos('¿1', configarray[97])-2);

  pop[4].server:=copy(configarray[95],pos('¿2', configarray[95])+2,pos('¿3', configarray[95])-pos('¿2', configarray[95])-2);
  pop[4].user:=copy(configarray[96],pos('¿2', configarray[96])+2,pos('¿3', configarray[96])-pos('¿2', configarray[96])-2);
  pop[4].pword:=copy(configarray[97],pos('¿2', configarray[97])+2,pos('¿3', configarray[97])-pos('¿2', configarray[97])-2);

  pop[5].server:=copy(configarray[95],pos('¿3', configarray[95])+2,pos('¿4', configarray[95])-pos('¿3', configarray[95])-2);
  pop[5].user:=copy(configarray[96],pos('¿3', configarray[96])+2,pos('¿4', configarray[96])-pos('¿3', configarray[96])-2);
  pop[5].pword:=copy(configarray[97],pos('¿3', configarray[97])+2,pos('¿4', configarray[97])-pos('¿3', configarray[97])-2);

  pop[6].server:=copy(configarray[95],pos('¿4', configarray[95])+2,pos('¿5', configarray[95])-pos('¿4', configarray[95])-2);
  pop[6].user:=copy(configarray[96],pos('¿4', configarray[96])+2,pos('¿5', configarray[96])-pos('¿4', configarray[96])-2);
  pop[6].pword:=copy(configarray[97],pos('¿4', configarray[97])+2,pos('¿5', configarray[97])-pos('¿4', configarray[97])-2);

  pop[7].server:=copy(configarray[95],pos('¿5', configarray[95])+2,pos('¿6', configarray[95])-pos('¿5', configarray[95])-2);
  pop[7].user:=copy(configarray[96],pos('¿5', configarray[96])+2,pos('¿6', configarray[96])-pos('¿5', configarray[96])-2);
  pop[7].pword:=copy(configarray[97],pos('¿5', configarray[97])+2,pos('¿6', configarray[97])-pos('¿5', configarray[97])-2);

  pop[8].server:=copy(configarray[95],pos('¿6', configarray[95])+2,pos('¿7', configarray[95])-pos('¿6', configarray[95])-2);
  pop[8].user:=copy(configarray[96],pos('¿6', configarray[96])+2,pos('¿7', configarray[96])-pos('¿6', configarray[96])-2);
  pop[8].pword:=copy(configarray[97],pos('¿6', configarray[97])+2,pos('¿7', configarray[97])-pos('¿6', configarray[97])-2);

  pop[9].server:=copy(configarray[95],pos('¿7', configarray[95])+2,pos('¿8', configarray[95])-pos('¿7', configarray[95])-2);
  pop[9].user:=copy(configarray[96],pos('¿7', configarray[96])+2,pos('¿8', configarray[96])-pos('¿7', configarray[96])-2);
  pop[9].pword:=copy(configarray[97],pos('¿7', configarray[97])+2,pos('¿8', configarray[97])-pos('¿7', configarray[97])-2);

  pop[0].server:=copy(configarray[95],pos('¿8', configarray[95])+2,pos('¿9', configarray[95])-pos('¿8', configarray[95])-2);
  pop[0].user:=copy(configarray[96],pos('¿8', configarray[96])+2,pos('¿9', configarray[96])-pos('¿8', configarray[96])-2);
  pop[0].pword:=copy(configarray[97],pos('¿8', configarray[97])+2,pos('¿9', configarray[97])-pos('¿8', configarray[97])-2);


  result:=true;
end;

procedure TConfig.save;
var
  bestand: textfile;
  regel: String;
  z, y, tempradio: Integer;
  ascreen: TScreenLine;
  templine1,form7spinedit,tempserver,tempuser,temppword: String;
begin
  assignfile(bestand,extractfilepath(application.exename)+'config.cfg');
  rewrite(bestand);

  // line 1
  regel:=IntToStr(refreshRate)+'¿'+winampLocation;
  writeln(bestand, regel);

  // line 2
  regel:=IntToStr(bootDriverDelay)+'¿'+setiEmail;
  writeln(bestand, regel);

  // line 3
  regel:=IntToStr(sizeOption)+'¿1'+IntToStr(contrast)+'¿2'+IntToStr(brightness)
        +'¿3'+IntToStr(CF_contrast)+'¿4'+IntToStr(CF_brightness);
  writeln(bestand, regel);

  // lines 4..84
  for z := 1 to 20 do begin
    for y := 1 to 4 do begin
      ascreen:=screen[z][y];
      if ascreen.enabled then regel:='¿1' else regel := '¿0';
      regel:=regel+IntToStr(ascreen.skip);
      if ascreen.center then templine1:='%c%' else templine1:='';
      templine1:=templine1 + ascreen.text + regel;
      if ascreen.noscroll then templine1:=templine1 + '1'
      else templine1:=templine1 + '0';

      if ascreen.contNextLine then templine1:=templine1+'1'
      else templine1:=templine1+'0';

      form7spinedit:=IntToStr(ascreen.interactionTime);
      if ascreen.interactionTime < 10 then form7spinedit:='0'+form7spinedit;

      templine1:=templine1+intToStr(ascreen.theme) + IntToStr(ascreen.interaction)
          + Form7Spinedit + intToStr(ascreen.showTime);

      writeln(bestand, templine1);
    end;
  end;

  // line 84
  if randomScreens then regel:='1'
  else regel:='0';

  regel := regel + IntToStr(newsRefresh);
  writeln(bestand,regel);

  // line 85
  regel:=foldUsername+'¿'+IntToStr(gameRefresh);
  writeln(bestand,regel);


  // line 86
  if checkUpdates then regel:='1'
  else regel:='0';
  writeln(bestand, regel+IntToStr(mbmRefresh));

  // line 87
  writeln(bestand, IntToStr(colorOption));

  // line 88
  writeln(bestand, distLog);

  // line 89
  writeln(bestand, IntToStr(emailPeriod)+'¿'+IntToStr(dllPeriod)+'¿¿'+IntToStr(scrollPeriod));

  // line 90
  writeln(bestand, '');

  // line 91
  writeln(bestand, IntToStr(parallelPort));

  // line 92
  if mx3Usb then regel:='1'
  else regel:='0';
  if alwaysOnTop then writeln(bestand, '1'+regel)
  else writeln(bestand, '0'+regel);

  // lines 93..94
  writeln(bestand, httpProxy);
  writeln(bestand, httpProxyPort);

  // lines 95..97
  tempserver:='';
  tempuser:='';
  temppword:='';
  for y:= 1 to 10 do begin
    tempserver:=tempserver + pop[y mod 10].server + '¿' + IntToStr(y-1);
    tempuser:=tempuser + pop[y mod 10].user + '¿' + IntToStr(y-1);
    temppword:=temppword + pop[y mod 10].pword + '¿' + IntToStr(y-1);
  end;

  writeln(bestand, tempserver);
  writeln(bestand, tempuser);
  writeln(bestand, temppword);

  // line 98
  tempradio:=0;
  if (isHD) then tempradio:=1;
  if (isMO) then tempradio:=2;
  if (isCF) then tempradio:=3;
  if (isHD2) then tempradio:=4;
  writeln(bestand, tempradio);

  // line 99
  writeln(bestand, IntToStr(comPort));

  // line 100
  writeln(bestand, intToStr(baudrate));

  closefile(bestand);
end;

end.
