program LogitechLedConsoleDemo;
{$APPTYPE CONSOLE}
{$R *.res}
uses
    System.SysUtils,
    LogitechLedLib in 'LogitechLedLib.pas';
begin
    WriteLn('Your keyboard is pulsing for 5 seconds...');
    LogiLed.LoadLedEngine();
    LogiLed.InitWithName('Logitech LED Delphi Console Demo');
    LogiLed.SetTargetDevice(LOGI_DEVICETYPE_ALL);
    LogiLed.PulseLighting(100, 90, 60, 5000, 200);
    WriteLn('Hit RETURN');
    ReadLn;
    LogiLed.Shutdown();
end.
