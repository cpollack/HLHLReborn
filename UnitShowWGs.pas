unit UnitShowWGs;

interface

uses
  Windows, Messages, SysUtils, Classes, Grids, StdCtrls, Controls, Forms,
  frmTemplate;

type
  TFormShowWGs = class(TfTemplate)
    StringGridWGs: TStringGrid;
    ButtonHide: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonHideClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowWGs;
  end;

var
  FormShowWGs: TFormShowWGs;

implementation

uses
	UnitClasses, UnitConsts, UnitGlobal, UnitTypesAndVars, ClsGames;

{$R *.dfm}

procedure TFormShowWGs.ShowWGs;
// 刷新网格中武功信息
var
  i: integer;
  tmpstr: string;
begin
  ThisUser.GetWGs;
  with StringGridWGs do
  begin
	  for i := 1 to 10 do Rows[i].Clear;	// 清除网格
	  for i := 0 to ThisUser.WGCount - 1 do
  	begin
    	Cells[0, i + 1] := IntToStr(i + 1);       	// 编号
	    Cells[1, i + 1] := ThisUser.WGs[i].Name;		// 名称
  	  Cells[2, i + 1] := IntToStr(ThisUser.WGs[i].Neili);	// 内力

      if ThisUser.WGs[i].Real_DisplayXishuPercent >= 100 then
      	tmpstr := '√'
      else
      	tmpstr := '×';
      Cells[3, i + 1] := tmpstr;            			// 难易度
      Cells[4, i + 1] := IntToStr(Round(ThisUser.WGs[i].Neili
      	* ThisUser.WGs[i].DisplayXishuMultiply100 / 100)); 	// 杀伤
    	Cells[5, i + 1] := IntToStr(ThisUser.WGs[i].Jingyan);	//经验
	  end;
  end;
end;

procedure TFormShowWGs.FormCreate(Sender: TObject);
begin
 	// 设置窗体位置
  self.CFormName := IDS_WGsFormName;
  inherited;

	// 初始化表头
  with StringGridWGs do
  begin
  	Cells[0, 0] := 'No.';
	  Cells[1, 0] := '招式名称';
  	Cells[2, 0] := '需内';
	  Cells[3, 0] := '容易';
  	Cells[4, 0] := '杀伤';
	  Cells[5, 0] := '经验';
  end;
end;

procedure TFormShowWGs.ButtonHideClick(Sender: TObject);
begin
  Close;
end;

procedure TFormShowWGs.FormShow(Sender: TObject);
begin
  Caption := '显示武功·' + HLInfoList.GlobalHL.UserName;
end;

end.
