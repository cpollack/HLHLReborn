unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UnitGlobal, ComCtrls, UnitConsts, UnitTypesAndVars, Math,
  ShellAPI, UnitClasses, frmTemplate, AnsiStrings;
type
  TFormMain = class(TfTemplate)
    Panel3: TPanel;
    LabelTitle: TLabel;
    PanelCreateWG: TPanel;
    ButtonShowWGs: TButton;
    ButtonSetWGAttr: TButton;
    CheckBoxBeginCreateWG: TCheckBox;
    PanelMove: TPanel;
    LabelMap: TLabel;
    ComboBoxZone: TComboBox;
    ButtonMove: TButton;
    ComboBoxMap: TComboBox;
    ButtonStopMove: TButton;
    PanelTigerMachine: TPanel;
    ButtonShowImage: TButton;
    CheckBoxBeginTigerMachine: TCheckBox;
    RadioGroupWorkMode: TRadioGroup;
    PanelWork: TPanel;
    Label1: TLabel;
    PanelCapture: TPanel;
    Label2: TLabel;
    EditMonsterToCapture: TEdit;
    CheckBoxBeginCapture: TCheckBox;
    Label3: TLabel;
    EditCaptureLevelFrom: TEdit;
    Label4: TLabel;
    EditCaptureLevelTo: TEdit;
    Label5: TLabel;
    CheckBoxBeginWork: TCheckBox;
    Label6: TLabel;
    ComboBoxScripts: TComboBox;
    ButtonReadScript: TButton;
    PanelAux: TPanel;
    MemoWinInfo: TMemo;
    ButtonGetNPCDialog: TButton;
    ButtonUnPatchAll: TButton;
    Panel2: TPanel;
    ButtonHide: TButton;
    ButtonGeneralSet: TButton;
    ButtonShowUniverseStove: TButton;
    ButtonShowStuff: TButton;
    btnPet: TButton;
    ButtonCancelNPCDialog: TButton;
    ButtonShowTransactions: TButton;
    btnClose: TButton;
    chkSort: TCheckBox;
    btnDevelop: TButton;
    btnShowScript: TButton;
    Label8: TLabel;
    PanelBattle: TPanel;
    CheckBoxStartBattle: TCheckBox;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    LabelPetName: TLabel;
    Label15: TLabel;
    EditPetLife: TEdit;
    EditPetAttack: TEdit;
    EditPetDefence: TEdit;
    EditPetDexterity: TEdit;
    Label16: TLabel;
    LabelCurrLIfe: TLabel;
    LabelCurrAttack: TLabel;
    LabelCurrDefence: TLabel;
    LabelCurrDexterity: TLabel;
    LabelGrLife: TLabel;
    LabelGrAttack: TLabel;
    LabelGrDefence: TLabel;
    LabelGrDexterity: TLabel;
    Label3AGr: TLabel;
    Label26: TLabel;
    LabelMedalGr: TLabel;
    Label28: TLabel;
    Label14: TLabel;
    EditBattleStopLevel: TEdit;
    LabelCurrLevel: TLabel;
    Button1: TButton;
    PanelStats: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    EditStatAvailable: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    EditStatAttack: TEdit;
    EditStatDefense: TEdit;
    EditStatDexterity: TEdit;
    EditStatLife: TEdit;
    ButtonApplyStats: TButton;
    EditStatMana: TEdit;
    procedure CheckBoxBeginCreateWGClick(Sender: TObject);
    procedure CheckBoxBeginTigerMachineClick(Sender: TObject);
    procedure ButtonShowImageClick(Sender: TObject);
    procedure ComboBoxZoneChange(Sender: TObject);
    procedure ButtonStopMoveClick(Sender: TObject);
    procedure ButtonSetWGAttrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonHideClick(Sender: TObject);
    procedure btnDevelopClick(Sender: TObject);
    procedure ButtonShowWGsClick(Sender: TObject);
    procedure ButtonGeneralSetClick(Sender: TObject);
    procedure ButtonMoveClick(Sender: TObject);
    procedure RadioGroupWorkModeClick(Sender: TObject);
    procedure CheckBoxBeginCaptureClick(Sender: TObject);
    procedure btnPetClick(Sender: TObject);
    procedure EditCaptureLevelFromKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxBeginWorkClick(Sender: TObject);
    procedure ButtonShowStuffClick(Sender: TObject);
    procedure ButtonShowUniverseStoveClick(Sender: TObject);
    procedure ButtonReadScriptClick(Sender: TObject);
    procedure ButtonShowTransactionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonCancelNPCDialogClick(Sender: TObject);
    procedure ButtonGetNPCDialogClick(Sender: TObject);
    procedure ButtonUnPatchAllClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure chkSortClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnShowScriptClick(Sender: TObject);
    procedure UpdateMarchingPetInfo();
    procedure PetBaseStatsChange(Sender: TObject);
    procedure CheckBoxStartBattleClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ResetAttributes;
    procedure UpdateUserAttributes(Sender: TObject);
    procedure ButtonApplyStatsClick(Sender: TObject);
  private
    { Private declarations }
    ntida: TNotifyIconDataA;
    procedure HotKeyMessage(var MyMessage: TMessage); Message WM_HOTKEY;
    procedure MouseMessage(var MyMessage: TMessage); Message CustomMouseMsg;
    procedure LoadScriptLists;
  public
    { Public declarations }
    IsLoad: boolean;
    FSnapshotHandle: THandle;

    procedure HideAllWorkPanels;
    procedure ShowSelectedWorkPanel;
    procedure DisableCaptureObjs;
    procedure EnableCaptureObjs;
    procedure SetCaptureObjsEnabled(isEnable: Boolean);
    procedure BeginWork;
    procedure EndWork;
  end;

var
  FormMain: TFormMain;
implementation

