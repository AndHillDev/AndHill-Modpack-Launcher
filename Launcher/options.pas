unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvAppStyler, ExtCtrls, AdvPanel, JvToolEdit, StdCtrls, Mask,
  JvExMask, ImgList, AdvGlowButton, Buttons;

type
  ToptionFrm = class(TForm)
    AdvPanelStyler1: TAdvPanelStyler;
    AdvFormStyler1: TAdvFormStyler;
    ImageList1: TImageList;
    JavaPath: TJvDirectoryEdit;
    Label1: TLabel;
    Label2: TLabel;
    JavaInterpreter: TJvFilenameEdit;
    Label3: TLabel;
    ModpackPath: TJvDirectoryEdit;
    Label4: TLabel;
    RamIndex: TComboBox;
    Label5: TLabel;
    LanguageIndex: TComboBox;
    AutoUpdate: TCheckBox;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  optionFrm: ToptionFrm;

implementation

uses main;

{$R *.dfm}

procedure ToptionFrm.FormShow(Sender: TObject);
begin
  if mainFrm.javapath <> '' then
  begin
    JavaPath.Text:=mainFrm.JavaPath;
    JavaPath.Directory:=mainFrm.JavaPath;
    JavaPath.InitialDir:=mainFrm.JavaPath;
  end;
  if mainFrm.JavaExe <> '' then
  begin
    JavaInterpreter.Text:=mainFrm.JavaExe;
    JavaInterpreter.InitialDir:=mainFrm.JavaPath;
  end;
  if mainFrm.ModpackPath <> '' then
  begin
    ModpackPath.Text:=mainFrm.ModpackPath;
    ModpackPath.InitialDir:=mainFrm.ModpackPath;
    ModpackPath.Directory:=mainFrm.ModpackPath;
  end;
  RamIndex.ItemIndex:=mainFrm.RamIndex;
  LanguageIndex.ItemIndex:=mainFrm.LanguageIndex;
  AutoUpdate.Checked:=mainFrm.AutoUpdate;
  
end;

procedure ToptionFrm.BitBtn1Click(Sender: TObject);
begin
  mainFrm.JavaPath:=JavaPath.Text;
  mainFrm.JavaExe:=JavaInterpreter.FileName;
  mainFrm.ModpackPath:=ModpackPath.Text;
  mainFrm.RamIndex:=RamIndex.ItemIndex;
  mainFrm.LanguageIndex:=LanguageIndex.ItemIndex;
  mainFrm.AutoUpdate:=AutoUpdate.Checked;
  mainFrm.SaveConfig(ExtractFilePath(Application.ExeName)+'config.json');
  mainFrm.LoadLanguage(languageIndex.ItemIndex);
  close;
end;

procedure ToptionFrm.BitBtn2Click(Sender: TObject);
begin
  close;
end;

end.
