program AHMLauncher;

uses
  ShareMem,
  Forms,
  main in 'main.pas' {mainFrm},
  info in 'info.pas' {infoFrm},
  options in 'options.pas' {optionFrm},
  install in 'install.pas' {installFrm},
  login in 'login.pas' {loginFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TmainFrm, mainFrm);
  Application.CreateForm(TinfoFrm, infoFrm);
  Application.CreateForm(ToptionFrm, optionFrm);
  Application.CreateForm(TinstallFrm, installFrm);
  Application.CreateForm(TloginFrm, loginFrm);
  Application.Run;
end.