uses
	IniFiles, ClsMaps, ClsGames,
	UnitImage, UnitShowWGs, UnitSetWGAttr, UnitWelcome, UnitDevelop,
  UnitGeneralSet, UnitShowWorkTransactions, UnitShowPets, UnitShowStuffs,
  UnitShowUniverseStove, frmShowScript, UnitTimers;

{$R *.DFM}

procedure TFormMain.CheckBoxBeginCreateWGClick(Sender: TObject);
// ��ʼ����
var
  tmpTransaction: TTransaction;
  tmpPurpose: PurposeInfo;
  ReturnMapID, ReturnX, ReturnY: DWORD;
//  tmpMap, tmpCurrMap: MapInfo;
  BuyItemName, DeleteFrom, DelRemainIndicator, DelRemainXS: String;
  fateini: TINIFile;
  tmpStringList: TStringList;
  GuojieTransFrom: integer;
begin
  FormShowWGS.ShowWGs;

  if CheckBoxBeginCreateWG.Checked then
  begin
    RadioGroupWorkMode.Enabled := False;

    ThisUser.GetAttr;

    BuyItemName := FormGeneralSet.ComboBoxMed.Items[FormGeneralSet.ComboBoxMed.ItemIndex];
    if
      (BuyItemName <> 'MagicPowder') and (BuyItemName <> 'PearlPill')
      and (BuyItemName <> 'RevivingPill') and (BuyItemName <> 'NectarWine')
    then
    begin
      RadioGroupWorkMode.Enabled := True;
      CheckBoxBeginCreateWG.Checked := False;
      ShowMessage('You must choose a Mana medicine. You choose: "' + BuyItemName + '".');
      exit;
    end;

    if FormSetWGAttr.EditWGName.Text = '' then
    begin
      showmessage('Please add a Kungfu Name');
      RadioGroupWorkMode.Enabled := True;
      CheckBoxBeginCreateWG.Checked := False;
      FormSetWGAttr.EnableCreateWGObjs;
      exit;
    end;

    FormSetWGAttr.DisableCreateWGObjs;

    if FormSetWGAttr.CheckBoxAutoDeleteWG.Checked then
      DeleteFrom := IntToStr(FormSetWGAttr.ComboBoxDeleteFromPos.ItemIndex+1)
    else
      DeleteFrom := '';

    ReturnMapID := ReadCurrMapID;
    GetCurrPosXY(ReturnX, ReturnY);
    
    DelRemainXS := '';
    if FormSetWGAttr.CheckBoxRemainEasyWG.Checked then
      DelRemainIndicator := 'EasyToKeep'
    else if FormSetWGAttr.CheckBoxRemainXS.Checked then
    begin
      DelRemainIndicator := '��RetainFactor';
      DelRemainXS := FormSetWGAttr.EditRemainedXS.Text;
    end
    else
      DelRemainIndicator := '';

    ThisWork.Clean;

    // Transaction 0
    tmpTransaction := ThisWork.AddTransaction('Set Kungfu Attributes and Effects');
    tmpPurpose := tmpTransaction.AddPurpose;
    // ���Խ���ָ������
    if FormSetWGAttr.CheckBoxLevelLimit.Checked then
      tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
    tmpTransaction.AddStep(ActSetWGAttr, FormSetWGAttr.EditWGName.Text,
      FormSetWGAttr.EditWGXS.Text, FormSetWGAttr.EditWGNL.Text);
    tmpTransaction.AddStep(ActSetWGDisp,
      IntToStr(FormSetWGAttr.ComboBoxWGQS.ItemIndex + 1),
      IntToStr(FormSetWGAttr.ComboBoxWGGJ.ItemIndex + 1),
      IntToStr(FormSetWGAttr.ComboBoxWGBZ.ItemIndex + 1));

    // Transaction 1
    tmpTransaction := ThisWork.AddTransaction('Buy Medicine');
    tmpPurpose := tmpTransaction.AddPurpose;
    tmpPurpose.Allows.Add('Item,' + BuyItemName + ',TQ-Anonym,1');
    // ��������
    tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
    // ���Խ���ָ������
    if FormSetWGAttr.CheckBoxLevelLimit.Checked then
      tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
    // ���˹��ټ���
    if FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
      tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
        + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
    tmpTransaction.AddStep(ActGotoMap, '100000', '', '');
    tmpTransaction.AddStep(ActCallNPC, FormGeneralSet.cmbStore.Items[FormGeneralSet.ComboBoxMed.ItemIndex], '', '');
    tmpTransaction.AddStep(ActBuyStuff, BuyItemName, 'TQ-Anonym', '');
    tmpTransaction.AddStep(ActQuitShop, '', '', '');

    // Transaction 2
    tmpTransaction := ThisWork.AddTransaction('Test for Medicine');
    tmpPurpose := tmpTransaction.AddPurpose;
    tmpPurpose.Allows.Add('Item,' + BuyItemName + ',TQ-Anonym,1');
    // ��������
    tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
    // ���Խ���ָ������
    if FormSetWGAttr.CheckBoxLevelLimit.Checked then
      tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
    // ���˹��ټ���
    if FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
      tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
        + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
    tmpTransaction.AddStep(ActJumpToTransN, '1', '', '');

    // Transaction 3
    tmpTransaction := ThisWork.AddTransaction('Use Medicine and create Kungfu. Full list or level drop will not create');
    tmpPurpose := tmpTransaction.AddPurpose;
    // ��������
    tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
    // ���Խ���ָ������
    if FormSetWGAttr.CheckBoxLevelLimit.Checked then
      tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
    // ���˹��ټ���
    if FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
      tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
        + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
    tmpTransaction.AddStep(ActGotoMap, IntToStr(ReturnMapID), '', '');
    tmpTransaction.AddStep(ActMoveToPos, IntToStr(ReturnX), IntToStr(ReturnY), '');
    tmpTransaction.AddStep(ActOpenItemWindow, '', '', '');
    tmpTransaction.AddStep(ActUseItem, BuyItemName, 'TQ-Anonym', '');
    tmpTransaction.AddStep(ActCreateWG, '', '', '');
    tmpTransaction.AddStep(ActJumpToTransN, '2', '', '');


    if DeleteFrom <> '' then // ��ɾ��
    begin
      // Transaction 4
      tmpTransaction := ThisWork.AddTransaction('Delete Kungfu');
      tmpPurpose := tmpTransaction.AddPurpose;
      // ���Խ���ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      // ���˹��ټ���
      if FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
        tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
          + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
      tmpTransaction.AddStep(ActDeleteWGs, DeleteFrom, DelRemainIndicator, DelRemainXS);
      
      // Transaction 5
      tmpTransaction := ThisWork.AddTransaction('Confirm List has an empty slot after deleting');
      tmpPurpose := tmpTransaction.AddPurpose;
      tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
      // ���Խ���ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      // ���˹��ټ���
      if FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
        tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
          + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
      tmpTransaction.AddStep(ActJumpToTransN, '2', '', '');

      GuojieTransFrom := 6;
    end
    else
      GuojieTransFrom := 4;

    // ������������������1)�������Ҳ�����ɾ��2������ָ�����Ƽ���3���Ѿ����˹��ټ���

    if not FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
    begin // ����Ҫ���ٴ���
      // Transaction the last
      tmpTransaction := ThisWork.AddTransaction('Terminate');
      tmpTransaction.AddStep(ActTerminate, 'Kungfu Creation Completed', '', '');
    end
    else // ��Ҫ���ٴ���
    begin
      // Transaction GuojieTransFrom
      tmpTransaction := ThisWork.AddTransaction('Rank and Buy Meds');
      tmpPurpose := tmpTransaction.AddPurpose;
      tmpPurpose.Allows.Add('Item,' + BuyItemName + ',TQ-Anonym,1');
      // ��������
      tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
      // ���Խ���ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      // ���˹��ټ���
      if FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
        tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
          + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
      tmpTransaction.AddStep(ActGotoMap, '100000', '', '');
      tmpTransaction.AddStep(ActCallNPC, FormGeneralSet.cmbStore.Items[FormGeneralSet.ComboBoxMed.ItemIndex], '', '');
      tmpTransaction.AddStep(ActBuyStuff, BuyItemName, 'TQ-Anonym', '');
      tmpTransaction.AddStep(ActQuitShop, '', '', '');

      // Transaction GuojieTransFrom+1
      tmpTransaction := ThisWork.AddTransaction('Test for medicine');
      tmpPurpose := tmpTransaction.AddPurpose;
      tmpPurpose.Allows.Add('Item,' + BuyItemName+',TQ-Anonym,1');
      // ��������
      tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
      // ���Խ���ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      // ���˹��ټ���
      if FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
        tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
        + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
      tmpTransaction.AddStep(ActJumpToTransN, IntToStr(GuojieTransFrom), '', '');

      // Transaction GuojieTransFrom+2
      tmpTransaction:=ThisWork.AddTransaction('Take medicine and make kungfu, stop if full or spec level not met');
      tmpPurpose:=tmpTransaction.AddPurpose;
      // ��������
      tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
      // ���Խ���ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      // ���˹��ټ���
      if FormSetWGAttr.CheckBoxDoFateCreateWG.Checked then
        tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
          + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
      tmpTransaction.AddStep(ActOpenItemWindow, '', '', '');
      tmpTransaction.AddStep(ActUseItem, BuyItemName, 'TQ-Anonym', '');
      tmpTransaction.AddStep(ActCreateWG, '', '', '');

      // Transaction GuojieTransFrom+3   һֱ�ȵ����Ｖ�𽵳ɹ��ټ���Ӧ��ֻ��һ����
      tmpTransaction:=ThisWork.AddTransaction('Overrank: wait for rank');
      tmpPurpose:=tmpTransaction.AddPurpose;
      // ��������
      tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
      // ����ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      // ���˹��ټ���
      tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
        + ',' + FormSetWGAttr.ComboBoxGJLevel.Text);
      tmpTransaction.AddStep(ActJumpToTransN, IntToStr(GuojieTransFrom+3), '', '');

      // Transaction GuojieTransFrom+4   ����
      tmpTransaction:=ThisWork.AddTransaction('Overrank - start rank');
      tmpPurpose:=tmpTransaction.AddPurpose;
      // ��������
      tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
      // ����ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      fateini := TIniFile.Create('.\Info\fate.ini');
      tmpStringList := TStringList.Create;
      tmpStringList.Clear;
      fateini.ReadSectionValues(FormSetWGAttr.ComboBoxGJRank.Text
        + FormSetWGAttr.ComboBoxGJLevel.Text, tmpStringList);
      tmpTransaction.PurseSteps(tmpStringList);
      tmpStringList.Clear;
      tmpStringList.Free;
      fateini.Free;

      // Transaction GuojieTransFrom+5   ��������ʽ����
      tmpTransaction := ThisWork.AddTransaction('Over the top: wait for upgrade of char');
      tmpPurpose := tmpTransaction.AddPurpose;
      // ��������
      tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
      // ����ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      tmpPurpose.Allows.Add('Player,Rank,' + FormSetWGAttr.ComboBoxGJRank.Text
        + ',' + IntToStr(StrToInt(FormSetWGAttr.ComboBoxGJLevel.Text) + 1));
      tmpTransaction.AddStep(ActJumpToTransN, IntToStr(GuojieTransFrom+5), '', '');

      // Transaction GuojieTransFrom+6   �����Ƿ���Լ�������
      tmpTransaction:=ThisWork.AddTransaction('Overkill? Check full and down to spec lvl, otherwise make more');
      tmpPurpose:=tmpTransaction.AddPurpose;
      // ��������
      tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
      // ����ָ������
      if FormSetWGAttr.CheckBoxLevelLimit.Checked then
        tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
      tmpTransaction.AddStep(ActJumpToTransN, IntToStr(GuojieTransFrom), '', '');

      if DeleteFrom <> '' then // ��ɾ��
      begin
        // Transaction GuojieTransFrom+7
        tmpTransaction := ThisWork.AddTransaction('Delete over the top');
        tmpPurpose := tmpTransaction.AddPurpose;
        // ���Խ���ָ������
        if FormSetWGAttr.CheckBoxLevelLimit.Checked then
          tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
        tmpTransaction.AddStep(ActDeleteWGs, DeleteFrom, DelRemainIndicator, DelRemainXS);

        // Transaction GuojieTransFrom+8
        tmpTransaction := ThisWork.AddTransaction('Overkill? Check if open slot after delete');
        tmpPurpose := tmpTransaction.AddPurpose;
        tmpPurpose.Allows.Add('Player,Kungfu,MaxCount');
        // ���Խ���ָ������
        if FormSetWGAttr.CheckBoxLevelLimit.Checked then
          tmpPurpose.Allows.Add('Player,Level,,1-' + FormSetWGAttr.EditLevelLimited.Text);
        tmpTransaction.AddStep(ActJumpToTransN, IntToStr(GuojieTransFrom), '', '');
      end;

      // Transaction the last
      tmpTransaction:=ThisWork.AddTransaction('Terminate');
      tmpTransaction.AddStep(ActTerminate, 'Kungfu Creation Complete', '', '');
    end;

    BeginWork;
  end
  else
  begin
    RadioGroupWorkMode.Enabled := True;
    FormSetWGAttr.EnableCreateWGObjs;

    EndWork;
  end;
