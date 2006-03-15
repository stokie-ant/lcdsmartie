unit UDataMBM;

interface

uses
  SysUtils,DataThread;

const
  MaxMBMStat = 11;
  MaxMBMCPU = 5;

type
  TSensorType = (stUnknown, stTemperature, stVoltage, stFan, stMhz, stPercentage);
  TBusType = (btISA, btSMBus, btVIA686ABus, btDirectIO);
  TSMBType = (smtSMBIntel, smtSMBAMD, smtSMBALi, smtSMBNForce, smtSMBSIS);

  TSharedIndex = Record
    iType : TSensorType;                          // type of sensor
    Count : Integer;                              // number of sensor for that type
  end;

  TSharedInfo = Record
    siSMB_Base : Word;                            // SMBus base address
    siSMB_Type : TBusType;                        // SMBus/Isa bus used to access chip
    siSMB_Code : TSMBType;                        // SMBus sub type, Intel, AMD or ALi
    siSMB_Addr : Byte;                            // Address of sensor chip on SMBus
    siSMB_Name : Array [0..40] of AnsiChar;       // Nice name for SMBus
    siISA_Base : Word;                            // ISA base address of sensor chip on ISA
    siChipType : Integer;                         // Chip nr, connects with Chipinfo.ini
    siVoltageSubType : Byte;                      // Subvoltage option selected
  end;

  TSharedSensor = Record
    ssType : TSensorType;                         // type of sensor
    ssName : Array [0..11] of AnsiChar;           // name of sensor
    sspadding1: Array [0..2] of Char;             // padding of 3 byte
    ssCurrent : Double;                           // current value
    ssLow : Double;                               // lowest readout
    ssHigh : Double;                              // highest readout
    ssCount : LongInt;                            // total number of readout
    sspadding2: Array [0..3] of Char;             // padding of 4 byte
    ssTotal : Extended;                           // total amout of all readouts
    sspadding3: Array [0..5] of Char;             // padding of 6 byte
    ssAlarm1 : Double;                            // temp & fan: high alarm; voltage: % off;
    ssAlarm2 : Double;                            // temp: low alarm
  end;

  PSharedData = ^TSharedData;
  TSharedData = Record
    sdVersion : Double;                           // version number (example: 51090)
    sdIndex : Array [0..9] of TSharedIndex;       // Sensor index
    sdSensor : Array [0..99] of TSharedSensor;    // sensor info
    sdInfo : TSharedInfo;                         // misc. info
    sdStart : Array [0..40] of AnsiChar;          // start time
    sdCurrent : Array [0..40] of AnsiChar;        // current time
    sdPath : Array [0..255] of AnsiChar;          // MBM path
  end;

  TMBMRecord = record
    Temperature : double;
    Voltage : double;
    Fan : double;
    TempName : String;
    VoltName : String;
    FanName : String;
  end;

  TMBMDataThread = class(TDataThread)
  private
    // Begin MBM Stats - main thread only
    fmbmactive: Boolean;
    fMbmCpuUsage: double;
    MBMStats : array[1..MaxMBMStat] of TMBMRecord;
    CPU: Array [1..MaxMBMCPU] of double;
    procedure SetMBMCPUUsage(Value : double);
    function GetMBMCPUUsage : double;
    function ReadMBM5Data : Boolean;
  protected
    procedure  DoUpdate; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure  ResolveVariables(var Line : string); override;
    property MBMCpuUsage : double read GetMBMCPUUsage write SetMBMCPUUsage;
    property MBMActive : boolean read fMBMActive;
  end;

implementation

uses
  Math, Windows, UConfig, UUtils;

constructor TMBMDataThread.Create;
begin
  fMbmCpuUsage := 0;
  fmbmactive := false;
  fillchar(MBMStats,sizeof(MBMStats),$00);
  inherited Create(config.mbmRefresh*1000);
end;

destructor TMBMDataThread.Destroy;
begin
  inherited;
end;

procedure TMBMDataThread.SetMBMCPUUsage(Value : double);
begin
  fDataLock.Enter;
  fMbmCpuUsage := Value;
  fDataLock.Leave;
end;

function TMBMDataThread.GetMBMCPUUsage : double;
begin
  fDataLock.Enter;
  Result := fMbmCpuUsage;
  fDataLock.Leave;
end;

procedure TMBMDataThread.ResolveVariables(var Line : string);
var
  StatNo : byte;
