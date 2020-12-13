program LogitechLedDemo;

uses
  Vcl.Forms,
  LogitechLedDemoMain in 'LogitechLedDemoMain.pas' {LogiLedMainForm},
  LogitechLedLib in 'LogitechLedLib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLogiLedMainForm, LogiLedMainForm);
  Application.Run;
end.
