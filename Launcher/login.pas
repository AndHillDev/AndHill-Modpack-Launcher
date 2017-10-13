unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, IdBaseComponent, IdAntiFreezeBase,
  IdAntiFreeze;

type
  TloginFrm = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    username: TEdit;
    Label3: TLabel;
    userpass: TEdit;
    savedata: TCheckBox;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

type 
  TStringArray = array[0..3] of String;

var
  loginFrm: TloginFrm;

implementation

uses main;

{$R *.dfm}

function authenticate(user, pass, ctoken: String): TStringArray; Stdcall; external 'Libraries\minecraftapi.dll';

procedure TloginFrm.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TloginFrm.BitBtn1Click(Sender: TObject);
var
  accessdata: TStringArray;
begin
  mainFrm.UserName:=username.Text;
  mainFrm.UserPass:=userpass.Text;
  mainFrm.SaveUserData:=savedata.Checked;

  try
    accessdata:=authenticate(username.Text,userpass.Text,mainFrm.AccessToken);
    mainFrm.AccessToken:=accessdata[0];
    mainFrm.ProfileID:=accessdata[2];
    mainFrm.MinecraftUser:=accessdata[3];
  except
    MessageDlg('Fehler bei der Authenifizierung. Bitte überprüfe deine Benutzerdaten', mtError, [mbOK], 0);
  end;

  if savedata.Checked = true then
    mainFrm.SaveConfig(ExtractFilePath(application.ExeName)+'config.json');
  close;
end;

end.
