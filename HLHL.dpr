program HLHL;

{%File 'Readme.txt'}

uses
  Forms,
  Dialogs,
  UnitGlobal in 'UnitGlobal.pas',
  UnitImage in 'UnitImage.pas' {FormImage},
  UnitConsts in 'UnitConsts.pas',
  UnitTypesAndVars in 'UnitTypesAndVars.pas',
  UnitShowWGs in 'UnitShowWGs.pas' {FormShowWGs},
  UnitSetWGAttr in 'UnitSetWGAttr.pas' {FormSetWGAttr},
  UnitGeneralSet in 'UnitGeneralSet.pas' {FormGeneralSet},
  UnitWelcome in 'UnitWelcome.pas' {FormWelcome},
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitShowWorkTransactions in 'UnitShowWorkTransactions.pas' {FormShowWorkTransactions},
  UnitShowPets in 'UnitShowPets.pas' {FormShowPets},
  UnitShowStuffs in 'UnitShowStuffs.pas' {FormShowStuffs},
  UnitShowUniverseStove in 'UnitShowUniverseStove.pas' {FormShowUniverseStove},
  UnitClasses in 'UnitClasses.pas',
  UnitDevelop in 'UnitDevelop.pas' {FormDevelop},
  ClsMaps in 'ClsMaps.pas',
  frmShowScript in 'frmShowScript.pas' {fShowScript},
  UserApiInterface in 'UserApiInterface.pas',
  ClsGames in 'ClsGames.pas',
  frmTemplate in 'frmTemplate.pas' {fTemplate},
  UnitTimers in 'UnitTimers.pas' {FormTimers};

{$R *.RES}

begin
  Application.Title := 'HLHLReborn';

  if not UnitWelcome.ShowMe(Application) then Exit;

  if HLInfoList.GlobalHL = nil then Exit;

  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormShowWGs, FormShowWGs);
  Application.CreateForm(TFormImage, FormImage);
  Application.CreateForm(TFormSetWGAttr, FormSetWGAttr);
  Application.CreateForm(TFormGeneralSet, FormGeneralSet);
  Application.CreateForm(TFormShowWorkTransactions, FormShowWorkTransactions);
  Application.CreateForm(TFormShowPets, FormShowPets);
  Application.CreateForm(TFormShowStuffs, FormShowStuffs);
  Application.CreateForm(TFormShowUniverseStove, FormShowUniverseStove);
  Application.CreateForm(TFormDevelop, FormDevelop);
  Application.CreateForm(TfShowScript, fShowScript);
  Application.CreateForm(TFormTimers, FormTimers);
  Application.Run;
end.

