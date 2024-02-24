[Code]
var
  // Custom Pages
  DataDirPage: TInputDirWizardPage;
  CallSign: TInputOptionWizardPage;
  PitchVariations: TInputOptionWizardPage;
  PageEnglishImprovements: TWizardPage;
  PageSinglePlayer: TWizardPage;
  StartupRes: TInputOptionWizardPage;
  LogoRes: TInputOptionWizardPage;
  SmallText: TInputOptionWizardPage;
  PageWidescreenHud: TWizardPage;
  PageDarkHUD: TWizardPage;
  PagePlanetScape: TWizardPage;
  PageGraphicsApi: TWizardPage;
  PageEffects: TWizardPage;
  PageDrawDistances: TInputOptionWizardPage;
  PageSkips: TWizardPage;
  PageMiscOptions: TWizardPage;

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

  // Single Player mode
  lblSinglePlayerMode: TLabel;
  StoryMode: TComboBox;
  descSinglePlayerMode: TNewStaticText;

  // Level requirements
  lblLevelRequirements: TLabel;
  LevelRequirements: TCheckBox;
  descLevelRequirements: TNewStaticText;

  // New save folder
  lblNewSaveFolder: TLabel;
  NewSaveFolder: TCheckBox;
  descNewSaveFolder: TNewStaticText;

  // Advanced Widescreen HUD
  lblWidescreenHud: TLabel;
  WidescreenHud: TCheckBox;
  descWidescreenHud: TNewStaticText;

  // Weapon Groups
  lblWeaponGroups: TLabel;
  WeaponGroups: TCheckBox;
  descWeaponGroups: TNewStaticText;

  // Dark HUD
  lblDarkHud: TLabel;
  DarkHud: TCheckBox;
  descDarkHud: TNewStaticText;

  // Custom Icons
  lblVanillaIcons: TLabel;
  lblAlternativeIcons: TLabel;
  lblFlatIcons: TLabel;
  VanillaIcons: TRadioButton;
  AlternativeIcons: TRadioButton;
  FlatIcons: TRadioButton;
  descCustomIcons: TNewStaticText;

  // Fix clipping with 16:9 resolution planetscapes
  lblPlanetScape: TLabel;
  PlanetScape: TCheckBox;
  descPlanetScape: TNewStaticText;

  // Graphics API
  lblDxWrapperGraphicsApi: TLabel;
  lblDgVoodooGraphicsApi: TLabel;
  lblVanillaGraphicsApi: TLabel;
  lblLightingFixGraphicsApi: TLabel;
  DxWrapperGraphicsApi: TRadioButton;
  DgVoodooGraphicsApi: TRadioButton;
  VanillaGraphicsApi: TRadioButton;
  LightingFixGraphicsApi: TRadioButton;
  descDxWrapperGraphicsApi: TNewStaticText;
  descDgVoodooGraphicsApi: TNewStaticText;
  descVanillaGraphicsApi: TNewStaticText;
  descLightingFixGraphicsApi: TNewStaticText;
  descGraphicsApi: TNewStaticText;

  // DxWrapper
  lblDxWrapperAf: TLabel;
  lblDxWrapperAa: TLabel;
  DxWrapperAf: TComboBox;
  DxWrapperAa: TComboBox;
  descDxWrapperAf: TNewStaticText;
  descDxWrapperAa: TNewStaticText;

  // DxWrapper #2
  lblDxWrapperReShade: TLabel;
  lblDxWrapperSaturation: TLabel;
  lblDxWrapperSharpening: TLabel;
  lblDxWrapperHdr: TLabel;
  lblDxWrapperBloom: TLabel;
  DxWrapperReShade: TCheckBox;
  DxWrapperSaturation: TCheckBox;
  DxWrapperSharpening: TCheckBox;
  DxWrapperHdr: TCheckBox;
  DxWrapperBloom: TCheckBox;
  descDxWrapperReShade: TNewStaticText;
  descDxWrapperSaturation: TNewStaticText;
  descDxWrapperSharpening: TNewStaticText;
  descDxWrapperHdr: TNewStaticText;
  descDxWrapperBloom: TNewStaticText;

  // dgVoodoo
  lblDgVoodooAf: TLabel;
  lblDgVoodooAa: TLabel;
  lblDgVoodooRefreshRate: TLabel;
  lblDgVoodooRefreshRateHz: TLabel;
  DgVoodooAf: TComboBox;
  DgVoodooAa: TComboBox;
  DgVoodooRefreshRate: TNewEdit;
  descDgVoodooAf: TNewStaticText;
  descDgVoodooAa: TNewStaticText;
  descDgVoodooRefreshRate: TNewStaticText;

  // dgVoodoo #2
  lblDgVoodooReShade: TLabel;
  lblDgVoodooSaturation: TLabel;
  lblDgVoodooSharpening: TLabel;
  lblDgVoodooHdr: TLabel;
  lblDgVoodooBloom: TLabel;
  DgVoodooReShade: TCheckBox;
  DgVoodooSaturation: TCheckBox;
  DgVoodooSharpening: TCheckBox;
  DgVoodooHdr: TCheckBox;
  DgVoodooBloom: TCheckBox;
  descDgVoodooReShade: TNewStaticText;
  descDgVoodooSaturation: TNewStaticText;
  descDgVoodooSharpening: TNewStaticText;
  descDgVoodooHdr: TNewStaticText;
  descDgVoodooBloom: TNewStaticText;

  // Add improved reflections
  lblVanillaReflections: TLabel;
  lblShinyReflections: TLabel;
  lblShiniestReflections: TLabel;
  VanillaReflections: TRadioButton;
  ShinyReflections: TRadioButton;
  ShiniestReflections: TRadioButton;
  descReflections: TNewStaticText;

  // Add new missile and explosion effects
  lblMissleEffects: TLabel;
  lblExplosionEffects: TLabel;
  MissileEffects: TCheckBox;
  ExplosionEffects: TCheckBox;
  descMissileEffects: TNewStaticText;

  // Add player ship engine trails
  lblEngineTrails: TLabel;
  EngineTrails: TCheckBox;
  descEngineTrails: TNewStaticText;

  // Skip intros
  lblSkipIntros: TLabel;
  SkipIntros: TCheckBox;
  descSkipIntros: TNewStaticText;

  // Jump tunnel duration
  lblJumpTunnel10Sec: TLabel;
  lblJumpTunnel5Sec: TLabel;
  lblJumpTunnel2Sec: TLabel;
  lblJumpTunnelSkip: TLabel;
  JumpTunnel10Sec: TRadioButton;
  JumpTunnel5Sec: TRadioButton;
  JumpTunnel2Sec: TRadioButton;
  JumpTunnelSkip: TRadioButton;
  descJumpTunnelDuration: TNewStaticText;

  // Single Player Command Console
  lblSinglePlayer: TLabel;
  SinglePlayer: TCheckBox;
  descSinglePlayer: TNewStaticText;

  // Apply best options
  lblBestOptions: TLabel;
  BestOptions: TCheckBox;
  descBestOptions: TNewStaticText;
 
  // Display mode
  lblDisplayMode: TLabel;
  DisplayMode: TComboBox;
  descDisplayMode: TNewStaticText;

  // Do not pause on alt tab
  lblDoNotPauseOnAltTab: TLabel;
  DoNotPauseOnAltTab: TCheckBox;
  MusicInBackground: Boolean;

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

