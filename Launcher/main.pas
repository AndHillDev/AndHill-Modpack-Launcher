unit main;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvToolBar, AdvToolBarStylers, AdvPreviewMenu,
  AdvPreviewMenuStylers, AdvShapeButton, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers, XPMan, AdvAppStyler, AdvOfficePager,
  AdvOfficePagerStylers, ImgList, uLkJSON, ExeInfo, ExtCtrls, AdvSplitter,
  OleCtrls, SHDocVw, ComCtrls, AdvListV, AdvPanel, StdCtrls, ActnList, URLMon,
  AdvOfficeHint, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, ConsoleIO, WUpdateWiz,
  WUpdateLanguages, WUpdate, Menus, AdvMenus, AdvMenuStylers,
  mxPluginLoader;

type
  TmainFrm = class(TAdvToolBarForm)
    AdvToolBarPager1: TAdvToolBarPager;
    AdvPage1: TAdvPage;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvToolBar1: TAdvToolBar;
    AdvShapeButton1: TAdvShapeButton;
    AdvPreviewMenu1: TAdvPreviewMenu;
    AdvPreviewMenuOfficeStyler1: TAdvPreviewMenuOfficeStyler;
    AdvOfficeStatusBar1: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    XPManifest1: TXPManifest;
    AdvFormStyler1: TAdvFormStyler;
    AdvToolBar2: TAdvToolBar;
    AdvToolBar3: TAdvToolBar;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    AdvOfficePager12: TAdvOfficePage;
    AdvOfficePager13: TAdvOfficePage;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    ToolBarImages: TImageList;
    TabImages: TImageList;
    AdvToolBarButton2: TAdvToolBarButton;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBarButton4: TAdvToolBarButton;
    AdvToolBarButton5: TAdvToolBarButton;
    AdvToolBarButton6: TAdvToolBarButton;
    AdvToolBarButton7: TAdvToolBarButton;
    AdvToolBarButton8: TAdvToolBarButton;
    AdvToolBarButton9: TAdvToolBarButton;
    AdvToolBarButton10: TAdvToolBarButton;
    AdvToolBarButton11: TAdvToolBarButton;
    ExeInfo1: TExeInfo;
    AdvToolBarMenuButton1: TAdvToolBarMenuButton;
    WelcomePage: TWebBrowser;
    TwitterWeb: TWebBrowser;
    AdvSplitter1: TAdvSplitter;
    Console: TMemo;
    AdvPanelStyler1: TAdvPanelStyler;
    ListView1: TListView;
    ActionList1: TActionList;
    optionAction: TAction;
    exitAction: TAction;
    installAction: TAction;
    startAction: TAction;
    stopAction: TAction;
    helpAction: TAction;
    homepageAction: TAction;
    donateAction: TAction;
    updatesAction: TAction;
    infoAction: TAction;
    Timer1: TTimer;
    AdvOfficeHint1: TAdvOfficeHint;
    con: TZConnection;
    query: TZQuery;
    consoleio1: TConsoleIO;
    WebUpdate1: TWebUpdate;
    WebUpdateWizard1: TWebUpdateWizard;
    WebUpdateWizardGerman1: TWebUpdateWizardGerman;
    AddonMenu: TAdvPopupMenu;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    AdvQuickAccessToolBar1: TAdvQuickAccessToolBar;
    AdvToolBarButton1: TAdvToolBarButton;
    AddonLoader: TmxPluginLoader;
    ImageList1: TImageList;
    query2: TZQuery;
    WebUpdateWizardEnglish1: TWebUpdateWizardEnglish;
    procedure FormCreate(Sender: TObject);
    procedure AdvSplitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure exitActionExecute(Sender: TObject);
    procedure helpActionExecute(Sender: TObject);
    procedure homepageActionExecute(Sender: TObject);
    procedure donateActionExecute(Sender: TObject);
    procedure infoActionExecute(Sender: TObject);
    procedure optionActionExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure installActionExecute(Sender: TObject);
    procedure startActionExecute(Sender: TObject);
    procedure consoleio1ReceiveOutput(Sender: TObject; const Cmd: String);
    procedure consoleio1ReceiveError(Sender: TObject; const Cmd: String);
    procedure consoleio1ProcessStatusChange(Sender: TObject;
      IsRunning: Boolean);
    procedure stopActionExecute(Sender: TObject);
    procedure updatesActionExecute(Sender: TObject);
    procedure AddonLoaderNewAction(Sender: TObject; Name: String;
      Image, HotImage, DisabledImage: TBitmap; Caption: String; Enabled,
      Checked: Boolean; Hint: String; ShortCut: TShortCut;
      OnAction: TNotifyEvent);
    procedure AdvToolBarButton1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    JavaPath: String;
    JavaExe: String;
    ModpackPath: String;
    RamIndex: Integer;
    LanguageIndex: Integer;
    AutoUpdate: Boolean;
    ClientToken: String;
    UserName: String;
    UserPass: String;
    SaveUserData: Boolean;
    AccessToken: String;
    ProfileID: String;
    MinecraftUser: String;
    TwitchToken: String;
    ExitMessage: String;
    MissingMCM: String;
    LogonError: String;
    InstallDir: String;
    InstallPrepare: String;
    InstallDownload: String;
    InstallNatives: String;
    InstallLibraries: String;
    InstallMenu: String;
    InstallRegister: String;
    TextDownloadFile: String;
    TextFile: String;
    TextOf: String;
    TextDownloaded: String;
    TextExtract: String;
    TextRegisterMod: String;
    TextModReg: String;
    LicenseFile: String;
    HelpFile: String;
    launcherstring: TStringList;
    procedure LoadConfig(ConfigFile: String);
    procedure SaveConfig(ConfigFile: String);
    procedure LoadLanguage(LangIndex: Integer);
  end;

