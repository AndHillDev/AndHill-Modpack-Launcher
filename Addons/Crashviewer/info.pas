unit info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, AdvAppStyler, AdvPanel;

type
  TinfoFrm = class(TForm)
    AdvPanel1: TAdvPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvFormStyler1: TAdvFormStyler;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  infoFrm: TinfoFrm;

implementation

uses mainform;

{$R *.dfm}

procedure TinfoFrm.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TinfoFrm.FormShow(Sender: TObject);
begin
  if mainfrm.LanguageIndex <> 0 then
  begin
    label2.Caption:='Programmed and developed by Andreas Hiller';
    label4.Caption:='All rights reserved';
    bitbtn1.Caption:='Close';
    caption:='Addon informations';
  end;
end;

end.
