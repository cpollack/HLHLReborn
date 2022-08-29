unit ClsMaps;

interface
uses
	Contnrs, Windows, Classes, StrUtils, IniFiles,
  UnitConsts;
type
  TNPCID = (
  	ShuiCheng_Forge, 	ShuiCheng_Med, 	ShuiCheng_Jewelry, 	ShuiCheng_Pet,	// 水
    ShuCheng_Forge,  	ShuCheng_Med, 	ShuCheng_Jewelry,                   // 树
    ShanCheng_Forge, 	ShanCheng_Med, 	ShanCheng_Jewelry,                  // 山
    ShaCheng_Forge,  	ShaCheng_Med, 	ShaCheng_Jewelry,                   // 沙
     									XueCheng_Med,                                       // 雪
    									HaiCheng_Med,                                       // 海
                      XinShanCheng_Med                                    // 新山
  ); // NPC 编号：铁匠、药店、珠宝店、宠物店

  // 步骤信息
  TStepInfo = Class
    Action: Integer;
    X: String;
    Y: String;
    Z: String;
    SubStepIndex: integer;
    CalledNPCID: TNPCID;
  public
    constructor Create(tmpAct: Integer = ActUnknown; tmpX: String = '';
      	tmpY: String = ''; tmpZ: String = '');
    class procedure ExtractStepInfo(SrcStr: string; var Action: integer;
      var X: string; var Y: string);
  end;
{  // 步骤列表
  TStepList = Class(TObjectList)
  private
    function GetItem(Index: Integer): TStepInfo;
    procedure SetItem(Index: Integer; const Value: TStepInfo);
  public
    property Items[Index: Integer]: TStepInfo read GetItem write SetItem; default;
  end;        }
	// 药店信息
  TStoreInfo = Class
    ID          : DWORD;        // 药店地图编号
    Name        : WideString;   // 药店名称
    EnteredX    : integer; 		  // 刚刚进去后时的地图坐标
    EnteredY    : integer;
    DoctorPosX  : Integer;	    // 大夫坐标
    DoctorPosY  : Integer;
    NursePosX   : Integer;      // 护士坐标
    NursePosY   : Integer;
    MedList     : TStringList;  // 药品列表
  public
    constructor Create;
    destructor Destroy; override;
  end;

  // 药店列表
  TStoreList = Class(TObjectList)
  private
    function GetItem(Index: Integer): TStoreInfo;
    procedure SetItem(Index: Integer; const Value: TStoreInfo);
  public
    property Items[Index: Integer]: TStoreInfo read GetItem write SetItem; default;
  end;

  // 地图切换点信息
  TTransportInfo = Class(TObjectList)
    ID: Integer;
    StepIndex: integer;