var
  mainFrm: TmainFrm;

implementation

uses
  info, options, install, login;

{$R *.dfm}

function GetProgramTitle(name, version: String): String; StdCall; external 'Libraries\AHDLibrary.dll';
procedure ExecuteFile(Filename, Params, WorkDir: String); StdCall; external 'Libraries\AHDLibrary.dll';
function CreateUUID: String; Stdcall; external 'Libraries\AHDLibrary.dll';
function GetEnvVar(variable: String): String; StdCall; external 'Libraries\AHDLibrary.dll';
function ReadFromIni(Filename, Section, Key: String): String; StdCall; external 'Libraries\AHDLibrary.dll';

procedure TmainFrm.LoadLanguage(LangIndex: Integer);
var
  langFile: String;
begin
  if LangIndex = 1 then
  begin
    langFile:=ExtractFilePath(Application.ExeName)+'Languages\en_US.lang';
    mainFrm.WebUpdateWizard1.Language:=mainFrm.WebUpdateWizardEnglish1;
    LicenseFile:=ExtractFilePath(Application.ExeName)+'license.txt';
    HelpFile:=ExtractFilePath(Application.ExeName)+'help.chm';
    welcomePage.Navigate('http://www.andhilldev.de/software/andhilltech/welcomepageen.php');
  end
  else
  begin
    langFile:=ExtractFilePath(Application.ExeName)+'Languages\de_DE.lang';
    mainFrm.WebUpdateWizard1.Language:=mainFrm.WebUpdateWizardGerman1;
    LicenseFile:=ExtractFilePath(Application.ExeName)+'lizenz.txt';
    HelpFile:=ExtractFilePath(Application.ExeName)+'hilfe.chm';
    welcomePage.Navigate('http://www.andhilldev.de/software/andhilltech/welcomepage.php');
  end;
  with mainFrm do
  begin
    AdvPage1.Caption:=ReadFromIni(langFile,'Tabs','Tab.Standard');
    AdvOfficePager11.Caption:=ReadFromIni(langFile,'Tabs','Tab.Welcome');
    AdvOfficePager12.Caption:=ReadFromIni(langFile,'Tabs','Tab.Console');
    AdvOfficePager13.Caption:=ReadFromIni(langFile,'Tabs','Tab.ErrorLog');
    ListView1.Columns.Items[0].Caption:=ReadFromIni(langFile,'ErrorLogHeaders','ErrorLogHeader.Date');
    ListView1.Columns.Items[1].Caption:=ReadFromIni(langFile,'ErrorLogHeaders','ErrorLogHeader.Time');
    ListView1.Columns.Items[2].Caption:=ReadFromIni(langFile,'ErrorLogHeaders','ErrorLogHeader.Code');
    ListView1.Columns.Items[3].Caption:=ReadFromIni(langFile,'ErrorLogHeaders','ErrorLogHeader.Description');
    optionAction.Caption:=ReadFromIni(langFile,'Actions','Options.Caption');
    optionAction.Hint:=ReadFromIni(langFile,'Actions','Options.Hint');
    exitAction.Caption:=ReadFromIni(langFile,'Actions','Exit.Caption');
    exitAction.Hint:=ReadFromIni(langFile,'Actions','Exit.Hint');
    installAction.Caption:=ReadFromIni(langFile,'Actions','Install.Caption');
    installAction.Hint:=ReadFromIni(langFile,'Actions','Install.Hint');
    startAction.Caption:=ReadFromIni(langFile,'Actions','Start.Caption');
    startAction.Hint:=ReadFromIni(langFile,'Actions','Start.Hint');
    stopAction.Caption:=ReadFromIni(langFile,'Actions','Stop.Caption');
    stopAction.Hint:=ReadFromIni(langFile,'Actions','Stop.Hint');
    AdvToolBarMenuButton1.Caption:=ReadFromIni(langFile,'Actions','Addons.Caption');
    AdvToolBarMenuButton1.Hint:=ReadFromIni(langFile,'Actions','Addons.Hint');
    helpAction.Caption:=ReadFromIni(langFile,'Actions','Help.Caption');
    helpAction.Hint:=ReadFromIni(langFile,'Actions','Help.Hint');
    homepageAction.Caption:=ReadFromIni(langFile,'Actions','Homepage.Caption');
    homepageAction.Hint:=ReadFromIni(langFile,'Actions','Homepage.Hint');
    donateAction.Caption:=ReadFromIni(langFile,'Actions','Donate.Caption');
    donateAction.Hint:=ReadFromIni(langFile,'Actions','Donate.Hint');
    updatesAction.Caption:=ReadFromIni(langFile,'Actions','Update.Caption');
    updatesAction.Hint:=ReadFromIni(langFile,'Actions','Update.Hint');
    infoAction.Caption:=ReadFromIni(langFile,'Actions','Info.Caption');
    infoAction.Hint:=ReadFromIni(langFile,'Actions','Info.Hint');
    AdvToolbar1.Caption:=ReadFromIni(langFile,'Toolbars','Toolbar.Program');
    AdvToolbar2.Caption:=ReadFromIni(langFile,'Toolbars','Toolbar.Minecraft');
    AdvToolbar3.Caption:=ReadFromIni(langFile,'Toolbars','Toolbar.Help');
    AdvToolBarButton1.Caption:=ReadFromIni(langFile,'QuickAccess','Optifine.Caption');
    ExitMessage:=ReadFromIni(langFile,'Messages','ExitMessage');
    MissingMCM:=ReadFromIni(langFile,'Messages','MissingMCM');
    LogonError:=ReadFromIni(LangFile,'Messages','LogonError');
    WebUpdateWizard1.Caption:=ReadFromIni(LangFile,'Update','Caption');
  end;
  With OptionFrm do
  begin
    Caption:=ReadFromIni(langFile,'Options','Options');
    Label1.Caption:=ReadFromIni(langFile,'Options','InstallPath.Caption');
    label2.Caption:=ReadFromIni(langFile,'Options','Interpreter.Caption');
    Label3.Caption:=ReadFromIni(langFile,'Options','ModpackInstallDir.Caption');
    Label4.Caption:=ReadFromIni(langFile,'Options','Ram.Caption');
    Label5.Caption:=ReadFromIni(langFile,'Options','Language.Caption');
    Ramindex.Items.Strings[2]:=ReadFromIni(langFile,'Options','RAM.Recommended');
    LanguageIndex.Items.Strings[0]:=ReadFromIni(langFile,'Options','Language.German');
    LanguageIndex.Items.Strings[1]:=ReadFromIni(langFile,'Options','Language.English');
    AutoUpdate.Caption:=ReadFromIni(langFile,'Options','Update.Caption');
    BitBtn1.Caption:=ReadFromIni(langFile,'Options','Button.Apply');
    BitBtn2.Caption:=ReadFromIni(langFile,'Options','Button.Cancel');
  end;
  with infoFrm do
  begin
    Caption:=ReadFromIni(langFile,'Informations','Caption');
    Label2.Caption:=ReadFromIni(langFile,'Informations','ProgrammedBy.Caption');
    label4.Caption:=ReadFromIni(langFile,'Informations','AllRights.Caption');
    Label9.Caption:=ReadFromIni(langFile,'Informations','ExternLibs.Caption');
    BitBtn1.Caption:=ReadFromIni(langFile,'Informations','Button.Close');
    ListView1.Columns.Items[0].Caption:=ReadFromIni(langFile,'Informations','ListView.File');
    ListView1.Columns.Items[1].Caption:=ReadFromIni(langFile,'Informations','ListView.Version');
    ListView1.Columns.Items[2].Caption:=ReadFromIni(langFile,'Informations','ListView.Manufacturer');
  end;
  with loginFrm do
  begin
    Caption:=ReadFromIni(langFile,'Logon','Caption');
    Label1.Caption:=ReadFromIni(langFile,'Logon','Text.Caption');
    Label2.Caption:=ReadFromIni(langFile,'Logon','Username.Caption');
    Label3.Caption:=ReadFromIni(langFile,'Logon','Password.Caption');
    savedata.Caption:=ReadFromIni(langFile,'Logon','SaveUserData.Caption');
    Bitbtn1.Caption:=ReadFromIni(langFile,'Logon','Button.Login');
    BitBtn2.Caption:=ReadFromIni(langFile,'Logon','Button.Cancel');
  end;
  with InstallFrm do
  begin
    Caption:=ReadFromIni(langFile,'Installation','Caption');
    Welcome.Caption:=ReadFromIni(langFile,'Installation','Step.Welcome.Caption');
    Welcome.Title.Text:=ReadFromIni(langFile,'Installation','Step.Welcome.Caption');
    Welcome.Subtitle.Text:=ReadFromIni(langFile,'Installation','Step.Welcome.Subtitle');
    License.Caption:=ReadFromIni(langFile,'Installation','Step.License.Caption');
    License.Title.Text:=ReadFromIni(langFile,'Installation','Step.License.Caption');
    License.Subtitle.Text:=ReadFromIni(langFile,'Installation','Step.License.Subtitle');
    InstallPfad.Caption:=ReadFromIni(langFile,'Installation','Step.InstallPath.Caption');
    InstallPfad.Title.Text:=ReadFromIni(langFile,'Installation','Step.InstallPath.Caption');
    InstallPfad.Subtitle.Text:=ReadFromIni(langFile,'Installation','Step.InstallPath.Subtitle');
    Ready.Caption:=ReadFromIni(langFile,'Installation','Step.Ready.Caption');
    Ready.Title.Text:=ReadFromIni(langFile,'Installation','Step.Ready.Caption');
    Ready.Subtitle.Text:=ReadFromIni(langFile,'Installation','Step.Ready.Subtitle');
    Installation.Caption:=ReadFromIni(langFile,'Installation','Step.Install.Caption');
    Installation.Title.Text:=ReadFromIni(langFile,'Installation','Step.Install.Caption');
    Installation.Subtitle.Text:=ReadFromIni(langFile,'Installation','Step.Install.Subtitle');
    FertigPage.Caption:=ReadFromIni(langFile,'Installation','Step.Done.Caption');
    FertigPage.Title.Text:=ReadFromIni(langFile,'Installation','Step.Done.Caption');
    FertigPage.Subtitle.Text:=ReadFromIni(langFile,'Installation','Step.Done.Subtitle');
    JvWizard1.ButtonBack.Caption:=ReadFromIni(langFile,'Installation','Button.Back');
    JvWizard1.ButtonNext.Caption:=ReadFromIni(langFile,'Installation','Button.Next');
    JvWizard1.ButtonCancel.Caption:=ReadFromIni(langFile,'Installation','Button.Cancel');
    JvWizard1.ButtonFinish.Caption:=ReadFromIni(langFile,'Installation','Button.Finish');
    Bitbtn1.Caption:=ReadFromIni(langFile,'Installation','Button.Finish');
    Label1.Caption:=ReadFromIni(langFile,'Installation','InstallPath.Caption');
    InstallDir:=ReadFromIni(langFile,'Installation','Install.Dir');
    InstallPrepare:=ReadFromIni(langFile,'Installation','Install.Prepare');
    InstallDownload:=ReadFromIni(langFile,'Installation','Install.Download');
    InstallNatives:=ReadFromIni(langFile,'Installation','Install.Natives');
    InstallLibraries:=ReadFromIni(langFile,'Installation','Install.Libraries');
    InstallMenu:=ReadFromIni(langFile,'Installation','Install.Menu');
    InstallRegister:=ReadFromIni(langFile,'Installation','Install.Register');
    TextDownloadFile:=ReadFromIni(langFile,'Installation','Text.DownloadFile');
    TextFile:=ReadFromIni(langFile,'Installation','Text.File');
    TextOf:=ReadFromIni(langFile,'Installation','Text.Of');
    TextDownloaded:=ReadFromIni(langFile,'Installation','Text.Downloaded');
    TextExtract:=ReadFromIni(langFile,'Installation','Text.Extract');
    TextRegisterMod:=ReadFromIni(langFile,'Installation','Text.RegisterMod');
    TextModReg:=ReadFromIni(langFile,'Installation','Text.ModReg');
  end;
  addonloader.ClearPlugins;
  addonmenu.Items.Clear;
  AddonLoader.LoadFromFolder(ExtractFilePath(application.ExeName)+'Addons',true);
