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
	  for i:=1 to 15 do Rows[i].Clear;	// �������

  	ThisUser.GetItems;
	  for i:=0 to ThisUser.ItemCount - 1 do
  	begin
    	Cells[0, i + 1] := IntToStr(i + 1);       	// ���
	    Cells[1, i + 1] := ThisUser.Items[i].Name;	// ����
  	  Cells[2, i + 1] := ThisUser.Items[i].Maker;// ������
    	if ThisUser.Items[i].Level > 1000000 then                   // �ȼ�
    		tmpLevel := ThisUser.Items[i].Level - 1000000
	    else
  	  	tmpLevel:=ThisUser.Items[i].Level;
    	Cells[3, i + 1] := IntToStr(tmpLevel);
	    Cells[4, i + 1] := IntToStr(ThisUser.Items[i].PlusLife);		// Ѫ
  	  Cells[5, i + 1] := IntToStr(ThisUser.Items[i].PlusNeili);		// ��
    	Cells[6, i + 1] := IntToStr(ThisUser.Items[i].PlusGongji);	// ����
	    Cells[7, i + 1] := IntToStr(ThisUser.Items[i].PlusFangyu);	// ����
	 	  Cells[8, i + 1] := IntToStr(ThisUser.Items[i].PlusMinjie);	// ��
    	Cells[9, i + 1] := '--';                                    // ����λ��

	    if ThisForge <> Nil then
    	  if ThisForge.StoveCount > 0 then
      	begin
        	tmpStove := ThisForge.GetCurrStove;
	        for j := 0 to 7 do
          	// �ҵ���Ӧ��Item��
    	      if tmpStove.Rooms[j].Stuff.StuffID = ThisUser.Items[i].ID then
          	  Cells[9, i + 1] := IntToStr(j);  // ¯λ
    	  end; {if}
  	end;	{for}
  end; {with}
  ThisUser.GetAttr;
  LabelMoney.Caption := 'Money��' + inttostr(ThisUser.Money);
end;

procedure TFormShowStuffs.FormCreate(Sender: TObject);
begin
	// װ������
  self.CFormName := IDS_StuffsFormName;
  inherited;
	// ��ʼ����ͷ
  StringGridStuffs.Cells[0, 0] := 'No.';
  StringGridStuffs.Cells[1, 0] := '����';
  StringGridStuffs.Cells[2, 0] := '������';
  StringGridStuffs.Cells[3, 0] := '����';
  StringGridStuffs.Cells[4, 0] := '+Ѫ';
  StringGridStuffs.Cells[5, 0] := '+��';
  StringGridStuffs.Cells[6, 0] := '+��';
  StringGridStuffs.Cells[7, 0] := '+��';
  StringGridStuffs.Cells[8, 0] := '+��';
  StringGridStuffs.Cells[9, 0] := '¯λ';
end;

procedure TFormShowStuffs.FormShow(Sender: TObject);
begin
  Caption := '��ʾ��Ʒ��' + HLInfoList.GlobalHL.UserName;
end;

procedure TFormShowStuffs.ButtonHideClick(Sender: TObject);
begin
  Close;
end;

procedure TFormShowStuffs.btnRefreshClick(Sender: TObject);
// ˢ����ʾ��Ʒ
begin
  self.ShowStuffs;
end;

end.