end;

procedure TFormMain.CheckBoxBeginTigerMachineClick(Sender: TObject);
// ���ϻ���
var
  tmpTransaction: TTransaction;
begin
  if CheckBoxBeginTigerMachine.Checked then
  begin
    ThisWork.Clean;

    tmpTransaction := ThisWork.AddTransaction('���ϻ���');
    tmpTransaction.AddStep(ActLocateWindow, '', 'pnlMain', '');
    tmpTransaction.AddStep(ActWinLeftClick, '��', TigerMachinePutCoinX, TigerMachinePutCoinY);
    tmpTransaction.AddStep(ActDelay, '200', '', '');
    tmpTransaction.AddStep(ActWinLeftClick, '��', TigerMachineCheckX, TigerMachineCheckY);
    tmpTransaction.AddStep(ActDelay, '200', '', '');
    tmpTransaction.AddStep(ActJumpToTransN, '0', '', '');

    BeginWork;
  end
  else
  begin
    EndWork;
  end;
end;

procedure TFormMain.ButtonShowImageClick(Sender: TObject);
begin
  If FormImage.Visible then
  begin
    FormImage.Hide;
  end
  else
  begin
    FormImage.Show;
  end;
end;

procedure TFormMain.ComboBoxZoneChange(Sender: TObject);
var
  tmpZone: TZoneInfo;
  tmpMap: TMapInfo;
  i: integer;
