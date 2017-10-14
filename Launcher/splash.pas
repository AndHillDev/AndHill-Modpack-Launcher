unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls;

type
  TsplashFrm = class(TForm)
    Image1: TImage;
    Bevel1: TBevel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  splashFrm: TsplashFrm;

implementation

{$R *.dfm}

end.
