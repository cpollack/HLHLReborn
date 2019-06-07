unit frmShowScript;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfShowScript = class(TForm)
    Panel1: TPanel;
    bbtnSave: TBitBtn;
    bbtnClose: TBitBtn;
    Memo1: TMemo;
    lstScripts: TListBox;
    Splitter1: TSplitter;
    bbtnRefresh: TBitBtn;
    procedure bbtnRefreshClick(Sender: TObject);
    procedure lstScriptsDblClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FLoadFileName: WideString;
    procedure RefreshScriptsList;
  public
    { Public declarations }
  end;

var
  fShowScript: TfShowScript;

implementation
uses
	UnitConsts;

{$R *.dfm}
procedure TfShowScript.RefreshScriptsList;
var
  sr: TSearchRec;
begin
	lstScripts.Items.Clear;
  if FindFirst(IDS_ScriptFilesPath + '*.ini', faAnyFile, sr) = 0 then
 	repeat
    	lstScripts.Items.Add(sr.Name);
  until FindNext(sr) <> 0;
  FindClose(sr);
end;

procedure TfShowScript.FormCreate(Sender: TObject);
begin
  RefreshScriptsList;
end;

procedure TfShowScript.bbtnRefreshClick(Sender: TObject);
begin
	RefreshScriptsList;
end;

procedure TfShowScript.lstScriptsDblClick(Sender: TObject);
begin
	FLoadFileName := IDS_ScriptFilesPath + lstScripts.Items[lstScripts.ItemIndex];
  self.Memo1.Lines.LoadFromFile(FLoadFileName);
end;

procedure TfShowScript.bbtnSaveClick(Sender: TObject);
begin
	if Length(FLoadFileName) > 0 then
	  self.Memo1.Lines.SaveToFile(FLoadFileName);
end;

procedure TfShowScript.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = Ord('A')) then
  	Memo1.SelectAll;
end;

end.
