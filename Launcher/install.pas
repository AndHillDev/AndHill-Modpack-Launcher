unit install;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvWizard, JvExControls, AdvAppStyler, JvWizardRouteMapNodes,
  StdCtrls, Mask, JvExMask, JvToolEdit, WebCopy, ComCtrls, UrlMon, ZipMstr,
  JvComponentBase, JvThread, db, Buttons;

type
  TinstallFrm = class(TForm)
    JvWizard1: TJvWizard;
    Welcome: TJvWizardWelcomePage;
    License: TJvWizardInteriorPage;
    Installpfad: TJvWizardInteriorPage;
    Ready: TJvWizardInteriorPage;
    Installation: TJvWizardInteriorPage;
    JvWizardRouteMapNodes1: TJvWizardRouteMapNodes;
    FertigPage: TJvWizardInteriorPage;
    lizenzvertrag: TMemo;
    Label1: TLabel;
    installPath: TJvDirectoryEdit;
    WebCopy1: TWebCopy;
    Singlestatus: TLabel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    OverallStatus: TLabel;
    Items: TLabel;
    Speed: TLabel;
    ZipMaster1: TZipMaster;
    JvThread1: TJvThread;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure InstallpfadNextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure InstallationPage(Sender: TObject);
    procedure WebCopy1CopyProgress(Sender: TObject; fileidx: Integer; size,
      totsize: Cardinal);
    procedure WebCopy1FileDone(Sender: TObject; idx: Integer);
    procedure ZipMaster1Progress(Sender: TObject;
      details: TZMProgressDetails);
    procedure JvThread1Execute(Sender: TObject; Params: Pointer);
    procedure FertigPagePage(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  installFrm: TinstallFrm;

implementation

uses main;

{$R *.dfm}

procedure SetDelay(const Milliseconds: DWord); StdCall; external 'Libraries\AHDLibrary.dll';
function ReadFromIni(Filename, Section, Key: String): String; StdCall; external 'Libraries\AHDLibrary.dll';
function getAssetUrl(hash: string): String; StdCall; external 'Libraries\MinecraftAPI.dll';
function DeleteFiles(const AFile: string): boolean; StdCall; external 'Libraries\AHDLibrary.dll';

procedure TinstallFrm.FormCreate(Sender: TObject);
begin
  if mainFrm.ModpackPath <> '' then
  begin
    installPath.Directory:=mainFrm.ModpackPath;
    installPath.InitialDir:=mainFrm.ModpackPath;
    installPath.Text:=mainFrm.ModpackPath;
  end;
  progressbar1.DoubleBuffered:=true;
  progressbar2.DoubleBuffered:=true;
  jvWizard1.DoubleBuffered:=true;
end;

procedure TinstallFrm.InstallpfadNextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  if installpath.Directory <> mainFrm.ModpackPath then
  begin
    mainFrm.ModpackPath:=installPath.Text;
    mainFrm.SaveConfig(extractFilePath(application.ExeName)+'config.json');
  end;
end;

procedure TinstallFrm.InstallationPage(Sender: TObject);
var
  WebItem: TWebCopyItem;
  count, x: Integer;
  hash, path, url: String;
begin
  // Verzeichnisse erstellen
  OverallStatus.Caption:=mainFrm.InstallDir;
  Progressbar1.Position:=0;
  Progressbar1.Max:=12;
  if directoryExists(mainFrm.ModpackPath) = false then
    mkDir(mainFrm.ModpackPath);
  setDelay(100);
  Progressbar1.Position:=1;
  if directoryExists(mainFrm.ModpackPath+'\bin') = false then
    mkDir(mainFrm.ModpackPath+'\bin');
  setDelay(100);
  Progressbar1.Position:=2;
  if directoryExists(mainFrm.ModpackPath+'\bin\natives') = false then
    mkDir(mainFrm.ModpackPath+'\bin\natives');
  setDelay(100);
  Progressbar1.Position:=3;
  if directoryExists(mainFrm.ModpackPath+'\assets') = false then
    mkDir(mainFrm.ModpackPath+'\assets');
  setDelay(100);
  Progressbar1.Position:=4;
  if directoryExists(mainFrm.ModpackPath+'\assets\indexes') = false then
    mkDir(mainFrm.ModpackPath+'\assets\indexes');
  setDelay(100);
  Progressbar1.Position:=5;
  if directoryExists(mainFrm.ModpackPath+'\assets\objects') = false then
    mkDir(mainFrm.ModpackPath+'\assets\objects');
  setDelay(100);
  Progressbar1.Position:=6;
  if directoryExists(mainFrm.ModpackPath+'\assets\skins') = false then
    mkDir(mainFrm.ModpackPath+'\assets\skins');
  setDelay(100);
  Progressbar1.Position:=7;
  if directoryExists(mainFrm.ModpackPath+'\config') = false then
    mkDir(mainFrm.ModpackPath+'\config');
  setDelay(100);
  Progressbar1.Position:=8;
  if directoryExists(mainFrm.ModpackPath+'\mods') = false then
    mkDir(mainFrm.ModpackPath+'\mods');
  setDelay(100);
  Progressbar1.Position:=9;
  if directoryExists(mainFrm.ModpackPath+'\libraries') = false then
    mkDir(mainFrm.ModpackPath+'\libraries');
  setDelay(100);
  Progressbar1.Position:=10;
  if directoryexists(mainFrm.ModpackPath+'\mods\1.7.10') = false then
    mkdir(mainFrm.ModpackPath+'\mods\1.7.10');
  setDelay(100);
  Progressbar1.Position:=11;
  if directoryexists(mainFrm.ModpackPath+'\mods\ic2') = false then
    mkdir(mainFrm.ModpackPath+'\mods\ic2');
  setDelay(100);
  Progressbar1.Position:=12;
  setDelay(1000);

  // Herunterladen der Steuerungsdateien
  OverallStatus.Caption:=mainFrm.InstallPrepare;

  WebCopy1.Items.Clear;
  If DirectoryExists(ExtractFilePath(application.ExeName)+'Temp') = false then
    mkDir(ExtractFilePath(application.ExeName)+'Temp');
  UrlDownloadToFile(nil, PChar('http://www.andhilldev.de/software/andhilltech/files/assets.ini'), PChar(ExtractFilePath(application.ExeName)+'Temp'+'\assets.ini'), 0, nil);
  UrlDownloadToFile(nil, PChar('http://www.andhilldev.de/software/andhilltech/files/modlist.ini'), PChar(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini'), 0, nil);

  // Assets
  count:=StrToInt(ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\assets.ini','FILES','count'));
  for x:=1 to count do
  begin
    hash:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\assets.ini',IntToStr(x),'hash');
    path:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\assets.ini',IntToStr(x),'path');
    url:=getAssetUrl(hash);
    if directoryexists(mainFrm.ModpackPath+'\assets\objects\'+path) = false then
        mkdir(mainFrm.ModpackPath+'\assets\objects\'+path);
    webItem:=WebCopy1.Items.Add;
    webItem.URL:=url;
    webItem.TargetDir:=mainFrm.ModpackPath+'\assets\objects\'+path;
    webItem.TargetFilename:=hash;
  end;

  // Indexes
  WebItem:=WebCopy1.Items.Add;
  webItem.URL:='http://s3.amazonaws.com/Minecraft.Download/indexes/1.7.10.json';
  webItem.TargetDir:=mainFrm.ModpackPath+'\assets\indexes';
  webItem.TargetFilename:='1.7.10.json';

  // natives
  WebItem:=WebCopy1.Items.Add;
  WebItem.URL:='http://www.andhilldev.de/software/andhilltech/files/natives.zip';
  WebItem.TargetDir:=ExtractFilePath(application.ExeName)+'Temp';
  WebItem.TargetFilename:='natives.zip';

  // libraries
  WebItem:=WebCopy1.Items.Add;
  WebItem.URL:='http://www.andhilldev.de/software/andhilltech/files/libraries.zip';
  WebItem.TargetDir:=ExtractFilePath(application.ExeName)+'Temp';
  WebItem.TargetFilename:='libraries.zip';

  // custommenu
  WebItem:=WebCopy1.Items.Add;
  WebItem.URL:='http://www.andhilldev.de/software/andhilltech/files/custommenu.zip';
  WebItem.TargetDir:=ExtractFilePath(application.ExeName)+'Temp';
  WebItem.TargetFilename:='custommenu.zip';

  // minecraft.jar
  WebItem:=WebCopy1.Items.Add;
  Webitem.URL:='http://s3.amazonaws.com/Minecraft.Download/versions/1.7.10/1.7.10.jar';
  Webitem.TargetDir:=mainFrm.ModpackPath+'\bin\';
  Webitem.TargetFilename:='minecraft.jar';

  // 1.7.10.json
  WebItem:=WebCopy1.Items.Add;
  Webitem.URL:='http://s3.amazonaws.com/Minecraft.Download/versions/1.7.10/1.7.10.json';
  Webitem.TargetDir:=mainFrm.ModpackPath+'\bin\';
  Webitem.TargetFilename:='1.7.10.json';

  // forge.jar
  WebItem:=WebCopy1.Items.Add;
  Webitem.URL:='http://www.andhilldev.de/software/andhilltech/files/forge.jar';
  Webitem.TargetDir:=mainFrm.ModpackPath+'\bin\';
  Webitem.TargetFilename:='forge.jar';

  // forge.json
  WebItem:=WebCopy1.Items.Add;
  Webitem.URL:='http://www.andhilldev.de/software/andhilltech/files/forge.json';
  Webitem.TargetDir:=mainFrm.ModpackPath+'\bin\';
  Webitem.TargetFilename:='forge.json';

  // Mods
  count:=StrToInt(ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini','files','count'));
  for x:=1 to count do
  begin
    WebItem:=WebCopy1.Items.Add;
    WebItem.URL:='http://www.andhilldev.de/software/andhilltech/files'+StringReplace(ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'folder'),'\','/',[rfReplaceAll])+ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'filename');
    WebItem.TargetDir:=mainFrm.ModpackPath+ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'folder');
    WebItem.TargetFilename:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'filename');
  end;

  OverallStatus.Caption:=mainFrm.InstallDownload;
  Webcopy1.Execute;

  Zipmaster1.DLLDirectory:=ExtractFilePath(application.ExeName)+'libraries';
  OverallStatus.Caption:=mainFrm.InstallNatives;
  zipmaster1.ExtrBaseDir:=mainFrm.ModpackPath+'\bin\natives';
  zipmaster1.ZipFileName:=ExtractFilePath(application.ExeName)+'Temp'+'\natives.zip';
  zipmaster1.Extract;

  OverallStatus.Caption:=mainFrm.InstallLibraries;
  zipmaster1.ExtrBaseDir:=mainFrm.ModpackPath+'\libraries';
  zipmaster1.ZipFileName:=ExtractFilePath(application.ExeName)+'Temp'+'\libraries.zip';
  zipmaster1.Extract;

  OverallStatus.Caption:=mainFrm.InstallMenu;
  zipmaster1.ExtrBaseDir:=mainFrm.ModpackPath;
  zipmaster1.ZipFileName:=ExtractFilePath(application.ExeName)+'Temp'+'\custommenu.zip';
  zipmaster1.Extract;

  OverallStatus.Caption:=mainFrm.InstallRegister;
  JvThread1.ExecuteThreadAndWait(nil);

  DeleteFiles(ExtractFilePath(application.ExeName)+'Temp\*.*');
  rmDir(ExtractFilePath(application.ExeName)+'Temp');

  setDelay(1000);
  JvWizard1.ActivePageIndex:=5;
end;

procedure TinstallFrm.WebCopy1CopyProgress(Sender: TObject;
  fileidx: Integer; size, totsize: Cardinal);
begin
  Progressbar1.Max:=totsize;
  Progressbar1.Position:=size;
  Progressbar2.Max:=WebCopy1.Items.Count;
  Singlestatus.Caption:=mainFrm.TextDownloadFile+' '+WebCopy1.Items.Items[fileidx-1].TargetFilename;
  Items.Caption:=mainFrm.TextFile+' '+IntToStr(fileidx + 1)+' '+mainFrm.TextOf+' '+IntToStr(WebCopy1.Items.Count)+' '+mainFrm.TextDownloaded;
  Speed.Caption:=WebCopy1.RateStr;
end;

procedure TinstallFrm.WebCopy1FileDone(Sender: TObject; idx: Integer);
begin
  ProgressBar2.Position:=idx;
end;

procedure TinstallFrm.ZipMaster1Progress(Sender: TObject;
  details: TZMProgressDetails);
begin
  SingleStatus.Caption:=mainFrm.TextExtract+' '+ExtractFileName(details.ItemName)+ '...';
  ProgressBar1.Max:=details.ItemSize;
  ProgressBar1.Position:=details.ItemPosition;
  ProgressBar2.Max:=details.TotalSize;
  ProgressBar2.Position:=details.TotalPosition;
end;

procedure TinstallFrm.JvThread1Execute(Sender: TObject; Params: Pointer);
var
  x, count: Integer;
  foundrows: integer;
begin
  mainFrm.query.SQL.Clear;
  mainFrm.query.Params.Clear;
  mainFrm.query.Params.CreateParam(ftString, 'name', ptInputOutput);
  mainFrm.query.Params.CreateParam(ftString, 'version', ptInputOutput);
  mainFrm.query.Params.CreateParam(ftString, 'description', ptInputOutput);
  mainFrm.query.Params.CreateParam(ftString, 'modurl', ptInputOutput);
  mainFrm.query.Params.CreateParam(ftString, 'author', ptInputOutput);
  mainFrm.query.Params.CreateParam(ftString, 'filename', ptInputOutput);
  mainFrm.query.Params.CreateParam(ftString, 'folder', ptInputOutput);
  mainFrm.query.Params.CreateParam(ftBoolean, 'enabled', ptInputOutput);
  mainFrm.query.Params.CreateParam(ftString, 'installpath', ptInputOutput);
  mainFrm.query2.SQL.Clear;
    mainFrm.query2.Params.CreateParam(ftString,'modpackpath',ptInputOutput);
    mainFrm.query2.Params.CreateParam(ftString,'name', ptInputOutput);

  count:=StrToInt(ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini','files','count'));
  ProgressBar1.Max:=9;
  ProgressBar2.Max:=count;
  ProgressBar1.Position:=0;
  ProgressBar2.Position:=0;
  SingleStatus.Caption:='';
  Items.Caption:='';
  Speed.Caption:='';
  for x:=1 to count do
  begin
    SingleStatus.Caption:=mainFrm.TextRegisterMod+' '+ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'name')+' ...';
    items.Caption:=IntToStr(x)+' '+mainFrm.TextOf+' '+IntToStr(count)+' '+mainFrm.TextModReg;

    mainFrm.query2.ParamByName('name').Value:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'name');
    mainFrm.query2.ParamByName('modpackpath').value:=mainFrm.ModpackPath;
    mainFrm.query2.SQL.Text:='select * from Mods where name=:name and modpackpath=:modpackpath';
    mainFrm.query2.Open;
      foundrows:=mainFrm.query2.RecordCount;
    mainFrm.query2.Close;
    if foundrows = 0 then
    begin
      
      mainFrm.query.ParamByName('name').Value:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'name');
      ProgressBar1.Position:=1;
      mainFrm.query.ParamByName('version').Value:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'version');
      ProgressBar1.Position:=2;
      mainFrm.query.ParamByName('description').Value:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'description');
      ProgressBar1.Position:=3;
      mainFrm.query.ParamByName('modurl').Value:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'modurl');
      ProgressBar1.Position:=4;
      mainFrm.query.ParamByName('author').Value:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'authors');
      ProgressBar1.Position:=5;
      mainFrm.query.ParamByName('filename').Value:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'filename');
      ProgressBar1.Position:=6;
      mainFrm.query.ParamByName('folder').Value:=ReadFromIni(ExtractFilePath(application.ExeName)+'Temp'+'\modlist.ini',IntToStr(x),'folder');
      ProgressBar1.Position:=7;
      mainFrm.query.ParamByName('enabled').value:=true;
      ProgressBar1.Position:=8;
      mainFrm.query.ParamByName('installpath').value:=mainFrm.ModpackPath;
      ProgressBar1.Position:=9;
      mainFrm.query.SQL.Text:='insert into Mods (name,version,description,modurl,author,filename,folder,enabled,modpackpath) values (:name,:version,:description,:modurl,:author,:filename,:folder,:enabled,:installpath)';
      mainFrm.query.ExecSQL;
    end;
    ProgressBar2.Position:=x;
    ProgressBar1.Position:=0;
  end;
end;

procedure TinstallFrm.FertigPagePage(Sender: TObject);
begin
  mainFrm.installAction.Visible:=false;
  mainFrm.startAction.Visible:=true;
  mainFrm.stopAction.Visible:=true;
  mainFrm.startAction.Enabled:=true;
end;

procedure TinstallFrm.BitBtn1Click(Sender: TObject);
begin
  close;
end;

end.
