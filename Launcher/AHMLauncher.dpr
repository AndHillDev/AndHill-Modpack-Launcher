program AHMLauncher;

uses
  ShareMem,
  Windows,
  Forms,
  main in 'main.pas' {mainFrm},
  info in 'info.pas' {infoFrm},
  options in 'options.pas' {optionFrm},
  install in 'install.pas' {installFrm},
  login in 'login.pas' {loginFrm},
  splash in 'splash.pas' {splashFrm};

{$R *.res}

procedure SetDelay(const Milliseconds: DWord); StdCall; external 'Libraries\AHDLibrary.dll';

begin
  Application.Initialize;
  splashFrm:=TSplashFrm.Create(Application);
  splashFrm.Show;
  splashFrm.Update;
  try
    Application.CreateForm(TmainFrm, mainFrm);
    Application.CreateForm(TinfoFrm, infoFrm);
    Application.CreateForm(ToptionFrm, optionFrm);
    Application.CreateForm(TinstallFrm, installFrm);
    Application.CreateForm(TloginFrm, loginFrm);
    setDelay(3000);
    splashFrm.Hide;
  finally
    Application.Run;
  end;
end.