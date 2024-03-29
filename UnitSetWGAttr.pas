unit UnitSetWGAttr;
// 欢乐幻灵·创招设置
interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, frmTemplate;

type
  TFormSetWGAttr = class(TfTemplate)
    GroupBox1: TGroupBox;
    Label7: TLabel;
    EditWGName: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EditWGXS: TEdit;
    EditWGNL: TEdit;
    ComboBoxWGQS: TComboBox;
    ComboBoxWGGJ: TComboBox;
    ComboBoxWGBZ: TComboBox;
    gbGJConfig: TGroupBox;
    Label55: TLabel;
    Label56: TLabel;
    ComboBoxGJRank: TComboBox;
    ComboBoxGJLevel: TComboBox;
    Bevel1: TBevel;
    GroupBox14: TGroupBox;
    Label53: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    CheckBoxAutoDeleteWG: TCheckBox;
    ComboBoxDeleteFromPos: TComboBox;
    CheckBoxRemainEasyWG: TCheckBox;
    CheckBoxLevelLimit: TCheckBox;
    EditLevelLimited: TEdit;
    CheckBoxDoFateCreateWG: TCheckBox;
    CheckBoxRemainXS: TCheckBox;
    EditRemainedXS: TEdit;
    procedure EditWGXSKeyPress(Sender: TObject; var Key: Char);
    procedure EditWGNLKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxGJRankChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetFateEnableOrNot;
    procedure CheckBoxDoFateCreateWGClick(Sender: TObject);
    procedure CheckBoxRemainXSClick(Sender: TObject);
    procedure CheckBoxRemainEasyWGClick(Sender: TObject);
    procedure CheckBoxAutoDeleteWGClick(Sender: TObject);
    procedure CheckBoxLevelLimitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure LoadAttribute;
    procedure SaveAttribute;
  public
    { Public declarations }
    procedure DisableCreateWGObjs;
    procedure EnableCreateWGObjs;
    procedure SetCreateWGObjsEnabled(isEnable: Boolean);
  end;

var
  FormSetWGAttr: TFormSetWGAttr;

implementation

uses
	IniFiles, ClsGames,
  UnitTypesAndVars, UnitGlobal, UnitClasses, UnitConsts;

{$R *.dfm}

procedure TFormSetWGAttr.EditWGXSKeyPress(Sender: TObject; var Key: Char);
// 限制系数输入
begin
  if ((Key < '0') or (Key > '9')) and (Key <> '.') and (Key <> Chr(8)) and (Key <> Chr(13))
  then begin
    ShowMessage('Error: Must be a number');
    Key := Chr(0);
  end;
end;

procedure TFormSetWGAttr.EditWGNLKeyPress(Sender: TObject; var Key: Char);
// 限制内力输入
begin
  if ((Key < '0') or (Key > '9')) and (Key <> Chr(8)) and (Key <> Chr(13))
  then begin
    ShowMessage('Error: Must be a number');
    Key := Chr(0);
  end;
end;

procedure TFormSetWGAttr.ComboBoxGJRankChange(Sender: TObject);
// 设置过节队列
var
  i: integer;
begin
  ComboBoxGJLevel.Clear;	// 清除过节队列
  case ComboBoxGJRank.ItemIndex of
    0, 1, 4, 5:	// 2、3转：地仙、天仙、夜叉、修罗
    	for i := 1 to 12 do
      	ComboBoxGJLevel.Items.Add(inttostr(i * 100 - 1));
    2, 7: 	// 4转：大罗、魔神
    	for i := 1 to 13 do
      	ComboBoxGJLevel.Items.Add(IntToStr(i * 100 - 1));
    3, 8:  	// 5转：天神、魔尊
    	for i := 1 to 4 do
      	ComboBoxGJLevel.Items.Add(IntToStr(i * 300 - 1));
  end;
end;

procedure TFormSetWGAttr.FormCreate(Sender: TObject);
var
  i: integer;
begin
 	// 设置窗体位置
  self.CFormName := IDS_WGAttrFormName;
  inherited;
	// 装载属性
  LoadAttribute;

  ThisUser.GetWGs;              // 获取武功信息
  ComboBoxDeleteFromPos.Clear;	// 清除删招点列表

  for i := 0 to ThisUser.WGCountLimit - 1 do  				// 根据级别限制招数最大数
    ComboBoxDeleteFromPos.Items.Add(inttostr(i + 1));
  // 设置默认删招点
  ComboBoxDeleteFromPos.ItemIndex := ComboBoxDeleteFromPos.Items.Count - 1;
end;

