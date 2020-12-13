{*_* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Author:        François PIETTE
Creation:      December 9, 2020
Version:       1.00
Description:   LogitechLedLib is a port of the Logitech Gaming LED SDK for
               Logitech devices such as keyboard, mouse, headset,...
               This has been developped with Delphi Sidney 10.4.1.
               Not tested, but should work with any recent version as well.
Credit:        The original code is:
                  Copyright (C) 2011-2014 Logitech. All rights reserved.
                  Author: Tiziano Pigliucci
                  Email: devtechsupport@logitech.com
EMail:         francois.piette@overbyte.be         http://www.overbyte.be
Legal issues:  Copyright (C) 2020 by François PIETTE
               Rue de Grady 24, 4053 Embourg, Belgium.
               <francois.piette@overbyte.be>
Disclaimer:    This software is provided 'as-is', without any express or
               implied warranty.  In no event will the author be held liable
               for any  damages arising from the use of this software.
License:       This software is published under MOZILLA PUBLIC LICENSE V2.0;
               you may not use this file except in compliance with the License.
               You may obtain a copy of the License at
               https://www.mozilla.org/en-US/MPL/2.0/
Support:       Use https://stackoverflow.com, write your question, tag it
               with "delphi" and add a comment with "@fpiette" to ping me.
Documentation: To be downloaded from Logitech developer website at:
                 https://www.logitechg.com/en-us/innovation/developer-lab.html
               You need the file "Led Illumination SDK". This will download
               a zip file and you need to look at LogitechGamingLEDSDK.pdf.
HowTo:
      The SDK is implemented by Logitech in a DLL. That DLL is registered in
      Windows registry when installing "Logitech G HUB" application. The code
      in this source will find the DLL and load it when you call:
          LogiLed.LoadLedEngine();
      Once loaded, the DLL must still be initialized by calling either
          LogiLed.InitWithName('some nice name for G HUB');
      or
          LogiLed.Init();
      After initialization, you can call the other functions to make
      illuminations and effects.
      When finished, probably just before program closes, you must call
          LogiLed.Shutdown();
      See the console mode example below. Actually, you may write any type of
      Delphi program: console/VCL/FMX/DLL, 32 or 64 bits.
      To deploy your application, you need a Logitech hardware (Almost all
      with lightning: keyboard, mouse, headset,...). And you need the SDK DLL
      to be deployed which is easily done by installing "Logitech G HUB"
      application that is used to configure Logitech hardware.
Example:
//    uses
//        System.SysUtils,
//        LogitechLedLib in 'LogitechLedLib.pas';
//    begin
//        WriteLn('Your keyboard is pulsing for 5 seconds...');
//        LogiLed.LoadLedEngine();
//        LogiLed.InitWithName('Logitech LED Delphi Console Demo');
//        LogiLed.SetTargetDevice(LOGI_DEVICETYPE_ALL);
//        LogiLed.PulseLighting(100, 90, 60, 5000, 200);
//        WriteLn('Hit RETURN');
//        ReadLn;
//        LogiLed.Shutdown();
//    end.


 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit LogitechLedLib;

interface

uses
    Winapi.Windows, System.SysUtils, System.Win.Registry;

const
    LOGI_LED_BITMAP_WIDTH           = 21;
    LOGI_LED_BITMAP_HEIGHT          = 6;
    LOGI_LED_BITMAP_BYTES_PER_KEY   = 4;

    LOGI_LED_BITMAP_SIZE            = (LOGI_LED_BITMAP_WIDTH  *
                                       LOGI_LED_BITMAP_HEIGHT *
                                       LOGI_LED_BITMAP_BYTES_PER_KEY);

    LOGI_LED_DURATION_INFINITE      = 0;

    LOGI_DEVICETYPE_MONOCHROME_ORD  = 0;
    LOGI_DEVICETYPE_RGB_ORD         = 1;
    LOGI_DEVICETYPE_PERKEY_RGB_ORD  = 2;

    LOGI_DEVICETYPE_MONOCHROME      = (1 shl LOGI_DEVICETYPE_MONOCHROME_ORD);
    LOGI_DEVICETYPE_RGB             = (1 shl LOGI_DEVICETYPE_RGB_ORD);
    LOGI_DEVICETYPE_PERKEY_RGB      = (1 shl LOGI_DEVICETYPE_PERKEY_RGB_ORD);

    LOGI_DEVICETYPE_ALL             = (LOGI_DEVICETYPE_MONOCHROME or
                                       LOGI_DEVICETYPE_RGB        or
                                       LOGI_DEVICETYPE_PERKEY_RGB);
type
    // LogiLed is a record you'll never use directly. You shall only
    // use the function, types and constants defined in like
    // Logiled.KeyName.F1 or LogiLed.SetTargetDevice(LOGI_DEVICETYPE_ALL)
    LogiLed = record
    type
        TKeyName = Integer;
        PKeyName = ^TKeyName;
        // KeyName record is only used to give a name space for key name constants
        // Note: END is a Delphi reserved word. It has been renamed to END_KEY.
        KeyName = record
            const ESC                     = $01;
            const F1                      = $3b;
            const F2                      = $3c;
            const F3                      = $3d;
            const F4                      = $3e;
            const F5                      = $3f;
            const F6                      = $40;
            const F7                      = $41;
            const F8                      = $42;
            const F9                      = $43;
            const F10                     = $44;
            const F11                     = $57;
            const F12                     = $58;
            const PRINT_SCREEN            = $137;
            const SCROLL_LOCK             = $46;
            const PAUSE_BREAK             = $145;
            const TILDE                   = $29;
            const ONE                     = $02;
            const TWO                     = $03;
            const THREE                   = $04;
            const FOUR                    = $05;
            const FIVE                    = $06;
            const SIX                     = $07;
            const SEVEN                   = $08;
            const EIGHT                   = $09;
            const NINE                    = $0A;
            const ZERO                    = $0B;
            const MINUS                   = $0C;
            const EQUALS                  = $0D;
            const BACKSPACE               = $0E;
            const INSERT                  = $152;
            const HOME                    = $147;
            const PAGE_UP                 = $149;
            const NUM_LOCK                = $45;
            const NUM_SLASH               = $135;
            const NUM_ASTERISK            = $37;
            const NUM_MINUS               = $4A;
            const TAB                     = $0F;
            const Q                       = $10;
            const W                       = $11;
            const E                       = $12;
            const R                       = $13;
            const T                       = $14;
            const Y                       = $15;
            const U                       = $16;
            const I                       = $17;
            const O                       = $18;
            const P                       = $19;
            const OPEN_BRACKET            = $1A;
            const CLOSE_BRACKET           = $1B;
            const BACKSLASH               = $2B;
            const KEYBOARD_DELETE         = $153;
            const END_KEY                 = $14F;
            const PAGE_DOWN               = $151;
            const NUM_SEVEN               = $47;
            const NUM_EIGHT               = $48;
            const NUM_NINE                = $49;
            const NUM_PLUS                = $4E;
            const CAPS_LOCK               = $3A;
            const A                       = $1E;
            const S                       = $1F;
            const D                       = $20;
            const F                       = $21;
            const G                       = $22;
            const H                       = $23;
            const J                       = $24;
            const K                       = $25;
            const L                       = $26;
            const SEMICOLON               = $27;
            const APOSTROPHE              = $28;
            const ENTER                   = $1C;
            const NUM_FOUR                = $4B;
            const NUM_FIVE                = $4C;
            const NUM_SIX                 = $4D;
            const LEFT_SHIFT              = $2A;
            const Z                       = $2C;
            const X                       = $2D;
            const C                       = $2E;
            const V                       = $2F;
            const B                       = $30;
            const N                       = $31;
            const M                       = $32;
            const COMMA                   = $33;
            const PERIOD                  = $34;
            const FORWARD_SLASH           = $35;
            const RIGHT_SHIFT             = $36;
            const ARROW_UP                = $148;
            const NUM_ONE                 = $4F;
            const NUM_TWO                 = $50;
            const NUM_THREE               = $51;
            const NUM_ENTER               = $11C;
            const LEFT_CONTROL            = $1D;
            const LEFT_WINDOWS            = $15B;
            const LEFT_ALT                = $38;
            const SPACE                   = $39;
            const RIGHT_ALT               = $138;
            const RIGHT_WINDOWS           = $15C;
            const APPLICATION_SELECT      = $15D;
            const RIGHT_CONTROL           = $11D;
            const ARROW_LEFT              = $14B;
            const ARROW_DOWN              = $150;
            const ARROW_RIGHT             = $14D;
            const NUM_ZERO                = $52;
            const NUM_PERIOD              = $53;
            const G_1                     = $FFF1;
            const G_2                     = $FFF2;
            const G_3                     = $FFF3;
            const G_4                     = $FFF4;
            const G_5                     = $FFF5;
            const G_6                     = $FFF6;
            const G_7                     = $FFF7;
            const G_8                     = $FFF8;
            const G_9                     = $FFF9;
            const G_LOGO                  = $FFFF1;
            const G_BADGE                 = $FFFF2;
        end;
        // This record is only used to give a name space for device type constants
        DeviceType = record
            const Keyboard = $0;
            const Mouse    = $3;
            const Mousemat = $4;
            const Headset  = $8;
            const Speaker  = $e;
        end;
        type
        // Global functions
        TInit                     = function ()
                                                    : Bool; cdecl;
        TInitWithName             = function (const Name          : PAnsiChar)
                                                    : Bool; cdecl;
        TShutdown                 = procedure; cdecl;

        // Info functions
        TGetSdkVersion            = function (var   MajorNum      : Integer;
                                                     var   MinorNum      : Integer;
                                                     var   BuildNum      : Integer)
                                                    : Bool; cdecl;

        // Config functions
        TGetConfigOptionNumber    = function (const ConfigPath    : PChar;
                                                     var   DefaultValue  : Double)
                                                    : Bool; cdecl;
        TGetConfigOptionBool      = function (const ConfigPath    : PChar;
                                                     var   DefaultValue  : Bool)
                                                    : Bool; cdecl;
        TGetConfigOptionColor     = function (const ConfigPath    : PChar;
                                                     var   DefaultRed    : Integer;
                                                     var   DefaultGreen  : Integer;
                                                     var   DefaultBlue   : Integer)
                                                    : Bool; cdecl;
        TGetConfigOptionRect      = function (const ConfigPath    : PChar;
                                                     var   DefaultX      : Integer;
                                                     var   DefaultY      : Integer;
                                                     var   DefaultWidth  : Integer;
                                                     var   DefaultHeight : Integer)
                                                    : Bool; cdecl;
        TGetConfigOptionString    = function (const ConfigPath    : PChar;
                                                     DefaultValue        : PChar;
                                                     BufferSize          : Integer)
                                                    : Bool; cdecl;
        TGetConfigOptionKeyInput  = function (const ConfigPath    : PChar;
                                                     DefaultValue        : PChar;
                                                     BufferSize          : Integer)
                                                    : Bool; cdecl;
        TGetConfigOptionSelect    = function (const ConfigPath    : PChar;
                                                     DefaultValue        : PChar;
                                                     var   ValueSize     : Integer;
                                                     const Values        : PChar;
                                                     BufferSize          : Integer)
                                                    : Bool; cdecl;
        TGetConfigOptionRange     = function (const ConfigPath    : PChar;
                                                     var   DefaultValue  : Integer;
                                                     MinValue            : Integer;
                                                     MaxValue            : Integer)
                                                    : Bool; cdecl;
        TSetConfigOptionLabel     = function (const ConfigPath    : PChar;
                                                     DefaultValue        : PChar;
                                                     LabelValue          : PChar)
                                                    : Bool; cdecl;

        // Generic functions => Apply to any device type.
        TSetTargetDevice          = function (TargetDevice        : Integer)
                                                    : Bool; cdecl;
        TSaveCurrentLighting      = function : Bool; cdecl;
        TSetLighting              = function (RedPercentage       : Integer;
                                                     GreenPercentage     : Integer;
                                                     BluePercentage      : Integer)
                                                    : Bool; cdecl;
        TRestoreLighting          = function : Bool; cdecl;
        TFlashLighting            = function (RedPercentage       : Integer;
                                                     GreenPercentage     : Integer;
                                                     BluePercentage      : Integer;
                                                     MilliSecDuration    : Integer;
                                                     milliSecInterval    : Integer)
                                                    : Bool; cdecl;
        TPulseLighting            = function (RedPercentage       : Integer;
                                                     GreenPercentage     : Integer;
                                                     BluePercentage      : Integer;
                                                     MilliSecDuration    : Integer;
                                                     milliSecInterval    : Integer)
                                                    : Bool; cdecl;
        TStopEffects              = function : Bool; cdecl;

        // Per-key functions => only apply to LOGI_DEVICETYPE_PERKEY_RGB devices.
        TSetLightingFromBitmap           = function(Bitmap : PBYTE)
                                                    : Bool; cdecl;
        TSetLightingForKeyWithScanCode   = function(
                                                     KeyCode         : Integer;
                                                     RedPercentage   : Integer;
                                                     GreenPercentage : Integer;
                                                     BluePercentage  : Integer)
                                                    : Bool; cdecl;
        TSetLightingForKeyWithHidCode    = function(
                                                     KeyCode         : Integer;
                                                     RedPercentage   : Integer;
                                                     GreenPercentage : Integer;
                                                     BluePercentage  : Integer)
                                                    : Bool; cdecl;
        TSetLightingForKeyWithQuartzCode = function(
                                                     KeyCode         : Integer;
                                                     RedPercentage   : Integer;
                                                     GreenPercentage : Integer;
                                                     BluePercentage  : Integer)
                                                    : Bool; cdecl;
        TSetLightingForKeyWithKeyName    = function(
                                                     KeyName         : LogiLed.TKeyName;
                                                     RedPercentage   : Integer;
                                                     GreenPercentage : Integer;
                                                     BluePercentage  : Integer)
                                                    : Bool; cdecl;
        TSaveLightingForKey              = function(
                                                     KeyName         : LogiLed.TKeyName)
                                                    : Bool; cdecl;
        TRestoreLightingForKey           = function(
                                                     KeyName         : LogiLed.TKeyName)
                                                    : Bool; cdecl;
        TExcludeKeysFromBitmap           = function(
                                                     KeyList         : LogiLed.PKeyName;
                                                     ListCount       : Integer)
                                                    : Bool; cdecl;


        // Per-key effects => only apply to LOGI_DEVICETYPE_PERKEY_RGB devices.
        TFlashSingleKey           = function (KeyName               : LogiLed.TKeyName;
                                                     RedPercentage         : Integer;
                                                     GreenPercentage       : Integer;
                                                     BluePercentage        : Integer;
                                                     MilliSecDuration      : Integer;
                                                     milliSecInterval      : Integer)
                                                    : Bool; cdecl;
        TPulseSingleKey           = function (KeyName               : LogiLed.TKeyName;
                                                     StartRedPercentage    : Integer;
                                                     StartGreenPercentage  : Integer;
                                                     StartBluePercentage   : Integer;
                                                     FinishRedPercentage   : Integer;
                                                     FinishGreenPercentage : Integer;
                                                     FinishBluePercentage  : Integer;
                                                     MilliSecDuration      : Integer;
                                                     IsInfinite            : Bool)
                                                    : Bool; cdecl;
        TStopEffectsOnKey         = function (KeyName               : LogiLed.TKeyName)
                                                    : Bool; cdecl;

        // Zonal functions => only apply to devices with zones.
        TSetLightingForTargetZone = function (DeviceType      : Integer;
                                                     Zone            : Integer;
                                                     RedPercentage   : Integer;
                                                     GreenPercentage : Integer;
                                                     BluePercentage  : Integer)
                                                    : Bool; cdecl;

        class function LoadLedEngine       : Boolean; static;
        class function UnloadLedEngine     : Boolean; static;
        class function GetAddress(const ProcName : PAnsiChar) : Pointer; static;
        class var DLLPath                  : String;
        const DLLDefaultName = {$IFDEF WIN32} 'sdk_legacy_led_x86.dll'; {$ENDIF}
                               {$IFDEF WIN64} 'sdk_legacy_led_x64.dll'; {$ENDIF}
        class var LogiDllHandle            : THandle;
        class var LogiLedLastError         : Integer;
        // Global functions
        class var Init                     : TInit;
        class var InitWithName             : TInitWithName;
        class var Shutdown                 : TShutdown;

        // Info functions
        class var GetSdkVersion            : TGetSdkVersion;

        // Config functions
        class var GetConfigOptionNumber    : TGetConfigOptionNumber;
        class var GetConfigOptionBool      : TGetConfigOptionBool;
        class var GetConfigOptionColor     : TGetConfigOptionColor;
        class var GetConfigOptionRect      : TGetConfigOptionRect;
        class var GetConfigOptionString    : TGetConfigOptionString;
        class var GetConfigOptionKeyInput  : TGetConfigOptionKeyInput;
    //  class var GetConfigOptionSelect    : TGetConfigOptionSelect;
        class var GetConfigOptionRange     : TGetConfigOptionRange;
        class var SetConfigOptionLabel     : TSetConfigOptionLabel;

        // Generic functions => Apply to any device type.
        class var SetTargetDevice          : TSetTargetDevice;
        class var SaveCurrentLighting      : TSaveCurrentLighting;
        class var SetLighting              : TSetLighting;
        class var RestoreLighting          : TRestoreLighting;
        class var FlashLighting            : TFlashLighting;
        class var PulseLighting            : TPulseLighting;
        class var StopEffects              : TStopEffects;

        // Per-key functions => only apply to LOGI_DEVICETYPE_PERKEY_RGB devices.
        class var SetLightingFromBitmap           : TSetLightingFromBitmap;
        class var SetLightingForKeyWithScanCode   : TSetLightingForKeyWithScanCode;
        class var SetLightingForKeyWithHidCode    : TSetLightingForKeyWithHidCode;
        class var SetLightingForKeyWithQuartzCode : TSetLightingForKeyWithQuartzCode;
        class var SetLightingForKeyWithKeyName    : TSetLightingForKeyWithKeyName;
        class var SaveLightingForKey              : TSaveLightingForKey;
        class var RestoreLightingForKey           : TRestoreLightingForKey;
        class var ExcludeKeysFromBitmap           : TExcludeKeysFromBitmap;

        // Per-key effects => only apply to LOGI_DEVICETYPE_PERKEY_RGB devices.
        class var FlashSingleKey           : TFlashSingleKey;
        class var PulseSingleKey           : TPulseSingleKey;
        class var StopEffectsOnKey         : TStopEffectsOnKey;

        // Zonal functions => only apply to devices with zones.
        class var SetLightingForTargetZone : TSetLightingForTargetZone;
    end;


implementation

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
class function LogiLed.GetAddress(
    const ProcName : PAnsiChar) : Pointer;
begin
    Result :=  GetProcAddress(LogiLed.LogiDllHandle, ProcName);
    if Result = nil then
        raise Exception.CreateFmt('Entry point "%s" not found', [ProcName]);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
// Logitech Gaming LED SDK is a DLL which is registered by game installer,
// or "Logitech G HUB" application or by yourself runnig RegSvr.
// We can get the full path of the DLL from the registry.
// If we don't find it in the registry, make sure the DLL is accessible
// thru the path or is in your application current directory.
// When registered by "Logitech G HUB" application, it is located in
// Win32: C:\Program Files\LGHUB\sdk_legacy_led_x86.dll
// Win64: C:\Program Files\LGHUB\sdk_legacy_led_x64.dll
class function LogiLed.LoadLedEngine : Boolean;
var
    Reg     : TRegistry;
const
    Key = 'SOFTWARE\Classes\CLSID\{a6519e67-7632-4375-afdf-caa889744403}\' +
          'ServerBinary\';
begin
    Result := FALSE;

    DLLPath := '';
    // Search for DLL registration in the registry
    Reg := TRegistry.Create(KEY_READ);
    try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.KeyExists(Key) then begin
            if Reg.OpenKey(Key, FALSE) then
                DLLPath := Reg.ReadString('');
        end;
    finally
        FreeAndNil(Reg);
    end;
    if DLLPath = '' then
        DLLPath := DLLDefaultName; // Default value

    LogiLed.LogiDllHandle := LoadLibrary(PChar(DLLPath));
    if LogiLed.LogiDllHandle = 0 then begin
        LogiLed.LogiLedLastError := GetLastError;
        Exit;
    end;

    // Global functions
    @LogiLed.Init                     := GetAddress('LogiLedInit');
    @LogiLed.InitWithName             := GetAddress('LogiLedInitWithName');
    @LogiLed.Shutdown                 := GetAddress('LogiLedShutdown');

    // Info functions
    @LogiLed.GetSdkVersion            := GetAddress('LogiLedGetSdkVersion');

    // Config functions
    @LogiLed.GetConfigOptionNumber    := GetAddress('LogiGetConfigOptionNumber');
    @LogiLed.GetConfigOptionBool      := GetAddress('LogiGetConfigOptionBool');
    @LogiLed.GetConfigOptionColor     := GetAddress('LogiGetConfigOptionColor');
    @LogiLed.GetConfigOptionRect      := GetAddress('LogiGetConfigOptionRect');
    @LogiLed.GetConfigOptionString    := GetAddress('LogiGetGetConfigOptionString');
    @LogiLed.GetConfigOptionKeyInput  := GetAddress('LogiGetConfigOptionKeyInput');
//  @LogiLed.GetConfigOptionSelect    := GetAddress('LogiGetConfigOptionSelect');
    @LogiLed.GetConfigOptionRange     := GetAddress('LogiGetConfigOptionRange');
    @LogiLed.SetConfigOptionLabel     := GetAddress('LogiSetConfigOptionLabel');

    // Generic functions => Apply to any device type.
    @LogiLed.SetTargetDevice          := GetAddress('LogiLedSetTargetDevice');
    @LogiLed.SaveCurrentLighting      := GetAddress('LogiLedSaveCurrentLighting');
    @LogiLed.SetLighting              := GetAddress('LogiLedSetLighting');
    @LogiLed.RestoreLighting          := GetAddress('LogiLedRestoreLighting');
    @LogiLed.FlashLighting            := GetAddress('LogiLedFlashLighting');
    @LogiLed.PulseLighting            := GetAddress('LogiLedPulseLighting');
    @LogiLed.StopEffects              := GetAddress('LogiLedStopEffects');

    // Per-key functions => only apply to LOGI_DEVICETYPE_PERKEY_RGB devices.
    @LogiLed.SetLightingFromBitmap           := GetAddress('LogiLedSetLightingFromBitmap');
    @LogiLed.SetLightingForKeyWithScanCode   := GetAddress('LogiLedSetLightingForKeyWithScanCode');
    @LogiLed.SetLightingForKeyWithHidCode    := GetAddress('LogiLedSetLightingForKeyWithHidCode');
    @LogiLed.SetLightingForKeyWithQuartzCode := GetAddress('LogiLedSetLightingForKeyWithQuartzCode');
    @LogiLed.SetLightingForKeyWithKeyName    := GetAddress('LogiLedSetLightingForKeyWithKeyName');
    @LogiLed.SaveLightingForKey              := GetAddress('LogiLedSaveLightingForKey');
    @LogiLed.RestoreLightingForKey           := GetAddress('LogiLedRestoreLightingForKey');
    @LogiLed.ExcludeKeysFromBitmap           := GetAddress('LogiLedExcludeKeysFromBitmap');

    // Per-key effects => only apply to LOGI_DEVICETYPE_PERKEY_RGB devices.
    @LogiLed.FlashSingleKey           := GetAddress('LogiLedFlashSingleKey');
    @LogiLed.PulseSingleKey           := GetAddress('LogiLedPulseSingleKey');
    @LogiLed.StopEffectsOnKey         := GetAddress('LogiLedStopEffectsOnKey');

    // Zonal functions => only apply to devices with zones.
    @LogiLed.SetLightingForTargetZone := GetAddress('LogiLedSetLightingForTargetZone');

    Result := TRUE;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
class function LogiLed.UnloadLedEngine : Boolean;
begin
    Result := TRUE;

    if LogiLed.LogiDllHandle <> 0 then begin
        FreeLibrary(LogiLed.LogiDllHandle);
        LogiLed.LogiDllHandle := 0;
    end;

    @LogiLed.Init                            := nil;
    @LogiLed.InitWithName                    := nil;
    @LogiLed.Shutdown                        := nil;

    // Info functions
    @LogiLed.GetSdkVersion                   := nil;

    // Config functions
    @LogiLed.GetConfigOptionNumber           := nil;
    @LogiLed.GetConfigOptionBool             := nil;
    @LogiLed.GetConfigOptionColor            := nil;
    @LogiLed.GetConfigOptionRect             := nil;
    @LogiLed.GetConfigOptionString           := nil;
    @LogiLed.GetConfigOptionKeyInput         := nil;
//  @LogiLed.GetConfigOptionSelect           := nil;
    @LogiLed.GetConfigOptionRange            := nil;
    @LogiLed.SetConfigOptionLabel            := nil;

    // Generic functions => Apply to any device type.
    @LogiLed.SetTargetDevice                 := nil;
    @LogiLed.SaveCurrentLighting             := nil;
    @LogiLed.SetLighting                     := nil;
    @LogiLed.RestoreLighting                 := nil;
    @LogiLed.FlashLighting                   := nil;
    @LogiLed.PulseLighting                   := nil;
    @LogiLed.StopEffects                     := nil;

    // Per-key functions => only apply to LOGI_DEVICETYPE_PERKEY_RGB devices.
    @LogiLed.SetLightingFromBitmap           := nil;
    @LogiLed.SetLightingForKeyWithScanCode   := nil;
    @LogiLed.SetLightingForKeyWithHidCode    := nil;
    @LogiLed.SetLightingForKeyWithQuartzCode := nil;
    @LogiLed.SetLightingForKeyWithKeyName    := nil;
    @LogiLed.SaveLightingForKey              := nil;
    @LogiLed.RestoreLightingForKey           := nil;
    @LogiLed.ExcludeKeysFromBitmap           := nil;

    // Per-key effects => only apply to LOGI_DEVICETYPE_PERKEY_RGB devices.
    @LogiLed.FlashSingleKey                  := nil;
    @LogiLed.PulseSingleKey                  := nil;
    @LogiLed.StopEffectsOnKey                := nil;

    // Zonal functions => only apply to devices with zones.
    @LogiLed.SetLightingForTargetZone        := nil;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.