//    IsDoingTrans: Boolean;
    OldNPCDialog: WideString;
  private
    function GetItem(Index: Integer): TStepInfo;
    procedure SetItem(Index: Integer; const Value: TStepInfo);
  public
    property Items[Index: Integer]: TStepInfo read GetItem write SetItem; default;
  end;

  // 地图切换点列表
  TTransportList = Class(TObjectList)
  private
    function GetItem(Index: Integer): TTransportInfo;
    procedure SetItem(Index: Integer; const Value: TTransportInfo);
  public
    function ItemOfTransportID(const TransportID: Integer): TTransportInfo;
    property Items[Index: Integer]: TTransportInfo read GetItem write SetItem; default;
  end;

  // 地区信息
  TZoneInfo = Class
    ID      : Integer;      // 地区编号
    Name    : WideString;   // 地区名称
    MapList : TList;  // 地图列表
  public
    constructor Create;
    destructor Destroy; override;
  end;

  // 地区列表
  TZoneList = Class(TObjectList)
  private
    function GetItem(Index: Integer): TZoneInfo;
    procedure SetItem(Index: Integer; const Value: TZoneInfo);
  public
    property Items[Index: Integer]: TZoneInfo read GetItem write SetItem; default;
    function ItemOfZoneID(const ZoneID: Integer): TZoneInfo;
  end;

  TNodeList = Class;

  TMapInfo = Class
    ID: DWORD;                // 在游戏里面的地图编号
    PosInMapList: integer; 		// 在MapList中的序号
    NumberOfMapINI: integer; 	// 在Map.ini里面的[map序号]
    Zone: Integer;            // 地区编号
    Name: WideString;         // 地图名称
    NodeNum: integer;         // 节点数
    NodeList: TNodeList;      // 节点列表
  public
    constructor Create;
    destructor Destroy; override;
  end;
  // 地图列表
	TMapList = Class(TObjectList)
  private
  	FIniFileName: WideString;
  	FStoreList: TStoreList;
    FTransportList: TTransportList;
    FZoneList: TZoneList;
		function ExtractStoreInfo(iniFile: TIniFile; SourceStr: string): TStoreInfo;
  protected
    function GetItem(Index: Integer): TMapInfo;
    procedure SetItem(Index: Integer; Value: TMapInfo);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadMapList;
    procedure LoadStoreList;
    procedure LoadZoneList;
    procedure LoadTransportList;
    procedure ReadOneMap(PosInMapList: Integer);
    property IniFileName: WideString read FIniFileName write FIniFileName;
    function ItemOfMapID(const MapID: LongWord): TMapInfo;
    property Items[Index: Integer]: TMapInfo read GetItem write SetItem; default;
    property StoreList: TStoreList read FStoreList;
    property TransportList: TTransportList read FTransportList;
    property ZoneList: TZoneList read FZoneList;
  end;
  // 节点信息
  TNodeInfo = Class
    MyMap: TMapInfo;
    InHL_X: Integer;
    InHL_Y: Integer;
    OutMapID: DWORD;
  private
    function GetCommaText: WideString;
    procedure SetCommaText(const Value: WideString);
  public
    constructor Create;
    destructor Destroy; override;
    property CommaText: WideString read GetCommaText Write SetCommaText;
  end;
  // 节点列表
  TNodeList = Class(TObjectList)
  private
    function GetItem(Index: Integer): TNodeInfo;
    procedure SetItem(Index: Integer; const Value: TNodeInfo);
  public
    property Items[Index: Integer]: TNodeInfo read GetItem write SetItem; default;
  end;
var
	GameMaps: TMapList;
implementation
uses
	SysUtils;
//==============================================================================
{ TMapInfo }
// 地图信息
constructor TMapInfo.Create;
begin
  self.NodeList := TNodeList.Create;
end;

destructor TMapInfo.Destroy;
begin
  self.NodeList.Free;
  inherited;
end;

//==============================================================================
{ TMapList }
// 地图列表
constructor TMapList.Create;
// 构造地图列表
begin
  inherited;
  FStoreList := TStoreList.Create;
  FZoneList := TZoneList.Create;
  FTransportList := TTransportList.Create;
  IniFileName := IDS_InfoFilesPath +  IDS_DefaultMapFileName; // 设置默认地图文件
end;

destructor TMapList.Destroy;
// 销毁地图列表
begin
	FStoreList.Free;
  FZoneList.Free;
  FTransportList.Free;
  inherited;
end;

function TMapList.ExtractStoreInfo(iniFile: TIniFile; SourceStr: string): TStoreInfo;
// 返回药店信息
var
  i, iMedNum, tmpPos, iID, X, Y: integer;
  sName: WideString;
  tmpStringList: TStringList;
begin
 	Result := nil;	// 初始化对象

  tmpPos := Pos(',', SourceStr);
  if tmpPos = 0 then Exit;

  iID := StrToIntDef(copy(SourceStr, 1, tmppos - 1), -1);
  SourceStr := Copy(SourceStr, tmpPos + 1, length(SourceStr) - tmpPos);

  tmpPos := Pos(',', SourceStr);
  if tmpPos = 0 then Exit;

  X := StrToIntDef(copy(SourceStr, 1, tmpPos - 1), -1);
  SourceStr := Copy(SourceStr, tmpPos + 1, length(SourceStr) - tmpPos);

  tmpPos := Pos(',', SourceStr);
  if tmpPos = 0 then Exit;

  Y := StrToIntDef(copy(SourceStr, 1, tmppos - 1), -1);

  sName := Copy(SourceStr, tmpPos + 1, length(SourceStr) - tmpPos);

 	Result := TStoreInfo.Create;	// 创建对象
  tmpStringList := TStringList.Create;
  try
    iniFile.ReadSectionValues('Store' + IntToStr(iID), tmpStringList);
	  With Result do begin
   		ID := iID;
		  DoctorPosX := X;
	   	DoctorPosY := Y;
	  	Name := sName;
      EnteredX := StrToIntDef(tmpStringList.Values['EnteredX'], -1);
      EnteredY := StrToIntDef(tmpStringList.Values['EnteredY'], -1);
      NursePosX := StrToIntDef(tmpStringList.Values['NursePosX'], -1);
      NursePosY := StrToIntDef(tmpStringList.Values['NursePosY'], -1);
      iMedNum := StrToIntDef(tmpStringList.Values['Num'], -1);
      if iMedNum <= 0 then Exit;
      for i := 0 to iMedNum -1 do
        Result.MedList.Add(tmpStringList.Values[format('Med%d', [i])]);
  	end;
  finally
	  tmpStringList.Free;
  end;
