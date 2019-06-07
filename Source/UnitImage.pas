unit UnitImage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, jpeg, frmTemplate;

type
  TFormImage = class(TfTemplate)
    Image1: TImage;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormImage: TFormImage;

implementation

{$R *.dfm}
uses
	UnitConsts, UnitGlobal;
procedure TFormImage.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormImage.FormCreate(Sender: TObject);
begin
  self.CFormName := IDS_ImageFormName;
  inherited;
end;

end.
