program LCDSmartie;

uses
  Forms,
  parport in 'parport.pas' {parport},
  UMain in 'UMain.pas' {Form1},
  USetup in 'USetup.pas' {Form2},
  UMOSetup in 'UMOSetup.pas' {Form3},
  UCredits in 'UCredits.pas' {Form4},
  UCFSetup in 'UCFSetup.pas' {Form5},
  UPara in 'UPara.pas' {Form6},
  UInteract in 'UInteract.pas' {Form7},
  UConfig in 'UConfig.pas',
  System2 in 'system2.pas',
  adCpuUsage in 'adCpuUsage.pas',
  cxCpu40 in 'cxCpu40.pas',
  IpExport in 'IpExport.pas',
  IpHlpApi in 'IpHlpApi.pas',
  IpIfConst in 'IpIfConst.pas',
  IpRtrMib in 'IpRtrMib.pas',
  IpTypes in 'IpTypes.pas',
  DLPortIO in 'DLPORTIO.PAS';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'LCD Smartie';
  Application.HelpFile := 'README.HTM';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
