unit UnitClasses;

interface

Uses
	Windows, SysUtils, Classes, IniFiles, Messages, Contnrs,
  UnitTypesAndVars, UnitConsts, ClsMaps, ClsGames, Math,
  UnitGeneralSet;

Type
  // 步骤信息
{  TStep = Class
    public
      Action: Integer;
      X: String;
      Y: String;
      Z: String;
      SubStepIndex: integer;
      CalledNPCID: TNPCID;
      constructor Create(tmpAct: Integer = ActUnknown; tmpX: String = '';
      	tmpY: String = ''; tmpZ: String = '');
  end;    }
  // 事务信息
  TTransaction = Class // 做一系列步骤
    Private
      FCaption: WideString; // 这一步叫什么名字
      FID: integer; // 在Workini中的定位
      Purposes: TList;
      FOldTime: LongWord;
      StepList: TList;
      StepCount: Integer; // 一共有多少个Step
    Public
      StepIndex: integer;
      IsWorking: Boolean;
      PosX: DWORD;
      PosY: DWORD;
      OldNPCDialog: WideString;
      State: Integer; // 0-还没有检查，1-OK，-1为不行      constructor Create;
      property Caption: WideString read FCaption;
      constructor Create(tmpID: integer = -1; tmpCaption: String = ''); overload;
      destructor Destroy; override;
      procedure SetOldTime;
      procedure ClearOldTime;
      function HasPassedInterval(MilliSecond: LongWord): Boolean;
      procedure TryReadDetails(const vIniFileName: WideString);
      function IsPurposeSatisfied: Boolean;
      procedure AddStep(tmpAction: Integer; tmpX, tmpY, tmpZ: String);
      procedure InsertStep(tmpAction: Integer; tmpX, tmpY, tmpZ: String; pos: Integer);
      function GetCurrStep: TStepInfo;
      procedure Init;
      function IsFinish: Boolean;
      procedure GotoNextStep;
      function AddPurpose: PurposeInfo;
      procedure PurseSteps(tmpStringList: TStringList);
  end;
  // 工作
  TWork = Class(TObjectList)
  Private
//    TransactionList: TList;
    //FTransactionIndex: Integer;  // 当前事务编号{此Step不是StepInfo的含义}
    FIniFileName: WideString;   // 脚本文件
    FRepeatCount: Integer;
    function GetItem(Index: Integer): TTransaction;
    procedure SetItem(Index: Integer; const Value: TTransaction);      // 预计循环数
  Public
    FTransactionIndex: Integer;  // 当前事务编号{此Step不是StepInfo的含义}
    CanWork: Boolean;
    IsFirstTime: Boolean;     // 是否第一次工作
    RepeatCounter: Integer;
//    TransactionCount: integer;
    property IniFileName: WideString read FIniFileName write FIniFileName;  // 脚本文件
    property Items[Index: Integer]: TTransaction read GetItem write SetItem; default;
    property RepeatCount: Integer read FRepeatCount;  // 预计循环数

    function AddTransaction(const Caption: String = ''): TTransaction;
    procedure DeleteTransaction(Index: integer);
    procedure Clean;
    constructor Create;
    destructor Destroy; override;
    function GetSize: Integer;
    function GetCurrTransaction: TTransaction;
    function GetNextTransToDo: Boolean;
    function GetTransactionByIndex(Index: integer): TTransaction;
    procedure GotoNextTrans;
    procedure GotoTrans(ToIndex: integer; IsClearState: Boolean=False);
    function IsFinish: Boolean; // 检测工作是否完成
    function ReadIni: Boolean;
  end;
  // 原料
  TBuyStuff = class
    Public
      function InitShop: Boolean; // 返回值为False的时候，表明Shop有些窗口没有找到
      function IsSatisfied: Boolean;
      procedure WriteStuffInfo(Name, Maker: String; Count: integer);
      procedure GetAllStuffCount;
      procedure PatchShop;
      procedure UnPatchShop;
      function DoBuyStuff: Boolean;
      function HasBoughtStuff: Boolean;
    Private
      hwndShop: HWND;
      hwndItemList: HWND;
      hwndBuy: HWND;
      StuffName: String;
      StuffMaker: String;
      StuffCount: integer;
      OldAllStuffCount: integer;
  end;
  // 战斗
  TBattle = Class
    Public
      OrderHumanAction: integer; // 预先下的指令，在战斗过程中不会变化
      OrderPetAction: integer;
      EscapeWhenNoMonsterToCapture: Boolean; // 没有找到捉宠目标时是否要逃跑
      MonsterNameToCapture: String;  // 要捉的宠的名字
      CaptureLevelFrom: integer; // 捉宠时级别下限
      CaptureLevelTo: integer; // 捉宠时级别上限
      HasBegin: Boolean;

      CreatureCount: integer;
      Creatures: TList;
      procedure GetCreatures;

      constructor Create;
      destructor Destroy; override;
      procedure DoBattle;
    private
      DeadMonsterCount: integer;

      CurrHumanAction: integer; // 此次回合中的指令
      CurrPetAction: integer;

      OldCreatureCount: integer; // 捉宠时有用，判断宠是否被捉
      LiveMonsterCount: integer;
      TotalExp: integer; // Total experience for all monsters in battle
      BattleBufferOrder: DWORD; // 战斗指令
      BattleBufferHumanAct: DWORD; // 人物动作
      BattleBufferHumanActObj: DWORD; // 人物动作对象
      BattleBufferRemain1: DWORD;
      BattleBufferRemain1a: DWORD;
      BattleBufferPetAct: DWORD; // 宠物动作
      BattleBufferPetActObj: DWORD; // 宠物动作对象
      BattleBufferRemain2: DWORD;
      BattleBufferRemain2a: DWORD;
      BattleBufferTimer: DWORD;

      function FindMonsterToAct(IsPetAction:Boolean=False):DWORD;
      function GetMyPetBattleID(myPet: TPet):DWORD;
      function GetCreatureById(creatureId: DWORD): CreatureInfo;
      procedure ReadOrders;
      procedure WriteOrders;
      function ReadDeadMonsterCount: integer;
      procedure SubmitAction;
      function ReadState: integer;
      function GetBattleExpForLevel(Level:Integer): integer;
  end;
  // 移动
  TMove = class
  private
    function GetPathNodeCount: integer;
    Public
      property PathNodeCount: integer read GetPathNodeCount;
      constructor Create;
      destructor Destroy; override;
      function Init(FromPos, ToPos: integer): Boolean;

      function GetCurrPathNode: TNodeInfo;
      function GetCurrPathNodeIndex: integer;
      procedure GotoNextPathNode;
    private
      FromMapIndexInList: integer; // 发起移动/回来动作时当前的地图
      ToMapIndexInList: integer;

      Path: TList;
      PathNodeIndex: integer;
      Dijksatra_Nodes: TList;

      function FindPath: Boolean;
  end;
  // 锻造
  TForge = class
    Public
      StoveCount: integer;
      constructor Create;
      destructor Destroy; override;
      procedure Clean;
      procedure Init;
      procedure WriteStoveInstruction;
      procedure PatchUniverseStove;
      procedure UnPatchUniverseStove;
      function GetCurrStove: StoveInfo;
      function FillStove: Boolean;
      function HasCurrStoveFinished: Boolean;
      function IsFinish: Boolean;
      procedure GotoNextStove;
      procedure InitStoveStuffsToBeChozen;
    Private
      StoveStuffsToBeChozenCount: integer;
      StoveStuffsToBeChozen: array [0..14] of TStoveStuffToBeChozen;

      StoveIndex: integer;
      StoveList: TList;
  end;
  // 用户
  TUser = class
    Public
      ID: WORD;
      Rank: WORD;
      Level: WORD;
      Xiu_Level: DWORD;
      Xianmo: WORD;    // 仙魔
      CurrLife: WORD;
      MaxLife: WORD;
      CurrNeili: WORD;
      MaxNeili: WORD;
      Tili: WORD;      // 体力
      Neigong: WORD;   // 内功
      Gongji: WORD;    // 攻击
      Fangyu: WORD;    // 防御
      Qinggong: WORD;  // 轻功
      RemainingPoints: WORD;
      OldRemaining: integer;
      Money: DWORD;    // 钱
      PetCount: integer;
      BattlePetPos: integer;
      Pets: array [0..4] of TPet;
      WGCount: integer;
      WGCountLimit: integer;
      WGs: array[0..9] of TWG;
      OldItemCount: integer;  // 使用物品前一次的ItemCount
      ItemCount: integer;
      OldItemID: DWORD;
      Items: array [0..14] of TItem;

      procedure GetAttr;
      function FindPetCount(Name: String; Loyal: WORD): integer;
      procedure GetWGs;
      procedure GetPets;
      procedure GetItems;
      function GetMarchingPet(): TPet;
      function FindPetPos(Name: String; Loyal: integer): integer; // 从 1 开始，0说明没有找到
      function FindItemCount(Name: String; Maker: String): integer;
      function FindItemPos(Name: String; Maker: String): integer; // 从 1 开始，0说明没有找到
      function FindItemPosByID(ID: DWORD): integer; // 从 1 开始，0说明没有找到
      function FindNeiyaoPos: integer; // 从 1 开始，0说明没有找到
      function UseItem(ID: DWORD):Boolean;
      function DropItem(ID: DWORD):Boolean;
      function FindItemID(Name: String; Maker: String): DWORD;
      function FindItemByType(ItemType: DWORD): DWORD;
      procedure PatchItemWindow;
      procedure UnPatchItemWindow;
      procedure AddStats(statType: String; points: integer);

    Private
  end;
  // 创招
  TCreateWG = Class
    Public
      WorkStep: Integer;
      HumanOldNeili: integer;  // 用来判断吃否吃过药，不能用满内判断，因为有时候吃药内也不满
      HumanOldLevel: integer; // 用了判断是否已经降级
      CreateStep: integer; // 创招步骤
      IsWorking: Boolean;
      IsDoingFate: Boolean; // 是否正在过劫
      LevelLimit: integer; // 到多少级就停止创招

      OldWGCount: integer;
      DeleteWGRemainIndicator: Real;
      DeleteFrom: integer;

      function FindWindows(var hwndMC, hwndXS, hwndNL,
        hwndQS, hwndGJ, hwndBZ, hwndButtonCZ: HWND): HWND;
      function DoCreateWG: Boolean;
      function DoDeleteWGs: Boolean;

      procedure PatchCreateWG;
      procedure UnPatchCreateWG;
  end;

var
  ThisBattle: TBattle = nil;      // 战斗
  ThisBuyStuff: TBuyStuff = nil;  // 原料
  ThisCreateWG: TCreateWG = nil;  // 创招
  ThisForge: TForge = nil;        // 锻造
  ThisMove: TMove = nil;          // 移动

  ThisWork: TWork;
  ThisUser: TUser;

implementation

Uses UnitGlobal;
     {
constructor TStep.Create(tmpAct: Integer = ActUnknown;
	tmpX: String = ''; tmpY: String = ''; tmpZ: String = '');
begin
  Inherited Create;

  Action := tmpAct;
  X := tmpX;
  Y := tmpY;
  Z := tmpZ;
  SubStepIndex := 0;
end;       }

//==============================================================================
function TTransaction.AddPurpose: PurposeInfo;
var
  tmpPurpose: PurposeInfo;
begin
  new(tmpPurpose);
  tmpPurpose.Allows := TStringList.Create;
  tmpPurpose.Allows.Clear;
  tmpPurpose.isSatisfied := False;
  Purposes.Add(tmpPurpose);
  Result := tmpPurpose;
end;

procedure TTransaction.AddStep(tmpAction: Integer; tmpX, tmpY, tmpZ: String);
var
  tmpStep: TStepInfo;
begin
  tmpStep := TStepInfo.Create(tmpAction, tmpX, tmpY, tmpZ);
  StepList.Add(tmpStep);
  StepCount := StepList.Count;
end;

procedure TTransaction.InsertStep(tmpAction: Integer; tmpX, tmpY, tmpZ: String; pos: Integer);
var
  tmpStep: TStepInfo;
begin
  tmpStep := TStepInfo.Create(tmpAction, tmpX, tmpY, tmpZ);
  StepList.Insert(pos, tmpStep);
  StepCount := StepList.Count;
end;

procedure TTransaction.ClearOldTime;
begin
  FOldTime := 0;
end;

constructor TTransaction.Create(tmpID: Integer = -1; tmpCaption: String = '');
// 构造过程
begin
  Inherited Create;

  FID := tmpID;            // 步骤编号
  FCaption := tmpCaption;	// 步骤说明

  StepCount := -1; // 表示还没有开始读详细数据

  Purposes := TList.Create; // 目的
  StepList := TList.Create;	// 步骤
  Purposes.Clear;
  StepList.Clear;

  Init;	// 初始化