// Ensures the DxWrapper or dgVoodoo pages are skipped if they haven't been checked in the Graphics API menu
function PageHandler_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
  Result := False;
   
  if (Page.Id = DxWrapperPage.Id) or (Page.Id = DxWrapperPage2.Id) then
    Result := not DxWrapperGraphicsApi.Checked
  else if (Page.Id = DgVoodooPage.Id) or (Page.Id = DgVoodooPage2.Id) then
    Result := not DgVoodooGraphicsApi.Checked
end;

procedure DxWrapperReShadeCheckBoxClick(Sender: TObject);
begin
  DxWrapperSaturation.Enabled := DxWrapperReShade.Checked;
  DxWrapperSharpening.Enabled := DxWrapperReShade.Checked;
  DxWrapperHdr.Enabled := DxWrapperReShade.Checked;
  DxWrapperBloom.Enabled := DxWrapperReShade.Checked;
end;

procedure DgVoodooReShadeCheckBoxClick(Sender: TObject);
begin
  DgVoodooSaturation.Enabled := DgVoodooReShade.Checked;
  DgVoodooSharpening.Enabled := DgVoodooReShade.Checked;
  DgVoodooHdr.Enabled := DgVoodooReShade.Checked;
  DgVoodooBloom.Enabled := DgVoodooReShade.Checked;
end;

procedure InitializeUi();
var 
  dir : string;
  CheckBoxWidth: Integer;

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