begin
  ComboBoxMap.Clear;

  tmpZone := GameMaps.ZoneList.Items[ComboBoxZone.ItemIndex];

  for i := 0 to tmpZone.MapList.Count - 1 do
  begin
    tmpMap := tmpZone.MapList.Items[i];
    if tmpMap.ID = 0 then // ��ʼ��
      GameMaps.ReadOneMap(tmpMap.PosInMapList);
    ComboBoxMap.Items.Add(tmpMap.Name);
  end;
  ComboBoxMap.ItemIndex := 0;
end;

procedure TFormMain.ButtonStopMoveClick(Sender: TObject);
// ֹͣ�ƶ�
begin
  EndWork;
end;

procedure TFormMain.ButtonSetWGAttrClick(Sender: TObject);
// ����
begin
  If FormSetWGAttr.Visible then
    FormSetWGAttr.Close
  else
    FormSetWGAttr.Show;
end;

procedure TFormMain.MouseMessage(var MyMessage: TMessage);
// �����Ϣ
{var
  MousePoint: TPoint;}
begin
  inherited;

  if MyMessage.LParam <> WM_LBUTTONDBLCLK then Exit;

  ShowWindow(Handle,SW_SHOW);
  ShowWindow(Application.Handle, SW_SHOW);

  MyMessage.Result := 0;
end;

procedure TFormMain.HotKeyMessage(var MyMessage: TMessage);
// �ȼ���Ϣ
var
  tmpWin: TWindowInfo;
  tmpHLInfo: THLInfo;
  CursorPoint: TPOINT;
  tmpStr: String;
begin
  tmpHLInfo := HLInfoList.GlobalHL;
  if (MyMessage.LParamHi = tmpHLInfo.MainHotKeyInfo.VirtualKey)
    and (MyMessage.LParamLo = tmpHLInfo.MainHotKeyInfo.Modifiers) then
  begin
  	// ��ʾ/����������
    If IsWindowVisible(Handle) then
    begin
      ShowWindow(Handle, SW_Hide);
      ShowWindow(Application.Handle, SW_HIDE);
    end else begin
      ShowWindow(Handle, SW_SHOW);
      ShowWindow(Application.Handle, SW_SHOW);
      Application.BringToFront;
    end;
    MyMessage.Result := 1;
  end else if (MyMessage.LParamHi = tmpHLInfo.WinInfoHotKeyInfo.VirtualKey)
    and (MyMessage.LParamLo = tmpHLInfo.WinInfoHotKeyInfo.Modifiers) then
  begin
  	// ץ��
    MemoWinInfo.Clear;
    MemoWinInfo.Lines.Add('Current Map ID: ' + IntToStr(ReadCurrMapID));

    GetCursorPos(CursorPoint);
    tmpWin := tmpHLInfo.ItemOfWindowID(WindowFromPoint(CursorPoint));
    if tmpWin = Nil then
    begin
      MemoWinInfo.Lines.Add('Could not locate a window based on cursor position.');
      Exit;
    end;
    tmpStr := 'Window:[' + tmpWin.Title+ ']'
      + ', Relative Point: <' + IntToStr(CursorPoint.X - tmpWin.Left) + ', '
      + IntToStr(CursorPoint.Y-tmpWin.Top) + '>';

    if tmpWin.ParentWin <> nil then
      tmpStr := tmpStr + '; Parent Window: [' + tmpWin.ParentWin.Title + ']'
    else
      tmpStr := tmpStr + '; No Parent Window';
    MemoWinInfo.Lines.Add(tmpStr);
  end;
