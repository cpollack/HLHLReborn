unit frmTemplate;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms;

type
  TfTemplate = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    CFormName: WideString;
  public
    { Public declarations }
  end;

implementation
uses
  ClsGames, UnitConsts;
{$R *.dfm}

procedure TfTemplate.FormCreate(Sender: TObject);
begin
	// 保存属性
	HLInfoList.GlobalHL.LoadFormAttribute(CFormName, self);
end;

procedure TfTemplate.FormDestroy(Sender: TObject);
begin
	// 装载属性
  HLInfoList.GlobalHL.SaveFormAttribute(CFormName, self);
end;

end.