end;

function TMapList.GetItem(Index: Integer): TMapInfo;
begin
  Result := TMapInfo(inherited Items[Index]);
end;

function TMapList.ItemOfMapID(const MapID: LongWord): TMapInfo;
// 获取指定标识的地图信息
var
  i: integer;
  TmpMap: TMapInfo;
begin
  Result := nil;
  for i := 0 to Self.Count - 1 do
  begin
    TmpMap := Self.Items[i];
    if TmpMap.ID = 0 then Self.ReadOneMap(i);
    if TmpMap.ID = MapID then
    begin
      Result := TmpMap;
      Break;
    end;
  end;
end;

procedure TMapList.LoadMapList;
// 装载地图列表
var
  MapIni: TIniFile;
  i, MapNum, iZone: Integer;
  tmpMap: TMapInfo;
  tmpZone: TZoneInfo;
begin
  MapIni := TIniFile.Create(self.FIniFileName);
  with MapIni do
  try
    MapNum := ReadInteger('Main', 'MapNum', 0);
    if MapNum = 0 then
      Exit;

    for i := 0 to MapNum - 1 do
    begin
      iZone := ReadInteger(format('Map%d', [i]), 'Zone', -1);
      if iZone = -1 then Continue; // 没有map[i]

      tmpMap := TMapInfo.Create;
      tmpMap.ID := 0;
      tmpMap.PosInMapList := self.Count;  // 在MapList中的序号
      tmpMap.NumberOfMapINI := i;         // 在Map.ini里面的[map序号]
      tmpMap.Zone := iZone;               // 地区编号

      tmpZone := FZoneList.ItemOfZoneID(iZone);
      tmpZone.MapList.Add(tmpMap);
      self.Add(tmpMap);
      // =========================================
//      self.ReadOneMap(tmpMap.PosInMapList); // 装载地图信息
      // =========================================
    end;
  finally
    Free;
  end;
end;

procedure TMapList.LoadStoreList;
// 装载药店列表
var
	i, StoreNum: integer;
  tmpStr: WideString;
  tmpStringList: TStringList;
  tmpStoreInfo: TStoreInfo;
  tmpIniFile: TIniFile;
begin
  FStoreList.Clear;
  tmpIniFile := TIniFile.Create(IDS_InfoFilesPath + IDS_StoreFilename); // 打开药店文件
  with tmpIniFile do
  try
  	tmpStringList := TStringList.Create;
    try
    	ReadSectionValues('Store', tmpStringList);
	    StoreNum := StrToIntDef(tmpStringList.Values['Num'], 0);	// 获得药店数目

	    if StoreNum = 0 then 	// 药店数为0，退出
	      Exit;

  	  for i := 0 to StoreNum - 1 do
    	begin
	      tmpStr := tmpStringList.Values[format('Store%d', [i])];
        tmpStoreInfo := ExtractStoreInfo(tmpIniFile, tmpStr); // 返回药店信息
    	  FStoreList.Add(tmpStoreInfo);
	    end;
    finally
  	  tmpStringList.Free; // 销毁字串列表
    end;
  finally
	  Free; // 销毁 INI 对象
  end;
end;

procedure TMapList.LoadTransportList;
var
  i, j, StepNum: integer;
  MapIni: TINIFile;
  tmpTransportInfo: TTransportInfo;
  tmpStep: TStepInfo;
  tmpStr: String;
  tmpStringList: TStringList;