end;

destructor TTransaction.Destroy;
// 销毁过程
var
  i: Integer;
  tmpPurpose: PurposeInfo;
  tmpStep: TStepInfo;
begin
  // 销毁步骤
  for i:= 0 to StepList.Count - 1 do
  begin
    tmpStep := StepList.Items[i];
    tmpStep.Free;
  end;
  StepList.Clear;
  StepList.Free;
  // 销毁目的
  for i := 0 to Purposes.Count - 1 do
  begin
    tmpPurpose := Purposes.Items[i];
    tmpPurpose.Allows.Clear;
    tmpPurpose.Allows.Free;
  end;
  Purposes.Clear;
  Purposes.Free;

  inherited;
end;

function  TTransaction.GetCurrStep: TStepInfo;
// 返回当前步骤
begin
  if StepIndex >= StepCount then StepIndex := StepCount - 1;
  Result := StepList[StepIndex];
end;

procedure TTransaction.GotoNextStep;
// 指向下一个步骤
begin
  StepIndex := StepIndex + 1;
end;

function TTransaction.HasPassedInterval(MilliSecond: LongWord): Boolean;
// 与上次记录时间，是否超过指定毫秒数
begin
  Result := Windows.GetTickCount - FOldTime >= MilliSecond;
end;

procedure TTransaction.Init;
// 初始化
var
  i: integer;
  tmpStep: TStepInfo;
begin
  IsWorking := False;
  StepIndex := 0;
  State := 0;
  OldNPCDialog := '';
  FOldTime := 0;

  for i := 0 to StepCount - 1 do
  begin
    tmpStep := StepList[i];
    tmpStep.SubStepIndex := 0;
  end;
end;

function TTransaction.IsFinish: Boolean;
// 检查是否完成
begin
  Result := (StepIndex >= StepCount);
end;

function TTransaction.IsPurposeSatisfied: Boolean;
// 测试目的是否满足
var
  i, j, tmpint: integer;
  tmpString, tmpCase, tmpX, tmpY, tmpZ: String;
  tmpPurpose: PurposeInfo;
  tmpDWORD1, tmpDWORD2: DWORD;
  marchingPet: TPet;
begin
  Result := False;
  // 没有 Purpose，就返回 False(没有目的，必须执行)
  if Purposes.Count = 0 then Exit;
  // 找到每个Purpose的IsSatisfied

  marchingPet := ThisUser.GetMarchingPet();

  for i := 0 to Purposes.Count - 1 do
  begin
    tmpPurpose := Purposes[i];
    tmpPurpose.isSatisfied := False;  // 初始化目的
    for j := 0 to tmpPurpose.Allows.Count - 1 do // 各个Allows之间是OR的关系
    begin
      tmpCase := '';
      tmpX := '';
      tmpY := '';
      tmpZ := '';

      tmpString := tmpPurpose.Allows[j];
      tmpint := Pos(',', tmpString);
      if tmpint = 0 then
        tmpCase := tmpString
      else
      begin
        tmpCase := copy(tmpString, 1, tmpint - 1);
        tmpString := copy(tmpString, tmpint + 1, Length(tmpString) - tmpint);
        tmpint := Pos(',', tmpString);
        if tmpint = 0 then tmpX := tmpString
        else
        begin
          tmpX := Copy(tmpString, 1, tmpint - 1);
          tmpString := Copy(tmpString, tmpint + 1, Length(tmpString) - tmpint);
          tmpint := Pos(',', tmpString);
          if tmpint = 0 then
            tmpY := tmpString
          else
          begin
            tmpY := Copy(tmpString, 1, tmpint - 1);
            tmpZ := Copy(tmpString, tmpint + 1, Length(tmpString) - tmpint);
          end;
        end;
      end;

      if tmpX = '[username]' then tmpX := HLInfoList.GlobalHL.UserName;
      if tmpY = '[username]' then tmpY := HLInfoList.GlobalHL.UserName;
      if tmpZ = '[username]' then tmpZ := HLInfoList.GlobalHL.UserName;

      if tmpCase = 'Item' then
      begin
        tmpint := ThisUser.FindItemCount(tmpX, tmpY);
        if tmpint >= strtointdef(tmpZ, 0) then
        begin
          tmpPurpose.isSatisfied := True;
          break;
        end;
      end
      else if tmpCase = 'Pet' then
      begin
        if tmpX = 'Marching' then
        begin
          if tmpY = 'Level' then
          begin
            if marchingPet.Level >= StrToInt(tmpZ) then
            begin
              tmpPurpose.isSatisfied := True;
              Break;
            end;
          end;

          if(tmpY = 'Attack') or (tmpY = 'Atk') then
          begin
            if marchingPet.Attack >= StrToInt(tmpZ) then
            begin
              tmpPurpose.isSatisfied := True;
              Break;
            end;
          end;

          if (tmpY = 'Defence') or (tmpY = 'Defense') or (tmpY = 'Def') then
          begin
            if marchingPet.Defence >= StrToInt(tmpZ) then
            begin
              tmpPurpose.isSatisfied := True;
              Break;
            end;
          end;

          if (tmpY = 'Dexterity') or (tmpY = 'Dex') then
          begin
            if marchingPet.Dexterity >= StrToInt(tmpZ) then
            begin
              tmpPurpose.isSatisfied := True;
              Break;
            end;
          end;
        end
        else
          tmpint := ThisUser.FindPetCount(tmpX, StrToIntDef(tmpY, 1000));
          if tmpint >= strtointdef(tmpZ, 0) then
          begin
            tmpPurpose.isSatisfied := True;
            Break;
          end;
        begin
        end;
      end
      else if tmpCase = 'State' then
      begin
        tmpint:=GetUserEnvState;
        if ((tmpX='Normal') and (tmpint=UserEnvNormal))
          or ((tmpX='Dialogue') and (tmpint=UserEnvDialog))
          or ((tmpX='Battle') and (tmpint=UserEnvBattle))
        then
        begin
          tmpPurpose.isSatisfied:=True;
          break;
        end;
      end
      else if tmpCase = 'Map' then
      begin
        if LongWord(StrToIntDef(tmpX, 0)) = ReadCurrMapID then
        begin
          GetCurrPosXY(tmpDWORD1, tmpDWORD2);
          if ((tmpY = '') and (tmpZ = ''))
            or ((LongWord(StrToIntDef(tmpY, 0)) = tmpDWORD1)
            and (LongWord(StrToIntDef(tmpZ, 0)) = tmpDWORD2))
          then
          begin
            tmpPurpose.isSatisfied:=True;
            break;
          end;
        end;
      end
      else if tmpCase='Player' then
      begin
        if tmpX='Rank' then
        begin
          tmpint:=-1;
          //Player, rank, mortal, basic god, etc
          if  tmpY='Mortal' then tmpint:=0
          else if tmpY='Basic God' then tmpint:=1
          else if (tmpY='Junior God') or (tmpY='Junior Devil') then tmpint:=2
          else if (tmpY='Senior God') or (tmpY='Senior Devil') then tmpint:=3
          else if (tmpY='Super God') or (tmpY='Super Devil') then tmpint:=4
          else if (tmpY='Master God') or (tmpY='Master Devil') then tmpint:=5
          else if (tmpY<>'') then continue; // 如果还不是空，就是写错了，不管

          if tmpint>=2 then
          begin
            if (tmpY='Junior') or  (tmpY='Senior') or (tmpY='Super') or (tmpY='Master')
            then tmpDWORD1:=UserAttrXian
            else tmpDWORD1:=UserAttrMo;
          end
          else
            tmpDWORD1:=0;

          ThisUser.GetAttr;
          if (((ThisUser.Rank=tmpint) and (ThisUser.Xianmo=tmpDWORD1))
            or (tmpint=-1)) // tmpint=-1时，不对Rank进行判断
          then
          begin
            // Check Level: tmpDWORD1 stands for LevelFrom; tmpDWORD2 stands for LevelTo
            tmpint:=pos('-', tmpZ);
            if tmpint=0 then
            begin
              tmpDWORD1:=StrToIntDef(tmpZ, 0);
              tmpDWORD2:=StrToIntDef(tmpZ, 0);
            end
            else
            begin
              tmpDWORD1:=StrToIntDef(copy(tmpZ, 1, tmpint-1), 0);
              tmpDWORD2:=StrToIntDef(copy(tmpZ, tmpint+1, length(tmpZ)-tmpint), 0);
            end;

            if (ThisUser.Level>=tmpDWORD1) and (ThisUser.Level<=tmpDWORD2) then
            begin
              tmpPurpose.isSatisfied:=True;
              break;
            end;
          end;
        end
        else if tmpX='Kungfu' then
        begin
          ThisUser.GetWGs;
          if tmpY='MaxCount' then
          begin
            if ThisUser.WGCount >= ThisUser.WGCountLimit then
            begin
              tmpPurpose.isSatisfied:=True;
              break;
            end;
          end
          else if ThisUser.WGCount>=StrToIntDef(tmpY, 100) then
          begin
            tmpPurpose.isSatisfied:=True;
            break;
          end;
        end
        else if tmpX='Life' then
        begin
          ThisUser.GetAttr;
          tmpDWORD1:=StrToIntDef(tmpY, 101);
          tmpDWORD2:=StrToIntDef(tmpZ, 0);
          tmpint:=(ThisUser.CurrLife * 100) div ThisUser.MaxLife;
          if (tmpint >= tmpDWORD1) and (tmpint <= tmpDWORD2) then
          begin
            tmpPurpose.isSatisfied:=True;
            break;
          end;
        end
      end
    end;
  end;

  Result:=True;
  for i:=0 to Purposes.Count-1 do  // 各个Purpose之间是AND的关系
  begin
    tmpPurpose:=Purposes[i];
    Result:=Result and tmpPurpose.isSatisfied;
  end;
end;

procedure TTransaction.PurseSteps(tmpStringList: TStringList);
var
  i, tmpPos{, tmpint}: integer;
  tmpStep: TStepInfo;
  tmpString, tmpActionStr: String;
