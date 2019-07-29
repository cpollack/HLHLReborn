unit UnitShowStuffs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, UnitTypesAndVars, UnitGlobal, UnitClasses, frmTemplate;

type
  TFormShowStuffs = class(TfTemplate)
    StringGridStuffs: TStringGrid;
    ButtonHide: TButton;
    LabelMoney: TLabel;
    btnRefresh: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonHideClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowStuffs;
  end;

var
  FormShowStuffs: TFormShowStuffs;

implementation
uses
	IniFIles, UnitConsts, ClsGames;
{$R *.dfm}
procedure TFormShowStuffs.ShowStuffs;
var
  i, j: integer;
  tmpStove: StoveInfo;
  tmpLevel: DWORD;
begin
	with StringGridStuffs do
  begin
	  for i:=1 to 15 do Rows[i].Clear;	// 清除网格

  	ThisUser.GetItems;
	  for i:=0 to ThisUser.ItemCount - 1 do
  	begin
    	Cells[0, i + 1] := IntToStr(i + 1);       	// 编号
	    Cells[1, i + 1] := ThisUser.Items[i].Name;	// 名称
  	  Cells[2, i + 1] := ThisUser.Items[i].Maker;// 制作者
    	if ThisUser.Items[i].Level > 1000000 then                   // 等级
    		tmpLevel := ThisUser.Items[i].Level - 1000000
	    else
  	  	tmpLevel:=ThisUser.Items[i].Level;
    	Cells[3, i + 1] := IntToStr(tmpLevel);
	    Cells[4, i + 1] := IntToStr(ThisUser.Items[i].PlusLife);		// 血
  	  Cells[5, i + 1] := IntToStr(ThisUser.Items[i].PlusNeili);		// 内
    	Cells[6, i + 1] := IntToStr(ThisUser.Items[i].PlusGongji);	// 攻击
	    Cells[7, i + 1] := IntToStr(ThisUser.Items[i].PlusFangyu);	// 防御
	 	  Cells[8, i + 1] := IntToStr(ThisUser.Items[i].PlusMinjie);	// 敏
    	Cells[9, i + 1] := '--';                                    // 锻造位置

	    if ThisForge <> Nil then
    	  if ThisForge.StoveCount > 0 then
      	begin
        	tmpStove := ThisForge.GetCurrStove;
	        for j := 0 to 7 do
          	// 找到对应的Item了
    	      if tmpStove.Rooms[j].Stuff.StuffID = ThisUser.Items[i].ID then
          	  Cells[9, i + 1] := IntToStr(j);  // 炉位
    	  end; {if}
  	end;	{for}
  end; {with}
  ThisUser.GetAttr;
  LabelMoney.Caption := 'Money：' + inttostr(ThisUser.Money);
end;

procedure TFormShowStuffs.FormCreate(Sender: TObject);
begin
	// 装载属性
  self.CFormName := IDS_StuffsFormName;
  inherited;
	// 初始化表头
  StringGridStuffs.Cells[0, 0] := 'No.';
  StringGridStuffs.Cells[1, 0] := '名称';
  StringGridStuffs.Cells[2, 0] := '制作者';
  StringGridStuffs.Cells[3, 0] := '级别';
  StringGridStuffs.Cells[4, 0] := '+血';
  StringGridStuffs.Cells[5, 0] := '+内';
  StringGridStuffs.Cells[6, 0] := '+攻';
  StringGridStuffs.Cells[7, 0] := '+防';
  StringGridStuffs.Cells[8, 0] := '+敏';
  StringGridStuffs.Cells[9, 0] := '炉位';
end;

procedure TFormShowStuffs.FormShow(Sender: TObject);
begin
  Caption := '显示物品·' + HLInfoList.GlobalHL.UserName;
end;

procedure TFormShowStuffs.ButtonHideClick(Sender: TObject);
begin
  Close;
end;

procedure TFormShowStuffs.btnRefreshClick(Sender: TObject);
// 刷新显示物品
begin
  self.ShowStuffs;
end;

end.
