unit UnitConsts;
interface

Uses Messages;
                                        
resourcestring
  IDS_InfoFilesPath 	= '.\Info\';
  IDS_ScriptFilesPath = '.\Scripts\';
  IDS_UsersPath       = '.\Users\';

  IDS_StoreFilename       = 'Store.ini';
  IDS_DefaultMapFileName  = 'Map.ini';
  RS_UpDateTime	          = '2019.06.03';

  IDS_MainHotKeyInfo    = 'MainHotKeyInfo';
  IDS_WinInfoHotKeyInfo = 'WinInfoHotKeyInfo';
  IDS_VirtualKey        = 'VirtualKey';
  IDS_Modifiers         = 'Modifiers';
  IDS_ShowText          = 'ShowText';

  IDS_FormTopStr 								= 'Top';
  IDS_FormLeftStr 							= 'Left';
  IDS_MainFormName 							= 'Main';
  IDS_ImageFormName 						= 'Image';
  IDS_GeneralSetFormName 				= 'Settings';
  IDS_StuffsFormName 						= 'Inventory';
  IDS_PetsFormName 							= 'Pets';
  IDS_UniverseStoveFormName 		= 'Wuxing Oven';
  IDS_WorkTransactionsFormName 	= 'Script';
  IDS_WGsFormName 							= 'Create Kungfu';
	IDS_WGAttrFormName 						= 'Basic Settings';
  IDS_WG_Name 									= 'Name';
  IDS_WG_NameDef 								= 'DivinePalm';
  IDS_WG_XiShu 									= 'Destructive Index';
  IDS_WG_NeiLi 									= 'Mana Consumed';
  IDS_WG_ZiShi 									= 'Starting Posture';
  IDS_WG_GuiJi 									= 'Flying Track';
  IDS_WG_BaoZha 								= 'Explosion Type';
const
//  AddrHumanBase 	= $006C21FC;
//  AddrBattleState = $006C51DC;

  CustomMouseMsg = WM_USER + 1;
  CustomIID = 100;

  // ����Ķ������룬����Work.ini����
  ActUnknown 					= -1;  	// δָ֪��---------------------------------------
  ActLeftClick 				= 0;		// �������
  ActRightClick				= 1;    // �Ҽ�����
  ActMoveToPos				= 10;   // �ƶ�λ�ã��ƶ�����ͼ�ڵ�ĳ������
  ActGoToMap					= 20; 	// ������ͼ���ƶ���ָ����ͼ
  ActInBattle					= 30;   // ����ս��
  ActBuyStuff					= 40;   // ������Ʒ
  ActDoForge					= 50;		// ���ж���
  ActQuitShop					= 60;   // �뿪�̵�
  ActPressButton			= 70;		// �����ť
  ActCallNPC					= 80;		// ���� NPC
  ActTerminate				= 90;		// ֹͣ����
  ActHaveStuff				= 100;	// ӵ����Ʒ���ȴ��������Ʒ���ﵽָ��������
  ActStuffNum					= 110;	// ��Ʒ��Ŀ���ȴ��������Ʒ������ָ��������
  ActJumpToTransN			= 120;	// �������� N
  ActHavePet					= 130;  // ӵ�г���ȴ�����˳���ﵽָ��������
  ActPetNum						= 140;  // ������Ŀ���ȴ�����˳������ָ��������
  ActCancelNPCDialog	= 150;	// ȡ���Ի�
  ActWinLeftClick			= 160;	// ���ڵ���
  ActWinLeftDblClick	= 170;	// ����˫��
  ActDelay						= 180;	// �ȴ���ʱ
  ActActiveBattle			= 190;  // ����ս��
  ActSetCapture				= 200;  // ׽������
  ActLocateWindow			= 210;	// ��λ����
  ActWinRightClick		= 220;	// �����Ҽ�
  ActWaitWindow				= 230;	// �ȴ�����
  ActCreateWG					= 240;	// �Դ��书
  ActUseItem					= 250;	// ʹ����Ʒ
  ActOpenItemWindow		= 260;  // ����Ʒ��
  ActCloseItemWindow	= 270;	// ����Ʒ��
  ActSetWGAttr				= 280;  // �书����
  ActSetWGDisp				= 290;	// �书���
  ActDeleteWGs				= 300;	// ɾ���书
  ActSetHeal          = 310;  // Set heal settings
  ActDropItem         = 320;  // Drop an item
  ActSetAttr          = 330;  // Set user Attributes