begin
  MapIni := TIniFile.Create(self.FIniFileName);
  try
    tmpStringList := TStringList.Create;
    try
      i := 0;
      repeat
        i := i + 1;
        
        MapIni.ReadSectionValues(Format('Transport%d', [i]), tmpStringList);
        StepNum := StrToIntDef(tmpStringList.Values['StepNum'], 0);
        if StepNum < 1 then Break;

        tmpTransportInfo := TTransportInfo.Create;
        tmpTransportInfo.ID := i;
        for j := 0 to StepNum - 1 do
        begin
          tmpStep := TStepInfo.Create;
          tmpStr := tmpStringList.Values[format('Step%d', [j])];
          TStepInfo.ExtractStepInfo(tmpStr, tmpStep.Action, tmpStep.X, tmpStep.Y);
          tmpTransportInfo.Add(tmpStep);
        end;
        TransportList.Add(tmpTransportInfo);
      until False;
    finally
      tmpStringList.Free;
    end;
  finally
    MapIni.Free;
  end;
end;

procedure TMapList.LoadZoneList;
// 装载地区列表
var
  MapIni: TIniFile;
  i, ZoneNum: integer;
  tmpZone: TZoneInfo;
  tmpStringList: TStringList;
begin
  FZoneList.Clear;
  MapIni := TIniFile.Create(self.FIniFileName);
  try
    ZoneNum := MapIni.ReadInteger('Zone', 'Num', 0);
    if ZoneNum = 0 then
      Exit;

    tmpStringList := TStringList.Create;
    try
      tmpStringList.Clear;

      MapIni.ReadSectionValues('Zone', tmpStringList);

      for i := 0 to ZoneNum - 1 do
      begin
        tmpZone := TZoneInfo.Create;
        tmpZone.Name := tmpStringList.Values[format('Zone%d', [i])];
        tmpZone.ID := i;
        FZoneList.Add(tmpZone);
      end;
    finally
      tmpStringList.Clear;
      tmpStringList.Free;
    end;
  finally
    MapIni.Free;
  end;
end;

procedure TMapList.ReadOneMap(PosInMapList: Integer);
// 读入一个地图信息
var
  MapIni: TIniFile;
  tmpMap: TMapInfo;
  i: integer;
  tmpNode: TNodeInfo;
  tmpStr: WideString;
  tmpStringList: TStringList;
begin
  tmpMap := Self.Items[PosInMapList];
  MapIni := TIniFile.Create(self.FIniFileName);
  with MapIni do
  try
    tmpStringList := TStringList.Create;
    try
      ReadSectionValues(Format('Map%d', [tmpMap.NumberOfMapINI]), tmpStringList);

      tmpMap.Name := tmpStringList.Values['Name'];
      tmpMap.ID := StrToIntDef(tmpStringList.Values['ID'], 0);

      tmpMap.NodeNum := StrToIntDef(tmpStringList.Values['NodeNum'], 0);
      if tmpMap.NodeNum = 0 then Exit;  // 节点数为0

      for i := 0 to tmpMap.NodeNum - 1 do
      begin
        tmpStr := tmpStringList.Values[Format('Node%d', [i])];
        if tmpStr = '' then Break;

        tmpNode := TNodeInfo.Create;
        tmpNode.MyMap := tmpMap;
        tmpNode.CommaText := tmpStr;
        tmpMap.NodeList.Add(tmpNode);
      end;
      tmpMap.NodeNum := tmpMap.NodeList.Count;
    finally
      tmpStringList.Clear;
      tmpStringList.Free;
    end;
  finally
    Free;
  end;
end;

procedure TMapList.SetItem(Index: Integer; Value: TMapInfo);
begin
  inherited Items[Index] := Value;
end;

//==============================================================================
{ TNodeInfo }
// 节点信息
constructor TNodeInfo.Create;
begin

end;

destructor TNodeInfo.Destroy;
begin

  inherited;
end;

function TNodeInfo.GetCommaText: WideString;
begin
  Result := Format('%d, %d, %d', [InHL_X, InHL_Y, OutMapID]);
end;

procedure TNodeInfo.SetCommaText(const Value: WideString);
var
  tmpStringList: TStringList;
begin
  tmpStringList := TStringList.Create;
  try
    tmpStringList.CommaText := Value;
    if tmpStringList.Count <> 3 then Exit;
    Self.InHL_X := StrToIntDef(tmpStringList[0], 0);
    Self.InHL_Y := StrToIntDef(tmpStringList[1], 0);
    Self.OutMapID := StrToIntDef(tmpStringList[2], 0);
  finally
    tmpStringList.Free;
  end;