procedure TFormSetWGAttr.FormShow(Sender: TObject);
begin
  Caption := '创招设置·' + HLInfoList.GlobalHL.UserName;
  SetFateEnableOrNot;

  //隐藏系数识别
  CheckBoxRemainXS.Visible := False;
  EditRemainedXS.Visible := False;
  Label1.Visible := False;
end;

procedure TFormSetWGAttr.SetFateEnableOrNot;
// 启用/关闭过节创招设置
var
	i: integer;
begin
	// 启用/禁止过节设置部分
  for i := 0 to gbGJConfig.ControlCount - 1 do
    gbGJConfig.Controls[i].Enabled := CheckBoxDoFateCreateWG.Checked;
  // 如果关闭过节设置，恢复默认过节参数
  if not CheckBoxDoFateCreateWG.Checked then
  begin
    ComboBoxGJRank.ItemIndex := -1;
    ComboBoxGJLevel.ItemIndex := -1;
  end;
end;

procedure TFormSetWGAttr.CheckBoxDoFateCreateWGClick(Sender: TObject);
// 过节创招
begin
  SetFateEnableOrNot;	// 启用/关闭过节创招设置

  if not CheckBoxDoFateCreateWG.Checked then exit;	// 不是过节创招则退出

  ThisUser.GetAttr;  // 获得人物属性
  // 设置人物过节转数
  if ThisUser.Xianmo = UserAttrXian then  // 仙
    ComboBoxGJRank.ItemIndex := ThisUser.Rank - 2
  else if ThisUser.Xianmo  = UserAttrMo then  // 魔
    ComboBoxGJRank.ItemIndex := ThisUser.Rank + 2
  else
  begin	// 凡人、散仙
    ComboBoxGJRank.ItemIndex := -1;
    CheckBoxDoFateCreateWG.Checked := False;
    SetFateEnableOrNot;
    exit;
  end;
  // 人物转数切换，刷新过节等级队列
  ComboBoxGJRankChange(Sender);
  // 设置人物过节等级
  if ThisUser.Rank <> 5 then
  	ComboBoxGJLevel.ItemIndex := Floor((ThisUser.Level + 1) / 100) - 1
  else
  	ComboBoxGJLevel.ItemIndex := Floor((ThisUser.Level + 1) / 300) - 1;
end;

procedure TFormSetWGAttr.CheckBoxRemainXSClick(Sender: TObject);
// 选择保留高系数招
// *******已经失效**********
begin
  if CheckBoxRemainXS.Checked then CheckBoxRemainEasyWG.Checked:=False;
  EditRemainedXS.Enabled:=CheckBoxRemainXS.Checked;
end;

procedure TFormSetWGAttr.CheckBoxRemainEasyWGClick(Sender: TObject);
// 选择保留容易招，设置相应状态（已经失效）
begin
  if CheckBoxRemainEasyWG.Checked then CheckBoxRemainXS.Checked := False;
  EditRemainedXS.Enabled := CheckBoxRemainXS.Checked;
  Label1.Enabled := CheckBoxRemainXS.Checked;
end;

procedure TFormSetWGAttr.CheckBoxAutoDeleteWGClick(Sender: TObject);
// 选择自动删招
begin
  ComboBoxDeleteFromPos.Enabled := CheckBoxAutoDeleteWG.Checked;
  CheckBoxRemainEasyWG.Enabled := CheckBoxAutoDeleteWG.Checked;
  CheckBoxRemainXS.Enabled := CheckBoxAutoDeleteWG.Checked;
  EditRemainedXS.Enabled := CheckBoxAutoDeleteWG.Checked and CheckBoxRemainXS.Checked;
  Label1.Enabled := CheckBoxAutoDeleteWG.Checked and CheckBoxRemainXS.Checked;
end;

procedure TFormSetWGAttr.DisableCreateWGObjs;
begin
  SetCreateWGObjsEnabled(False);
end;

procedure TFormSetWGAttr.EnableCreateWGObjs;
begin
  SetCreateWGObjsEnabled(True);

  ComboBoxDeleteFromPos.Enabled := CheckBoxAutoDeleteWG.Checked;
  CheckBoxRemainEasyWG.Enabled := CheckBoxAutoDeleteWG.Checked;
  CheckBoxRemainXS.Enabled := CheckBoxAutoDeleteWG.Checked;
  EditRemainedXS.Enabled := CheckBoxAutoDeleteWG.Checked and CheckBoxRemainXS.Checked;
  Label1.Enabled := CheckBoxAutoDeleteWG.Checked;
  EditLevelLimited.Enabled := CheckBoxLevelLimit.Checked;
  ComboBoxGJRank.Enabled := CheckBoxDoFateCreateWG.Checked;
  ComboBoxGJLevel.Enabled := CheckBoxDoFateCreateWG.Checked;