//  UserIDAddr	= $006c2200;  // Old HL_Base_Address

  HL_EXE_Name				= 'HL_Client.exe';
  //UserNameAddress		= $006c2244; CN
  //UserNickAddress		= $006c2254;
  //UserSpouseAddress	= $006c2264;
  UserNameAddress		= $006BB974;
  UserNickAddress		= $006BB984;
  UserSpouseAddress	= $006BB994;
  UserNameSize			= 16;
  UserIdAddress     = $006BB930;

  //UserMoneyAddress	= $6c2214;
  UserMoneyAddress	= $6BB944;

  // Level, cultivation(?)
  //UserLevelAddr			= $006c2206; // WORD  CN
  //UserBaseXiuAddr		= $006C3478;  // DWORD
  UserLevelAddr			= $6BB936; // WORD
  UserBaseXiuAddr		= $6BCBA8;  // DWORD

  // User rank: master=5
//  UserRankAddr = $006c2208; // WORD CN
  UserRankAddr = $6BB938; // WORD

  // ������ħ��ַ����=1��ħ=2, ����/ɢ��=0
  //UserXianmo_1Xian_2Mo 	= $006C346C; // WORD CN
  UserXianmo_1Xian_2Mo 	= $6BCB9C; // WORD
  UserAttrXian 					= 1; // ��
  UserAttrMo 						= 2; // ħ

  // ������תְҵ��
  //User5TurnCareer	= $006C3470; // WORD
  User5TurnCareer	= $6BCBA0; // WORD

  // Life current/max
  //UserLifeCurrAddr	= $006c220A; // WORD   CN
  //UserLifeMAXAddr		= $006c220c; //WORD
  UserLifeCurrAddr	= $6BB93A; // WORD
  UserLifeMAXAddr		= $6BB93C; //WORD

  // Mana current/max
  //UserNeiliCurrAddr	= $006c220e;  // WORD  CN
  //UserNeiliMAXAddr	= $006c2210;  // WORD
  UserNeiliCurrAddr	= $6BB93E;  // WORD
  UserNeiliMAXAddr	= $6BB940;  // WORD

  // 5 attributes
  //UserAttribTiliAddr			= $006c2230; // WORD  CN
  //UserAttribNeigongAddr		= $006c2238; // WORD
  //UserAttribGongjiAddr		= $006c2234; // WORD
  //UserAttribFangyuAddr		= $006c2232; // WORD
  //UserAttribQinggongAddr	= $006c2236; // WORD
  UserAttribTiliAddr			= $6BB960; // WORD  hp
  UserAttribNeigongAddr		= $6BB968; // WORD  mp
  UserAttribGongjiAddr		= $6BB964; // WORD  atk
  UserAttribFangyuAddr		= $6BB962; // WORD  def
  UserAttribQinggongAddr	= $6BB966; // WORD  dex
  UserAttribRemainingAddr = $6BCCF4; // WORD  unused attributes

  // User coordinates on map
  //UserPosXAdress	= $006c22a8; CN
  //UserPosYAdress	= $006c22ac;
  UserPosXAdress	= $006BB9D8;
  UserPosYAdress	= $006BB9DC;
  UserRealXAddress = $006BB9E8;
  UserRealYAddress = $006BB9EC;

  // �û����ڵĵ�ͼ��ID�����Ƶĵ�ַ
  //UserCurMapAddress			= $006c4630;  // DWORD
  //UserCurMapNameAddress	= $006c45A0;  // 16 Bytes
  UserCurMapAddress			= $006BDD60;  // DWORD
  UserCurMapNameAddress	= $006BDCD0;  // 16 Bytes

  // �û���������״̬��ַ��״̬��3f1-ս����3f2-ƽʱ��3f3-��NPC�Ի�
  UserEnvironmentAdress	= $0066C0B8; // WORD
  UserEnvSwitchMap			= $3f0;
  UserEnvBattle					= $3f1;
  UserEnvNormal					= $3f2;
  UserEnvDialog					= $3f3;
  UserEnvSomeAboutDealingPostClickMessage = $3f4;

  // �û������������·���Ь�ӡ����Ρ�ͷ�ε�ƫ��
  //UserWuqiOnBodyAddress			= $006c39a4;
  //UserHujiaOnBodyAddress		= $006c39a8;
  //UserXieziOnBodyAddress		= $006c39ac;
  //UserShenshiOnBodyAddress	= $006c39b0;
  //UserToushiOnBodyAddress		= $006c39b4;
  UserWuqiOnBodyAddress			= $6BD0D4;
  UserHujiaOnBodyAddress		= $6BD0D8;
  UserXieziOnBodyAddress		= $6BD0DC;
  UserShenshiOnBodyAddress	= $6BD0E0;
  UserToushiOnBodyAddress		= $6BD0E4;

  // ��Ի�ָ���ָ��
  //NPCDialogAddressAddress		= $6c6f60;
  NPCDialogAddressAddress		= $6C06C0;

  // �Ի����ݵĳ���
  NPCDialogLength	= $200;

  // $006c39a0($006c39c0) ��һ��ָ���ָ���base��ַ

  // �û���Ʒ��������Ʒ��Ŀ�ĵ�ַ
  //UserItemCountAddress	= $006c39ec;
  UserItemCountAddress	= $6BD11C;

  // �û���Ʒָ���ָ��
  //UserFirstItemAddressAddress	= $006c39c4;
  UserFirstItemAddressAddress	= $006BD0F4;

  // ����ָ���ָ��
  //UserFirstPetAddressAddress	= $006C3A0C;
  UserFirstPetAddressAddress	= $6BD13C;

  // �������ݵĴ�С
  UserPetSize	= $B4;

  // ������Ŀ�ĵ�ַ
  //UserPetCountAddress	= $006c3a34;
  UserPetCountAddress	= $6BD164;

  // ��Ʒ��Ϣ���ݴ�С
  UserItemInfoSize=$60;

  // ��������Ʒ����
  ItemJian					= 0; // ��
  ItemDao						= 1; // ��
  ItemChui					= 2; // ��
  ItemTui						= 3; // ��
  ItemHuan					= 4; // ��
  ItemShan					= 5; // ��
  ItemZhang					= 6; // ��
  ItemCha						= 7; // ��
  ItemGou						= 8; // ��
  ItemHujia					= 100; // ����
  ItemXiezi					= 200; // Ь��
  ItemShenshi				= 300; // ����
  ItemToushi				= 400; // ͷ��
  ItemAnqi					= 500; // ����
  ItemDuyao					= 600; // ��ҩ
  ItemLiaoshangyao	= 700; // ����ҩ��ע����ҩ��Ѫҩ

  ItemUnknown				=	800; // ��֪����ʲô��������������Ʒ

  // �ϻ��� Ͷ�� λ��
  TigerMachinePutCoinX	= '263';
  TigerMachinePutCoinY	= '84';

  // �ϻ��� "3" λ��
  TigerMachineCheckX	= '426';
  TigerMachineCheckY	= '151';

  // ��Ϸ������
  PlayLeftJust		= 29;
  PlayRightJust		= -31;
  PlayTopJust			= 58;
  PlayBottomJust	= -132;

  // ����崰��
  PnlMainTitle		= 'pnlMain';

  // ��Ʒ/װ������
  ItemWindowTitle	= 'Item/Equipment';

  // ��װ���� ��ť
  ItemButtonX	= 630;
  ItemButtonY	= 450;

  // ��������Ʒ����15��λ��
  Item1X	=	395;
  Item1Y	= 75;

  Item2X	= 440;
  Item2Y	= 75;

  Item3X	= 485;
  Item3Y	= 75;

  Item4X	= 535;
  Item4Y	= 75;

  Item5X	= 395;
  Item5Y	= 120;

  Item6X	= 440;
  Item6Y	= 120;

  Item7X	= 485;
  Item7Y	= 120;

  Item8X	= 530;
  Item8Y	= 120;

  Item9X	= 395;
  Item9Y	= 170;

  Item10X	= 440;
  Item10Y	= 170;

  Item11X	= 490;
  Item11Y	= 170;

  Item12X	= 530;
  Item12Y	= 170;

  Item13X	= 395;
  Item13Y	= 215;

  Item14X	= 440;
  Item14Y	= 215;

  Item15X	= 485;
  Item15Y	= 210;

  // �û��е���Ŀ��ַ
  //UserWGCountAddress				= $006c3a7c;
  UserWGCountAddress				= $6BD1AC;

  // �û���ʽָ���ָ��
  //UserFirstWGAddressAddress	= $006c3a54;
  UserFirstWGAddressAddress	= $6BD184;

  // ��ʽ����
  // ����[16];������[16];[4];�书ID[4];����[4];�켣[4];��ը[4];�ȼ�[4];����[4];��ʾϵ��*100[4];[12];ʵ��ϵ������ʾϵ���ı�ֵ[4];[16];[8];����[4];...

  // ��ʽ���ݳ���
  UserWGDataLength				= $6c;

  // ���� ��ʽ����
  CreateWG_MC_LeftJust		= 112;
  CreateWG_MC_RightJust		= -50;
  CreateWG_MC_TopJust			= 54;
  CreateWG_MC_BottomJust	= -343;

  // ���� ɱ��ϵ��
  CreateWG_XS_LeftJust		= 112;
  CreateWG_XS_RightJust		= -50;
  CreateWG_XS_TopJust			= 78;
  CreateWG_XS_BottomJust	= -319;

  // ���� ʹ������
  CreateWG_NL_LeftJust		= 112;
  CreateWG_NL_RightJust		= -50;
  CreateWG_NL_TopJust			= 102;
  CreateWG_NL_BottomJust	= -295;

  // ���� ��������
  CreateWG_QS_LeftJust		= 112;
  CreateWG_QS_RightJust		= -50;
  CreateWG_QS_TopJust			= 239;
  CreateWG_QS_BottomJust	= -158;

  // ���� ���й켣
  CreateWG_GJ_LeftJust		= 112;
  CreateWG_GJ_RightJust		= -50;
  CreateWG_GJ_TopJust			= 265;
  CreateWG_GJ_BottomJust	= -132;

  // ���� ��ը��ʽ
  CreateWG_BZ_LeftJust		= 112;
  CreateWG_BZ_RightJust		= -50;
  CreateWG_BZ_TopJust			= 291;
  CreateWG_BZ_BottomJust	= -106;

  // �����˵�
  IDM_UniverseStove	= 20;

  // ���в˵�ID
  IDM_CreateWG			= 22;

  // �������Բ˵�ID
  IDM_HumanAttr	= 73;

  // ս���˵�ID
  IDM_Battle		= 88;

  // ��Ʒ�˵�ID
  IDM_Item			= 74;


  // ս��״̬�ĵ�ַ