end;

procedure TmainFrm.LoadConfig(ConfigFile: String);
var
  input: TStringList;
  rootObject, programObject, dataObject: TlkJSONObject;
begin
  if fileexists(ConfigFile) then
  begin
    input:=TStringList.Create;
    input.LoadFromFile(ConfigFile);
    rootObject:=TlkJSON.ParseText(input.Text) as TlkJSONObject;
    programObject:=(rootObject.Field['programdata'] as TlkJSONObject);
    dataObject:=(rootObject.Field['minecraftdata'] as TlkJSONObject);

    JavaPath:=programObject.getString('javapath');
    JavaExe:=programObject.getString('javaexe');
    ModpackPath:=programObject.getString('modpackpath');
    RamIndex:=programObject.getInt('ramindex');
    LanguageIndex:=programObject.getInt('langfile');
    AutoUpdate:=programObject.getBoolean('autoupdate');
    ClientToken:=programObject.getString('clienttoken');

    UserName:=dataObject.getString('username');
    UserPass:=dataObject.getString('userpass');
    SaveUserData:=dataObject.getBoolean('saveuserdata');
    AccessToken:=dataObject.getString('accesstoken');
    ProfileID:=dataObject.getString('profileid');
    MinecraftUser:=dataObject.getString('minecraftuser');
    TwitchToken:=dataObject.getString('twitchtoken');
    input.Free;
  end
  else
  begin
    JavaPath:='';
    JavaExe:='';
    ModpackPath:=GetEnvVar('appdata')+'\.andhilltech';
    RamIndex:=2;
    LanguageIndex:=0;
    AutoUpdate:=false;
    ClientToken:=CreateUUID;
    UserName:='';
    UserPass:='';
    SaveUserData:=false;
    AccessToken:='';
    ProfileID:='';
    MinecraftUser:='';
    TwitchToken:='';
  end;
