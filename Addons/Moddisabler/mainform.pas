unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, uLkJSON, AdvOfficeHint, ImgList, AdvPanel, ExtCtrls,
  AdvAppStyler;

type
  TmainFrm = class(TForm)
    AdvFormStyler1: TAdvFormStyler;
    AdvPanel1: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    ModpackPath: String;
    LanguageIndex: Integer;
  end;

var
  mainFrm: TmainFrm;

implementation

uses main, info;

{$R *.dfm}

procedure FindAllFiles(const FileList: tstrings;RootFolder: string; Maske: array of string; Recurse: Boolean = True); Stdcall; external 'AHDLibrary.dll';

procedure TmainFrm.FormShow(Sender: TObject);
var
  input: TStringList;
  rootObject, programObject: TlkJSONObject;
  ConfigFile: String;
begin
  ConfigFile:=ExtractFilePath(Application.ExeName)+'config.json';
  if FileExists(ConfigFile) then
  begin
    input:=TStringList.Create;
    input.LoadFromFile(ConfigFile);
    rootObject:=TlkJSON.ParseText(input.Text) as TlkJSONObject;
    programObject:=(rootObject.Field['programdata'] as TlkJSONObject);
    ModpackPath:=programObject.getString('modpackpath');
    LanguageIndex:=programObject.getInt('langfile');
    input.Free;
    ListBox1.Items.Clear;
    ListBox2.Items.Clear;
    FindAllFiles(ListBox1.Items,ModpackPath+'\mods',['*.jar','*.zip','*.litemod'],true);
    FindAllFiles(ListBox2.Items,ModpackPath+'\mods',['*.disabled'],true);
  end
  else
  begin
    MessageDlg('Sie haben im Hauptprogramm noch nicht angegeben wo sich das Installationsverzeichnis des Modpacks befindet. Das Addon kann daher nicht verwendet werden.', mtError,[mbOK],0);
  end;
  if languageIndex <> 0 then
  begin
    Caption:='Enable or Disable Mods';
    BitBtn1.Hint:='Disable selected Mod';
    BitBtn2.Hint:='Enable selected Mod';
    BitBtn3.Hint:='Close Addon';
    BitBtn4.Hint:='Open Addon Informations';
    Label2.Caption:='Enabled Mods';
    Label3.Caption:='Disabled Mods';
    label1.Caption:='Choose the mod from one of the lists below that you want to enable or to disable and click on the appropriate direction button.';
  end;
end;

procedure TmainFrm.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TmainFrm.BitBtn1Click(Sender: TObject);
var
  selItem: String;
begin
  try
    selItem:=ListBox1.Items[ListBox1.ItemIndex];
    RenameFile(ModpackPath+'\mods\'+selItem,ModpackPath+'\mods\'+selItem+'.disabled');
    listBox2.Items.Add(selItem+'.disabled');
    listBox1.Items.Delete(ListBox1.ItemIndex);
  except

  end;
end;

procedure TmainFrm.BitBtn2Click(Sender: TObject);
var
  selItem: string;
  newFile: String;
begin
  try
    selItem:=ListBox2.Items[ListBox2.ItemIndex];
    newFile:=StringReplace(selItem,'.disabled','',[rfReplaceAll, rfIgnoreCase]);
    RenameFile(ModpackPath+'\mods\'+selItem,ModpackPath+'\mods\'+newFile);
    ListBox2.Items.Delete(ListBox2.ItemIndex);
    ListBox1.Items.add(newFile);
  except

  end;
end;

procedure TmainFrm.BitBtn4Click(Sender: TObject);
begin
  infoFrm.ShowModal;
end;

end.