end;


procedure TFormSetWGAttr.SetCreateWGObjsEnabled(isEnable: Boolean); //设置那些组件是Enable，还是Disable
begin
  EditWGName.Enabled := isEnable;
  EditWGXS.Enabled := isEnable;
  EditWGNL.Enabled := isEnable;
  ComboBoxWGQS.Enabled := isEnable;
  ComboBoxWGGJ.Enabled := isEnable;
  ComboBoxWGBZ.Enabled := isEnable;
  EditLevelLimited.Enabled := isEnable;
  Label14.Enabled := isEnable;
  CheckBoxLevelLimit.Enabled := isEnable;
  CheckBoxAutoDeleteWG.Enabled := isEnable;
  CheckBoxDoFateCreateWG.Enabled := isEnable;
  CheckBoxRemainEasyWG.Enabled := isEnable;
  CheckBoxRemainXS.Enabled := isEnable;
  ComboBoxDeleteFromPos.Enabled := isEnable;
  Label53.Enabled := isEnable;
  EditRemainedXS.Enabled := isEnable;
  Label1.Enabled := isEnable;
  ComboBoxGJRank.Enabled := isEnable;
  ComboBoxGJLevel.Enabled := isEnable;
end;

procedure TFormSetWGAttr.CheckBoxLevelLimitClick(Sender: TObject);
// 选择停止创招等级
begin
  EditLevelLimited.Enabled := CheckBoxLevelLimit.Checked;
end;

procedure TFormSetWGAttr.LoadAttribute;
// 装载属性
var
	iTmp: Integer;
  fTmp: Currency;
begin

	with TIniFile.Create(IDS_UsersPath + HLInfoList.GlobalHL.UserName + '.Ini') do // 创招
  try
    // 设置武功名称
    self.EditWGName.Text := ReadString(IDS_WGAttrFormName, IDS_WG_Name, IDS_WG_NameDef);
    // 设置武功系数
	  fTmp := ReadFloat(IDS_WGAttrFormName, IDS_WG_XiShu, 1);
    if (fTmp <= 0) or (fTmp > 2) then fTmp := 1;
  	EditWGXS.Text := FloatToStr(fTmp);
    // 设置武功内力
  	iTmp := ReadInteger(IDS_WGAttrFormName, IDS_WG_NeiLi, 100);
    EditWGNL.Text := IntToStr(iTmp);
    // 设置武功样式
  	iTmp := ReadInteger(IDS_WGAttrFormName, IDS_WG_ZiShi, 0);
    if (iTmp < 0) or (iTmp >= ComboBoxWGQS.Items.Count) then iTmp := 0;
    ComboBoxWGQS.ItemIndex := iTmp;

  	iTmp := ReadInteger(IDS_WGAttrFormName, IDS_WG_GuiJi, 0);
    if (iTmp < 0) or (iTmp >= ComboBoxWGGJ.Items.Count) then iTmp := 0;
    ComboBoxWGGJ.ItemIndex := iTmp;

  	iTmp := ReadInteger(IDS_WGAttrFormName, IDS_WG_BaoZha, 0);
    if (iTmp < 0) or (iTmp >= ComboBoxWGBZ.Items.Count) then iTmp := 0;
    ComboBoxWGBZ.ItemIndex := iTmp;
  finally
  	Free;
  end;
end;

procedure TFormSetWGAttr.SaveAttribute;
// 保存属性
begin
	with TIniFile.Create(IDS_UsersPath + HLInfoList.GlobalHL.UserName + '.Ini') do // 创招
  try
    // 保存武功名称
    WriteString(IDS_WGAttrFormName, IDS_WG_Name, self.EditWGName.Text);
    // 保存武功系数
	  WriteFloat(IDS_WGAttrFormName, IDS_WG_XiShu, StrToFloatDef(EditWGXS.Text, 1));

    // 保存武功内力
  	WriteInteger(IDS_WGAttrFormName, IDS_WG_NeiLi, StrToIntDef(EditWGNL.Text, 100));
    // 保存武功样式
  	WriteInteger(IDS_WGAttrFormName, IDS_WG_ZiShi, ComboBoxWGQS.ItemIndex);
  	WriteInteger(IDS_WGAttrFormName, IDS_WG_GuiJi, ComboBoxWGGJ.ItemIndex);
  	WriteInteger(IDS_WGAttrFormName, IDS_WG_BaoZha, ComboBoxWGBZ.ItemIndex);
  finally
  	free;
  end;
end;

procedure TFormSetWGAttr.FormDestroy(Sender: TObject);
begin
	// 保存属性
	SaveAttribute;
 	// 保存窗体位置
  inherited;
end;

end.