begin
  for i := 0 to StepList.Count - 1 do
  begin
    tmpStep := StepList.Items[i];
    tmpStep.Free;
  end;
  StepList.Clear;

  StepCount := StrToIntDef(tmpStringList.Values['StepCount'], 0);

  for i:=0 to StepCount-1 do
  begin
    tmpStep:=TStepInfo.Create;

    tmpString:=tmpStringList.Values[format('Step%d', [i])];
    tmppos:=Pos(',', tmpString);

    if tmppos=0 then tmpActionStr:=tmpString
    else tmpActionStr:=copy(tmpString, 1, tmppos-1);

    if tmpActionStr='LeftClick' then tmpStep.Action:=ActLeftClick
    else if tmpActionStr='RightClick' then tmpStep.Action:=ActRightClick
    else if tmpActionStr='MoveToPos' then tmpStep.Action:=ActMoveToPos
    else if tmpActionStr='GoToPos' then tmpStep.Action:=ActMoveToPos
    else if tmpActionStr='GoToMap' then tmpStep.Action:=ActGoToMap
    else if tmpActionStr='GotoMap' then tmpStep.Action:=ActGoToMap
    else if tmpActionStr='BattleAct' then tmpStep.Action:=ActInBattle
    else if tmpActionStr='Terminate' then tmpStep.Action:=ActTerminate
    else if tmpActionStr='BuyItem' then tmpStep.Action:=ActBuyStuff
    else if tmpActionStr='Wux' then tmpStep.Action:=ActDoForge
    else if tmpActionStr='CloseShop' then tmpStep.Action:=ActQuitShop
    else if tmpActionStr='PressButton' then tmpStep.Action:=ActPressButton
    else if tmpActionStr='CallNPC' then tmpStep.Action:=ActCallNPC
    else if tmpActionStr='HaveItem' then tmpStep.Action:=ActHaveStuff
    else if tmpActionStr='ItemNum' then tmpStep.Action:=ActStuffNum
    else if tmpActionStr='HavePet' then tmpStep.Action:=ActHavePet
    else if tmpActionStr='PetNum' then tmpStep.Action:=ActPetNum
    else if tmpActionStr='CancelDialog' then tmpStep.Action:=ActCancelNPCDialog
    else if tmpActionStr='LeftClickWin' then tmpStep.Action:=ActWinLeftClick
    else if tmpActionStr='DblLeftClickWin' then tmpStep.Action:=ActWinLeftDblClick
    else if tmpActionStr='JumpToTransaction' then tmpStep.Action:=ActJumpToTransN
    else if tmpActionStr='Delay' then tmpStep.Action:=ActDelay
    else if tmpActionStr='BattleActive' then tmpStep.Action:=ActActiveBattle
    else if tmpActionStr='StartBattle' then tmpStep.Action:=ActActiveBattle
    else if tmpActionStr='CaptureTarget' then tmpStep.Action:=ActSetCapture
    else if tmpActionStr='SetHeal' then tmpStep.Action:=ActSetHeal
    else if tmpActionStr='LocateWindow' then tmpStep.Action:=ActLocateWindow
    else if tmpActionStr='RightClickWin' then tmpStep.Action:=ActWinRightClick
    else if tmpActionStr='WaitWindow' then tmpStep.Action:=ActWaitWindow
    else if tmpActionStr='OpenInv' then tmpStep.Action:=ActOpenItemWindow
    else if tmpActionStr='UseItem' then tmpStep.Action:=ActUseItem
    else if tmpActionStr='DropItem' then tmpStep.Action:=ActDropItem
    else if tmpActionStr='CloseInv' then tmpStep.Action:=ActCloseItemWindow
    else if tmpActionStr='SetKungfuAttr' then tmpStep.Action:=ActSetWGAttr
    else if tmpActionStr='SetKungfuEffect' then tmpStep.Action:=ActSetWGDisp
    else if tmpActionStr='CreateKungfu' then tmpStep.Action:=ActCreateWG
    else if tmpActionStr='DeleteKungfu' then tmpStep.Action:=ActDeleteWGs
    else if tmpActionStr='AddStats' then tmpStep.Action:=ActSetAttr
    else
    begin
      tmpStep.Action:=ActUnknown;
      tmpStep.X:=tmpString; // For future prompts
      StepList.Add(tmpStep);
      continue;
    end;

    if tmppos<>0 then // Can also resolve x
    begin
      tmpString:=copy(tmpString, tmppos+1, length(tmpString)-tmppos);
      tmppos:=Pos(',', tmpString);

      if tmppos=0 then
      begin
        tmpStep.X:=tmpString;
      end
      else // 还能解析出Y
      begin
        tmpStep.X:=copy(tmpString, 1, tmppos-1);

        tmpString:=copy(tmpString, tmppos+1, length(tmpString)-tmppos);
        tmppos:=Pos(',', tmpString);

        if tmppos=0 then
        begin
          tmpStep.Y:=tmpString;
        end
        else  // 还能解析出Z
        begin
          tmpStep.Y:=copy(tmpString, 1, tmppos-1);
          tmpStep.Z:=copy(tmpString, tmppos+1, length(tmpString)-tmppos);
        end;
      end;
    end;

    if tmpStep.X='[username]' then tmpStep.X := HLInfoList.GlobalHL.UserName;
    if tmpStep.Y='[username]' then tmpStep.Y := HLInfoList.GlobalHL.UserName;
    if tmpStep.Z='[username]' then tmpStep.Z := HLInfoList.GlobalHL.UserName;
    
    StepList.Add(tmpStep);
  end;
end;

procedure TTransaction.SetOldTime;
begin
  FOldTime := Windows.GetTickCount;
end;

procedure TTransaction.TryReadDetails(const vIniFileName: WideString);
var
  ScriptIni: TIniFile;
  i, j, tmpint, tmpint2: integer;
  tmpString: String;
  tmpStringList: TStringList;
  tmpPurpose: PurposeInfo;
begin
  if StepCount <> -1 then Exit; // 已经Read过了

  StepList.Clear;
  Purposes.Clear;

  ScriptIni := TIniFile.Create(vIniFileName);

  tmpStringList := TStringList.Create;
  tmpStringList.Clear;

  ScriptIni.ReadSectionValues(format('Transaction%d', [FID]), tmpStringList);

  tmpint := StrToIntDef(tmpStringList.Values['PurposeCount'], 0);

  for i := 0 to tmpint - 1 do
  begin
    new(tmpPurpose);
    tmpPurpose.Allows := TStringList.Create;
    tmpint2:=StrToIntDef(tmpStringList.Values[format('Purpose%d_AllowCount', [i])], 0);

    for j := 0 to tmpint2 - 1 do
    begin
      tmpString := tmpStringList.Values[format('Purpose%d_Allow%d', [i, j])];
      tmpPurpose.Allows.Add(tmpString);
    end;
    tmpPurpose.isSatisfied := False;
    Purposes.Add(tmpPurpose);
  end;

  PurseSteps(tmpStringList);

  tmpStringList.Clear;
  tmpStringList.Free;
  ScriptIni.Free;
end;

//==============================================================================
function TWork.AddTransaction(const Caption: String = ''): TTransaction;
// 增加一个空的事务
begin
  Result := TTransaction.Create(-1, Caption);  // 返回事物指针
  self.Add(Result);	// 加入列表
end;

procedure TWork.DeleteTransaction(Index: integer);
begin
  self.Delete(Index);
end;

procedure TWork.Clean;
// 清除工作脚本
begin
	self.Clear;

  FTransactionIndex := 0;
  FRepeatCount := 1;
  IsFirstTime := True;
end;

constructor TWork.Create;
// 构造过程，初始化
begin
  inherited;

  FTransactionIndex := 0;

  FRepeatCount := 1;
  RepeatCounter := 0;
end;

destructor TWork.Destroy;
// 销毁自身
begin
  Clean;

  inherited;
end;

function TWork.GetSize: Integer;
begin
  Result := self.Count;
end;

function TWork.GetCurrTransaction: TTransaction;
// 返回当前事务
begin
	// 防止事务编号超界
  if self.IsFinish then
  	FTransactionIndex := self.Count - 1;
  // 返回当前事务
  Result := self.Items[FTransactionIndex];
end;

function TWork.GetItem(Index: Integer): TTransaction;
begin
  Result := TTransaction(inherited Items[Index]);
end;

procedure TWork.SetItem(Index: Integer; const Value: TTransaction);
begin
  inherited Items[Index] := Value;
end;

function TWork.GetNextTransToDo: Boolean;
// 指向下一个需要执行的事务
var
  tmpTransaction: TTransaction;
begin
  Result := False;

  if self.IsFinish then Exit;
  tmpTransaction := self.Items[FTransactionIndex];
  tmpTransaction.TryReadDetails(self.FIniFileName);
  while tmpTransaction.IsPurposeSatisfied do // 如果发现当前Purpose已经满足了
  begin
    tmpTransaction.Init;
    tmpTransaction.State := 1;

    self.GotoNextTrans;

    if self.IsFinish then Exit;

    tmpTransaction := self.Items[FTransactionIndex];
    tmpTransaction.TryReadDetails(self.FIniFileName);
  end;

  Result := True;
end;

function TWork.GetTransactionByIndex(Index: integer): TTransaction;
// 返回指定编号事务
begin
  Result := self.Items[Index];
end;

procedure TWork.GotoNextTrans;
// 进入下一个事务
begin
  Inc(FTransactionIndex);
end;

procedure TWork.GotoTrans(ToIndex: Integer; IsClearState: Boolean = False);
// 指向 ToIndex 指定编号的事务，并根据 IsClearState 设置状态标志
var
  i: Integer;
begin
  CanWork := True;
  if ToIndex < 0 then ToIndex := 0;

  If self.IsFinish then
  	FTransactionIndex := self.Count - 1;

  for i := ToIndex to FTransactionIndex do
    if IsClearState then
    	self.Items[i].State := 0;

  FTransactionIndex := ToIndex;
  IsFirstTime := True;
end;

function TWork.IsFinish: Boolean;
// 检测工作是否完成
begin
	// 如果事务编号超出，表示工作完成
  Result := (FTransactionIndex >= self.Count);
end;

function TWork.ReadIni: Boolean;
var
  ScriptIni: TIniFile;
  i, iTransactionCount: integer;
  tmpTransaction: TTransaction;
  tmpString: String;
  tmpStringList: TStringList;
begin
  Clean;	// 清除脚本信息
  Result := False;
  ScriptIni := TIniFile.Create('.\' + FIniFileName);	// 打开脚本文件
  try
  	tmpStringList := TStringList.Create;	// 创建字符串列表
    try
  	  ScriptIni.ReadSectionValues('Main', tmpStringList);
	    iTransactionCount := StrToIntDef(tmpStringList.Values['TransactionCount'], 0); // 获得步骤数
  	  if iTransactionCount = 0 then Exit;	// 步骤数为0，退出

    	tmpString := tmpStringList.Values['RepeatCount'];	// 获得循环数
 	   	if tmpString = 'Infinite' then
  	  	FRepeatCount := -1
    	else
    		FRepeatCount := StrToIntDef(tmpString, 1);

  	  for i := 0 to iTransactionCount - 1 do	// 装载脚本
    	begin
      	tmpTransaction := TTransaction.Create(i,
      		ScriptIni.ReadString(Format('Transaction%d', [i]), 'Caption', ''));
        if tmpTransaction = nil then
        begin
          self.Clean;
          Exit;
        end;
    	  self.Add(tmpTransaction);
    	end;
    finally
   	  tmpStringList.Free;	// 释放字符串列表
    end;
  finally
	  ScriptIni.Free;				// 释放脚本文件句柄
  end;
  Result := True;
end;

//==============================================================================
function TBuyStuff.InitShop: Boolean;
// 初始化商店
var
  tmpwinShop: TWindowInfo;
  tmphwnd: HWND;
begin
  Result := False;

  tmpwinShop := HLInfoList.GlobalHL.ItemOfWindowTitle('Monster&Me - Store');
  if tmpwinShop = nil then Exit;

  hwndShop := tmpwinShop.Window;
  if IsWindowEnabled(hwndShop) then EnableWindow(hwndShop, False);
  if IsWindowVisible(hwndShop) then ShowWindow(hwndShop, SW_HIDE);

  tmphwnd := HLInfoList.GlobalHL.LocateChildWindowWNDByTitle(hwndShop, 'Item List', True);
  if tmphwnd = 0 then Exit;

  hwndItemList := HLInfoList.GlobalHL.LocateChildWindowWNDByTitle(tmphwnd, '', True);
  if hwndItemList = 0 then Exit;

  hwndBuy := HLInfoList.GlobalHL.LocateChildWindowWNDByTitle(hwndShop, 'Buy(&B)', True);
  if hwndBuy = 0 then Exit;
  Result := True;
end;

function TBuyStuff.IsSatisfied: Boolean;
var
  tmpCount: integer;
begin
  Result:=False;
  tmpCount:=ThisUser.FindItemCount(StuffName, StuffMaker);
  if (ThisUser.ItemCount>=15) or (tmpCount>=StuffCount) then Result:=True;
end;

procedure TBuyStuff.WriteStuffInfo(Name, Maker: String; Count: integer);
begin
  StuffName:=Name;
  StuffMaker:=Maker;
  StuffCount:=Count;
end;

procedure TBuyStuff.GetAllStuffCount;
begin
  ThisUser.GetItems;
  OldAllStuffCount:=ThisUser.ItemCount;
end;

procedure TBuyStuff.PatchShop;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  BufferDWord: DWORD;
  BufferByte: Byte;
  tmpWin: TWindowInfo;
begin
  BufferDWord := $000001b8;
  BufferByte := $00;

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);

  if ProcessHandle <> 0 then
  begin
//    WriteProcessMemory(ProcessHandle, Pointer($42d99f), @BufferDWord, 4, lpNumberOfBytes);
//    WriteProcessMemory(ProcessHandle, Pointer($42d9a3), @BufferByte, 1, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($42CCDE), @BufferDWord, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($42CCE2), @BufferByte, 1, lpNumberOfBytes);

    BufferDWord := $90909090;
    BufferByte := $90;

//    WriteProcessMemory(ProcessHandle, Pointer($42d8aa), @BufferDWord, 4, lpNumberOfBytes);
//    WriteProcessMemory(ProcessHandle, Pointer($42d8ae), @BufferByte, 1, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($42CBEA), @BufferDWord, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($42CBEE), @BufferByte, 1, lpNumberOfBytes);
  end;
  CloseHandle(ProcessHandle);

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Monster&Me - Store');
  if tmpWin <> nil
  then
    if IsWindow(tmpWin.Window) and IsWindowVisible(tmpWin.Window)
    then
      ShowWindow(tmpWin.Window, SW_HIDE);
end;

procedure TBuyStuff.UnPatchShop;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  BufferDWord: DWORD;
  BufferByte: Byte;
  tmpWin: TWindowInfo;
begin
  //BufferDWord := $fe0ebce8;
  BufferDWord := $fdfa05e8;
  BufferByte := $ff;

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);
  if ProcessHandle <> 0 then
  begin
//    WriteProcessMemory(ProcessHandle, Pointer($42d99f), @BufferDWord, 4, lpNumberOfBytes);
//    WriteProcessMemory(ProcessHandle, Pointer($42d9a3), @BufferByte, 1, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($42CCDE), @BufferDWord, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($42CCE2), @BufferByte, 1, lpNumberOfBytes);

    //BufferDWord := $fe0c09e8;
    BufferDWord := $fdf751e8;
    BufferByte := $ff;