end;

procedure TmainFrm.SaveConfig(ConfigFile: String);
var
  rootObject, programObject, dataObject : TlkJSONObject;
  output: TStringList;
  i: Integer;
begin
  rootObject:=TlkJSONObject.Create();
  programObject:=TlkJSONObject.Create();
  dataObject:=TlkJSONObject.Create();

  programObject.Add('javapath',JavaPath);
  programObject.Add('javaexe',JavaExe);
  programObject.Add('modpackpath',ModpackPath);
  programObject.Add('ramindex',RamIndex);
  programObject.Add('langfile',LanguageIndex);
  programObject.Add('autoupdate',AutoUpdate);
  programObject.Add('clienttoken',ClientToken);

  dataObject.Add('username',UserName);
  dataObject.Add('userpass',UserPass);
  dataObject.Add('saveuserdata',SaveUserData);
  dataObject.Add('accesstoken',AccessToken);
  dataObject.Add('profileid',ProfileID);
  dataObject.Add('minecraftuser',MinecraftUser);
  dataObject.Add('twitchtoken',TwitchToken);

  rootObject.Add('programdata',programObject);
  rootObject.Add('minecraftdata',dataObject);

  output:=TStringList.Create;
  i:=0;
  output.Add(GenerateReadableText(rootObject, i));
  output.SaveToFile(ConfigFile);
  output.Free;
  rootObject.Free;
