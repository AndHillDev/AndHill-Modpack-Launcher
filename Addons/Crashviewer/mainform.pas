unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvOfficeStatusBar, AdvOfficeStatusBarStylers, AdvOfficeHint,
  AdvToolBar, AdvToolBarStylers, AdvAppStyler, ExtCtrls, AdvSplitter,
  ComCtrls, StdCtrls, ActnList, ImgList, uLkJSON, AdvMenus, AdvMenuStylers,
  Menus;

type
  TmainFrm = class(TForm)
    AdvFormStyler1: TAdvFormStyler;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    TreeView1: TTreeView;
    AdvSplitter1: TAdvSplitter;
    Memo1: TMemo;
    AdvToolBarButton1: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvToolBarButton2: TAdvToolBarButton;
    ImageList1: TImageList;
    AdvToolBarButton3: TAdvToolBarButton;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    AdvToolBarButton4: TAdvToolBarButton;
    ActionList1: TActionList;
    exitAction: TAction;
    copyAction: TAction;
    selectAllAction: TAction;
    infoAction: TAction;
    nodeImages: TImageList;
    deleteAction: TAction;
    AdvToolBarButton5: TAdvToolBarButton;
    AdvToolBar2: TAdvToolBar;
    AdvMainMenu1: TAdvMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    Crashreport1: TMenuItem;
    Lschen1: TMenuItem;
    Kopieren1: TMenuItem;
    AllesMarkieren1: TMenuItem;
    N1: TMenuItem;
    Hilfe1: TMenuItem;
    Infober1: TMenuItem;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    procedure AdvSplitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
    procedure selectAllActionExecute(Sender: TObject);
    procedure copyActionExecute(Sender: TObject);
    procedure deleteActionExecute(Sender: TObject);
    procedure exitActionExecute(Sender: TObject);
    procedure infoActionExecute(Sender: TObject);
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

uses info;

{$R *.dfm}

procedure ListFileDir(Path: string; Treeview: TTreeview; rootnode: TTreeNode);
var
  SR: TSearchRec;
  node: TTreeNode;
  datenode: TTreeNode;
  timenode: TTreeNode;
  csnode: TTreeNode;
  date: String;
  time: String;
  cs: String;
  i, nodeindex: integer;
  exists: boolean;
begin
  if FindFirst(Path + '*.txt', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        node:=Treeview.Items.AddChild(rootnode,SR.Name);
        node.ImageIndex:=1;
        node.SelectedIndex:=1;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure TmainFrm.AdvSplitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept:=true;
end;

procedure TmainFrm.FormShow(Sender: TObject);
var
  root: TTreeNode;
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
    treeview1.Items.Clear;
    memo1.Lines.Clear;
    root:=treeview1.Items.Add(nil, 'Crashreports');
    root.ImageIndex:=0;
    ListFileDir(ModpackPath+'\crash-reports\',Treeview1,root);
    Treeview1.Select(root);
    if languageindex <> 0 then
    begin
      with exitAction do
      begin
        Caption:='Exit';
        Hint:='Close the Addon';
      end;
      with copyAction do
      begin
        Caption:='Copy';
        hint:='Copy the select text';
      end;
      with selectAllAction do
      begin
        Caption:='Select All';
        hint:='Select the entire text';
      end;
      with infoAction do
      begin
        Caption:='Info about';
        hint:='Open the addon informations';
      end;
      with deleteAction do
      begin
        Caption:='Delete';
        hint:='Delete selected crash report';
      end;
      AdvToolBar2.BeginUpdate;
      Datei1.Caption:='File';
      Crashreport1.Caption:='Crash Report';
      Hilfe1.Caption:='Help';
      AdvToolBar2.UpdateMenu;
      AdvToolBar2.EndUpdate;
    end;
  end
  else
  begin
    MessageDlg('Sie haben im Hauptprogramm noch nicht angegeben wo sich das Installationsverzeichnis des Modpacks befindet. Das Addon kann daher nicht verwendet werden.', mtError,[mbOK],0);
  end;
end;

procedure TmainFrm.TreeView1DblClick(Sender: TObject);
begin
  if Treeview1.SelectionCount >= 1 then
  begin
    try
      memo1.Lines.Clear;
      Memo1.Lines.LoadFromFile(ModpackPath+'\crash-reports\'+treeview1.Selected.Text);
    except

    end;
  end;
end;

procedure TmainFrm.selectAllActionExecute(Sender: TObject);
begin
  memo1.SelectAll;
end;

procedure TmainFrm.copyActionExecute(Sender: TObject);
begin
  memo1.CopyToClipboard;
end;

procedure TmainFrm.deleteActionExecute(Sender: TObject);
var
  text: String;
begin
  if LanguageIndex = 0 then
    text:='Sind Sie sicher, das Sie diesen Crashreport löschen möchten?'
  else
    text:='Are you sure that you want to delete the selected crash report?';
  if (treeview1.SelectionCount >= 1) and (treeview1.Selected.Text <> 'Crashreports') then
  begin
    if MessageDlg(text,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      deleteFile(ModpackPath+'\crash-reports\'+treeview1.Selected.Text);
      treeview1.Selected.Delete;
    end;
  end;
end;

procedure TmainFrm.exitActionExecute(Sender: TObject);
var
  text: STring;
begin
  if LanguageIndex = 0 then
    text:='Sind Sie sicher, das Sie den Crashreport Viewer beenden möchten?'
  else
    text:='Are you sure that you want to close the Crashreport Viewer?';
  if MessageDlg(text, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    close;
  end;
end;

procedure TmainFrm.infoActionExecute(Sender: TObject);
begin
  infoFrm.ShowModal;
end;

end.