//    WriteProcessMemory(ProcessHandle, Pointer($42d8aa), @BufferDWord, 4, lpNumberOfBytes);
//    WriteProcessMemory(ProcessHandle, Pointer($42d8ae), @BufferByte, 1, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($42CBEA), @BufferDWord, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($42CBEE), @BufferByte, 1, lpNumberOfBytes);
  end;
  CloseHandle(ProcessHandle);

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Monster&Me - Store');
  if tmpWin <> nil then
    if IsWindow(tmpWin.Window) and (not IsWindowVisible(tmpWin.Window)) then
      Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
end;

function TBuyStuff.DoBuyStuff: Boolean;
var
  tmpIndex: integer;
  tmpRect: TRECT;
begin
  Result := False;

  tmpIndex:=SendMessage(hwndItemList, LB_FINDSTRING, -1, LPARAM(PChar(StuffName)));
  if tmpindex=LB_ERR then Exit;

  if SendMessage(hwndItemList, LB_SETCURSEL, tmpindex, 0)=LB_ERR then Exit;
  if SendMessage(hwndItemList, LB_GETITEMRECT, tmpindex, LPARAM(@tmpRect))=LB_ERR then Exit;

  LeftClickOnSomeWindow_Send(hwndItemList, tmpRect.Left, tmpRect.Top);
  sleep(200);

  if tmpindex=SendMessage(hwndItemList, LB_GETCURSEL, 0, 0) then
  begin
    LeftClickOnSomeWindow_Post(hwndBuy, 0, 0);
    Result := True;
  end;
end;

function TBuyStuff.HasBoughtStuff: Boolean;
begin
  Result := False;
  ThisUser.GetItems;
  if ThisUser.ItemCount>OldAllStuffCount then Result:=True
end;

constructor TBattle.Create;
begin
  Inherited Create;
  OrderHumanAction:=BattleIdle;
  OrderPetAction:=BattleIdle;
  EscapeWhenNoMonsterToCapture:=True;
  MonsterNameToCapture:='';
  CaptureLevelFrom:=0;
  CaptureLevelTo:=5000;
  HasBegin:=False;
  DeadMonsterCount:=0;
  CurrHumanAction:=BattleIdle;
  CurrPetAction:=BattleIdle;
  CreatureCount:=0;
  OldCreatureCount:=0;
  LiveMonsterCount:=0;
  TotalExp:=0;
  BattleBufferOrder:=0;
  BattleBufferHumanAct:=BattleIdle;
  BattleBufferHumanActObj:=0;
  BattleBufferRemain1:=0;
  BattleBufferPetAct:=BattleIdle;
  BattleBufferPetActObj:=0;
  BattleBufferRemain2:=0;

  Creatures:=TList.Create;
  Creatures.Clear;
end;

destructor TBattle.Destroy;
var
  i: integer;
  tmpCreature: CreatureInfo;
begin
  for i:=0 to Creatures.Count-1 do
  begin
    tmpCreature := Creatures.Items[i];
    dispose(tmpCreature);
  end;
  Creatures.Clear;
  Creatures.Free;

  Inherited Destroy;
end;

procedure TBattle.GetCreatures;
var
  i, j:integer;
  pCurrCreature: DWORD;
//  CreatureBuffer: array [0.. CreatureInfoSize-1] of Byte;
  tmp: DWORD;
  tmpCreature: CreatureInfo;
  CharArrayTemp: array [0..15] of Char;
begin
  LiveMonsterCount:=0;

  for i:=0 to Creatures.Count - 1 do
  begin
    tmpCreature := Creatures.Items[i];
    Dispose(tmpCreature);
  end;
  Creatures.Clear;

  ReadFromHLMEM(Pointer(BattleCreatureCountAddress), @tmp, 4);
  CreatureCount:=tmp;

  for i := 0 to CreatureCount - 1 do
  begin
    new(tmpCreature);
    pCurrCreature:=GetHLMemListNumberByNo(i, BattleFirstCreatureAddressAddress, $674CCC);
    ReadFromHLMEM(Pointer(pCurrCreature), @tmpCreature.Data, CreatureInfoSize);

    tmpCreature.ID:=tmpCreature.Data[$5f]*65536*256
                    +tmpCreature.Data[$5e]*65536
                    +tmpCreature.Data[$5d]*256
                    +tmpCreature.Data[$5c];

    for j:=0 to 15 do CharArrayTemp[j]:=Char(tmpCreature.Data[j+$60]);
    tmpCreature.Name:=CharArrayTemp;

    tmpCreature.Level := tmpCreature.Data[$0d] * 256
                    + tmpCreature.Data[$0c];

    tmpCreature.State := tmpCreature.Data[$20];
    if tmpCreature.State=$65 then tmpCreature.IsDead:=True else tmpCreature.IsDead:=False;

    Creatures.Add(tmpCreature);

    if (tmpCreature.ID>=$C0000000) and (not tmpCreature.IsDead)
    then  // 说明是未死的敌怪
      LiveMonsterCount:=LiveMonsterCount+1;

  end;

end;

function TBattle.GetMyPetBattleID(myPet: TPet): DWORD;
var
  i: integer;
  tmpCreature: CreatureInfo;
  myPetId: DWORD;
begin
  myPetId := 0;

  for i := 0 to CreatureCount - 1 do
  begin
    tmpCreature:=Creatures.Items[i];

    if tmpCreature.ID<$C0000000 then
    begin
      if (myPet.Name = tmpCreature.Name) and (myPet.Level = tmpCreature.Level) then
      begin
        myPetId := tmpCreature.ID;
        break;
      end;
    end;
  end;

  Result := myPetId;
end;

function TBattle.GetCreatureById(creatureId: DWORD): CreatureInfo;
var
  i: integer;
  tmpCreature, creature: CreatureInfo;
begin
  creature := nil;

  for i := 0 to CreatureCount - 1 do
  begin
    tmpCreature:=Creatures.Items[i];

    if tmpCreature.ID<$C0000000 then
    begin
      if creatureId = tmpCreature.id then
      begin
        creature := tmpCreature;
        break;
      end;
    end;
  end;

  Result := creature;
end;

function TBattle.GetBattleExpForLevel(Level: integer): integer;
var
  i: integer;
  dExp: double;
  iExp: integer;
  lvlDif: integer;
  tmpCreature: CreatureInfo;

begin
  TotalExp := 0;

  for i := 0 to CreatureCount - 1 do
  begin
    tmpCreature:=Creatures.Items[i];

    if tmpCreature.ID>=$C0000000 then
    begin
      dExp := tmpCreature.Level * tmpCreature.Level * 0.012;
      iExp :=  Ceil(dExp) + tmpCreature.Level * 5;
      if (Level > tmpCreature.Level) then
      begin
          lvlDif := Level -  tmpCreature.Level;
          if lvlDif > 95 then lvlDif := 95;
          dExp := iExp * (100 - lvlDif) / 100;
          iExp := Ceil(dExp);
      end;
      TotalExp := TotalExp + iExp;
    end;
  end;

  Result := TotalExp;
end;

function TBattle.FindMonsterToAct(IsPetAction:Boolean=False):DWORD;
var
  i:integer;
  tmpCreature:CreatureInfo;

begin
  Result:=0;

  GetCreatures;
  for i:=0 to CreatureCount-1 do
  begin
    tmpCreature:=Creatures.Items[i];

    if tmpCreature.ID>=$C0000000 then  // 说明是敌怪
    begin
      if not tmpCreature.IsDead then // 还没有死
      begin
        if IsPetAction then // 是宠物的动作
        begin
          if CurrHumanAction=BattleCapture then // 如果人物要捉宠
          begin
            if tmpCreature.Name<>MonsterNameToCapture // 现在这个宠不是人物要捉的
            then
            begin
              Result:=tmpCreature.ID;
              break;
            end
            else // 名字对应上了，继续测试
            begin
              if (tmpCreature.Level>CaptureLevelTo) or (tmpCreature.Level<CaptureLevelFrom) then
              begin
                Result:=tmpCreature.ID;
                break;
              end;
            end;
          end
          else // 人物不捉宠
          begin
            Result:=tmpCreature.ID;
            break;
          end;
        end
        else // 是人物的动作
        begin
          if CurrHumanAction=BattleCapture then // 如果人物要捉宠
          begin
            if tmpCreature.Name=MonsterNameToCapture // 现在这个宠的名字对应上了
            then
            begin
              if (tmpCreature.Level<=CaptureLevelTo) and (tmpCreature.Level>=CaptureLevelFrom) then
              begin
                Result:=tmpCreature.ID;
                break;
              end;
            end;
          end
          else // 人物不捉宠
          begin
            Result:=tmpCreature.ID;
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TBattle.ReadOrders;
begin
  ReadFromHLMEM(Pointer(BattleOrderAddr), @BattleBufferOrder, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + 4), @BattleBufferHumanAct, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + 8), @BattleBufferHumanActObj, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + $c), @BattleBufferRemain1, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + $10), @BattleBufferRemain1a, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + $14), @BattleBufferPetAct, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + $18), @BattleBufferPetActObj, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + $1c), @BattleBufferRemain2a, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + $20), @BattleBufferRemain2, 4);
  ReadFromHLMEM(Pointer(BattleOrderAddr + $24), @BattleBufferTimer, 4);
end;

procedure TBattle.WriteOrders;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
begin
  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);
  if ProcessHandle<>0 then
  begin
    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr+4), @BattleBufferHumanAct, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr+8), @BattleBufferHumanActObj, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr+$c), @BattleBufferRemain1, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr+$10), @BattleBufferRemain1a, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr+$14), @BattleBufferPetAct, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr+$18), @BattleBufferPetActObj, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr+$1c), @BattleBufferRemain2a, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr+$20), @BattleBufferRemain2, 4, lpNumberOfBytes);

    WriteProcessMemory(ProcessHandle, Pointer(BattleOrderAddr), @BattleBufferOrder, 4, lpNumberOfBytes);
  end;
  CloseHandle(ProcessHandle);
end;

function TBattle.ReadDeadMonsterCount: integer;
begin
  ReadFromHLMem(Pointer(DeadMonsterCountAddr), @DeadMonsterCount, 4);
end;

function TBattle.ReadState: integer;
var
  tmpByte: Byte;
begin
  ReadFromHLMem(Pointer(BattleStateAddr), @tmpByte, 1);
  Result:= tmpByte;
end;

procedure TBattle.SubmitAction;
var
  tmpWIn: TWindowInfo;
begin
  if HLInfoList.GlobalHL.LocateToPlayWindow(tmpWIn) = -1 then Exit; // 没有找到
  SendMessage(tmpWIn.Window, $7E8, $3EA, 0);
end;

procedure TBattle.DoBattle;
var
  tmpPet: TPet;
  expToGain: integer;
  useItemId: DWORD;
  doHeal,healPlayer,healPet: Boolean;
  tmpPetId: DWORD;
  tmpCreature: CreatureInfo;

  playerLifePerc, petLifePerc: Double;