end;


procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // ����������ͼ��
  ntida.cbSize := Sizeof(tnotifyicondata);
  ntida.Wnd := Handle;
  ntida.uID := CustomIID;
  ntida.uFlags := nif_icon+nif_tip+nif_message;
  ntida.uCallbackMessage := CustomMouseMsg;
  ntida.hIcon := Application.Icon.Handle;
  ntida.szTip := '';
  Shell_NotifyIconA(NIM_DELETE, @ntida);
  // ע���������ȼ�
  HLInfoList.GlobalHL.MainHotKeyInfo.UnRegisterHotKey(self.Handle);
  HLInfoList.GlobalHL.WinInfoHotKeyInfo.UnRegisterHotKey(self.Handle);
{  UnRegisterHotkey(handle, MyHotkeyID);
  UnRegisterHotkey(handle, WinInfoHotkeyID);
  DeleteAtom(MyHotkeyID);
  DeleteAtom(WinInfoHotkeyID);    }

  UnPatchAll; // �ָ�����
end;

procedure TFormMain.ButtonHideClick(Sender: TObject);
// ����������
begin
  ShowWindow(Handle, SW_Hide);
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TFormMain.btnDevelopClick(Sender: TObject);
// ��ƽ���
begin
  FormDevelop.Show;
end;

procedure TFormMain.ButtonShowWGsClick(Sender: TObject);
// ��ʾ�书
begin
  If FormShowWGs.Visible then
  begin
    FormShowWGs.Close;
  end
  else
  begin
    FormShowWGS.ShowWGs;
    FormShowWGs.Show;
  end;
end;

procedure TFormMain.ButtonGeneralSetClick(Sender: TObject);
// ͨ������
begin
	if FormGeneralSet.Visible then
  	FormGeneralSet.Close
  else
    FormGeneralSet.Show;
end;

procedure TFormMain.ButtonMoveClick(Sender: TObject);
// �ƶ�
var
  tmpZone: TZoneInfo;
  tmpMap: TMapInfo;
  tmpTransaction: TTransaction;
begin
	// ������Ч���˳�
  if ComboBoxZone.ItemIndex = -1 then exit;
  // ��ȡ��ͼ��Ϣ
  tmpZone := GameMaps.ZoneList.Items[ComboBoxZone.ItemIndex];
  tmpMap := tmpZone.MapList.Items[ComboBoxMap.ItemIndex];

  if tmpMap.ID = 0 then // ��ʼ��
    GameMaps.ReadOneMap(tmpMap.PosInMapList);
  // �������ù����ű�����ִ��
  ThisWork.Clean;
  tmpTransaction := ThisWork.AddTransaction('Go to map ' + tmpMap.Name);
  tmpTransaction.AddStep(ActGoToMap, inttostr(tmpMap.ID), '', '');
  BeginWork;
end;

procedure TFormMain.HideAllWorkPanels;
// �������й������
begin
  PanelCreateWG.Hide;
  PanelTigerMachine.Hide;
  PanelMove.Hide;
  PanelWork.Hide;
  PanelCapture.Hide;
  PanelAux.Hide;
  PanelBattle.Hide;
  PanelStats.Hide;
end;

procedure TFormMain.ShowSelectedWorkPanel;
// ����ѡ����ʾ�������
var
  i: integer;
begin
  HideAllWorkPanels;	// �������й������

  case RadioGroupWorkMode.ItemIndex of
    0:  //Script
      begin
      	LoadScriptLists;	// װ�ؽű��б�
        PanelWork.Show;
      end;
    5: 	// Kungfu
      begin
        i := FormGeneralSet.ComboBoxMed.ItemIndex;
        if (FormGeneralSet.ComboBoxMed.Items[i] <> '�����')
          and (FormGeneralSet.ComboBoxMed.Items[i] <> '���鵤')
          and (FormGeneralSet.ComboBoxMed.Items[i] <> '����')
          and (FormGeneralSet.ComboBoxMed.Items[i] <> '��¶��') then
          for i := 0 to FormGeneralSet.ComboBoxMed.Items.Count - 1 do
            if (FormGeneralSet.ComboBoxMed.Items[i] = '�����')
              or (FormGeneralSet.ComboBoxMed.Items[i] = '���鵤')
              or (FormGeneralSet.ComboBoxMed.Items[i] = '����')
              or (FormGeneralSet.ComboBoxMed.Items[i] = '��¶��') then
                Break;
        FormGeneralSet.ComboBoxMed.ItemIndex := i;
        PanelCreateWG.Show;
      end;
    1:	// Move
    	PanelMove.Show;
    4:	// Capture
    	PanelCapture.Show;
    7:	// Misc
    	PanelAux.Show;
    2:	// Casino
    	PanelTigerMachine.Show;
    3:  // Battle
      begin
        UpdateMarchingPetInfo;
        PanelBattle.Show;
      end;
    6:
      begin
        ResetAttributes;
        PanelStats.Show;
      end;
  end;
end;

procedure TFormMain.RadioGroupWorkModeClick(Sender: TObject);
// ����ѡ����ʾ��Ӧ�Ĺ������
begin
  ShowSelectedWorkPanel;
end;

procedure TFormMain.CheckBoxBeginCaptureClick(Sender: TObject);
// ץ��
var
  tmpTransaction: TTransaction;
  tmpPurpose: PurposeInfo;
