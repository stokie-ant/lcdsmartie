program LCDSmartie;

uses

  madExcept,
  madLinkDisAsm,
  Forms,
  UMain in 'UMain.pas' {LCDSmartieDisplayForm},
  lcdline in 'lcdline.pas' {LCDLineFrame: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'LCD Smartie';
  Application.HelpFile := 'readme.txt';
  Application.ShowMainForm := False;
  Application.CreateForm(TLCDSmartieDisplayForm, LCDSmartieDisplayForm);
  Application.Run;
end.