begin
  if GetUserEnvState <> UserEnvBattle then Exit;

  if ReadState<>1 then Exit;
  sleep(100);

  ReadOrders;
  if (BattleBufferOrder<>0)
    or (BattleBufferHumanAct<>BattleIdle)
    or (BattleBufferPetAct<>BattleIdle) then Exit; // Action in Process

  if (BattleBufferTimer>30) or (BattleBufferTimer<0) then Exit;

  ThisUser.GetPets;
  GetCreatures;
  If LiveMonsterCount=0 then Exit;

  CurrHumanAction:=OrderHumanAction;
  CurrPetAction:=OrderPetAction;

  if not FormGeneralSet.CheckBoxNoHeal.Checked then
  begin
    doHeal := False;
    healPlayer := False;
    healPet := False;

    tmpPet := ThisUser.Pets[ThisUser.BattlePetPos];

    if FormGeneralSet.CheckBoxFullBlood.Checked then
    begin
      expToGain := GetBattleExpForLevel(tmpPet.Level);
      if (tmpPet.Experience + expToGain > tmpPet.NextLevel) and (tmpPet.CurrLife < tmpPet.MaxLife) and (LiveMonsterCount = 1) then
      begin
        doHeal := True;
        healPet := True;
      end;
    end;

    //check pet life
    petLifePerc := tmpPet.CurrLife / tmpPet.MaxLife * 100;
    if (petLifePerc < StrToFloat(FormGeneralSet.EditPetLife.Text)) and (tmpPet.CurrLife > 0) then
    begin
      doHeal := True;
      healPet := True;
    end;

    //check player life
    ThisUser.GetAttr;
    playerLifePerc := ThisUser.CurrLife / ThisUser.MaxLife * 100;
    if (playerLifePerc < StrToFloat(FormGeneralSet.EditPlayerLife.Text)) and (ThisUser.CurrLife > 0) then
    begin
      doHeal := True;
      healPlayer := True;
    end;

    //Run if pet died
    tmpPetId := GetMyPetBattleID(tmpPet);
    tmpCreature := GetCreatureById(tmpPetId);
    if (tmpCreature <> nil) and (tmpCreature.IsDead) then
    begin
      CurrHumanAction := BattleEscape;
      doHeal := False;
    end
    else
    begin
      if doHeal then
      begin
        //get item
        useItemId := ThisUser.FindItemByType(700);
        if useItemId = 0 then
        begin
          CurrHumanAction := BattleEscape;
          doHeal := False;
        end
        else
        begin
          CurrHumanAction := BattleEat;
        end;
      end;
    end;
  end;

  if CurrHumanAction=BattleCapture then // Capture
  begin
    if ThisUser.PetCount=5 then  // 如果捉宠，人物宠空满了
    begin
      if EscapeWhenNoMonsterToCapture then // 要逃跑
      begin
        CurrHumanAction:=BattleEscape;
        CurrPetAction:=BattleIdle;
      end
      else // 还要继续战斗
      begin
        CurrHumanAction:=BattleAttack;
      end;
    end;
  end;

  if CurrHumanAction=BattleEscape then CurrPetAction:=BattleIdle;

  ReadOrders;

  BattleBufferHumanActObj:=0;
  BattleBufferPetActObj:=0;
  BattleBufferOrder:=$2710;

  if CurrHumanAction=BattleCapture then // 捉宠
  begin
    BattleBufferHumanActObj:=FindMonsterToAct;

    if BattleBufferHumanActObj=0
    then // 没有找到要抓的怪，根据用户设置的情况
    begin
      if EscapeWhenNoMonsterToCapture then // 要逃跑
      begin
        CurrHumanAction:=BattleEscape;
        CurrPetAction:=BattleIdle;
      end
      else // 还要继续战斗
      begin
        CurrHumanAction:=BattleAttack;
      end;
    end;
  end;

  if CurrHumanAction = BattleEat then
  begin
    if healPlayer then BattleBufferHumanActObj := ThisUser.ID;
    if healPet then BattleBufferHumanActObj := GetMyPetBattleID(ThisUser.Pets[ThisUser.BattlePetPos]);

    BattleBufferRemain1 := useItemId;
    CurrPetAction := BattleDefence;
  end;

  if CurrHumanAction=BattleAttack then
  begin
    BattleBufferHumanActObj:=FindMonsterToAct;
    if BattleBufferHumanActObj=0 then Exit; // 出错了
  end;

  if CurrPetAction=BattleAttack then
  begin
    BattleBufferPetActObj:=FindMonsterToAct(True);
    if BattleBufferPetActObj=0 // 如果没有找到宠，通常是发生在所有的宠都满足人物要捉的条件
    then
      CurrPetAction:=BattleDefence;
  end;

  BattleBufferHumanAct := CurrHumanAction;
  if (BattleBufferHumanAct = BattleDefence) OR (BattleBufferHumanAct = BattleEscape) then BattleBufferHumanActObj := 0;

  BattleBufferPetAct := CurrPetAction;
  if BattleBufferPetAct <> BattleAttack then BattleBufferPetActObj := 0;


  if GetUserEnvState<>UserEnvBattle then Exit;

  GetCreatures;
  If LiveMonsterCount=0 then Exit;

  WriteOrders;
  //SubmitAction;
  sleep(100);
end;
//==============================================================================
constructor TMove.Create;
begin
  Inherited Create;
  Dijksatra_Nodes := TList.Create;
  Path := TList.Create;
  PathNodeIndex := 0;
//  PathNodeCount := 0;
end;

destructor TMove.Destroy;
var
//  tmpNode: TNodeInfo;
  tmpDijksatraNode: DijksatraNodeInfo;
  i: integer;
begin
{  for i := 0 to Path.Count - 1 do
  begin
    tmpNode := Path.Items[i];
    dispose(tmpNode);
  end;       }
  Path.Clear;
  Path.Free;

  for i := 0 to Dijksatra_Nodes.Count - 1 do
  begin
    tmpDijksatraNode := Dijksatra_Nodes.Items[i];
    tmpDijksatraNode.OutNodes.Clear;
    tmpDijksatraNode.OutNodes.Free;
    dispose(tmpDijksatraNode);
  end;
  Dijksatra_Nodes.Clear;
  Dijksatra_Nodes.Free;

  Inherited Destroy;
end;

function TMove.Init(FromPos, ToPos: integer): Boolean;
// 初始化移动对象
begin
  PathNodeIndex := 0;
  FromMapIndexInList := FromPos;
  ToMapIndexInList := ToPos;
  Result := FindPath;	// 寻找路径
end;

function TMove.GetPathNodeCount: integer;
begin
  Result := self.Path.Count;
end;

function TMove.FindPath: Boolean;
var
  i, j, tmpNewPNodeIndex: integer;
  tmpMap: TMapInfo;
  tmpNode: TNodeInfo;
  tmpDijksatraNode, tmpNewPNode: DijksatraNodeInfo;
//  ptmpID: ^DWord;
  tmpBoolean: Boolean;
//  tmpstr: String;
      Dijksatra_PNodes: TList;
      Dijksatra_TNodes: TList;
begin
  Path.Clear;
  Result := True;
  // 起始点等于终点，退出
  if FromMapIndexInList = ToMapIndexInList then Exit;

  if Dijksatra_Nodes.Count = 0 then // 初始化DijksatraPath
  begin
    for i := 0 to GameMaps.Count - 1 do
    begin
      tmpMap := GameMaps.Items[i];
      if tmpMap.ID = 0 then GameMaps.ReadOneMap(i);	// 如果ID非法，重新装载地图节点

      new(tmpDijksatraNode);
      tmpDijksatraNode.PosInMapList := tmpMap.PosInMapList;
      tmpDijksatraNode.MapID := tmpMap.ID;
      Dijksatra_Nodes.Add(tmpDijksatraNode);
    end;

    for i := 0 to GameMaps.Count - 1 do
    begin
      tmpMap := GameMaps.Items[i];
      tmpDijksatraNode := Dijksatra_Nodes.Items[i];
      tmpDijksatraNode.OutNodes := TList.Create;
      for j := 0 to tmpMap.NodeList.Count-1 do
      begin
        tmpNode := tmpMap.NodeList.Items[j];
        tmpDijksatraNode.OutNodes.Add(tmpNode);
      end;
    end;
  end;

  Dijksatra_PNodes:=TList.Create;
  Dijksatra_TNodes:=TList.Create;
  Dijksatra_PNodes.Clear;
  Dijksatra_TNodes.Clear;

  // 开始执行算法

  // 初始化
  for i:=0 to Dijksatra_Nodes.Count-1 do
  begin
    tmpDijksatraNode:=Dijksatra_Nodes.Items[i];
    if i = FromMapIndexInList then
    begin
      tmpDijksatraNode.distance:=0;
      tmpDijksatraNode.priorNode:=Nil;
      tmpDijksatraNode.priorDijksatraNode:=nil;
      Dijksatra_PNodes.Add(tmpDijksatraNode);
    end
    else
    begin
      tmpDijksatraNode.distance:=-1;
      Dijksatra_TNodes.Add(tmpDijksatraNode);
    end;
  end;

  repeat
    tmpNewPNode:=Dijksatra_PNodes.Items[Dijksatra_PNodes.Count-1]; // 新增加的那个

    for i:=0 to tmpNewPNode.OutNodes.Count-1 do
    begin
      tmpNode:=tmpNewPNode.OutNodes.Items[i];

      tmpBoolean:=False;
      for j:=0 to Dijksatra_TNodes.Count-1 do
      begin
        tmpDijksatraNode:=Dijksatra_TNodes.Items[j];
        if tmpNode.OutMapID=tmpDijksatraNode.MapID then
        begin
          tmpBoolean:=True;
          break;
        end;
      end;

      if tmpBoolean then  // Node在TNodes中
      begin
        if (tmpNewPNode.distance<>-1)
          and (((tmpNewPNode.distance+1)<tmpDijksatraNode.distance) or (tmpDijksatraNode.distance=-1))
        then
        begin // 更新tmpOutNode的Distance
          tmpDijksatraNode.distance:=tmpNewPNode.distance+1;
          tmpDijksatraNode.PriorNode:=tmpNode;

          for j:=0 to Dijksatra_PNodes.Count-1 do
          begin
            tmpNewPNode:=Dijksatra_PNodes.Items[j];
            if tmpNewPNode.MapID=tmpNode.MyMap.ID then
            begin
              tmpDijksatraNode.priorDijksatraNode:=tmpNewPNode;
              break;
            end;
          end;
        end;
      end;
    end;

    if Dijksatra_TNodes.Count <> 0 then
    begin
      tmpNewPNodeIndex := 0;
      tmpNewPNode := Dijksatra_TNodes.Items[0];
      for i := 1 to Dijksatra_TNodes.Count - 1 do
      begin
        tmpDijksatraNode := Dijksatra_TNodes.Items[i];
        if (tmpDijksatraNode.distance <> -1) and
          ((tmpNewPNode.distance = -1) or
          (tmpDijksatraNode.distance < tmpNewPNode.distance)) then
        begin // 找到新的PNode
          tmpNewPNodeIndex := i;
          tmpNewPNode := tmpDijksatraNode;
        end;
      end;
      Dijksatra_TNodes.Delete(tmpNewPNodeIndex);
      Dijksatra_PNodes.Add(tmpNewPNode);
    end;
  until Dijksatra_TNodes.Count = 0;

  tmpDijksatraNode := Dijksatra_Nodes[ToMapIndexInList];
  repeat
    if tmpDijksatraNode.distance = -1 then
    begin
      Result := False;
      Exit;
    end;
    tmpNode := tmpDijksatraNode.priorNode;
    Path.Insert(0, tmpNode);
    tmpDijksatraNode := tmpDijksatraNode.priorDijksatraNode;
  until tmpDijksatraNode.priorDijksatraNode = Nil;

//  PathNodeCount := Path.Count;
  
  Dijksatra_PNodes.Clear;
  Dijksatra_TNodes.Clear;
  Dijksatra_PNodes.Free;
  Dijksatra_TNodes.Free;
end;

function TMove.GetCurrPathNode: TNodeInfo;
// 返回当前路径节点
begin
  Result := Path[PathNodeIndex];
end;

function TMove.GetCurrPathNodeIndex: integer;
// 返回当前路径节点编号
begin
  Result := PathNodeIndex;
end;

procedure TMove.GotoNextPathNode;
// 指向下一个路径节点
begin
  PathNodeIndex := PathNodeIndex + 1;
end;

constructor TForge.Create;
begin
  Inherited Create;
  StoveList := TList.Create;
  StoveList.Clear;
end;

destructor TForge.Destroy;
begin
  Clean;
  StoveList.Free;
  Inherited Destroy;
end;

procedure TForge.Clean;
var
  i, j, k: integer;
  tmpStove: StoveInfo;
  tmpAllowedStuffType: AllowedStuffTypeInfo;
begin
  for i:=0 to StoveList.Count-1 do
  begin
    tmpStove:=StoveList.Items[i];
    for j:=0 to 7 do
    begin
      for k:=0 to tmpStove.Rooms[j].AllowedStuffTypes.Count-1 do
      begin
        tmpAllowedStuffType:=tmpStove.Rooms[j].AllowedStuffTypes.Items[k];
        dispose(tmpAllowedStuffType);
      end;
      tmpStove.Rooms[j].AllowedStuffTypes.Clear;
      tmpStove.Rooms[j].AllowedStuffTypes.Free;
    end;
    dispose(tmpStove);
  end;
  StoveList.Clear;
  StoveCount:=0;
  StoveIndex:=0;
end;

Procedure TForge.Init;
var
  mapini:TIniFile;
  i, j, k, tmpint, tmpint2: integer;
  tmpTransaction: TTransaction;
  tmpStep: TStepInfo;
  tmpString: String;
  tmpStove: StoveInfo;
  tmpAllowedStuffType: AllowedStuffTypeInfo;
