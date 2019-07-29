unit UnitShowUniverseStove;

interface

uses
  Windows, Messages, Classes, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, frmTemplate;

type
  TFormShowUniverseStove = class(TfTemplate)
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    LabelAnimator: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit0: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    TrackBarForgeDelay: TTrackBar;
    Label1: TLabel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowUniverseStove;
  end;

var
  FormShowUniverseStove: TFormShowUniverseStove;

implementation
uses
	UnitGlobal, UnitTypesAndVars, UnitClasses, Graphics, UnitConsts, ClsGames;
{$R *.dfm}

procedure TFormShowUniverseStove.ShowUniverseStove;
var
  i, j: integer;
  tmpStove: StoveInfo;
  tmpEditBox: TEdit;
begin
  Edit0.Text := '';
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Edit5.Text := '';
  Edit6.Text := '';
  Edit7.Text := '';

  if ThisForge = Nil then exit;

  ThisUser.GetItems;
  for i := 0 to ThisUser.ItemCount - 1 do
  begin
    if ThisForge.StoveCount > 0 then
    begin
      tmpStove := ThisForge.GetCurrStove;
      for j := 0 to 7 do
      begin
        case j of
          0: tmpEditBox := Edit0;
          1: tmpEditBox := Edit1;
          2: tmpEditBox := Edit2;
          3: tmpEditBox := Edit3;
          4: tmpEditBox := Edit4;
          5: tmpEditBox := Edit5;
          6: tmpEditBox := Edit6;
          7: tmpEditBox := Edit7;
        end;

        if tmpStove.Rooms[j].Stuff.StuffID = ThisUser.Items[i].ID
        then // 找到对应的Item了
        begin
          tmpEditBox.Text := ThisUser.Items[i].Name;
        end;
      end;
    end;
  end;

  if ThisForge.StoveCount>0 then
  begin
    tmpStove:=ThisForge.GetCurrStove;
    for j:=0 to 7 do
    begin
      case j of
        0: tmpEditBox := Edit0;
        1: tmpEditBox := Edit1;
        2: tmpEditBox := Edit2;
        3: tmpEditBox := Edit3;
        4: tmpEditBox := Edit4;
        5: tmpEditBox := Edit5;
        6: tmpEditBox := Edit6;
        7: tmpEditBox := Edit7;
      end;
      tmpEditBox.Font.Style:=[];
    end;

    case tmpStove.MainRoomPos of
      0: tmpEditBox := Edit0;
      1: tmpEditBox := Edit1;
      2: tmpEditBox := Edit2;
      3: tmpEditBox := Edit3;
      4: tmpEditBox := Edit4;
      5: tmpEditBox := Edit5;
      6: tmpEditBox := Edit6;
      7: tmpEditBox := Edit7;
    end;
    tmpEditBox.Font.Style := [fsBold];
  end;
end;

procedure TFormShowUniverseStove.FormShow(Sender: TObject);
begin
  Caption := '显示乾坤五行炉·' + HLInfoList.GlobalHL.UserName;
end;

procedure TFormShowUniverseStove.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormShowUniverseStove.FormCreate(Sender: TObject);
begin
	// 装载属性
  self.CFormName := IDS_UniverseStoveFormName;
  inherited;
end;

end.
