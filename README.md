# Logitech-Gaming-LED-SDK-for-Delphi
This repository contains the file required to use Logitech Gaming LED SDK from a Delphi application.

Using Logitech Gaming LED SDK, you'll be able to make illuminations on your Logitech hardware supporting that feature. For example, you may assign colors to keys on the keyboard, make it flash or pulse.

Example of console mode program making the keyboard pulse during 5 seconds:

```delphi
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
```

Of course you are not limited to a console mode program. You can make VCL or FMX as well, either 32 or 64 bits. There is a VCL application in the repository showing some of the features.

To deploy your application, you need a Logitech hardware (Almost all with lightning: keyboard, mouse, headset,...). And you need the Logitech SDK DLL to be deployed which is easily done by installing "Logitech G HUB" application that is used to configure Logitech hardware.