begin
  Clean;
  
  tmpTransaction := ThisWork.GetCurrTransaction;
  tmpStep := tmpTransaction.GetCurrStep;

  mapini := TIniFile.Create('.\' + ThisWork.IniFileName);
  try
    tmpint := mapini.ReadInteger(tmpStep.X, 'StoveCount', 0);
    for i := 0 to tmpint - 1 do
    begin
      new(tmpStove);
      tmpString := mapini.ReadString(tmpStep.X, format('Stove%d', [i]), '');
      tmpStove.MainRoomPos := mapini.ReadInteger(tmpString, 'MainRoomPos', -1);
      for j := 0 to 7 do
      begin
        tmpStove.Rooms[j].AllowedStuffTypes := TList.Create;
        tmpStove.Rooms[j].AllowedStuffTypes.Clear;
        tmpint2 := mapini.ReadInteger(tmpString,
          format('Room%d_AllowedStuffTypeCount', [j]), 0);
        for k := 0 to tmpint2 - 1 do
        begin
          new(tmpAllowedStuffType);
          tmpAllowedStuffType.Name := mapini.ReadString(tmpString,
            format('Room%d_AllowedStuffType%d_Name', [j, k]), '');
          tmpAllowedStuffType.Attr := mapini.ReadInteger(tmpString,
            format('Room%d_AllowedStuffType%d_Attr', [j, k]), -1);
          tmpAllowedStuffType.Maker := mapini.ReadString(tmpString,
            format('Room%d_AllowedStuffType%d_Maker', [j, k]), '');
          if tmpAllowedStuffType.Maker = '[username]' then
            tmpAllowedStuffType.Maker := HLInfoList.GlobalHL.UserName;
          tmpStove.Rooms[j].AllowedStuffTypes.Add(tmpAllowedStuffType);
        end;
      end;
      StoveList.Add(tmpStove);
    end;
    StoveCount := StoveList.Count;
  finally
    mapini.Free;
  end;
end;

procedure TForge.WriteStoveInstruction;
var
  AddressofUniverseStoveForm: DWORD;
  lpNumberOfBytes: SIZE_T;
  ProcessHandle: THandle;
  tmpStove: StoveInfo;
  i: integer;
begin
  tmpStove:=StoveList[StoveIndex];

  ReadFromHLMEM(Pointer(HL_UniverseStoveFormAddressAddress), @AddressofUniverseStoveForm, 4);

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False,
    HLInfoList.GlobalHL.ProcessId);
  if ProcessHandle <> 0 then
  begin
  //CN @ $458
    WriteProcessMemory(ProcessHandle, Pointer(AddressofUniverseStoveForm + $450),
      @tmpStove.MainRoomPos, 4, lpNumberOfBytes);

//CN @ $3f8
    for i := 0 to 7 do
    begin
      WriteProcessMemory(ProcessHandle,
        Pointer(AddressofUniverseStoveForm + $3f0 + i * 12),
        @tmpStove.Rooms[i].Stuff.StuffAttr, 4, lpNumberOfBytes);
      WriteProcessMemory(ProcessHandle,
        Pointer(AddressofUniverseStoveForm + $3f0 + i * 12 + 8),
        @tmpStove.Rooms[i].Stuff.StuffID, 4, lpNumberOfBytes);
    end;
  end;
  CloseHandle(ProcessHandle);
end;

procedure TForge.PatchUniverseStove;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  Buffers: array [0..5] of Byte;
  i: integer;
begin
  Buffers[0] := $0f;
  Buffers[1] := $85;
//  Buffers[2] := $44;
//  Buffers[3] := $02;
  Buffers[2] := $2F;
  Buffers[3] := $02;
  Buffers[4] := $00;
  Buffers[5] := $00;

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);
  if ProcessHandle<>0 then
  begin
    for i := 0 to 5 do
    begin
      //WriteProcessMemory(ProcessHandle, Pointer($459d8b + i), @Buffers[i], 1, lpNumberOfBytes);
      WriteProcessMemory(ProcessHandle, Pointer($472DEF + i), @Buffers[i], 1, lpNumberOfBytes);
    end;

    Buffers[0] := $90;
    for i := 0 to 7 do
    begin
      //WriteProcessMemory(ProcessHandle, Pointer($556b07 + i), @Buffers[0], 1, lpNumberOfBytes);
      WriteProcessMemory(ProcessHandle, Pointer($55788E + i), @Buffers[0], 1, lpNumberOfBytes);
    end;
  end;
  CloseHandle(ProcessHandle);
end;

procedure TForge.UnpatchUniverseStove;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  Buffers: array [0..7] of Byte;
  i: integer;
  tmpWin: TWindowInfo;
begin
  Buffers[0]:=$75;
  Buffers[1]:=$61;
  Buffers[2]:=$66;
  Buffers[3]:=$c7;
  Buffers[4]:=$45;
  Buffers[5]:=$d0;

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);
  if ProcessHandle<>0 then
  begin
    for i:=0 to 5 do
    begin
//      WriteProcessMemory(ProcessHandle, Pointer($459d8b+i), @Buffers[i], 1, lpNumberOfBytes);
      WriteProcessMemory(ProcessHandle, Pointer($472DEF+i), @Buffers[i], 1, lpNumberOfBytes);
    end;

    Buffers[0] := $e8;
    //Buffers[1] := $88;
    //Buffers[2] := $83;
    Buffers[1] := $11;
    Buffers[2] := $1c;
    Buffers[3] := $05;
    Buffers[4] := $00;
    Buffers[5] := $83;
    Buffers[6] := $c4;
    Buffers[7] := $08;
    for i := 0 to 7 do
    begin
      //WriteProcessMemory(ProcessHandle, Pointer($556b07+i), @Buffers[i], 1, lpNumberOfBytes);
      WriteProcessMemory(ProcessHandle, Pointer($55788E+i), @Buffers[i], 1, lpNumberOfBytes);
    end;
  end;
  CloseHandle(ProcessHandle);

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Wuxing Oven');
  if tmpWin <> nil then
    if IsWindow(tmpWin.Window) and (not IsWindowVisible(tmpWin.Window)) then
      SendMessage(tmpWin.Window, WM_Close, 0, 0);
end;

function TForge.GetCurrStove: StoveInfo;
begin
  Result:=StoveList[StoveIndex];
end;

function TForge.FillStove: Boolean;
var
  tmpStove: StoveInfo;
  tmpAllowedStuffType: AllowedStuffTypeInfo;
  isFoundForOneTime: Boolean;
  i, j, k: integer;
begin
  Result:=True;

  tmpStove:=StoveList[StoveIndex];
  
  For i:=0 to 7 do
  begin
    isFoundForOneTime:=False;
    for j:=0 to tmpStove.Rooms[i].AllowedStuffTypes.Count-1 do
    begin
      tmpAllowedStuffType:=tmpStove.Rooms[i].AllowedStuffTypes[j];
      for k:=0 to StoveStuffsToBeChozenCount-1 do
      begin
        if (StoveStuffsToBeChozen[k].ChozenBy=-1)
          and (tmpAllowedStuffType.Name=StoveStuffsToBeChozen[k].Stuff.Name)
          and (tmpAllowedStuffType.Attr=StoveStuffsToBeChozen[k].Stuff.ItemType)
          and (tmpAllowedStuffType.Maker=StoveStuffsToBeChozen[k].Stuff.Maker)
        then
        begin
          tmpStove.Rooms[i].Stuff.StuffID:=StoveStuffsToBeChozen[k].Stuff.ID;
          tmpStove.Rooms[i].Stuff.StuffAttr:=$4d6;
          StoveStuffsToBeChozen[k].ChozenBy:=i;
          isFoundForOneTime:=True;

          if tmpStove.tmpID1=0 then tmpStove.tmpID1:=tmpStove.Rooms[i].Stuff.StuffID
          else if tmpStove.tmpID2=0 then tmpStove.tmpID2:=tmpStove.Rooms[i].Stuff.StuffID;

          break;
        end;
      end;

      if isFoundForOneTime then break;
    end;

    if (tmpStove.Rooms[i].AllowedStuffTypes.Count<>0) and (not isFoundForOneTime) then
    begin
      Result:=False;
      break;
    end;
  end;
end;

function TForge.HasCurrStoveFinished: Boolean;
var
  tmpStove: StoveInfo;
  isFoundForOneTime: Boolean;
  i: integer;
begin
  Result:=True;

  tmpStove:=StoveList[StoveIndex];
  ThisUser.GetItems;
  isFoundForOneTime:=False;
  for i:=0 to ThisUser.ItemCount do
  begin
    if ThisUser.Items[i].ID=tmpStove.tmpID1 then
    begin
      isFoundForOneTime:=True;
      break;
    end;
  end;

  for i:=0 to ThisUser.ItemCount do
  begin
    if ThisUser.Items[i].ID=tmpStove.tmpID2 then
    begin
      if isFoundForOneTime then Result:=False;
      break;
    end;
  end;
end;

function TForge.IsFinish: Boolean;
begin
  Result:=(StoveIndex>=StoveCount);
end;

procedure TForge.GotoNextStove;
begin
  StoveIndex:=StoveIndex+1;
end;

procedure TForge.InitStoveStuffsToBeChozen; // 先不处理炼化宠物情况
var
  i, j: integer;
begin
  ThisUser.GetItems;
  j:=0;
  for i:=0 to ThisUser.ItemCount-1 do
  begin
    if (ThisUser.Items[i].Name='※乾坤袋') or (ThisUser.Items[i].Name='※百宝囊') then continue;
    StoveStuffsToBeChozen[j].Stuff:=ThisUser.Items[i];
    StoveStuffsToBeChozen[j].ChozenBy:=-1;
    j:=j+1;
  end;
  StoveStuffsToBeChozenCount:=j;
end;

procedure TUser.GetAttr;
begin
  ReadFromHLMEM(Pointer(UserIdAddress), @ID, 2);

  ReadFromHLMEM(Pointer(UserXianmo_1Xian_2Mo), @Xianmo, 2);
  ReadFromHLMEM(Pointer(UserAttribTiliAddr), @Tili, 2);
  ReadFromHLMEM(Pointer(UserAttribNeigongAddr), @Neigong, 2);
  ReadFromHLMEM(Pointer(UserAttribGongjiAddr), @Gongji, 2);
  ReadFromHLMEM(Pointer(UserAttribFangyuAddr), @Fangyu, 2);
  ReadFromHLMEM(Pointer(UserAttribQinggongAddr), @Qinggong, 2);
  ReadFromHLMEM(Pointer(UserAttribRemainingAddr), @RemainingPoints, 2);

  ReadFromHLMEM(Pointer(UserLifeCurrAddr), @CurrLife, 2);
  ReadFromHLMEM(Pointer(UserLifeMaxAddr), @MaxLife, 2);
  ReadFromHLMEM(Pointer(UserNeiliCurrAddr), @CurrNeili, 2);
  ReadFromHLMEM(Pointer(UserNeiliMAXAddr), @MaxNeili, 2);

  ReadFromHLMEM(Pointer(UserMoneyAddress), @Money, 4);

  ReadFromHLMEM(Pointer(UserRankAddr), @Rank, 2);

  ReadFromHLMEM(Pointer(UserLevelAddr), @Level, 2);
  Xiu_Level:=0;
  if Rank>=2 then
  begin
    ReadFromHLMEM(Pointer(UserBaseXiuAddr), @Xiu_Level, 4);
    Xiu_Level:=Xiu_Level+Level;
  end;
end;

function TUser.FindPetCount(Name: String; Loyal: WORD): integer;
var
  i: integer;
begin
  Result:=0;

  GetPets;

  for i:=0 to PetCount-1 do
  begin
    if ((Pets[i].Name=Name) or (Name='')) and (Pets[i].Loyal>=Loyal)
    then
    begin
      Result:=Result+1;
    end;
  end;
end;


procedure TUser.GetWGs;
var
  i, j:integer;
  pCurrWG: DWORD;
  WGBuffer: array [0.. UserWGDataLength-1] of Byte;
  CharArrayTemp: array [0.. 15] of Char;
  tmp: DWORD;
//  tmpext: Extended;
begin
  ReadFromHLMEM(Pointer(UserWGCountAddress), @tmp, 4);
  WGCount:=tmp;

  for i:=0 to WGCount-1 do
  begin
    pCurrWG:=GetHLMemListNumberByNo(i, UserFirstWGAddressAddress, $67295C);
    ReadFromHLMEM(Pointer(pCurrWG), @WGBuffer, UserWGDataLength);

    for j:=0 to 15 do CharArrayTemp[j]:=Char(WGBuffer[j]);
    WGs[i].Name:=CharArrayTemp;
    for j:=0 to 15 do CharArrayTemp[j]:=Char(WGBuffer[$10+j]);
    WGs[i].Creator:=CharArrayTemp;

    WGs[i].ID:=Byte(WGBuffer[$27])*65536*256+Byte(WGBuffer[$26])*65536
                      +Byte(WGBuffer[$25])*256+Byte(WGBuffer[$24]);
    WGs[i].QS:=Byte(WGBuffer[$28])+1;
    WGs[i].GJ:=Byte(WGBuffer[$2c])+1;
    WGs[i].BZ:=Byte(WGBuffer[$30])+1;
    WGs[i].LevelNeed:=Byte(WGBuffer[$35])*256+Byte(WGBuffer[$34]);
    WGs[i].Neili:=Byte(WGBuffer[$39])*256+Byte(WGBuffer[$38]);
    WGs[i].DisplayXishuMultiply100:=Byte(WGBuffer[$3c]);
    WGs[i].Real_DisplayXishuPercent:=Byte(WGBuffer[$4c]);
    WGs[i].Jingyan:=Byte(WGBuffer[$69])*256+Byte(WGBuffer[$68]);
  end;

  GetAttr;
  if Rank < 1 then WGCountLimit:=5 // 凡人为5个
  else if Rank < 2 then WGCountLimit:=8 // 散仙为8个
  else WGCountLimit:=10; // 其它为10个
