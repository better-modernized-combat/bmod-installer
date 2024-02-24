; Inno Install Script for Freelancer: BMOD
; Forked from https://github.com/oliverpechey/Freelancer-HD-Edition-Installer

#define MyAppVersion "0.1"
#define MyAppName "Freelancer: Better Modernized Combat v" + MyAppVersion
#define MyAppPublisher "Freelancer: BMOD Development Team"
#define MyAppURL "https://github.com/better-modernized-combat"
#define MyAppExeName "Freelancer.exe"
#define MyFolderName "freelancer-bmod-" + MyAppVersion
#define MyZipName "freelancerbmod"      
; This variable controls whether the zip is shipped with the exe or downloaded from a mirror
#define AllInOneInstall true
#dim Mirrors[1] {"https://github.com/better-modernized-combat/bmod-client/archive/refs/tags/" + MyAppVersion + ".zip"}
#if AllInOneInstall
  #define SizeZip 0 
#else
  #define SizeZip 2688696320 
#endif
#define SizeExtracted 4646719488
#define SizeVanilla 985624576
#define SizeBuffer 100000
#define SizeAll SizeZip + SizeExtracted + SizeVanilla + SizeBuffer

[Setup]
AllowNoIcons=yes
AppId={{Q40FDCWA-3A45-4CC3-9FDA-167EE480A1E0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
ChangesAssociations=yes
Compression=lzma
DefaultDirName={userappdata}\Freelancer BMOD
DefaultGroupName=Freelancer BMOD
DisableWelcomePage=False
DisableDirPage=False
ExtraDiskSpaceRequired = {#SizeAll}
InfoBeforeFile={#SourcePath}\Assets\Text\installinfo.txt
OutputBaseFilename=FreelancerBMODSetup
SetupIconFile={#SourcePath}\Assets\Images\icon.ico
SolidCompression=yes
UninstallDisplayIcon={#SourcePath}\Assets\Images\icon.ico
UninstallDisplayName={#MyAppName}
WizardImageFile={#SourcePath}\Assets\Images\backgroundpattern.bmp
WizardSmallImageFile={#SourcePath}\Assets\Images\icon*.bmp
WizardSizePercent=105
VersionInfoVersion=1.0.0.0

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\EXE\{#MyAppExeName}"
Name: "{commondesktop}\Freelancer BMOD"; Filename: "{app}\EXE\{#MyAppExeName}"; Tasks: desktopicon

[Files]
Source: "Assets\Text\installinfo.txt"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall
Source: "Assets\Text\PerfOptions.ini"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall
Source: "Assets\Fonts\AGENCYB.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Bold"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\AGENCYR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\AGENCYR_CR.TTF"; DestDir: "{autofonts}"; FontInstall: "Agency FB Cyrillic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\Fonts\ARIALUNI.TTF"; DestDir: "{autofonts}"; FontInstall: "Arial Unicode MS"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "Assets\External\7za.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "Assets\External\flcombinedpatch.7z"; DestDir: "{tmp}"; Flags: deleteafterinstall;
Source: "Scripts\vcredist.ps1"; DestDir: "{tmp}"

# if AllInOneInstall
Source: "Assets\Mod\freelancerbmod.7z"; DestDir: "{tmp}"; Flags: nocompression deleteafterinstall
#endif

[Run]
Filename: "powershell.exe"; \
  Parameters: "-ExecutionPolicy Bypass -File ""{tmp}\vcredist.ps1"""; \
  WorkingDir: {app}; Flags: runhidden
Filename: "{app}\EXE\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Messages]
WelcomeLabel2=Freelancer: Better Modernized Combat (BMOD) is a modification for Freelancer, the 2003 space shooter by Chris Roberts. The core goal of the mod is to create a fun and compelling PvE experience for solo and group players in a multiplayer setting.%n%nThis installer requires a clean, freshly installed Freelancer directory.
FinishedLabel=Setup has finished installing [name] on your computer. The application may be launched by selecting the installed shortcut.%n%nNOTE: [name] has been installed as a separate application. Therefore, your vanilla Freelancer installation has not been modified and can still be played at any time.

[Code]
# if !AllInOneInstall
// Declaration of global variables
var
  // Allows us to skip the downloading of the files and just copy it from the local PC to save time
  OfflineInstall: String;

  // String list of mirrors that we can potentially download the mod from. This is populated in InitializeWizard()
  mirrors : TStringList;
  // Size of Download in MB
  DownloadSize : String;
#endif

// Imports from other .iss files
#include "utilities.iss"
#include "ui.iss"
// Checks which step we are on when it changed. If its the postinstall step then start the actual installing
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode, i: Integer;
begin
    if CurStep = ssPostInstall then
    begin
        # if !AllInOneInstall
          if OfflineInstall <> 'false' then
            FileCopy(OfflineInstall,ExpandConstant('{tmp}\{#MyZipName}.7z'),false);
        # endif

        // Copy Vanilla game to directory
        UpdateProgress(0);
        WizardForm.StatusLabel.Caption := 'Copying vanilla Freelancer directory...';
        DirectoryCopy(DataDirPage.Values[0],ExpandConstant('{app}'),False);
        UpdateProgress(30);

        // Unzip
        WizardForm.StatusLabel.Caption := ExpandConstant('Unpacking {#MyAppName}...');
        Exec(ExpandConstant('{tmp}\7za.exe'), ExpandConstant(' x -y -aoa "{tmp}\{#MyZipName}.7z"  -o"{app}"'), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
        Exec(ExpandConstant('{tmp}\7za.exe'), ExpandConstant(' x -y -aoa "{tmp}\flcombinedpatch.7z"  -o"{app}"'), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
        // -aoa Overwrite All existing files without prompt
        // -o Set output directory
        // -y Assume "Yes" on all Queries
        UpdateProgress(60);

        // Copy mod files
        WizardForm.StatusLabel.Caption := ExpandConstant('Relocating {#MyAppName}...');

        DirectoryCopy(ExpandConstant('{app}\{#MyFolderName}'),ExpandConstant('{app}'),True);

        DelTree(ExpandConstant('{app}\{#MyFolderName}'), True, True, True);
        UpdateProgress(90);

        // Process options
        WizardForm.StatusLabel.Caption := 'Processing your options...';
        WizardForm.StatusLabel.Caption := 'Cleaning up...';
        UpdateProgress(95);

        // Remove 2003 junk files
        RemoveJunkFiles('dll');
        RemoveJunkFiles('msi');

        // Remove additional junk files
        DeleteFile(ExpandConstant('{app}\UNINSTAL.EXE'));
        // TODO next update: uncomment
        //DeleteFile(ExpandConstant('{app}\.gitattributes'));
        //DelTree(ExpandConstant('{app}\.github'), True, True, True);

        // Install Complete!
        UpdateProgress(100);
    end;
end;

// Various logic to be applied when the user clicks on the Next button.
function NextButtonClick(PageId: Integer): Boolean;
var
  i : Integer;
  RefreshRateError: String;
begin
    Result := True
    // If they specify an offline file in the cmd line. Check if it's valid, if not don't let them continue.
    # if !AllInOneInstall
    if ((PageId = 1) and (OfflineInstall <> 'false') and (not FileExists(OfflineInstall) or (Pos('.7z',OfflineInstall) < 1))) then begin
      MsgBox('The specified source file either doesn''t exist or is not a valid .7z file', mbError, MB_OK);
      Result := False;
      exit;
    end;
    # endif

    // Validate vanilla Freelancer directory
    if PageId = DataDirPage.ID then begin
      // Check if Freelancer is installed in the folder they have specified
      if not FileExists(DataDirPage.Values[0] + '\EXE\Freelancer.exe') then begin
        MsgBox('Freelancer does not seem to be installed in that folder. Please select the correct folder.', mbError, MB_OK);
        Result := False;
        exit;
      end;

      // If the installer is being run from the same directory as the vanilla Freelancer directory, the installation will fail because the running installer cannot be copied.
      // This checks if the active installer has been ran from any directory inside the selected vanilla Freelancer folder.
      // No issues occur when Freelancer from the vanilla directory is running, so no need to check for that.
      if Pos(DataDirPage.Values[0], GetCurrentDir()) > 0 then begin
        MsgBox(ExpandConstant('The {#MyAppName} installer is located in the same directory as the vanilla Freelancer directory. This would cause the installation to fail because this file cannot be copied.' + #13#10 + #13#10
          + 'Please close the {#MyAppName} installer, move the installer .exe file to a directory outside your vanilla Freelancer installation and try again.'), mbError, MB_OK);
        Result := False;
        exit;
      end;
    end;

    // Validate install location
    if (PageId = 6) then begin
      // Needs to be in a seperate if statement since it tries to expand {app} even if not on PageID 6. Pascal what are you doing!
      if(Pos(AddBackslash(DataDirPage.Values[0]),ExpandConstant('{app}')) > 0) then begin
        MsgBox('Freelancer: BMOD cannot be installed to the same location as your vanilla install. Please select a new location.', mbError, MB_OK);
        Result := False;
        exit;
      end;
      // Check the install directory is empty
      if(not isEmptyDir(ExpandConstant('{app}'))) then begin
        MsgBox('Freelancer: BMOD cannot be installed to a directory that is not empty. Please empty this directory or choose another one.', mbError, MB_OK);
        Result := False;
        exit;
      end;
    end;
    # if !AllInOneInstall
    // Start downloading the mod
    if ((PageId = 10) and (OfflineInstall = 'false')) then begin
      for i:= 0 to mirrors.Count - 1 do
      begin
        DownloadPage.Clear;
        DownloadPage.Add(mirrors[i], ExpandConstant('{#MyZipName}.7z'), '');
        DownloadPage.SetText('Downloading mod...', '');
        DownloadPage.Show;
        DownloadPage.ProgressBar.Style := npbstNormal;
        try
          DownloadPage.Download;
          Result := True;
          i := mirrors.Count - 1;
        except
          if(i = mirrors.Count - 1) then
            SuppressibleMsgBox('All downloads failed. Please contact us on Discord: https://discord.gg/fCWtT3Ju8S', mbError, MB_OK, IDOK)
          else
            if SuppressibleMsgBox('Download failed. Do you want to try downloading with an alternate mirror?', mbError, MB_RETRYCANCEL, IDRETRY) = IDCANCEL then
              i := mirrors.Count - 1;
          Result := False;
          DownloadPage.Hide;
        finally
          DownloadPage.Hide;
        end;
      end;
    end;
    # endif
end;

// Run when the wizard is opened.
procedure InitializeWizard;
begin
    WizardForm.WizardSmallBitmapImage.Stretch := false;

    EDD_GET_DEVICE_INTERFACE_NAME := 1; // TODO: Initialize constants somewhere else
    DISPLAY_DEVICE_PRIMARY_DEVICE := 4;

    # if !AllInOneInstall
      // Offline install
      OfflineInstall := ExpandConstant('{param:sourcefile|false}')

      // Copy mirrors from our preprocessor to our string array. This allows us to define the array at the top of the file for easy editing
      mirrors := TStringList.Create;

      #sub PopMirrors
        mirrors.add('{#Mirrors[i]}');
      #endsub

      # define i
      #for {i = 0; i < DimOf(Mirrors); i++} PopMirrors
    # endif

    // Gets some information about the system for later use
    DesktopRes := Resolution();
    Wine := IsWine;
    GpuManufacturer := GetGpuManufacturer();
    SystemLanguage := GetSystemLanguage();

    // Initialize EditedConfigFiles
    EditedConfigFiles := TStringList.Create;
    EditedConfigFiles.Sorted := true;

    // Initialize UI. This populates all our ui elements with text, size and other properties
    InitializeUi();
 end;
