[Code]
var
  // Custom Pages
  DataDirPage: TInputDirWizardPage;

  # if !AllInOneInstall
  DownloadPage: TDownloadWizardPage;
  # endif

  // Optional pages
  DxWrapperPage: TWizardPage;
  DxWrapperPage2: TWizardPage;
  DgVoodooPage: TWizardPage;
  DgVoodooPage2: TWizardPage;

  // Localization
  lblEnglishImprovements: TLabel;
  EnglishImprovements: TCheckBox;
  descEnglishImprovements: TNewStaticText;

  // Russian fonts
  lblRussianFonts: TLabel;
  RussianFonts: TCheckBox;
  descRussianFonts: TNewStaticText;

// Report on download progress
# if !AllInOneInstall
function OnDownloadProgress(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
  DownloadPage.SetText('Downloading mod',(IntToStr(Progress/1048576)) + ' MB / ' + DownloadSize + ' MB');
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result := True;
end;
# endif

// Update progress of installer bar
procedure UpdateProgress(Position: Integer);
begin
  WizardForm.ProgressGauge.Position :=
    Position * WizardForm.ProgressGauge.Max div 100;
end;

// Handles key presses for an integer field
procedure DigitFieldKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key = #8) or { Tab key }
          (Key = #3) or (Key = #22) or (Key = #24) or { Ctrl+C, Ctrl+V, Ctrl+X }
          IsDigit(Key)) then
  begin
    Key := #0;
  end;
end;        


procedure InitializeUi();
var 
  dir : string;

  // Strings that are used more than once
  txtAa: String;
  txtAaDesc: String;
  txtAf: String;
  txtAfDesc: String;
  txtEnhancementsPage: String;
  txtReShade: String;
  txtReShadeDesc: String;
  txtSaturation: String;
  txtSaturationDesc: String;
  txtSharpening: String;
  txtSharpeningDesc: String;
  txtHdr: String;
  txtHdrDesc: String;
  txtBloom: String;
  txtBloomDesc: String;
begin
  txtAa := 'Anti-Aliasing';
  txtAaDesc := 'Anti-Aliasing removes jagged edges in-game, effectively making them appear smoother at a performance cost. Disable this option if you''re running low-end hardware.';
  txtAf := 'Anisotropic Filtering';
  txtAfDesc := 'Anisotropic Filtering improves the quality of textures when viewing them from the side with minimal performance overhead.';
  txtEnhancementsPage := 'Choose additional graphics enhancements.';
  txtReShade := 'Enable ReShade';
  txtReShadeDesc := 'This option enables ReShade, which allows for the use of various post-processing effects to improve the game''s appearance. If it''s been enabled, the configuration below can be adjusted at any time by pressing the ''Home'' key in-game.';
  txtSaturation := 'Add increased saturation (recommended)';
  txtSaturationDesc := 'Simply gives Freelancer a slightly more-saturated look.';
  txtSharpening := 'Add adaptive sharpening (recommended)';
  txtSharpeningDesc := 'Makes the game look slightly more crisp without oversharpening everything.';
  txtHdr := 'Add Fake HDR (High Dynamic Range)';
  txtHdrDesc := 'Makes darker areas a bit darker, and brighter areas a bit brighter.';
  txtBloom := 'Add Bloom';
  txtBloomDesc := 'Adds glow to brighter areas. May reduce detail.';

  # if !AllInOneInstall
  // Read download size
  DownloadSize := IntToStr(StrToInt64(ExpandConstant('{#SizeZip}'))/1048576);
  // Initialize DownloadPage
  DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
  # endif

  dir := 'C:\Program Files (x86)\Microsoft Games\Freelancer'

  // Initialize DataDirPage and add content
  DataDirPage := CreateInputDirPage(wpInfoBefore,
  'Select Freelancer installation', 'Where is Freelancer installed?',
  'Select the folder in which a fresh and completely unmodded copy of Freelancer is installed. This is usually ' + dir + '.' + #13#10 +
  'The folder you select here will be copied without modification.',
  False, '');
  DataDirPage.Add('');
  
  // If the Reg key exists, use its content to populate the folder location box. Use the default path if otherwise.
  RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Microsoft Games\Freelancer\1.0', 'AppPath', dir)
  DataDirPage.Values[0] := dir
  
  
end;