begin
  if CheckBoxBeginCapture.Checked then
  begin
    DisableCaptureObjs;

    ThisWork.Clean;

    tmpTransaction := ThisWork.AddTransaction('Capture: ' + EditMonsterToCapture.Text);
    tmpTransaction.AddStep(ActActiveBattle, 'Capture', '', '');
    tmpTransaction.AddStep(ActInBattle, 'Ordinary', 'Ordinary', '');
    tmpTransaction.AddStep(ActJumpToTransN, '0', '', '');
    tmpPurpose := tmpTransaction.AddPurpose;
    tmpPurpose.Allows.Add('Pet,,0,5');

    tmpTransaction := ThisWork.AddTransaction('Stop work');
    tmpTransaction.AddStep(ActTerminate, 'Pet list is full', '', '');

    BeginWork;
  end
  else
  begin
    EnableCaptureObjs;
    EndWork;
  end;
end;

procedure TFormMain.DisableCaptureObjs;
// ��ֹ����ץ�����
begin
  SetCaptureObjsEnabled(False);
end;

procedure TFormMain.EnableCaptureObjs;
// ��������ץ�����
begin
  SetCaptureObjsEnabled(True);
end;

procedure TFormMain.SetCaptureObjsEnabled(isEnable: Boolean);
// ����ץ�����ʹ��״̬
begin
  Label2.Enabled := isEnable;
  Label3.Enabled := isEnable;
  Label4.Enabled := isEnable;
  Label5.Enabled := isEnable;
  EditMonsterToCapture.Enabled := isEnable;
  EditCaptureLevelFrom.Enabled := isEnable;
  EditCaptureLevelTo.Enabled := isEnable;
end;

procedure TFormMain.btnPetClick(Sender: TObject);
// ��ʾ/�ر� ���ﴰ��
begin
  If FormShowPets.Visible then
  begin
    FormShowPets.Close;
  end
  else
  begin
    FormShowPets.ShowPets;
    FormShowPets.Show;
  end;
end;

procedure TFormMain.EditCaptureLevelFromKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key<'0') or (Key>'9')) and (Key<>Chr(8)) and (Key<>Chr(13))
  then begin
    showmessage('��������������ʽ');
    Key:=Chr(0);
  end;
end;

procedure TFormMain.CheckBoxBeginWorkClick(Sender: TObject);
// ��ʼ/ֹͣ�ű�����
begin
  if CheckBoxBeginWork.Checked then
  begin
  	// û��ָ���ű����˳�
    if ComboBoxScripts.ItemIndex = -1 then
    begin
      CheckBoxBeginWork.Checked := False;
      Exit;
    end;
    // ���³�ʼ�����������ű�
    ThisWork.RepeatCounter := 0;
    ThisWork.GotoTrans(0, True);
    BeginWork;
    ButtonReadScript.Enabled := False;	// ��ֹ���ű�
  end
  else
  begin
    EndWork;                           // ֹͣ�ű�
    ButtonReadScript.Enabled := True;  // �������ű�
  end;
end;

procedure TFormMain.CheckBoxStartBattleClick(Sender: TObject);
var
  tmpTransaction: TTransaction;
  tmpPurpose: PurposeInfo;
begin
  if CheckBoxStartBattle.Checked then
  begin
    ThisWork.Clean;

    tmpTransaction := ThisWork.AddTransaction('Battle!');
    tmpTransaction.AddStep(ActActiveBattle, 'Capture', '', '');
    tmpTransaction.AddStep(ActInBattle, 'Ordinary', 'Ordinary', '');
    tmpTransaction.AddStep(ActDelay, '200', '', '');
    tmpTransaction.AddStep(ActJumpToTransN, '0', '', '');

    tmpPurpose := tmpTransaction.AddPurpose;
    tmpPurpose.Allows.Add('Pet,Marching,Level,' + EditBattleStopLevel.Text);

    BeginWork;
  end
  else
  begin
    EndWork;
  end;
end;

procedure TFormMain.ButtonShowStuffClick(Sender: TObject);
// ��ʾ��Ʒ����
begin
  If FormShowStuffs.Visible then
  	FormShowStuffs.Close
  else
  begin
  	FormShowStuffs.Show;
    FormShowStuffs.ShowStuffs;
  end;
end;

procedure TFormMain.ButtonShowUniverseStoveClick(Sender: TObject);
// Ǭ������¯����
begin
  If FormShowUniverseStove.Visible then
  begin
    FormShowUniverseStove.Close;
  end
  else
  begin
    FormShowUniverseStove.ShowUniverseStove;
    FormShowUniverseStove.Show;
  end;
end;

procedure TFormMain.ButtonReadScriptClick(Sender: TObject);
begin
	// װ�ؽű�
  ThisWork.IniFileName := IDS_ScriptFilesPath + ComboBoxScripts.Text;
  ThisWork.ReadIni;

	// ��ʾ�ű�
  FormShowWorkTransactions.ShowTransactions;
end;

procedure TFormMain.ButtonShowTransactionsClick(Sender: TObject);
// ��ʾ��������
begin
	//��������Ϊ0������
  if ThisWork.Count = 0 then
  begin
    ShowMessage('����ѡ��Ų��ļ�');
    Exit;
  end;
  // ��ʾ/���ع������贰��
  If FormShowWorkTransactions.Visible then
  begin
    FormShowWorkTransactions.Hide;
  end
  else
  begin
    FormShowWorkTransactions.Show;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  i: integer;
  tmpSz: integer;
  tmpZone: TZoneInfo;
  DevelopState: boolean;
