unit UnitGeneralSet;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, frmTemplate;

type
  TFormGeneralSet = class(TfTemplate)
    GroupBox12: TGroupBox;
    RadioGroupHumanAct: TRadioGroup;
    RadioGroupPetAct: TRadioGroup;
    GroupBox13: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    TrackBar1: TTrackBar;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    Label30: TLabel;
    ComboBoxMed: TComboBox;
    cmbStore: TComboBox;
    RadioGroupWhatToDoWhenNoMonsterToCapture: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditMainHotkey: TEdit;
    EditWinInfoHotkey: TEdit;
    ButtonApplyHotkey: TButton;
    Label3: TLabel;
    Label4: TLabel;
    EditPlayerLife: TEdit;
    EditPetLife: TEdit;
    CheckBoxFullBlood: TCheckBox;
    CheckBoxNoHeal: TCheckBox;
    procedure cmbStoreChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditHotkeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonApplyHotkeyClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGeneralSet: TFormGeneralSet;

implementation

{$R *.dfm}
uses
	SysUtils, UnitConsts, UnitTypesAndVars, UnitGlobal, UnitMain, ClsMaps, ClsGames;
procedure TFormGeneralSet.cmbStoreChange(Sender: TObject);
var
  tmpStore: TStoreInfo;
  tmpMed: WideString;
  i: integer;
begin
  tmpStore := GameMaps.StoreList.Items[TComboBox(Sender).ItemIndex];
  ComboBoxMed.Clear;
  for i:=0 to tmpStore.MedList.Count-1 do
  begin
    tmpMed := tmpStore.MedList[i];
    ComboBoxMed.Items.Add(tmpMed);
  end;
  ComboBoxMed.ItemIndex:=0;
end;

procedure TFormGeneralSet.FormCreate(Sender: TObject);
var
  i: Integer;
  tmpStore: TStoreInfo;
begin 			
	// ◊∞‘ÿ Ù–‘
  self.CFormName := IDS_GeneralSetFormName;
  inherited;

  cmbStore.Clear;

  for i := 0 to GameMaps.StoreList.Count - 1 do
  begin
    tmpStore := GameMaps.StoreList.Items[i];
    cmbStore.Items.Add(tmpStore.Name);
  end;
  cmbStore.ItemIndex := 0;
  cmbStoreChange(cmbStore);
end;

procedure TFormGeneralSet.FormShow(Sender: TObject);
begin
  Caption := 'Settings - ' + HLInfoList.GlobalHL.UserName;
  EditMainHotkey.Text     := HLInfoList.GlobalHL.MainHotKeyInfo.ShowText;
  EditWinInfoHotkey.Text  := HLInfoList.GlobalHL.WinInfoHotKeyInfo.ShowText;
  TrackBar1.Position := TimeToSleep;
end;

procedure TFormGeneralSet.EditHotkeyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  mHotKey: THotKeyInfo;
  tmpEdt: TEdit;
begin
  if Sender is TEdit then
    tmpEdt := (Sender as TEdit)
  else
    Exit;

  if tmpEdt = EditMainHotkey then
    mHotKey := HLInfoList.GlobalHL.MainHotKeyInfo
  else if tmpEdt = EditWinInfoHotkey then
    mHotKey := HLInfoList.GlobalHL.WinInfoHotKeyInfo
  else
    Exit;

  with mHotKey do
  begin
    VirtualKey := Key;
    Modifiers := 0;
    ShowText := '';

    if ssAlt in Shift then
    begin
      ShowText  := ShowText + 'Alt-';
      Modifiers := Modifiers or MOD_ALT;
    end;
    if ssCtrl in Shift then
    begin
      ShowText := ShowText + 'Ctrl-';
      Modifiers := Modifiers or MOD_CONTROL;
    end;
    if ssShift in Shift then
    begin
      ShowText := ShowText + 'Shift-';
      Modifiers := Modifiers or MOD_SHIFT;
    end;

    ShowText := ShowText + '[' + IntToStr(Key) + ']';
    tmpEdt.Text := ShowText;
  end;

  ButtonApplyHotkey.Enabled := True;
end;

procedure TFormGeneralSet.ButtonApplyHotkeyClick(Sender: TObject);
begin
  HLInfoList.GlobalHL.MainHotKeyInfo.WriteHotKeyInfo;
  HLInfoList.GlobalHL.WinInfoHotKeyInfo.WriteHotKeyInfo;
  HLInfoList.GlobalHL.MainHotKeyInfo.RegisterHotKey(FormMain.Handle);
  HLInfoList.GlobalHL.WinInfoHotKeyInfo.RegisterHotKey(FormMain.Handle);
  ButtonApplyHotKey.Enabled := False;
end;

procedure TFormGeneralSet.TrackBar1Change(Sender: TObject);
begin
  TimeToSleep := TrackBar1.Position;
end;

end.