end;

procedure TUser.GetPets;
var
  i, j:integer;
  pCurrPet: DWORD;
  PetBuffer: array [0..UserPetSize-1] of Byte;
  CharArrayTemp: array[0..15] of Char;
begin
  ReadFromHLMEM(Pointer(UserPetCountAddress), @PetCount, 4);

  for i:=0 to PetCount-1 do
  begin
    pCurrPet:=GetHLMemListNumberByNo(i, UserFirstPetAddressAddress, $00672954);

    ReadFromHLMEM(Pointer(pCurrPet), @PetBuffer, UserPetSize);

    if PetBuffer[$B0]=1 then BattlePetPos:=i;

    for j:=0 to 15 do CharArrayTemp[j]:=Char(PetBuffer[j+4]);
    Pets[i].Name:=CharArrayTemp;
    Pets[i].ID:=PetBuffer[$93]*65536*256+PetBuffer[$92]*65536
                              +PetBuffer[$91]*256+PetBuffer[$90];
    Pets[i].Level:=PetBuffer[$39]*256+PetBuffer[$38];
    Pets[i].Loyal:=PetBuffer[$94];
    Pets[i].Experience:=PetBuffer[$3F]*65536*256+PetBuffer[$3E]*65536
                              +PetBuffer[$3D]*256+PetBuffer[$3C];
    Pets[i].NextLevel:= Floor((Pets[i].Level+1) * Pets[i].Level * 0.75);
    Pets[i].CurrLife:=PetBuffer[$43]*65536*256+PetBuffer[$42]*65536
                              +PetBuffer[$41]*256+PetBuffer[$40];
    Pets[i].MaxLife:=PetBuffer[$47]*65536*256+PetBuffer[$46]*65536
                              +PetBuffer[$45]*256+PetBuffer[$44];

    Pets[i].Attack:=PetBuffer[$1F]*65536*256+PetBuffer[$1E]*65536
                              +PetBuffer[$1D]*256+PetBuffer[$1C];
    Pets[i].Defence:=PetBuffer[$23]*65536*256+PetBuffer[$22]*65536
                              +PetBuffer[$21]*256+PetBuffer[$20];
    Pets[i].Dexterity:=PetBuffer[$27]*65536*256+PetBuffer[$26]*65536
                              +PetBuffer[$25]*256+PetBuffer[$24];
    Pets[i].MedalAttack:=PetBuffer[$87]*65536*256+PetBuffer[$86]*65536
                              +PetBuffer[$85]*256+PetBuffer[$84];
    Pets[i].MedalDefence:=PetBuffer[$8B]*65536*256+PetBuffer[$8A]*65536
                              +PetBuffer[$89]*256+PetBuffer[$88];
    Pets[i].MedalDexterity:=PetBuffer[$8F]*65536*256+PetBuffer[$8E]*65536
                              +PetBuffer[$8D]*256+PetBuffer[$8C];
  end;
end;

function TUser.GetMarchingPet(): TPet;
begin
  GetPets;
  Result := Pets[BattlePetPos];
end;

function TUser.FindPetPos(Name: String; Loyal: integer): integer; // 从 1 开始，0说明没有找到
var
  i: integer;
begin
  Result:=0;

  GetPets;

  for i:=0 to PetCount-1 do
  begin
    If (Pets[i].Name=Name) and (Pets[i].Loyal>=Loyal)
    then
    begin
      Result:=i+1;
      break;
    end;
  end;
end;

function TUser.FindItemPos(Name: String; Maker: String): integer; // 从 1 开始，0说明没有找到
var
  i: integer;
begin
  Result:=0;

  GetItems;

  for i:=0 to ItemCount-1 do
  begin
    If
      (Items[i].Name=Name) and (Items[i].Maker=Maker)
    then
    begin
      Result:=i+1;
      break;
    end;
  end;
end;

function TUser.FindItemPosByID(ID: DWORD): integer; // 从 1 开始，0说明没有找到
var
  i: integer;
begin
  Result:=0;

  GetItems;

  for i:=0 to ItemCount-1 do
  begin
    If Items[i].ID=ID
    then
    begin
      Result:=i+1;
      break;
    end;
  end;
end;

function TUser.FindItemID(Name: String; Maker: String): DWORD; // 0说明没有找到
var
  i: integer;
begin
  Result:=0;

  GetItems;

  for i:=0 to ItemCount-1 do
  begin
    If
      (Items[i].Name=Name) and (Items[i].Maker=Maker)
    then
    begin
      Result:=Items[i].ID;
      break;
    end;
  end;
end;

function TUser.FindItemByType(ItemType: DWORD): DWORD;
var
  i: integer;
begin
  Result:=0;

  GetItems;

  for i:=0 to ItemCount-1 do
  begin
    If
      (Items[i].ItemType=ItemType)
    then
    begin
      Result:=Items[i].ID;
      break;
    end;
  end;
end;

function TUser.FindItemCount(Name: String; Maker: String): integer;
var
  i: integer;
begin
  Result:=0;

  GetItems;

  for i:=0 to ItemCount-1 do
  begin
    If Name='' then
    begin // 只判断Maker
      if Items[i].Maker=Maker then Result:=Result+1;
    end
    else if Maker='' then
    begin // 只判断Name
      if Items[i].Name=Name then Result:=Result+1;
    end
    else // 两个都要判断
    begin
      if (Items[i].Name=Name) and (Items[i].Maker=Maker) then Result:=Result+1;
    end;
  end;
end;

procedure TUser.GetItems;
var
  i, j:integer;
  pCurrItem: DWORD;
  ItemBuffer: array [0.. UserItemInfoSize-1] of AnsiChar;
  CharArrayTemp: array [0.. 15] of AnsiChar;
  tmp: DWORD;
begin
  ReadFromHLMEM(Pointer(UserItemCountAddress), @tmp, 4);
  ItemCount:=tmp;

  for i:=0 to ItemCount-1 do
  begin
    //6715FC
    pCurrItem:=GetHLMemListNumberByNo(i, UserFirstItemAddressAddress, $0066824C);
    ReadFromHLMEM(Pointer(pCurrItem), @ItemBuffer, UserItemInfoSize);

    for j:=0 to 15 do CharArrayTemp[j]:=ItemBuffer[j];
    Items[i].Name:=CharArrayTemp;
    for j:=0 to 15 do CharArrayTemp[j]:=ItemBuffer[$10+j];
    Items[i].Maker:=CharArrayTemp;

    Items[i].Level:=Byte(ItemBuffer[$2f])*256*65536+Byte(ItemBuffer[$2e])*65536
          +Byte(ItemBuffer[$2d])*256+Byte(ItemBuffer[$2c]);

    Items[i].Price:=Byte(ItemBuffer[$27])*256*65536+Byte(ItemBuffer[$26])*65536
          +Byte(ItemBuffer[$25])*256+Byte(ItemBuffer[$24]);

    Items[i].ID:=Byte(ItemBuffer[$23])*256*65536+Byte(ItemBuffer[$22])*65536
          +Byte(ItemBuffer[$21])*256+Byte(ItemBuffer[$20]);

    Items[i].ItemType:=Byte(ItemBuffer[$2b])*256+Byte(ItemBuffer[$2a]);

    Items[i].PlusLife:=Byte(ItemBuffer[$31])*256+Byte(ItemBuffer[$30]);
    Items[i].PlusNeili:=Byte(ItemBuffer[$33])*256+Byte(ItemBuffer[$32]);
    Items[i].PlusGongji:=Byte(ItemBuffer[$35])*256+Byte(ItemBuffer[$34]);
    Items[i].PlusFangyu:=Byte(ItemBuffer[$37])*256+Byte(ItemBuffer[$36]);
    Items[i].PlusMinjie:=Byte(ItemBuffer[$39])*256+Byte(ItemBuffer[$38]);
    Items[i].PlusDufang:=Byte(ItemBuffer[$3b])*256+Byte(ItemBuffer[$3a]);
    Items[i].PlusDingfang:=Byte(ItemBuffer[$3d])*256+Byte(ItemBuffer[$3c]);
    Items[i].PlusShuifang:=Byte(ItemBuffer[$3f])*256+Byte(ItemBuffer[$3e]);
    Items[i].PlusHunfang:=Byte(ItemBuffer[$41])*256+Byte(ItemBuffer[$40]);

    // 如果是毒药，取负值
    if Items[i].ItemType=600 then Items[i].PlusLife:=0-Items[i].PlusLife;
  end;
end;

function TUser.FindNeiyaoPos: integer; // 从 1 开始，0说明没有找到
var
  i: integer;
begin
  Result:=0;

  GetItems;

  for i:=0 to ItemCount-1 do
  begin
    If
      (Items[i].ItemType=ItemLiaoshangyao) and (Items[i].PlusNeili<>0)
    then
    begin
      Result:=i+1;
      break;
    end;
  end;
end;

function TUser.UseItem(ID: DWORD): Boolean;
var
  tmpWin: TWindowInfo;
  tmpPos: Integer;
  XY: TPoint;
begin
  Result := False;

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Item/Equipment');
  if tmpWin = nil then Exit;

  tmpPos := FindItemPosByID(ID);
  if tmpPos = 0 then Exit;

  XY := GetItemXY(tmppos);

  // 双击要使用的物品, 注意，这个物品千万不能双击多次
  LeftDblClickOnSomeWindow_Post(tmpwin.Window, XY.X, XY.Y);

  Result := True;
end;

function TUser.DropItem(ID: DWORD): Boolean;
var
  tmpWin, tmpButton: TWindowInfo;
  tmpPos: Integer;
  XY: TPoint;
begin
  Result := False;

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Item/Equipment');
  if tmpWin = nil then Exit;

  tmpPos := FindItemPosByID(ID);
  if tmpPos = 0 then Exit;

  XY := GetItemXY(tmppos);

  // 双击要使用的物品, 注意，这个物品千万不能双击多次
  LeftClickOnSomeWindow_Post(tmpwin.Window, XY.X, XY.Y);
  Sleep(100);

  tmpButton := HLInfoList.GlobalHL.LocateChildWindowInfoByTitle(tmpWin, 'Drop Item', true);
  if tmpWin = nil then Exit;

  LeftClickOnSomeWindow_Post(tmpButton.Window, 1, 1);

  Result := True;
end;

procedure TUser.PatchItemWindow;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  BufferDWord: DWORD;
  BufferByte: Byte;
  tmpWin: TWindowInfo;
begin
  //BufferDWord := $00007EE9;
  BufferDWord := $00005BE9;
  BufferByte := $00;

  //0042A42B jump to loc 0x60 distance

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);
  if ProcessHandle <> 0 then
  begin
    //WriteProcessMemory(ProcessHandle, Pointer($0042A3CB), @BufferDWord, 4, lpNumberOfBytes);
    //WriteProcessMemory(ProcessHandle, Pointer($0042A3CD), @BufferByte, 1, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($0042A3CB), @BufferDWord, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($0042A3CF), @BufferByte, 1, lpNumberOfBytes);

  end;
  CloseHandle(ProcessHandle);

  // 隐藏窗体
  //物品/装备
  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Item/Equipment');
  if tmpWin <> Nil
  then
    if IsWindow(tmpWin.Window) and IsWindowVisible(tmpWin.Window)
    then
      ShowWindow(tmpWin.Window, SW_HIDE);
end;

procedure TUser.UnPatchItemWindow;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  BufferDWord: DWORD;
  BufferByte: Byte;
  tmpWin: TWindowInfo;