begin
  self.CFormName := IDS_MainFormName;
  inherited;
  // ���ð汾��ǩ
  LabelTitle.Caption := HLInfoList.GlobalHL.UserName;
  FormMain.Caption := 'HLHLReborn Ver ' + GetHLHLVer;

	// ���ݲ������á���ư�ť��״̬
  DevelopState := false;
	if ParamCount > 0 then
   	DevelopState := LowerCase(ParamStr(1)) = '-d';
 	self.btnDevelop.Visible := DevelopState;

  // װ�ص�ͼ
  ComboBoxZone.Clear;
  for i := 0 to GameMaps.ZoneList.Count - 1 do
  begin
    tmpZone := GameMaps.ZoneList.Items[i];
    ComboBoxZone.Items.Add(tmpZone.Name);
  end;

  if ComboBoxZone.Items.Count > 0 then
  begin
    ComboBoxZone.ItemIndex := 0;
    ComboBoxZoneChange(FormMain);
  end;
  // Tray Icon
  ntida.cbSize := sizeof(tnotifyicondataa);
  ntida.Wnd := Handle;
  ntida.uID := CustomIID;
  ntida.uFlags := nif_icon + nif_tip + nif_message;
  ntida.uCallbackMessage := CustomMouseMsg;
  ntida.hIcon := Application.Icon.Handle;

  tmpSz := SizeOf(ntida.szTip) div SizeOf(ntida.szTip[0]);
  AnsiStrings.StrPLCopy(ntida.szTip, LabelTitle.Caption, tmpSz);
//  ntida.szTip[length(FormMain.Caption)] := Chr(0);
  Shell_NotifyIconA(NIM_ADD, @ntida);
  // �ȼ�
  HLInfoList.GlobalHL.MainHotKeyInfo.RegisterHotKey(self.Handle);
  HLInfoList.GlobalHL.WinInfoHotKeyInfo.RegisterHotKey(self.Handle);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  ShowSelectedWorkPanel;
  FormTimers.TimerReadMapInfo.Enabled := True;
end;

procedure TFormMain.Button1Click(Sender: TObject);
begin
  PatchSpeed;
  ShowMessage('Battle speed has been patched.');
end;

procedure TFormMain.ButtonApplyStatsClick(Sender: TObject);
var
  tmpTransaction: TTransaction;
begin
  ThisUser.GetAttr;
  if (StrToInt(EditStatAvailable.Text) < 0) or (StrToInt(EditStatAvailable.Text) = ThisUser.RemainingPoints) then
  begin
    ShowMessage('Stats not applied due to bad values');
    Exit;
  end;

  ThisWork.Clean;

  tmpTransaction := ThisWork.AddTransaction('Add stats!');

  if (EditStatLife.Text <> '') and (EditStatLife.Text <> '0') then tmpTransaction.AddStep(ActSetAttr, 'Life', EditStatLife.Text, '');
  if (EditStatMana.Text <> '') and (EditStatMana.Text <> '0') then tmpTransaction.AddStep(ActSetAttr, 'Mana', EditStatMana.Text, '');
  if (EditStatAttack.Text <> '') and (EditStatAttack.Text <> '0') then tmpTransaction.AddStep(ActSetAttr, 'Attack', EditStatAttack.Text, '');
  if (EditStatDefense.Text <> '') and (EditStatDefense.Text <> '0') then tmpTransaction.AddStep(ActSetAttr, 'Defense', EditStatDefense.Text, '');
  if (EditStatDexterity.Text <> '') and (EditStatDexterity.Text <> '0') then tmpTransaction.AddStep(ActSetAttr, 'Dexterity', EditStatDexterity.Text, '');
  tmpTransaction.AddStep(ActDelay, '100', '', '');

  BeginWork;
end;

procedure TFormMain.ButtonCancelNPCDialogClick(Sender: TObject);
// ȡ�� NPC �Ի���
begin
  UnitGlobal.CancelNPCDialog;
end;

procedure TFormMain.ButtonGetNPCDialogClick(Sender: TObject);
begin
  MemoWinInfo.Clear;
  MemoWinInfo.Lines.Add(GetNPCDialog);
end;

procedure TFormMain.ButtonUnPatchAllClick(Sender: TObject);
// �ָ�����
begin
  UnPatchAll;
end;

procedure TFormMain.BeginWork;
// ��ʼ����
var
  tmpWin: TWindowInfo;
begin
  ThisWork.CanWork := True;			// �ܹ���
  ThisWork.IsFirstTime := True;	// ��һ�ι���

  FormMain.RadioGroupWorkMode.Enabled := False;	// ��ֹ�л�ģʽ

  ThisUser.PatchItemWindow;                     // ����

  CallNPCState.IsWorking := False;              // ����

  FormTimers.TimerWork.Enabled := True;        	// ������ʱ������

  HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);  // ��λ��Ϸ������
  if tmpWin = nil then Exit;              // ���ڲ����ڣ��˳�

  EnableWindow(tmpWin.Window, False); // ��ֹ��ǰ����
end;

procedure TFormMain.EndWork;
// ֹͣ����
begin
  ThisWork.CanWork := False;	// ��ֹ����

  FormMain.RadioGroupWorkMode.Enabled := True;	// �����л�ģʽ

  UnPatchAll;                                   // �ָ�����

  FormShowWorkTransactions.ShowTransactions;		// ��ʾ��������

  FormTimers.TimerWork.Enabled := False;        // ������ʱ���ر�

	// ȡ�����й���״̬���ű���ץ�衢���С��ı�
  CheckBoxBeginWork.Checked := False;
  CheckBoxBeginCapture.Checked := False;
  CheckBoxBeginCreateWG.Checked := False;
  CheckBoxBeginTigerMachine.Checked := False;
end;

procedure TFormMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.chkSortClick(Sender: TObject);
begin
	self.ComboBoxScripts.Sorted := TCheckBox(Sender).Checked;
  if not TCheckBox(Sender).Checked then
	  LoadScriptLists;	// װ�ؽű��б�
end;

procedure TFormMain.LoadScriptLists;	// װ�ؽű��б�
var
  sr: TSearchRec;
