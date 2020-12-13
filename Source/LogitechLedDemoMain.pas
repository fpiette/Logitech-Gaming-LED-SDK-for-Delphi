{*_* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Author:       François PIETTE
Creation:     December 9, 2020
Version:      1.00
Description:  Demo for LogitechLedLib (Logitech Gaming LED SDK). x32 & x64.
EMail:        francois.piette@overbyte.be         http://www.overbyte.be
Legal issues: Copyright (C) 2020 by François PIETTE
              Rue de Grady 24, 4053 Embourg, Belgium.
              <francois.piette@overbyte.be>
Disclaimer:   This software is provided 'as-is', without any express or
              implied warranty.  In no event will the author be held liable
              for any  damages arising from the use of this software.
License:      This software is published under MOZILLA PUBLIC LICENSE V2.0;
              you may not use this file except in compliance with the License.
              You may obtain a copy of the License at
              https://www.mozilla.org/en-US/MPL/2.0/

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit LogitechLedDemoMain;

interface

uses
    Winapi.Windows, Winapi.Messages,
    System.SysUtils, System.Variants, System.Classes,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
    LogitechLedLib;

type
    TLogiLedMainForm = class(TForm)
        RainbowButton: TButton;
        Memo1: TMemo;
        BlackoutButton: TButton;
        OptionCheckButton: TButton;
        SaveLightingButton: TButton;
        RestoreLightingButton: TButton;
        FlashEffectButton: TButton;
        StopEffectButton: TButton;
        PulseEffectButton: TButton;
        procedure RainbowButtonClick(Sender: TObject);
        procedure BlackoutButtonClick(Sender: TObject);
        procedure FlashEffectButtonClick(Sender: TObject);
        procedure OptionCheckButtonClick(Sender: TObject);
        procedure PulseEffectButtonClick(Sender: TObject);
        procedure RestoreLightingButtonClick(Sender: TObject);
        procedure SaveLightingButtonClick(Sender: TObject);
        procedure StopEffectButtonClick(Sender: TObject);
    private
        FLogiLedInitialized : Boolean;
        procedure Display(const Msg : String); overload;
        procedure Display(const Fmt : String; Args : array of const); overload;
        function  InitializeLogiLed: Boolean;
        function  CheckApiLoaded: Boolean;
    public
        constructor Create(AOwner : TComponent); override;
        destructor  Destroy; override;
    end;

var
    LogiLedMainForm: TLogiLedMainForm;

implementation

{$R *.dfm}

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
constructor TLogiLedMainForm.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    Memo1.Clear;
    InitializeLogiLed;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
destructor TLogiLedMainForm.Destroy;
begin
    if FLogiLedInitialized then begin
        FLogiLedInitialized := FALSE;
        LogiLed.Shutdown();
    end;
    inherited Destroy;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.Display(const Msg: String);
begin
    Memo1.Lines.Add(Msg);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.Display(const Fmt: String; Args: array of const);
begin
    Display(Format(Fmt, Args));
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TLogiLedMainForm.InitializeLogiLed : Boolean;
var
    MajorNum, MinorNum, BuildNum : Integer;
begin
    Result := TRUE;
    if not FLogiLedInitialized then begin
        if not LogiLed.LoadLedEngine() then begin
            Display('Failed to load %s', [LogiLed.DLLPath]);
            Result := FALSE;
            Exit;
        end;

        if LogiLed.InitWithName('Logitech LED Delphi Demo') then
            Display('LogiLedInit succeeded')
        else
            Display('LogiLedInit failed');
        FLogiLedInitialized := TRUE;

        if not LogiLed.GetSdkVersion(MajorNum, MinorNum, BuildNum) then begin
            Display('LogiLedGetSdkVersion failed');
            Result := FALSE;
            Exit;
        end;
        Display('SDK version %d.%d.%d', [MajorNum, MinorNum, BuildNum]);

        if not LogiLed.SetTargetDevice(LOGI_DEVICETYPE_ALL) then begin
            Display('LogiLedSetTargetDevice failed');
            Exit;
        end;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TLogiLedMainForm.CheckApiLoaded : Boolean;
begin
    Result := FLogiLedInitialized;
    if not Result then begin
        Display('Logitech library not loaded');
        Exit;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.RainbowButtonClick(Sender: TObject);
begin
    if not CheckApiLoaded then
        Exit;
    if not LogiLed.SetLightingForTargetZone(LogiLed.DeviceType.Keyboard, 1, 100, 0,   0) then begin
        Display('LogiLedSetLightingForTargetZone failed');
        Exit;
    end;
    if not LogiLed.SetLightingForTargetZone(LogiLed.DeviceType.Keyboard, 2, 100, 100, 0) then begin
        Display('LogiLedSetLightingForTargetZone failed');
        Exit;
    end;
    if not LogiLed.SetLightingForTargetZone(LogiLed.DeviceType.Keyboard, 3, 0,   100, 0) then begin
        Display('LogiLedSetLightingForTargetZone failed');
        Exit;
    end;
    if not LogiLed.SetLightingForTargetZone(LogiLed.DeviceType.Keyboard, 4, 0,   100, 100) then begin
        Display('LogiLedSetLightingForTargetZone failed');
        Exit;
    end;
    if not LogiLed.SetLightingForTargetZone(LogiLed.DeviceType.Keyboard, 5, 0,   0,   100) then begin
        Display('LogiLedSetLightingForTargetZone failed');
        Exit;
    end;

    if not LogiLed.SetLightingForTargetZone(LogiLed.DeviceType.Headset,  0, 100, 100, 100) then begin
        Display('LogiLedSetLightingForTargetZone failed');
        Exit;
    end;

    if not LogiLed.SetLightingForKeyWithKeyName(LogiLed.KeyName.L, 0, 100, 100) then begin
        Display('LogiLedSetLightingForKeyWithKeyName failed');
        Exit;
    end;

    Display('Rainbow done.');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.BlackoutButtonClick(Sender: TObject);
begin
    if not CheckApiLoaded then
        Exit;
    if not LogiLed.SetLighting(0, 0, 0) then begin
        Display('LogiLedSetLighting failed');
        Exit;
    end;
    Display('Blackout done.');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.FlashEffectButtonClick(Sender: TObject);
begin
    if not CheckApiLoaded then
        Exit;
    if not LogiLed.FlashLighting(100, 90, 60, 3000, 200) then begin
        Display('LogiLedFlashLighting failed');
        Exit;
    end;
    Display('Flash effect done.');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.OptionCheckButtonClick(Sender: TObject);
var
    HealthFlashingThreshold : Double;
begin
    if not CheckApiLoaded then
        Exit;
    HealthFlashingThreshold := 0.15;
    if not LogiLed.GetConfigOptionNumber('player/flashing_edge',
                                        HealthFlashingThreshold) then begin
        Display('LogiLedGetConfigOptionNumber failed');
        Exit;
    end;
    Display('HealthFlashingThreshold = %f', [HealthFlashingThreshold]);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.PulseEffectButtonClick(Sender: TObject);
begin
    if not CheckApiLoaded then
        Exit;
    if not LogiLed.PulseLighting(100, 90, 60, 3000, 200) then begin
        Display('LogiLedPulseLighting failed');
        Exit;
    end;
    Display('Pulse effect done.');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.RestoreLightingButtonClick(Sender: TObject);
begin
    if not CheckApiLoaded then
        Exit;
    if not LogiLed.RestoreLighting() then begin
        Display('LogiLedRestoreLighting failed');
        Exit;
    end;
    Display('Restore lighting done.');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.SaveLightingButtonClick(Sender: TObject);
begin
    if not CheckApiLoaded then
        Exit;
    if not LogiLed.SaveCurrentLighting() then begin
        Display('LogiLedSaveCurrentLighting failed');
        Exit;
    end;
    Display('Save lighting done.');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TLogiLedMainForm.StopEffectButtonClick(Sender: TObject);
begin
    if not CheckApiLoaded then
        Exit;
    if not LogiLed.StopEffects() then begin
        Display('LogiLedStopEffects failed');
        Exit;
    end;
    Display('Stop effect done.');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.
