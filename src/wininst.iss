; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Howl"
#define MyAppVersion "0.4.1"
#define MyAppPublisher "The Howl Developers"
#define MyAppURL "http://howl.io/"
#define MyAppExeName "howl.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F15DBA31-AA25-4F0F-83F4-D13588984724}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}  
DisableWelcomePage=no
DisableProgramGroupPage=yes
DefaultGroupName=Howl
LicenseFile=../LICENSE.md
OutputDir=wininst
OutputBaseFilename=howl-setup
Compression=lzma
SolidCompression=yes
SetupIconFile=howl.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "windist\bin\*"; DestDir: "{app}\bin"; Flags: recursesubdirs ignoreversion
Source: "windist\lib\*"; DestDir: "{app}\lib"; Flags: recursesubdirs ignoreversion
Source: "windist\share\*"; DestDir: "{app}\share"; Flags: recursesubdirs ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\bin\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
const 
    ModPathName = 'modifypath'; 
    ModPathType = 'system'; 

function ModPathDir(): TArrayOfString; 
begin 
    setArrayLength(Result, 1) 
    Result[0] := ExpandConstant('{app}\host\bin'); 
end; 
#include "deps/modpath.iss"