//  BattleStateAddr	= $006c51dc;
  BattleStateAddr	= $6BE90C;

  // ս��ָ��ĵ�ַ
//  BattleOrderAddr	= $006c6018;
  BattleOrderAddr	= $6BF748;

  // ս��ָ�����ݵĴ�С
  BattleOrderSize	= $1c;
  // ս��ָ��״̬[4], ���ﶯ��[4]�����ﶯ������[4]��[4]�����ﶯ��[4]�����ﶯ������[4]��[4]
  //Combat command status [4], character action [4], character action object [4], [4], pet action [4], pet action object [4], [4]

  // Autofight 0-no 1-yes
//  BattleIsAutoFightAddr	= $006c6260;
  BattleIsAutoFightAddr	= $6BF990;

  // �Ƿ����ս��  0-���ǣ�1-��
//  BattleIsFastFightAddr	= $006c6478;
  BattleIsFastFightAddr	= $6BFBA8;

  // ս��ʱ��������ݴ�С
  CreatureInfoSize			= $70;

  // ս����������������5����ַ
  // 6c627c

  // ս�������Ĺ�������ַ
//  DeadMonsterCountAddr	= $6c626c;
  DeadMonsterCountAddr	= $6BF99C;

  // ս��ʱ�������Ŀ�������Լ��ͳ裩�ĵ�ַ