begin
	ComboBoxScripts.Items.Clear;
  if FindFirst(IDS_ScriptFilesPath + '*.ini', faAnyFile, sr) = 0 then
 	repeat
    	ComboBoxScripts.Items.Add(sr.Name);
  until FindNext(sr) <> 0;
  FindClose(sr);
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  // ���ٶ���
  ThisBattle.Free;    // ս��
  ThisBuyStuff.Free;  // ԭ��
  ThisCreateWG.Free;  // ����
  ThisForge.Free;     // ����
  ThisMove.Free;      // �ƶ�
  inherited;
end;

procedure TFormMain.btnShowScriptClick(Sender: TObject);
begin
  // ��ʾ/���ؽű��༭����
  If fShowScript.Visible then
  begin
    fShowScript.Hide;
  end
  else
  begin
    fShowScript.Show;
  end;
end;

procedure TFormMain.UpdateMarchingPetInfo();
var
  marchingPet: TPet;
  lifeGrow, attackGrow, defenceGrow, dexGrow: Double;
  allGrow, medalGrow: Double;

begin
  ThisUser.GetPets;
  marchingPet := ThisUser.GetMarchingPet();

  LabelPetName.Caption := marchingPet.Name;
  LabelCurrLevel.Caption := IntToStr(marchingPet.Level);
  LabelCurrLife.Caption := IntToStr(marchingPet.MaxLife);
  LabelCurrAttack.Caption := IntToStr(marchingPet.Attack);
  LabelCurrDefence.Caption := IntToStr(marchingPet.Defence);
  LabelCurrDexterity.Caption := IntToStr(marchingPet.Dexterity);

  if marchingPet.Level = 1 then
  begin
    LabelGrLife.Caption := '';
    LabelGrAttack.Caption := '';
    LabelGrDexterity.Caption := '';
    LabelGrDefence.Caption := '';
    LabelMedalGr.Caption := '';
    Label3aGr.Caption := '';
  end
  else
  begin
    if (EditPetLife.Text = '') or (EditPetAttack.Text = '') or (EditPetDefence.Text = '') or (EditPetDexterity.Text = '') then Exit;

    lifeGrow := (marchingPet.MaxLife - StrToInt(EditPetLife.Text)) / (marchingPet.Level - 1);
    LabelGrLife.Caption := Format('%2f', [lifeGrow]);
    attackGrow := ((marchingPet.Attack * (1 - (0.05 * marchingPet.MedalAttack))) - StrToInt(EditPetAttack.Text)) / (marchingPet.Level - 1);
    LabelGrAttack.Caption := Format('%2f', [attackGrow]);
    defenceGrow := ((marchingPet.Defence * (1 - (0.05 * marchingPet.MedalDefence))) - StrToInt(EditPetDefence.Text)) / (marchingPet.Level - 1);
    LabelGrDefence.Caption := Format('%2f', [defenceGrow]);
    dexGrow := ((marchingPet.Dexterity * (1 - (0.05 * marchingPet.MedalDexterity))) - StrToInt(EditPetDexterity.Text)) / (marchingPet.Level - 1);
    LabelGrDexterity.Caption := Format('%2f', [dexGrow]);

    medalGrow := (marchingPet.Attack + marchingPet.Defence + marchingPet.Dexterity);
    medalGrow := medalGrow - (StrToInt(EditPetAttack.Text) + StrToInt(EditPetDefence.Text) + StrToInt(EditPetDexterity.Text));
    medalGrow := medalGrow / (marchingPet.Level - 1);
    LabelMedalGr.Caption := Format('%2f', [medalGrow]);

    allGrow := marchingPet.Attack * (1 - (0.05 * marchingPet.MedalAttack));
    allGrow := allGrow + marchingPet.Defence * (1 - (0.05 * marchingPet.MedalDefence));
    allGrow := allGrow + marchingPet.Dexterity * (1 - (0.05 * marchingPet.MedalDexterity));
    allGrow := allGrow - (StrToInt(EditPetAttack.Text) + StrToInt(EditPetDefence.Text) + StrToInt(EditPetDexterity.Text));
    allGrow := allGrow / (marchingPet.Level - 1);
    Label3aGr.Caption := Format('%2f', [allGrow]);
  end;

  UnitShowPets.FormShowPets.UpdateMarchingPetInfo;
end;

procedure TFormMain.PetBaseStatsChange(Sender: TObject);
begin
  UnitShowPets.FormShowPets.EditPetLife.Text := EditPetLife.Text;
  UnitShowPets.FormShowPets.EditPetAttack.Text := EditPetAttack.Text;
  UnitShowPets.FormShowPets.EditPetDefence.Text := EditPetDefence.Text;
  UnitShowPets.FormShowPets.EditPetDexterity.Text := EditPetDexterity.Text;
  UpdateMarchingPetInfo;
  UnitShowPets.FormShowPets.UpdateMarchingPetInfo;
end;

procedure TFormMain.ResetAttributes;
begin
  ThisUser.GetAttr;
  EditStatAvailable.Text := IntToStr(ThisUser.RemainingPoints);
  EditStatLife.Text := '0';
  EditStatMana.Text := '0';
  EditStatAttack.Text := '0';
  EditStatDefense.Text := '0';
  EditStatDexterity.Text := '0';
end;

procedure TFormMain.UpdateUserAttributes(Sender: TObject);
var
  rem: Integer;
begin
  rem := ThisUser.RemainingPoints;

  if StrToIntDef(EditStatLife.Text,0) > 0 then rem := rem - StrToIntDef(EditStatLife.Text,0);
  if StrToIntDef(EditStatMana.Text,0) > 0 then rem := rem - StrToIntDef(EditStatMana.Text,0);
  if StrToIntDef(EditStatAttack.Text,0) > 0 then rem := rem - StrToIntDef(EditStatAttack.Text,0);
  if StrToIntDef(EditStatDefense.Text,0) > 0 then rem := rem - StrToIntDef(EditStatDefense.Text,0);
  if StrToIntDef(EditStatDexterity.Text,0) > 0 then rem := rem - StrToIntDef(EditStatDexterity.Text,0);

  EditStatAvailable.Text := IntToStr(rem);
end;

end.