begin
  //BufferDWord := $E8B875FF;
  BufferDWord := $E8B875FF;
  //BufferByte := $01;
  BufferByte := $3D;

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);

  if ProcessHandle<>0 then
  begin
    //WriteProcessMemory(ProcessHandle, Pointer($429edb), @BufferDWord, 4, lpNumberOfBytes);
    //WriteProcessMemory(ProcessHandle, Pointer($429edf), @BufferByte, 1, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($0042A3CB), @BufferDWord, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($0042A3CF), @BufferByte, 1, lpNumberOfBytes);

  end;
  CloseHandle(ProcessHandle);
  // 关闭窗体
  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Item/Equipment');
  if tmpWin <> Nil
  then
    if IsWindow(tmpWin.Window) and (not IsWindowVisible(tmpWin.Window))
    then
      Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
end;

procedure TUser.AddStats(statType: String; points: integer);
var
  statOffset: WORD;
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  StatFormAddr: DWORD;
  NewRem: Integer;

begin
  if statType = 'Life' then statOffset := AttrOffset_Life
  else if statType = 'Mana' then statOffset := AttrOffset_Mana
  else if statType = 'Attack' then statOffset := AttrOffset_Attack
  else if (statType = 'Defense') or (statType = 'Defence') then statOffset := AttrOffset_Defense
  else if statType = 'Dexterity' then statOffset := AttrOffset_Dexterity
  else Exit;

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);
  if ProcessHandle<>0 then
  begin
    ReadFromHLMEM(Pointer(HL_HeroStatsFormAddressAddress), @StatFormAddr, 4);
    WriteProcessMemory(ProcessHandle, Pointer(StatFormAddr + statOffset), @points, 4, lpNumberOfBytes);

    NewRem := ThisUser.OldRemaining - points;
    WriteProcessMemory(ProcessHandle, Pointer(StatFormAddr + AttrOffset_Rem), @NewRem, 4, lpNumberOfBytes);
  end;
  CloseHandle(ProcessHandle);
end;

function TCreateWG.FindWindows(var hwndMC, hwndXS, hwndNL, hwndQS, hwndGJ, hwndBZ, hwndButtonCZ: HWND):HWND; // 返回创招窗口的HWND，如果为0，说明没有找到
const
  RepCountTol=5;
var
  i: integer;
  tmpWin, WinCreateWG : TWindowInfo;
  hwndCreateWG, hwndXiaoguo, hwndJiben: HWND;
begin
  Result := 0;

  hwndMC := 0;
  hwndXS := 0;
  hwndNL := 0;
  hwndQS := 0;
  hwndGJ := 0;
  hwndBZ := 0;
  hwndButtonCZ := 0;

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Create Kungfu');
  if tmpWin = nil then Exit;
  hwndCreateWG := tmpWin.Window;

  hwndXiaoguo := HLInfoList.GlobalHL.
    LocateChildWindowWNDByTitle(hwndCreateWG, 'Effect Settings', True);
  hwndJiben := HLInfoList.GlobalHL.
    LocateChildWindowWNDByTitle(hwndCreateWG, 'Basic Settings', True);
  hwndButtonCZ := HLInfoList.GlobalHL.
    LocateChildWindowWNDByTitle(hwndCreateWG, 'OK(&O)', True);

  if (hwndXiaoguo = 0) or (hwndJiben = 0) or (hwndButtonCZ = 0) then Exit;

  WinCreateWG := HLInfoList.GlobalHL.ItemOfWindowTitle('Create Kungfu');  // 这必须再来一次，因为会变
  for i := 0 to HLInfoList.GlobalHL.Count - 1 do
  begin
    tmpWin := HLInfoList.GlobalHL.Items[i];
    if tmpWin.ParentWin = nil then Continue;
    if (tmpWin.ParentWin.Window = hwndXiaoguo) then // QS, GJ, BZ
    begin
      if (tmpWin.Top - CreateWG_QS_TopJust = winCreateWG.Top)
      then
      begin
        hwndQS := tmpWin.Window;
      end
      else if (tmpWin.Top - CreateWG_GJ_TopJust = winCreateWG.Top)
      then
      begin
        hwndGJ := tmpWin.Window;
      end
      else if (tmpWin.Top - CreateWG_BZ_TopJust = winCreateWG.Top)
      then
      begin
        hwndBZ := tmpWin.Window;
      end;
    end
    else if (tmpWin.ParentWin.Window = hwndJiben) then // MC, XS, NL
    begin
      if (tmpWin.Top - CreateWG_MC_TopJust = winCreateWG.Top)
      then
      begin
        hwndMC := tmpWin.Window;
      end
      else if (tmpWin.Top - CreateWG_XS_TopJust = winCreateWG.Top)
      then
      begin
        hwndXS := tmpWin.Window;
      end
      else if (tmpWin.Top - CreateWG_NL_TopJust = winCreateWG.Top)
      then
      begin
        hwndNL := tmpWin.Window;
      end;
    end;
  end;

  if (hwndMC > 0) and (hwndXS > 0) and (hwndNL > 0) and (hwndQS > 0)
    and (hwndGJ > 0) and (hwndBZ > 0) and (hwndButtonCZ > 0)
  then
    Result := hwndCreateWG;
end;

function TCreateWG.DoCreateWG: Boolean;
var
  hwndCreateWG, hwndMC, hwndXS, hwndNL, hwndQS, hwndGJ, hwndBZ, hwndButtonCZ: HWND;
  tmpMC, tmpXS, tmpNL, tmpQS, tmpGJ, tmpBZ: String;
begin
  Result := False;

  hwndCreateWG := FindWindows(hwndMC, hwndXS, hwndNL, hwndQS, hwndGJ, hwndBZ, hwndButtonCZ);

  if hwndCreateWG = 0 then Exit;

  EnableWindow(hwndCreateWG, False);

  WindowSetText(hwndMC, ThisWGAttrs.MC);
  WindowSetText(hwndXS, ThisWGAttrs.XS);
  WindowSetText(hwndNL, ThisWGAttrs.NL);
  Sleep(100);
  tmpMC := WindowGetText(hwndMC);
  tmpXS := WindowGetText(hwndXS);
  tmpNL := WindowGetText(hwndNL);

  if (tmpMC <> ThisWGAttrs.MC) or (tmpXS <> ThisWGAttrs.XS) or (tmpNL <> ThisWGAttrs.NL) then Exit;

  SendMessage(hwndQS, CB_SETCURSEL, StrToInt(ThisWGAttrs.QS) - 1, 0);
  SendMessage(hwndGJ, CB_SETCURSEL, StrToInt(ThisWGAttrs.GJ) - 1, 0);
  SendMessage(hwndBZ, CB_SETCURSEL, StrToInt(ThisWGAttrs.BZ) - 1, 0);
  Sleep(100);
  tmpQS := WindowGetText(hwndQS);
  tmpGJ := WindowGetText(hwndGJ);
  tmpBZ := WindowGetText(hwndBZ);

  if (tmpQS <> ThisWGAttrs.QS) or (tmpGJ <> ThisWGAttrs.GJ) or (tmpBZ <> ThisWGAttrs.BZ) then Exit;

  EnableWindow(hwndCreateWG, True);

  // 点击创招
  Sendmessage(hwndButtonCZ, WM_LBUTTONDOWN, MK_LBUTTON, 1 + 1 * 65536);
  Sendmessage(hwndButtonCZ, WM_LBUTTONUP, 0, 1 + 1 * 65536);

  Result := True;
end;

function TCreateWG.DoDeleteWGs: Boolean;
// 删除武功
var
  tmpWin: TWindowInfo;
  hwndSkill, hwndLearnedSkillList, hwndForget: HWND;
  tmpRect: TRect;
begin
  Result := False;

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Kungfu');
  if tmpWin = nil then Exit;

  hwndSkill:=tmpWin.Window;

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Skill(s) Learned');
  if tmpWin = nil then Exit;

  hwndLearnedSkillList := HLInfoList.GlobalHL.
    LocateChildWindowWNDByTitle(tmpWin.Window, '', True);
  if hwndLearnedSkillList = 0 then Exit;

  hwndForget := HLInfoList.GlobalHL.
    LocateChildWindowWNDByTitle(hwndSkill, 'Forget(&F)', True);
  if hwndForget = 0 then Exit;
  
  ThisUser.GetWGs;
  if DeleteWGRemainIndicator=DelWGRemainEasyWG then
  begin // 保留容易招
    repeat
      if ThisUser.WGs[DeleteFrom-1].Real_DisplayXishuPercent>=100 // 容易招
      then
        DeleteFrom:=DeleteFrom+1
      else
        break;
    until DeleteFrom>ThisUser.WGCount;
  end
  else if DeleteWGRemainIndicator<>DelWGNoIndicator then
  begin // 保留系数
    repeat
      if ThisUser.WGs[DeleteFrom-1].DisplayXishuMultiply100*ThisUser.WGs[DeleteFrom-1].Real_DisplayXishuPercent/10000>=DeleteWGRemainIndicator
      then
        DeleteFrom:=DeleteFrom+1
      else
        break;
    until DeleteFrom>ThisUser.WGCount;
  end;

  if DeleteFrom>ThisUser.WGCount then Exit; // 无招可删了

  EnableWindow(hwndSkill, False);
  
  if SendMessage(hwndLearnedSkillList, LB_SETCURSEL, DeleteFrom-1, 0)=LB_ERR then Exit;
  if SendMessage(hwndLearnedSkillList, LB_GETITEMRECT, DeleteFrom-1, LPARAM(@tmpRect))=LB_ERR then Exit;

  LeftClickOnSomeWindow_Send(hwndLearnedSkillList, tmpRect.Left, tmpRect.Top);

  if DeleteFrom=SendMessage(hwndLearnedSkillList, LB_GETCURSEL, 0, 0)+1 then
  begin
    OldWGCount:=ThisUser.WGCount;
    LeftClickOnSomeWindow_Post(hwndForget, 0, 0);
  end;
  
  EnableWindow(hwndSkill, True);
  Result:=True;
end;

procedure TCreateWG.PatchCreateWG;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  BufferDWord, BufferDWord2: DWORD;
  BufferWord: WORD;
//  BufferByte: Byte;
  tmpWin: TWindowInfo;
begin
  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);

  if ProcessHandle <> 0 then
  begin
    //BufferDWord := $0000A3E9;
    BufferDWord := $0000A3E9;
    WriteProcessMemory(ProcessHandle, Pointer($458AA5), @BufferDWord, 4, lpNumberOfBytes); //4467DD

    BufferDWord := $000001B8;
    BufferDWord2 := $90909000;
    BufferWord := $9090;
    WriteProcessMemory(ProcessHandle, Pointer($4512E0), @BufferDWord, 4, lpNumberOfBytes); //4403F3
    WriteProcessMemory(ProcessHandle, Pointer($4512E4), @BufferDWord2, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($4512E8), @BufferWord, 2, lpNumberOfBytes);
  end;
  CloseHandle(ProcessHandle);

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Create Kungfu');
  if tmpWin <> nil then
    if IsWindow(tmpWin.Window) and IsWindowVisible(tmpWin.Window) then
      ShowWindow(tmpWin.Window, SW_HIDE);

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Kungfu'); //修炼技能
  if tmpWin <> nil then
    if IsWindow(tmpWin.Window) and IsWindowVisible(tmpWin.Window) then
      ShowWindow(tmpWin.Window, SW_HIDE);
end;

procedure TCreateWG.UnPatchCreateWG;
var
  ProcessHandle: THandle;
  lpNumberOfBytes: SIZE_T;
  BufferDWord, BufferDWord2: DWORD;
  BufferWord: WORD;
//  BufferByte: Byte;
  tmpWin: TWindowInfo;
begin

  ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, HLInfoList.GlobalHL.ProcessId);

  if ProcessHandle <> 0 then
  begin
    BufferDWord := $00A2840F;
    WriteProcessMemory(ProcessHandle, Pointer($458AA5), @BufferDWord, 4, lpNumberOfBytes);

    //BufferDWord := $66E831FF;
    //BufferDWord2 := $83FFFCE4;
    BufferDWord := $01E831FF;
    BufferDWord2 := $83FFFBB4;
    BufferWord := $0CC4;
    WriteProcessMemory(ProcessHandle, Pointer($4512E0), @BufferDWord, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($4512E4), @BufferDWord2, 4, lpNumberOfBytes);
    WriteProcessMemory(ProcessHandle, Pointer($4512E8), @BufferWord, 2, lpNumberOfBytes);
  end;
  CloseHandle(ProcessHandle);

  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Create Kungfu');
  if tmpWin <> nil then
    if IsWindow(tmpWin.Window) and (not IsWindowVisible(tmpWin.Window)) then
      Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);


  tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Kungfu');
  if tmpWin <> nil then
    if IsWindow(tmpWin.Window) and (not IsWindowVisible(tmpWin.Window)) then
      Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
end;

initialization
  ThisWork := TWork.Create;
  ThisUser := TUser.Create;
finalization
  ThisWork.Free;
  ThisUser.Free;
end.