end;

//==============================================================================
{ TNodeList }
// 节点列表
function TNodeList.GetItem(Index: Integer): TNodeInfo;
begin
  Result := TNodeInfo(inherited Items[Index]);
end;

procedure TNodeList.SetItem(Index: Integer; const Value: TNodeInfo);
begin
  inherited Items[Index] := Value;
end;

//==============================================================================
{ TStepInfo }
// 步骤信息
constructor TStepInfo.Create(tmpAct: Integer; tmpX, tmpY, tmpZ: String);
begin
  Inherited Create;

  Action := tmpAct;
  X := tmpX;
  Y := tmpY;
  Z := tmpZ;
  SubStepIndex := 0;
end;

class procedure TStepInfo.ExtractStepInfo(SrcStr: string;
  var Action: Integer; var X, Y: string);
var
  tmpPos: Integer;
begin
  X:='';
  Y:='';

  tmpPos := Pos(',', SrcStr);
  if tmpPos =0 then Exit;

  Action := StrToIntDef(copy(SrcStr, 1, tmpPos - 1), -1);
  SrcStr := Copy(SrcStr, tmpPos + 1, length(SrcStr) - tmpPos);

  tmpPos := Pos(',', SrcStr);
  if tmpPos = 0 then Exit;

  X := copy(SrcStr, 1, tmpPos - 1);
  Y := copy(SrcStr, tmpPos + 1, length(srcstr) - tmpPos);
end;

//==============================================================================
{ TStoreInfo }
// 药店信息
constructor TStoreInfo.Create;
begin
  MedList := TStringList.Create;
end;

destructor TStoreInfo.Destroy;
begin
  self.MedList.Free;
  inherited;
end;

//==============================================================================
{ TStoreList }
// 药店列表
function TStoreList.GetItem(Index: Integer): TStoreInfo;
begin
  Result := TStoreInfo(inherited Items[Index]);
end;

procedure TStoreList.SetItem(Index: Integer; const Value: TStoreInfo);
begin
  inherited Items[Index] := Value;
end;

//==============================================================================
{ TTransportInfo }
// 地图切换点信息
function TTransportInfo.GetItem(Index: Integer): TStepInfo;
begin
  Result := TStepInfo(inherited Items[Index]);
end;

procedure TTransportInfo.SetItem(Index: Integer; const Value: TStepInfo);
begin
  inherited Items[Index] := Value;
end;

//==============================================================================
{ TTransportList }
// 地图切换点列表
function TTransportList.GetItem(Index: Integer): TTransportInfo;
begin
  Result := TTransportInfo(inherited Items[Index]);
end;

function TTransportList.ItemOfTransportID(
  const TransportID: Integer): TTransportInfo;
// 返回指定标识的传送点信息
var
  i: Integer;
  tmpTrans: TTransportInfo;
begin
  Result := nil;
  for i := 0 to self.Count - 1 do
  begin
    tmpTrans := self.Items[i];
    if tmpTrans.ID = TransportID then
    begin
      Result := tmpTrans;
      Exit;
    end;
  end;
end;

procedure TTransportList.SetItem(Index: Integer;
  const Value: TTransportInfo);
begin
  inherited Items[Index] := Value;
end;

//==============================================================================
{ TZoneInfo }
// 区域信息
constructor TZoneInfo.Create;
begin
  MapList := TList.Create;
end;

destructor TZoneInfo.Destroy;
begin
  self.MapList.Free;
  inherited;
end;

//==============================================================================
{ TZoneList }
// 区域列表
function TZoneList.GetItem(Index: Integer): TZoneInfo;
begin
  Result := TZoneInfo(inherited Items[Index]);
end;

function TZoneList.ItemOfZoneID(const ZoneID: Integer): TZoneInfo;
var
  i: Integer;
begin
  for i := 0 to Self.Count - 1 do
  begin
    Result := Self.Items[i];
    if Result.ID = ZoneID then
      Exit;
  end;
  Result := nil;
end;

procedure TZoneList.SetItem(Index: Integer; const Value: TZoneInfo);
begin
  inherited Items[Index] := Value;
end;

initialization
	GameMaps := TMapList.Create;
  GameMaps.LoadStoreList;
  GameMaps.LoadZoneList;
  GameMaps.loadMapList;
  GameMaps.LoadTransportList;
finalization
	GameMaps.Free;
end.
