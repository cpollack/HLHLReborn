unit UnitShowPets;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, frmTemplate;

type
  TFormShowPets = class(TfTemplate)
    StringGridWGs: TStringGrid;
    ButtonHide: TButton;
    btnRefresh: TButton;
    Label7: TLabel;
    LabelPetName: TLabel;
    Label10: TLabel;
    LabelCurrLevel: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label13: TLabel;
    EditPetLife: TEdit;
    LabelCurrLIfe: TLabel;
    LabelGrLife: TLabel;
    LabelGrAttack: TLabel;
    LabelCurrAttack: TLabel;
    EditPetAttack: TEdit;
    Label9: TLabel;
    Label11: TLabel;
    EditPetDefence: TEdit;
    LabelCurrDefence: TLabel;
    LabelGrDefence: TLabel;
    LabelGrDexterity: TLabel;
    LabelCurrDexterity: TLabel;
    EditPetDexterity: TEdit;
    Label12: TLabel;
    Label28: TLabel;
    Label3AGr: TLabel;
    Label26: TLabel;
    LabelMedalGr: TLabel;
    btnRecord: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonHideClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure UpdateMarchingPetInfo();
    procedure PetBaseStatsChange(Sender: TObject);
    procedure btnRecordClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowPets;
  end;

var
  FormShowPets: TFormShowPets;

implementation

uses
	UnitConsts, UnitGlobal, UnitTypesAndVars, UnitClasses, ClsGames, UnitMain;

{$R *.dfm}

procedure TFormShowPets.ShowPets;
var
  i: integer;
  tmpstr: string;
begin
  ThisUser.GetPets;

  with StringGridWGs do
  begin
	  for i := 1 to 5 do Rows[i].Clear;

  	for i := 0 to ThisUser.PetCount-1 do
	  begin
  	  Cells[0, i+1] := IntToStr(i + 1);	// 编号
    	tmpstr := '   ';
	    if ThisUser.BattlePetPos = i then tmpstr := '※ ';
  	  Cells[1, i + 1] := tmpstr + ThisUser.Pets[i].Name;		// 宠物名称
    	Cells[2, i + 1] := IntToStr(ThisUser.Pets[i].Level);	// 宠物等级
	    Cells[3, i + 1] := IntToStr(ThisUser.Pets[i].Loyal);  // 忠
  	  Cells[4, i + 1] := IntToStr(ThisUser.Pets[i].CurrLife)
      	+ '/' + IntToStr(ThisUser.Pets[i].MaxLife);         // 血/生命
		end;
  end;
end;

procedure TFormShowPets.FormCreate(Sender: TObject);
begin
	// 装载属性
  self.CFormName := IDS_PetsFormName;
  inherited;
  // 初始化表头
  with StringGridWGs do
  begin
  	Cells[0, 0] := 'No.';
	  Cells[1, 0] := 'Name（※March）';
  	Cells[2, 0] := 'Lvl';
	  Cells[3, 0] := 'Loy';
  	Cells[4, 0] := 'Life';
	end;
end;

procedure TFormShowPets.FormShow(Sender: TObject);
begin
  Caption:='Show Pets - ' + HLInfoList.GlobalHL.UserName;
end;

procedure TFormShowPets.ButtonHideClick(Sender: TObject);
begin
  Close;
end;

procedure TFormShowPets.btnRecordClick(Sender: TObject);
begin
  ThisUser.RecordPetStats;
end;

procedure TFormShowPets.btnRefreshClick(Sender: TObject);
// 显示宠物
begin
  updateMarchingPetInfo();
  ThisUser.GetPetStats(ThisUser.GetMarchingPet().ID);
	self.ShowPets;
end;

procedure TFormShowPets.UpdateMarchingPetInfo();
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
end;

procedure TFormShowPets.PetBaseStatsChange(Sender: TObject);
begin
  UnitMain.FormMain.EditPetLife.Text := EditPetLife.Text;
  UnitMain.FormMain.EditPetAttack.Text := EditPetAttack.Text;
  UnitMain.FormMain.EditPetDefence.Text := EditPetDefence.Text;
  UnitMain.FormMain.EditPetDexterity.Text := EditPetDexterity.Text;
  UpdateMarchingPetInfo;
  UnitMain.FormMain.UpdateMarchingPetInfo;
end;

end.
