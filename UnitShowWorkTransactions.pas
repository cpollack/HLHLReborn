unit UnitShowWorkTransactions;
// 欢乐幻灵·显示工作步骤
interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, Grids, frmTemplate;

type
  TFormShowWorkTransactions = class(TfTemplate)
    StringGridTransactions: TStringGrid;
    ButtonHide: TButton;
    lblRepeatCount: TLabel;
    procedure ButtonHideClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowTransactions;
  end;

var
  FormShowWorkTransactions: TFormShowWorkTransactions;

implementation

{$R *.dfm}
uses
	UnitGlobal, UnitConsts, UnitTypesAndVars, UnitClasses, ClsGames;

procedure TFormShowWorkTransactions.ShowTransactions;
const
	MinRowCount = 10;
var
  i:integer;
  tmpTransaction: TTransaction;
begin
  if not self.Visible then Exit;
	// 设置网格行数
  if ThisWork.Count > MinRowCount then
    StringGridTransactions.RowCount := ThisWork.Count + 1
  else
  begin
    StringGridTransactions.RowCount := MinRowCount + 1;
  	// 清除网格内信息
	  for i := 1 to StringGridTransactions.RowCount - 1 do
  		StringGridTransactions.Rows[i].Clear;
	end;
  StringGridTransactions.Row := 1;
  
  with StringGridTransactions do
  for i := 0 to ThisWork.Count - 1 do
  begin
    tmpTransaction := ThisWork.GetTransactionByIndex(i);
    if tmpTransaction = ThisWork.GetCurrTransaction then
    	StringGridTransactions.Row := i + 1;
    Cells[0, i + 1] := IntToStr(i);		// 步骤编号
    Cells[1, i + 1] := tmpTransaction.Caption;	// 步骤说明
    if tmpTransaction.State = 1 then	// 执行状态
    	Cells[2, i + 1] := '√'
    else if tmpTransaction.State = -1 then
    	Cells[2, i + 1] := '×';
  end;

  if ThisWork.RepeatCount = -1 then
    lblRepeatCount.Caption := Format('无限循环，现在是第%d次', [ThisWork.RepeatCounter + 1])
  else
    lblRepeatCount.Caption := Format('共需要循环%d次，现在是第%d次',
    	[ThisWork.RepeatCount, ThisWork.RepeatCounter + 1]);
end;

procedure TFormShowWorkTransactions.ButtonHideClick(Sender: TObject);
begin
  Close;
end;

procedure TFormShowWorkTransactions.FormCreate(Sender: TObject);
begin
 	// 设置窗体位置
  self.CFormName := IDS_WorkTransactionsFormName;
  inherited;
  //设置表头
  with StringGridTransactions do
  begin
  	Cells[0, 0] := 'No.';
	  Cells[1, 0] := '行为名称';
  	Cells[2, 0] := 'OK';
  end;
end;

procedure TFormShowWorkTransactions.FormShow(Sender: TObject);
begin
  Caption := '显示工作步骤·' + HLInfoList.GlobalHL.UserName;
  ShowTransactions;
end;

end.