end;

procedure TmainFrm.FormCreate(Sender: TObject);
begin
  Application.Title:=GetProgramTitle(exeinfo1.ProductName, exeinfo1.FileVersion);
  mainFrm.Caption:=Application.Title;
  AdvToolBarPager1.Caption.Caption:=Application.Title;

  UrlDownloadToFile(nil, PChar('http://www.andhilldev.de/software/andhilltech/files/launcher.mcm'), PChar(ExtractFilePath(application.ExeName)+'launcher.mcm'), 0, nil);
  LoadConfig(ExtractFilePath(Application.ExeName)+'config.json');
  
  if FileExists(mainFrm.ModpackPath+'\Bin\Minecraft.jar') = true then
  begin
    startAction.Enabled:=true;
    startAction.Visible:=true;
    installAction.Visible:=false;
    stopAction.Visible:=true;
  end
  else
  begin
    startAction.Enabled:=false;
    startAction.Visible:=false;
    installAction.Visible:=true;
    stopAction.Visible:=false
  end;
  con.LibraryLocation:=ExtractFilePath(application.ExeName)+'Libraries\sqlite3.dll';
  con.Database:=ExtractFilePath(application.ExeName)+'Mods.db';
  con.Connect;
  try
    launcherstring:=TStringList.Create;
    launcherstring.LoadFromFile(ExtractFilePath(application.ExeName)+'launcher.mcm');
    deleteFile(ExtractFilePath(application.ExeName)+'launcher.mcm');
  except
    MessageDlg(MissingMCM, mtError, [mbOK], 0);
  end;