begin
  if (pos('$Temp', line) <> 0) then
  begin
    fDataLock.Enter;
    try
      for StatNo := 1 to MaxMBMStat-1 do
      begin
        line := StringReplace(line, '$Tempname' + IntToStr(StatNo), MBMStats[StatNo].TempName,
          [rfReplaceAll]);
        line := StringReplace(line, '$Temp' + IntToStr(StatNo),
          FloatToStr(MBMStats[StatNo].Temperature, localeFormat), [rfReplaceAll]);
      end;
    finally
      fDataLock.Leave;
    end;
  end;
  if (pos('$Fan', line) <> 0) then
  begin
    fDataLock.Enter;
    try
      for StatNo := 1 to MaxMBMStat-1 do
      begin
        line := StringReplace(line, '$Fanname' + IntToStr(StatNo), MBMStats[StatNo].Fanname,
          [rfReplaceAll]);
        line := StringReplace(line, '$FanS' + IntToStr(StatNo),
          FloatToStr(MBMStats[StatNo].Fan, localeFormat), [rfReplaceAll]);
      end;
    finally
      fDataLock.Leave;
    end;
  end;

  if (pos('$Volt', line) <> 0) then
  begin
    fDataLock.Enter;
    try
      for StatNo := 1 to MaxMBMStat-1 do
      begin
        line := StringReplace(line, '$Voltname' + IntToStr(StatNo),MBMStats[StatNo].Voltname,
          [rfReplaceAll]);
        line := StringReplace(line, '$Voltage' + IntToStr(StatNo),
          FloatToStr(MBMStats[StatNo].Voltage, localeFormat), [rfReplaceAll]);
      end;
    finally
      fDataLock.Leave;
    end;
  end;
end;

function TMBMDataThread.ReadMBM5Data : Boolean;
var
  myHandle, B, TotalCount : Integer;
  temptemp, tempfan, tempmhz, tempvolt: Integer;
  SharedData: PSharedData;
begin
  myHandle := OpenFileMapping(FILE_MAP_READ, False, '$M$B$M$5$S$D$');
  if myHandle > 0 then
  begin
    SharedData := MapViewOfFile(myHandle, FILE_MAP_READ, 0, 0, 0);
    with SharedData^ do
    begin
      TotalCount := sdIndex[0].Count + sdIndex[1].Count + sdIndex[2].Count +
        sdIndex[3].Count + sdIndex[4].Count;
      temptemp := 0;
      tempfan := 0;
      tempvolt := 0;
      tempmhz := 0;
      for B := 0 to TotalCount - 1 do
      begin
        with sdSensor[B] do
        begin
          if ssType = stTemperature then
          begin
            temptemp := min(MaxMBMStat,temptemp + 1);
            fDataLock.Enter;
            MBMStats[temptemp].Temperature := ssCurrent;
            MBMStats[temptemp].TempName := ssName;
            fDataLock.Leave;
          end;
          if ssType = stVoltage then
          begin
            tempvolt := min(MaxMBMStat,tempvolt + 1);
            fDataLock.Enter;
            MBMStats[tempvolt].Voltage := round(ssCurrent*100)/100;
            MBMStats[tempvolt].VoltName := ssName;
            fDataLock.Leave;
          end;
          if ssType = stFan then
          begin
            tempfan := min(MaxMBMStat,tempfan + 1);
            fDataLock.Enter;
            MBMStats[tempfan].Fan := ssCurrent;
            MBMStats[tempfan].FanName := ssName;
            fDataLock.Leave;
          end;
          if ssType = stMhz then
          begin
            tempmhz := min(MaxMBMCPU,tempmhz + 1);
            CPU[tempmhz] := ssCurrent;
          end;
          if ssType = stPercentage then
          begin
            MbmCpuUsage := ssCurrent;
          end;
        end;
      end;
    end;
    UnMapViewOfFile(SharedData);
    Result := True;
    CloseHandle(myHandle);
  end
  else result := false;
end;

procedure TMBMDataThread.DoUpdate;
var
  bMbm : Boolean;
  ScreenCount, LineCount: Integer;
  screenline: String;
begin

  bMbm := false;

  for ScreenCount := 1 to MaxScreens do
  begin
    for LineCount := 1 to config.height do
    begin
      screenline := config.screen[ScreenCount][LineCount].text;
      if (not bMbm) and (pos('$Fan', screenline) <> 0) then bMbm := true;
      if (not bMbm) and (pos('$Volt', screenline) <> 0) then bMbm := true;
      if (not bMbm) and (pos('$Temp', screenline) <> 0) then bMbm := true;
      if (not bMbm) and (pos('$CPUUsage%', screenline) <> 0) then bMbm := true; // used as backup.
    end;
  end;

  if bMbm then
    fmbmactive := ReadMBM5Data();
end;

end.
