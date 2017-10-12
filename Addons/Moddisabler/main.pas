// ****************************************************************************
// * mxPlugin for Delphi
// ****************************************************************************
// * Copyright 2001-2002, Bitvadász Kft. All Rights Reserved.
// ****************************************************************************
// * This component can be freely used and distributed in commercial and
// * private environments, provied this notice is not modified in any way.
// ****************************************************************************
// * Feel free to contact me if you have any questions, comments or suggestions
// * at support@maxcomponents.net
// ****************************************************************************
// * I would like to say a big thanks to Marco Cantu for his fantastic books
// * and to Dr.Bob for his Website (www.drbob42.com).
// * They helped me to create this component. Thanks....
// ****************************************************************************
// * Important note about DLL memory management: ShareMem must be the
// * first unit in your library's USES clause AND your project's (select
// * View-Project Source) USES clause if your DLL exports any procedures or
// * functions that pass strings as parameters or function results. This
// * applies to all strings passed to and from your DLL--even those that
// * are nested in records and classes. ShareMem is the interface unit to
// * the DELPHIMM.DLL shared memory manager, which must be deployed along
// * with your DLL. To avoid using DELPHIMM.DLL, pass string information
// * using PChar or ShortString parameters.
// ****************************************************************************

// * Please note that, if you change the name of this plugin from TmxPlugin1
// * you also need to change it manually in Function mxPlugInRegistration
// ****************************************************************************

Unit main;

Interface

Uses
     Windows,
     SysUtils,
     Classes,
     Forms,
     mxPlugin;

Type
  TmxPlugin1 = Class( TmxPlugin )
    procedure mxPluginAfterInit(Sender: TObject);
    procedure mxPluginDestroy(Sender: TObject);
    procedure mxPlugin1PluginActions0Action(Sender: TObject);
     Private
     { Private declarations }
     Public
     { Public declarations }
  End;

// ****************************************************************************
// ** WARNING: Never modify the next function's name
// ****************************************************************************

Function mxPlugInRegistration : TmxPlugin1; stdcall;

Implementation

uses mainform, info;

{$R *.DFM}

// ****************************************************************************
// ** WARNING: Never modify the next function's name
// ****************************************************************************

Function mxPlugInRegistration; // ** The result type is not need here **
Begin
  Result :=  TmxPlugin1.Create( Nil );
End;

procedure TmxPlugin1.mxPluginAfterInit(Sender: TObject);
begin
  mainFrm:=TMainFrm.Create(nil);
  infoFrm:=TInfoFrm.Create(nil);
end;

procedure TmxPlugin1.mxPluginDestroy(Sender: TObject);
begin
  mainFrm.Free;
  infoFrm.Free;
end;

procedure TmxPlugin1.mxPlugin1PluginActions0Action(Sender: TObject);
begin
  mainFrm.Show;
end;

End.