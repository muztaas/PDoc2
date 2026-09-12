; PDoc2 Inno Setup Script
[Setup]
AppName=PDoc2
AppVersion=1.0.0
AppPublisher=muztaas
DefaultDirName={pf}\PDoc2
DefaultGroupName=PDoc2
OutputDir=Output
OutputBaseFilename=PDoc2Setup
Compression=lzma
SolidCompression=yes

[Files]
Source: "src\PDoc\bin\Release\net9.0-windows7.0\win-x64\publish\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\PDoc2"; Filename: "{app}\PDoc2.exe"
Name: "{autodesktop}\PDoc2"; Filename: "{app}\PDoc2.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\PDoc2.exe"; Description: "Launch PDoc2"; Flags: postinstall skipifsilent
[Tasks]
Name: "desktopicon"; Description: "Create a desktop icon"; GroupDescription: "Additional icons:"; Flags: unchecked
