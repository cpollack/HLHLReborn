unit UnitTypesAndVars;
                                                                    
interface

uses
  Windows, Classes, UnitConsts, ClsMaps;

Type
  DijksatraNodeInfo = ^TDijksatraNode;

  TDijksatraNode = record
    PosInMapList: DWord;
    MapID: DWORD;
    priorNode: TNodeInfo;
    priorDijksatraNode: DijksatraNodeInfo;
    distance: integer;
    OutNodes: TList;
  end;

  TItem = record
    Name: String;
    Maker: String;
    Level: DWORD;
    Price: DWORD;
    ID: DWORD;
    ItemType: WORD;
    PlusLife: SmallInt;
    PlusNeili: SmallInt;
    PlusGongji: SmallInt;
    PlusFangyu: SmallInt;
    PlusMinjie: SmallInt;
    PlusDufang: SmallInt;
    PlusDingfang: SmallInt;
    PlusShuifang: SmallInt;
    PlusHunfang: SmallInt;
  end;

  TWG = record
    Name: String; // 名称
    Creator: String; // 创招人
    ID: DWORD; // 武功ID
    QS: DWORD; // 起手
    GJ: DWORD; // 轨迹
    BZ: DWORD; // 爆炸
    LevelNeed: DWORD; // 等级
    Neili: DWORD; // 内力
    DisplayXishuMultiply100: DWORD; // 显示系数 * 100
    Real_DisplayXishuPercent: DWORD; // 实际系数与显示系数的百分比；>= 100为容易招
    Jingyan: DWORD; // 经验
  end;

  TCreature = record
    Data: array [0..CreatureInfoSize-1] of Byte;
    ID: DWORD;
    Name: String;
    Level: WORD;
    State: Byte; // Dead=$65, Poison=$66, Freeze=$67, Sleep=$68, Chaos=$69, Over=$6A;
    IsDead: Boolean;
  end;

  CreatureInfo = ^TCreature;

  TFate = record
    Attr: Integer;
    Rank: Integer;
    Level: Integer;
    PosX: Integer;
    PosY: Integer;
    MapID: DWORD;
    StepIndex: integer;
    StepNum: Integer;
    StepList: TList;
    OldNPCDialog: String;
  end;

  TPet = record
    Name: String;
    ID: DWORD;
    Level: WORD;
    Loyal: WORD;
    Experience: DWORD;
    NextLevel: DWORD;
    MaxLife: DWORD;
    CurrLife: DWORD;
    Attack: DWORD;
    Defence: DWORD;
    Dexterity: DWORD;
    MedalAttack: DWORD;
    MedalDefence: DWORD;
    MedalDexterity: DWORD;
  end;

  TPurpose = record // 这里面的Allows之间是OR的关系
    Allows: TStringList;
    isSatisfied: Boolean;
  end;

  PurposeInfo=^TPurpose;

  TStoveStuff = record
    StuffID: DWORD;
    StuffAttr: DWORD;
  end;

  TStoveInstruction = record
    Stuffs: array [0..7] of TStoveStuff;
    MainStuffPos: integer;
  end;

  TAllowedStuffType = record
    Name: String;
    Attr: Word;
    Maker: String;
  end;

  AllowedStuffTypeInfo = ^TAllowedStuffType;

  TStoveRoom = record
    Stuff: TStoveStuff;
    AllowedStuffTypes: TList;
  end;

  TStove = record
    Rooms: array [0..7] of TStoveRoom;
    MainRoomPos: integer;
    tmpID1: DWORD;
    tmpID2: DWORD;  // 为了知道是否已经炼化成功
  end;

  StoveInfo=^TStove;
  
  TStoveStuffToBeChozen = record
    Stuff: TItem;
    ChozenBy: Integer; // 被谁Chozen了，如果是-1，则没有被Chozen
  end;

  TPStoveStuffToBeChozen = ^TStoveStuffToBeChozen;

  TNPC = record
//    UserCurrMapID: DWORD;
    ShopMapID: DWORD;
    ShopType: BYTE; //  $64-铁匠铺, $65-药店, $66-珠宝店, $67-宠物店
    Name: String;
    SatisfiedCond: String; // 如果是Shop，就是打开窗口的Title, 如果是对话NPC，就是Dialog
  end;

  TCallNPCState = record
    UserCurrMapID: DWORD;
    IsWorking: Boolean;
  end;

  TWGAttrs = record
    MC: String; // 武功名称
    XS: String; // 杀伤系数
    NL: String; // 所用内力
    QS: String; // 起手姿势
    GJ: String; // 飞行轨迹
    BZ: String; // 爆炸方式
  end;

var
//  ThisFate: TFate;
  ThisTrans: TTransportInfo;
  CallNPCState: TCallNPCState;
  ThisWGAttrs: TWGAttrs;

  TimeToSleep: Integer = 400; // 以微秒为单位

  StoveInstruction: TStoveInstruction;

  StoveRooms: array [0..7] of string=('乾·金', '兑·金', '离·火', '震·木', '巽·木', '坎·水', '艮·土', '坤·土');

//  NPCIDsArray: array [0..Ord(High(TNPCID))] of TNPCID;

  NPCs: array [0..Ord(High(TNPCID))] of TNPC; 	// NPC 信息

implementation

end.
