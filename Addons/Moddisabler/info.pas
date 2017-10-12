unit info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvAppStyler, AdvPanel, ExtCtrls, StdCtrls, Buttons;

type
  TinfoFrm = class(TForm)
    AdvPanelStyler1: TAdvPanelStyler;
    AdvFormStyler1: TAdvFormStyler;
    AdvPanel1: TAdvPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
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
  if mainFrm.LanguageIndex <> 0 then
  begin
    Caption:='Addon Informations';
    Label2.Caption:='Programmed and developed by Andreas Hiller';
    Label4.Caption:='All rights reserved';
    bitbtn1.Caption:='Close';
  end;
end;

end.