//  BattleCreatureCountAddress	= $006c5144;
  BattleCreatureCountAddress	= $6BE874;

  // ս��ʱ����ָ���ָ��
//  BattleFirstCreatureAddressAddress	= $006c511c;
  BattleFirstCreatureAddressAddress	= $6BE84C;

  // ս��ʱ�Ķ���
  BattleAttack	= 0;
  BattleMagic		= 1; // ���ʱ��BattleBufferRemain1����Ҫ����ȭ
  BattleDefence	= 2;
  BattleCapture	= 6;
  BattleEscape	= 5;
  BattleIdle		= 3;
  BattleEat			= 9; // ���ʱ��BattleBufferRemain1����Ҫ�Ե�ҩ��ID

  DelWGRemainEasyWG	= -1;
  DelWGNoIndicator	= -2;

  // �û����������ַ
  //UserLianhuaExpAddr	= $006c2220;
  UserLianhuaExpAddr	= $6BB950;

  // Oven item type
  StoveRoomVide	= $4D2;
  StoveRoomPet	= $4D4;
  StoveRoomItem	= $4D6;

  //DialogControlAddr	= $6c6d40;
  DialogControlAddr	= $6c04a0; // �����Ƿ��ǶԻ���״̬�ĵ�ַ
  //6c6f60 > 6C06C0

  // ��Exported Entry�ɵõ�

  // ����FormMain
//  HL_FormMainAddrAddrAddr	= $006ab338;

  // ����UniverseStoveForm
//HL_UniverseStoveFormAddressAddress = $006abb08;
  HL_UniverseStoveFormAddressAddress = $006A8568;


  HL_HeroStatsFormAddressAddress = $006a4ec8;
  AttrOffset_Rem     = $4bc;
  AttrOffset_Life    = $4d4;
  AttrOffset_Mana    = $4d8;
  AttrOffset_Attack  = $4dc;
  AttrOffset_Defense = $4e0;
  AttrOffset_Dexterity = $4e4;
implementation
end.