end;

procedure TmainFrm.AdvSplitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept:=false;
end;

procedure TmainFrm.FormShow(Sender: TObject);
begin
  twitterWeb.Navigate('http://www.andhilldev.de/software/andhilltech/twitter.php');
  LoadLanguage(LanguageIndex);
  InstallFrm.lizenzvertrag.Lines.Clear;
  InstallFrm.lizenzvertrag.Lines.LoadFromFile(mainFrm.LicenseFile);
end;

procedure TmainFrm.exitActionExecute(Sender: TObject);
begin
  if MessageDlg(ExitMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    mainFrm.Close;
    Application.Terminate;
  end;
end;

procedure TmainFrm.helpActionExecute(Sender: TObject);
begin
  ExecuteFile(mainFrm.HelpFile,'','');
end;

procedure TmainFrm.homepageActionExecute(Sender: TObject);
begin
  ExecuteFile('http://www.andhilldev.de','','');
end;

procedure TmainFrm.donateActionExecute(Sender: TObject);
begin
  ExecuteFile('https://www.paypal.me/andreashiller','','');
end;

procedure TmainFrm.infoActionExecute(Sender: TObject);
begin
  infoFrm.ShowModal;
end;

procedure TmainFrm.optionActionExecute(Sender: TObject);
begin
  optionFrm.ShowModal;
end;

procedure TmainFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  DeleteFile(ExtractFilePath(application.ExeName)+'launcher.mcm');
end;

procedure TmainFrm.installActionExecute(Sender: TObject);
begin
  installFrm.ShowModal;
end;

procedure TmainFrm.startActionExecute(Sender: TObject);
begin
  if AccessToken = '' then
  begin
    loginFrm.ShowModal;
  end;

  if AccessToken <> '' then
  begin
    AdvOfficePager1.ActivePageIndex:=1;
    launcherstring.Text:=StringReplace(launcherstring.Text,'[Java]',javaexe,[rfReplaceAll]);
    launcherstring.Text:=StringReplace(launcherstring.Text,'[InstallPath]',modpackpath,[rfReplaceAll]);
    launcherstring.Text:=StringReplace(launcherstring.Text,'[Ram]',IntToStr(ramindex+1),[rfReplaceAll]);
    launcherstring.Text:=StringReplace(launcherstring.Text,'[Username]',minecraftuser,[rfReplaceAll]);
    launcherstring.Text:=StringReplace(launcherstring.Text,'[Uuid]',clienttoken,[rfReplaceAll]);
    launcherstring.Text:=StringReplace(launcherstring.Text,'[AccessToken]',accesstoken,[rfReplaceAll]);
    launcherstring.Text:=StringReplace(launcherstring.Text,'[TwitchToken]',twitchtoken,[rfReplaceAll]);
    console.Lines.Clear;
    consoleio1.RunProcess(launcherstring.Text,modpackpath,true);
  end
  else
  begin
    MessageDlg(LogonError, mtError, [mbOK], 0);
  end;
end;

procedure TmainFrm.consoleio1ReceiveOutput(Sender: TObject;
  const Cmd: String);
begin
  console.Lines.Add(Cmd);
end;

procedure TmainFrm.consoleio1ReceiveError(Sender: TObject;
  const Cmd: String);
var
  listitem: TListItem;
begin
  listitem:=Listview1.Items.Add;
  listitem.Caption:=datetostr(now);
  listitem.SubItems.Add(timetostr(now));
  listitem.SubItems.Add('MINEERR1');
  listitem.SubItems.Add(cmd);
end;

procedure TmainFrm.consoleio1ProcessStatusChange(Sender: TObject;
  IsRunning: Boolean);
begin
  if IsRunning then
  begin
    startAction.Enabled:=false;
    stopAction.Enabled:=true;
  end
  else
  begin
    startAction.Enabled:=true;
    stopAction.Enabled:=false;
  end;
end;

procedure TmainFrm.stopActionExecute(Sender: TObject);
begin
  consoleIO1.StopProcess;
end;

procedure TmainFrm.updatesActionExecute(Sender: TObject);
begin
  WebUpdateWizard1.Execute();
end;

procedure TmainFrm.AddonLoaderNewAction(Sender: TObject; Name: String;
  Image, HotImage, DisabledImage: TBitmap; Caption: String; Enabled,
  Checked: Boolean; Hint: String; ShortCut: TShortCut;
  OnAction: TNotifyEvent);
var
  menuItem: TMenuItem;
  Bitmap: TBitmap;
begin
  Bitmap:=TBitmap.Create;
  Image.PixelFormat:=pf24bit;
  Image.SaveToFile(ExtractFilePath(application.ExeName)+'addons\'+name+'.bmp');
  menuItem := NewItem( Caption, scNone, Checked, Enabled, OnAction, 0, Name );
  addonMenu.Items.Add(menuItem);
  Bitmap.LoadFromFile(ExtractFilePath(application.ExeName)+'addons\'+name+'.bmp');
  Bitmap.TransparentColor:=clFuchsia;
  Bitmap.Transparent:=true;
  Bitmap.TransparentMode:=tmFixed;
  Bitmap.Modified:=true;
  Bitmap.PixelFormat:=pf24bit;
  menuItem.Bitmap:=Bitmap;
  Bitmap.Free;
  Deletefile(ExtractFilePath(application.ExeName)+'addons\'+name+'.bmp');
end;

procedure TmainFrm.AdvToolBarButton1Click(Sender: TObject);
begin
  ExecuteFile('http://optifine.net/adloadx?f=OptiFine_1.7.10_HD_U_D4.jar','','');
end;

end.
