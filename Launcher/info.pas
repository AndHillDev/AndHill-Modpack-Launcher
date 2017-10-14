unit info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ImgList, ComCtrls, Buttons;

type
  TinfoFrm = class(TForm)
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    ListView1: TListView;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    procedure Label6Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  infoFrm: TinfoFrm;

implementation

uses main;

{$R *.dfm}

function GetProgramTitle(name, version: String): String; StdCall; external 'Libraries\AHDLibrary.dll';
procedure ExecuteFile(Filename, Params, WorkDir: String); StdCall; external 'Libraries\AHDLibrary.dll';

procedure TinfoFrm.Label6Click(Sender: TObject);
begin
  ExecuteFile('http://www.andhilldev.de','','');
end;

procedure TinfoFrm.Label8Click(Sender: TObject);
begin
  ExecuteFile('mailto:andhilldev@freenet.de','','');
end;

procedure TinfoFrm.FormCreate(Sender: TObject);
begin
  infoFrm.DoubleBuffered:=true;
  Label1.Caption:=GetProgramTitle(mainFrm.ExeInfo1.ProductName, mainFrm.ExeInfo1.FileVersion);
end;

procedure TinfoFrm.BitBtn1Click(Sender: TObject);
begin
  close;
end;

end.
