unit UnitTimers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, UnitTypesAndVars, UnitGlobal, UnitConsts, Math, UnitClasses;

type
  TFormTimers = class(TForm)
    TimerWork: TTimer;
    TimerDoTransaction: TTimer;
    TimerReadMapInfo: TTimer;
    procedure TimerWorkTimer(Sender: TObject);
    procedure TimerDoTransactionTimer(Sender: TObject);
    procedure TimerReadMapInfoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FLocateHwnd: HWND;
    FForgeOldTime: TDateTime;
    FReadMapInfoCounter: integer;
  public
    { Public declarations }

  end;

var
  FormTimers: TFormTimers;

implementation

uses
  ClsMaps, ClsGames,
  UnitShowWGs, UnitGeneralSet, UnitSetWGAttr, UnitMain,
  UnitShowWorkTransactions, UnitShowPets, UnitShowStuffs, UnitDevelop,
  UnitShowUniverseStove;

{$R *.dfm}

procedure TFormTimers.TimerWorkTimer(Sender: TObject);
var
  tmpTransaction: TTransaction;
begin
	// 如果不能工作，禁用工作时钟，并结束工作
  if not ThisWork.CanWork then
  begin
    TimerWork.Enabled:=False;
    FormMain.EndWork;
    exit;
  end;
  // 获取当前事务
  tmpTransaction := ThisWork.GetCurrTransaction;
  // 当前事务正在工作，并且不是刚开始工作，退出
  if tmpTransaction.IsWorking and (not ThisWork.IsFirstTime) then exit;

  if ThisWork.IsFirstTime then // 如果是本轮中的刚开始，还没有做任何步骤，那么不可能是已做完本步骤的情况
    ThisWork.IsFirstTime := False
  else // 现在是应该已经做完本步骤的情况，进入下一步
    ThisWork.GotoNextTrans;

  if ThisWork.GetNextTransToDo then // 还有Transaction要完成
  begin
    tmpTransaction := ThisWork.GetCurrTransaction;
    tmpTransaction.Init;
    tmpTransaction.IsWorking := True;
    TimerDoTransaction.Enabled := True;
    TimerWork.Enabled := False;
  end
  else // 全部步骤已经完成
  begin
    ThisWork.RepeatCounter := ThisWork.RepeatCounter + 1;	// 执行数加 1

    if (ThisWork.RepeatCount = -1) or (ThisWork.RepeatCounter < ThisWork.RepeatCount)
    then // 循环
      ThisWork.GotoTrans(0, True)
    else // 停止工作
      ThisWork.CanWork := False;
  end;
  // 刷新工作状态显示
  FormShowWorkTransactions.ShowTransactions;
end;

procedure TFormTimers.TimerDoTransactionTimer(Sender: TObject);
var
  tmpStep, tmpTransStep: TStepInfo;
  myhwnd: HWND;
  tmpTransaction: TTransaction;
  tmpCurrMap, tmpMap: TMapInfo;
  tmpWin: TWindowInfo;
  tmpNode: TNodeInfo;
  i, tmpint: Integer;
  tmpDWORD: DWORD;
  tmpBoolean: Boolean;
  tmpStove: StoveInfo;
  tmpString: String;
  Buffer: DWORD;

  tmpPharmMap, tmpPharmName: String;
  prevMap: DWORD;
  prevX, prevY: DWORD;
  tmpHealTransaction: TTransaction;
  tmpReturnTransNum: Integer;

  setHealIter: Integer;
begin
  tmpTransaction := ThisWork.GetCurrTransaction;	// 获得当前子任务

  if (not ThisWork.CanWork) then	// 如果任务无法工作，善后处理
  begin
    tmpTransaction.IsWorking := False;
    TimerDoTransaction.Enabled := False;
    TimerWork.Enabled := True;
    exit;
  end;

  Sleep(TimeToSleep);		// 延时，由基本设置窗口决定

  if tmpTransaction.IsFinish then	// 如果子任务完成，善后
  begin
    tmpTransaction.IsWorking := False;
    tmpTransaction.State := 1;
    TimerDoTransaction.Enabled := False;
    if GetUserEnvState = UserEnvDialog then CancelNPCDialog;
    TimerWork.Enabled := True;
    exit;
  end;
	//----------------------------------------------------------------------------
  tmpStep := tmpTransaction.GetCurrStep;	// 获得当前步骤

  case tmpStep.Action of
  	//--------------------------------------------------------------------------
  	// 左键单击，选择对话框的内容
    //--------------------------------------------------------------------------
    ActLeftClick:
      begin
        if tmpStep.SubStepIndex = 0 then  // 最一开始，要按一次
        begin
          if GetUserEnvState = UserEnvDialog then // 只有在Dialog状态才能按左键
          begin
            tmpTransaction.SetOldTime;
            HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);
            if tmpWin = nil then Exit; // 没有找到
            LeftClickOnSomeWindow_Send(tmpWin.Window,
            	StrToIntDef(tmpStep.X, 0), StrToIntDef(tmpStep.Y, 0));
            tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
            Exit;
          end;
        end;
        if ((tmpStep.Z = 'BattleState') and (GetUserEnvState = UserEnvBattle))
          or ((tmpStep.Z = 'NormalState') and (GetUserEnvState = UserEnvNormal))
          or (((Pos(WideString(tmpStep.Z), GetNPCDialog) > 0) or (tmpStep.Z = '')) and (GetUserEnvState = UserEnvDialog))
        then // 满足条件，到下一步
        begin
          tmpStep.SubStepIndex := 0;
          tmpTransaction.ClearOldTime;
          tmpTransaction.GotoNextStep;
        end
        else if (tmpStep.Z = 'NormalOrBattleState') and ((GetUserEnvState = UserEnvNormal) or (GetUserEnvState = UserEnvBattle)) then
        begin
          tmpStep.SubStepIndex := 0;
          tmpTransaction.ClearOldTime;
          tmpTransaction.GotoNextStep;
        end
        else if GetUserEnvState=UserEnvDialog then // 只有在Dialog状态才能按左键
        begin
          if not tmpTransaction.HasPassedInterval(5000) then exit;
          tmpTransaction.SetOldTime;
          HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);
          if tmpWin = nil then Exit; // 没有找到
          LeftClickOnSomeWindow_Send(tmpWin.Window,
            StrToIntDef(tmpStep.X, 0), StrToIntDef(tmpStep.Y, 0));
        end;
      end;
  	//--------------------------------------------------------------------------
		// 右键单击
  	//--------------------------------------------------------------------------
    ActRightClick:
      begin
        if tmpStep.SubStepIndex = 0 then  // 最一开始，要按一次
        begin
          if GetUserEnvState = UserEnvDialog then
          begin	// 如果是NPC对话状态，取消对话
            CancelNPCDialog;
          end
          else if GetUserEnvState = UserEnvNormal then
          begin	// 如果是普通状态，记录当前时间，在指定位置点击右键，并进入下一步。
            tmpTransaction.SetOldTime;
            HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);
            if tmpWin = nil then exit; // 没有找到

            RightClickOnSomeWindow_Send(tmpWin.Window, StrToIntDef(tmpStep.X, 0), StrToIntDef(tmpStep.Y, 0));
            tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
          end
          else if (GetUserEnvState = UserEnvBattle) and (tmpStep.Z = 'NormalOrBattleState') then
          begin
            tmpStep.SubStepIndex := 0;
    	      tmpTransaction.ClearOldTime;
      	    tmpTransaction.GotoNextStep;
          end;
          exit;
        end;

        case GetUserEnvState of	// 判断当前状态
        UserEnvDialog:		// 对话状态
        	if (Pos(WideString(tmpStep.Z), GetNPCDialog) > 0) or (tmpStep.Z = '') then
	        begin	// 符合指定对话
  	        tmpStep.SubStepIndex := 0;
    	      tmpTransaction.ClearOldTime;
      	    tmpTransaction.GotoNextStep;
        	end
          else begin	// 不符合指定对话------------------ 0.90 add
        		tmpTransaction.Init;
        		TimerDoTransaction.Enabled := False;
        		TimerWork.Enabled := True;
        		tmpTransaction.State := 1;
        		if GetUserEnvState = UserEnvDialog then CancelNPCDialog;

          	ThisWork.GotoTrans(0, True);
        		FormShowWorkTransactions.ShowTransactions;
          end;
        UserEnvNormal: // 只有在Normal状态才能按右键
	        begin
            if (tmpStep.Z = 'NormalState') or (tmpStep.Z = 'NormalOrBattleState') then
            begin
              tmpStep.SubStepIndex := 0;
              tmpTransaction.ClearOldTime;
              tmpTransaction.GotoNextStep;
            end;
  	        if not tmpTransaction.HasPassedInterval(5000) then exit;
    	      tmpTransaction.SetOldTime;
            HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);
      	    if tmpWin = nil then Exit; // 没有找到
        	  RightClickOnSomeWindow_Send(tmpWin.Window, StrToIntDef(tmpStep.X, 0), StrToIntDef(tmpStep.Y, 0));
	        end;
        UserEnvBattle:
          begin
            if (tmpStep.Z = 'BattleState') or (tmpStep.Z = 'NormalOrBattleState') then
            begin
              tmpStep.SubStepIndex := 0;
              tmpTransaction.ClearOldTime;
              tmpTransaction.GotoNextStep;
            end;
            if not tmpTransaction.HasPassedInterval(5000) then exit;
    	      tmpTransaction.SetOldTime;
            HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);
      	    if tmpWin = nil then Exit; // 没有找到
        	  RightClickOnSomeWindow_Send(tmpWin.Window, StrToIntDef(tmpStep.X, 0), StrToIntDef(tmpStep.Y, 0));
          end;
        end;
      end;
  	//--------------------------------------------------------------------------
  	// 移动位置：移动到地图内的某个坐标
    //--------------------------------------------------------------------------
    ActMoveToPos:
      begin
        if GetUserEnvState = UserEnvBattle then
        begin
          tmpTransaction.GotoNextStep;
          exit;
        end;

        //check current pos?
        GetCurrPosXY(prevX,prevY);
        if (prevX <> StrToInt(tmpStep.X)) or (prevY <> StrToInt(tmpStep.Y)) then
        begin
          tmpTransaction.PosX := StrToInt(tmpStep.X);
          tmpTransaction.PosY := StrToInt(tmpStep.Y);
          MoveToHL_Pos(tmpTransaction.PosX, tmpTransaction.PosY, true); // 移动到指定坐标点
          Sleep(200);
        end
        else
        begin
          tmpTransaction.GotoNextStep;	// 时间延迟
        end;
      end;
  	//--------------------------------------------------------------------------
		// 来到地图：瞬移到某个地图：X-地图的ID
  	//--------------------------------------------------------------------------
    ActGoToMap:
      begin
        tmpDWORD := ReadCurrMapID;	// 获得当前地图标识

        if tmpDWORD = 0 then Exit;	// 正在切换地图中

        tmpCurrMap := GameMaps.ItemOfMapID(tmpDWORD);	// 获取当前地图信息
        if tmpCurrMap = nil then
        begin
          ThisWork.CanWork := False;
          ShowMessage('Unable to find map: ');
          Exit;
        end;

        tmpMap := GameMaps.ItemOfMapID(StrToIntDef(tmpStep.X, 0));	// 获取目的地图信息
        if tmpMap = tmpCurrMap then // 已经瞬移到了
        begin
          tmpStep.SubStepIndex := 0;
          ThisMove.Free;
          ThisMove := Nil;
          tmpTransaction.GotoNextStep;
          Exit;
        end;

        case tmpStep.SubStepIndex of
          0:	// Initialize, find path
            begin
              ThisMove.Free;
              ThisMove := TMove.Create;
              if not ThisMove.Init(tmpCurrMap.PosInMapList, tmpMap.PosInMapList) then
              begin
                ThisMove.Free;
                ThisMove := Nil;
                ThisWork.CanWork := False;
                ShowMessage('No path found, movement canceled');
                Exit;
              end;

              tmpTransaction.ClearOldTime;
              tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
            end;
          1:
            begin
            	// 路径走完，退出
              if ThisMove.GetCurrPathNodeIndex = ThisMove.PathNodeCount then Exit;
              // 获得当前路径节点
              tmpNode := ThisMove.GetCurrPathNode;
              // 如果当前地图 = 路径节点出口一致，跳至下一路径节点，并退出。
              if tmpCurrMap.ID = tmpNode.OutMapID then
              begin
                tmpTransaction.ClearOldTime;
                ThisMove.GotoNextPathNode;
                Exit;
              end;

              if tmpNode.InHL_X <> -1 then  // 普通移动
              begin
                if not tmpTransaction.HasPassedInterval(5000) then Exit;
                tmpTransaction.SetOldTime;
                MoveToHL_Pos(tmpNode.InHL_X, tmpNode.InHL_Y, false);	// 移动到指定坐标点
              end
              else // 要做Trans
              begin
                ThisTrans := GameMaps.TransportList.ItemOfTransportID(tmpNode.InHL_Y);	// 返回指定标识的传送点信息
                ThisTrans.StepIndex := 0;
                ThisTrans.OldNPCDialog := GetNPCDialog;	// 返回NPC对话信息
                tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
              end;
            end;
          2: // 这个是专门给Tran做的，发出动作
            begin
              If ThisTrans.StepIndex = ThisTrans.Count then // Trans的步骤已经做完
              begin
                if GetUserEnvState = UserEnvDialog then // 还有残余对话框
                begin
                  CancelNPCDialog;
                end
                else // 已经没有残余对话框了
                begin
                  tmpNode := ThisMove.GetCurrPathNode;
                  if tmpCurrMap.ID = tmpNode.OutMapID then
                  begin
                    tmpTransaction.ClearOldTime;
                    ThisMove.GotoNextPathNode;
                    tmpStep.SubStepIndex := 1;
                    Exit;
                  end;
                end;
                Exit;
              end;

              tmpTransStep := ThisTrans.Items[ThisTrans.StepIndex];
              case tmpTransStep.Action of
                0: // Left-Click
                  begin
                    if GetUserEnvState = UserEnvDialog then // 必须得是对话框情况下才能按左键
                    begin
                      tmpTransaction.SetOldTime;
                      tmpTransaction.OldNPCDialog := GetNPCDialog;
                      HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);
                      if tmpWin = nil then Exit; // 没有找到;
                      myhwnd := tmpWin.Window;
                      EnableWindow(myhwnd, False);
                      Sleep(100);
                      LeftClickOnSomeWindow_Send(myhwnd, StrToIntDef(tmpTransStep.X, 0) + PlayLeftJust, StrToIntDef(tmpTransStep.Y, 0)+ PlayTopJust);
                      Sleep(100);
                      EnableWindow(myhwnd, True);
                      tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
                    end else begin
//                      ThisTrans.StepIndex := 0;
                    end;
                  end;
                1: // Right-Click
                  begin
                    if GetUserEnvState = UserEnvNormal then // Must be in normal state to right-click
                    begin
                      tmpTransaction.SetOldTime;
                      tmpTransaction.OldNPCDialog := GetNPCDialog;
                      HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);
                      if tmpWin = nil then Exit;
                      myhwnd := tmpWin.Window;

                      EnableWindow(myhwnd, False);
                      Sleep(100);
                      RightClickOnSomeWindow_Send(myhwnd, StrToIntDef(tmpTransStep.X, 0) + PlayLeftJust, StrToIntDef(tmpTransStep.Y, 0) + PlayTopJust);
                      Sleep(100);
                      EnableWindow(myhwnd, True);
                      tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
                    end else begin
                    	// If the network delay fails because it is judged whether or not the previous step is completed
                      // The NPC dialog may have been called out here (exception handling)
    									CancelNPCDialog;	// 取消对话
                      ThisTrans.StepIndex := 0;
                    end;
                  end;
                10: // Trigger Movement
                  begin
                    MoveToHL_Pos(StrToIntDef(tmpTransStep.X, 0), StrToIntDef(tmpTransStep.Y, 0), false);
                    ThisTrans.StepIndex := ThisTrans.StepIndex + 1;
                  end;
              end;
            end;
          3: // 也是专门给Trans用的，检测是否完成了Trans中的一个Step
            begin
              if tmpTransaction.OldNPCDialog <> GetNPCDialog then // 切换了对话框
              begin
                tmpTransaction.OldNPCDialog := GetNPCDialog;
                tmpStep.SubStepIndex := 2;
                ThisTrans.StepIndex := ThisTrans.StepIndex + 1;
              end
              else // 等待超时，然后回去重做
              begin
                if not tmpTransaction.HasPassedInterval(5000) then Exit;
                tmpStep.SubStepIndex := 2;
              end;
            end;
        end;
      end;
  	//--------------------------------------------------------------------------
  	// Battle
    //--------------------------------------------------------------------------
    ActInBattle:
      case tmpStep.SubStepIndex of
        0:
          begin
            if GetUserEnvState<>UserEnvBattle then Exit;

            ThisBattle.Free;
            ThisBattle:=TBattle.Create;
            case FormGeneralSet.RadioGroupHumanAct.ItemIndex of
              0: ThisBattle.OrderHumanAction:=BattleAttack;
              1: ThisBattle.OrderHumanAction:=BattleDefence;
              2: ThisBattle.OrderHumanAction:=BattleCapture;
            end;
            case FormGeneralSet.RadioGroupPetAct.ItemIndex of
              0: ThisBattle.OrderPetAction:=BattleAttack;
              1: ThisBattle.OrderPetAction:=BattleDefence;
            end;
            case FormGeneralSet.RadioGroupWhatToDoWhenNoMonsterToCapture.ItemIndex of
              0: ThisBattle.EscapeWhenNoMonsterToCapture:=False;
              1: ThisBattle.EscapeWhenNoMonsterToCapture:=True;
            end;

            ThisBattle.MonsterNameToCapture:=FormMain.EditMonsterToCapture.Text;
            ThisBattle.CaptureLevelFrom:=StrToInt(FormMain.EditCaptureLevelFrom.Text);
            ThisBattle.CaptureLevelTo:=StrToInt(FormMain.EditCaptureLevelTo.Text);

            tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1;
          end;
        1:
          begin
            tmpint:=GetUserEnvState;
            if ((tmpStep.Y='Dialogue') and (tmpint=UserEnvDialog) and (Pos(WideString(tmpStep.Z), GetNPCDialog)>0)) // 战斗后应当是对话状态
              or ((tmpStep.Y='Ordinary') and (tmpint=UserEnvNormal)) // 战斗后应当是普通状态
            then
            begin
              if ThisBattle.HasBegin // 已经开始过，说明是战斗完毕了
              then
              begin
                ThisBattle.Free;
                ThisBattle:=Nil;

                if tmpStep.X='Ordinary' then // End of battle
                begin
                  tmpStep.SubStepIndex:=0;
                  tmpTransaction.GotoNextStep;
                  FormMain.UpdateMarchingPetInfo;
                end
                else if tmpStep.X='Overjob' then
                begin
                  ThisUser.GetAttr;
                  if (ThisUser.Level div 100)*100=ThisUser.Level then // User official upgrade?
                  begin // End of battle
                    tmpStep.SubStepIndex:=0;
                    tmpTransaction.GotoNextStep;
                    FormMain.UpdateMarchingPetInfo;
                  end
                  else if ((ThisUser.Level div 100)*100<>ThisUser.Level) and (((ThisUser.Level+1) div 100)*100 <> ThisUser.Level+1)
                  then // The robery failed and the battle ended
                  begin
                    ThisWork.CanWork:=False;
                    tmpStep.SubStepIndex:=0;
                    ShowMessage('Failure to rob, stop working');
                  end;
                end;
              end;
            end
            else if tmpint=UserEnvBattle then // 正在战斗
            begin
              FormShowPets.ShowPets;
              ThisBattle.DoBattle;
              ThisBattle.HasBegin:=True;
            end;
          end;
      end;
  	//--------------------------------------------------------------------------
		// 购买物品
  	//--------------------------------------------------------------------------
    ActBuyStuff:
      begin
        FormShowStuffs.ShowStuffs;

        if tmpStep.SubStepIndex=0 then
        begin
          ThisBuyStuff.Free;
          ThisBuyStuff:=TBuyStuff.Create;
          ThisBuyStuff.PatchShop;

          if not ThisBuyStuff.InitShop then Exit;

          if tmpStep.Z='' then
            ThisBuyStuff.WriteStuffInfo(tmpStep.X, tmpStep.Y, 1000)
          else
            ThisBuyStuff.WriteStuffInfo(tmpStep.X, tmpStep.Y, strtointdef(tmpStep.Z, 0));
          ThisBuyStuff.GetAllStuffCount;
          tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1;
        end;

        if ThisBuyStuff.IsSatisfied then // 不用再买了
        begin
          ThisBuyStuff.UnPatchShop;
          ThisBuyStuff.Free;
          ThisBuyStuff:=Nil;


          tmpStep.SubStepIndex:=0;
          tmpTransaction.ClearOldTime;
          tmpTransaction.GotoNextStep;
          Exit;
        end;

        case tmpStep.SubStepIndex of
          1:
            begin
              ThisBuyStuff.GetAllStuffCount;
              tmpTransaction.SetOldTime;
              if ThisBuyStuff.DoBuyStuff then tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1;
            end;
          2:
            begin
              if ThisBuyStuff.HasBoughtStuff then // 买到了药
              begin
                tmpStep.SubStepIndex:=1;
              end
              else // 还没有得到药
              begin
                if not tmpTransaction.HasPassedInterval(5000) then Exit; // 如果还没有到5秒，就等等
                // 现在，过了5秒，还没有得到药，说明不会再得到了，所以就得重买
                tmpStep.SubStepIndex:=1;
              end;
            end;
        end;
      end;
  	//--------------------------------------------------------------------------
		// 开物品栏
  	//--------------------------------------------------------------------------
    ActOpenItemWindow:
      begin
        tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Item/Equipment');
        if tmpWin = nil then // 没有找到物品/装备窗口
        begin
          for i := 0 to HLInfoList.GlobalHL.Count-1 do
          begin
            tmpWin := HLInfoList.GlobalHL.Items[i];
            if tmpWin.ClassName = 'TPUtilWindow' then
              PostMessage(tmpWin.Window, WM_COMMAND, IDM_Item, 0);
          end;
        end
        else
        begin
          if IsWindowEnabled(tmpWin.Window) then EnableWindow(tmpWin.Window, False);
          if IsWindowVisible(tmpWin.Window) then ShowWindow(tmpWin.Window, SW_HIDE);

          tmpTransaction.GotoNextStep;
        end;
      end;
  	//--------------------------------------------------------------------------
		// 关物品栏
  	//--------------------------------------------------------------------------
    ActCloseItemWindow:
      begin
        tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Item/Equipment');
        if tmpWin=Nil then
        begin
          tmpTransaction.GotoNextStep;
        end
        else
        begin
          Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
        end;
      end;
  	//--------------------------------------------------------------------------
		// 使用物品
  	//--------------------------------------------------------------------------
    ActUseItem:
      begin
        FormShowStuffs.ShowStuffs;

        if tmpStep.SubStepIndex=0 then
        begin
          ThisUser.OldItemID:=ThisUser.FindItemID(tmpStep.X, tmpStep.Y);
          tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1;
        end;

        case tmpStep.SubStepIndex of
          1:
            begin
              tmpTransaction.SetOldTime;
              if ThisUser.UseItem(ThisUser.OldItemID) then
                tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1
              else
              begin
                ThisWork.CanWork:=False;
                tmpStep.SubStepIndex:=0;
                ShowMessage('Unable to use item: '+tmpStep.X+','+tmpStep.Y+'['+IntToHex(ThisUser.OldItemID, 8)+']');
                Exit;
              end;
            end;
          2:
            begin
              if (ThisUser.FindItemPosByID(ThisUser.OldItemID)=0) or (tmpStep.Z = 'Skip') then // 已经完成使用物品
              begin
                tmpStep.SubStepIndex:=0;
                tmpTransaction.ClearOldTime;
                tmpTransaction.GotoNextStep;
                Exit;
              end
              else // 还没有完成使用物品
              begin
                if not tmpTransaction.HasPassedInterval(5000) then Exit; // 如果还没有到5秒，就等等
                // 现在，过了5秒，还没有完成，说明不会再完成，所以就得重使用
                tmpStep.SubStepIndex:=1;
              end;
            end;
        end;
      end;
    ActDropItem:
      begin
        FormShowStuffs.ShowStuffs;

        if tmpStep.SubStepIndex=0 then
        begin
          //ThisUser.OldItemID:=ThisUser.FindItemID(tmpStep.X, tmpStep.Y);
          ThisUser.OldItemCount := ThisUser.FindItemCount(tmpStep.X, tmpStep.Y);
          tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1;
        end;

        case tmpStep.SubStepIndex of
          1:
            begin
              tmpTransaction.SetOldTime;
              if ThisUser.DropItem(ThisUser.FindItemID(tmpStep.X, tmpStep.Y)) then
                tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1
              else
              begin //Item not owned
                tmpStep.SubStepIndex:=0;
                tmpTransaction.ClearOldTime;
                tmpTransaction.GotoNextStep;
                Exit;
              end;
            end;
          2:
            begin
              tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Are you sure?');
              if tmpWin = nil then Exit;

              myhwnd := HLInfoList.GlobalHL.
              LocateChildWindowWNDByTitle(tmpWin.Window, 'OK(&O)', True);
              PostMessage(myhwnd, WM_LBUTTONDOWN, MK_LBUTTON, 0);
              PostMessage(myhwnd, WM_LBUTTONUP, 0, 0);

              tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1
            end;
          3:
            begin
              ThisUser.OldItemID := ThisUser.FindItemID(tmpStep.X, tmpStep.Y);
              if (ThisUser.OldItemID=0)
                or ((StrToIntDef(tmpStep.Z, 0) > 0)
                and (StrToIntDef(tmpStep.Z, 0) <= (ThisUser.OldItemCount - ThisUser.FindItemCount(tmpStep.X, tmpStep.Y)))) then
              begin
                tmpStep.SubStepIndex:=0;
                tmpTransaction.ClearOldTime;
                tmpTransaction.GotoNextStep;
                Exit;
              end
              else // 还没有完成使用物品
              begin
                if not tmpTransaction.HasPassedInterval(5000) then Exit; // 如果还没有到5秒，就等等
                // 现在，过了5秒，还没有完成，说明不会再完成，所以就得重使用
                tmpStep.SubStepIndex:=1;
              end;
            end;
        end;
      end;
  	//--------------------------------------------------------------------------
		// 离开商店
  	//--------------------------------------------------------------------------
    ActQuitShop:
      begin
        tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Monster&Me - Store');
        if tmpWin = nil then
        begin
          tmpTransaction.GotoNextStep;
        end
        else
        begin
          Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
        end;
      end;
  	//--------------------------------------------------------------------------
		// 点击按钮
  	//--------------------------------------------------------------------------
    ActPressButton:
      begin
        if tmpStep.Z <> '' then tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(tmpStep.Z);
        if (tmpStep.Z <> '') and (tmpWin<>Nil) then
        begin
          tmpTransaction.GotoNextStep;
        end
        else
        begin
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(tmpStep.Y);
          if tmpWin=Nil then Exit;
          myhwnd := HLInfoList.GlobalHL.
            LocateChildWindowWNDByTitle(tmpWin.Window, tmpStep.X, True);
          PostMessage(myhwnd, WM_LBUTTONDOWN, MK_LBUTTON, 0);
          PostMessage(myhwnd, WM_LBUTTONUP, 0, 0);
          if tmpStep.Z = '' then
          begin
            tmpTransaction.GotoNextStep;
          end
        end;
      end;
  	//--------------------------------------------------------------------------
		// Wuxing
  	//--------------------------------------------------------------------------
    ActDoForge:
      case tmpStep.SubStepIndex of
        0: // Init
          begin
            ThisUser.GetItems;
            if ThisUser.ItemCount >= 15 then
            begin
              ThisWork.CanWork:=False;
              ShowMessage('Your inventory is full! Unable to wux.');
              Exit;
            end;

            tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Wuxing Oven');
            if tmpWin=Nil then // Did not find the wuxing oven
            begin
              for i := 0 to HLInfoList.GlobalHL.Count - 1 do
              begin
                tmpWin := HLInfoList.GlobalHL.Items[i];
                if tmpWin.ClassName = 'TPUtilWindow' then
                  PostMessage(tmpWin.Window, WM_COMMAND, IDM_UniverseStove, 0);
              end;
              Exit;
            end
            else
            begin
              if IsWindowEnabled(tmpWin.Window) then
                EnableWindow(tmpWin.Window, False);
              if IsWindowVisible(tmpWin.Window) then
                ShowWindow(tmpWin.Window, SW_HIDE);
            end;

            ThisForge.Free;
            ThisForge := TForge.Create;
            ThisForge.PatchUniverseStove;
            
            ThisForge.Init;

            tmpStep.SubStepIndex := tmpStep.SubStepIndex+1;
          end;
        1: // Handle Wuxing
          begin
            tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Wuxing Oven');
            if tmpWin = nil then Exit;
            myhwnd := HLInfoList.GlobalHL.
              LocateChildWindowWNDByTitle(tmpWin.Window, 'Start', True);
            if myhwnd = 0 then Exit;

            FormShowStuffs.ShowStuffs;
            FormShowUniverseStove.ShowUniverseStove;

            tmpint := Round((GetTime - FForgeOldTime) * 24 * 3600 * 1000);
            tmpint := FormShowUniverseStove.TrackBarForgeDelay.Position - tmpint;  // Elapsed time and rated dif
            if tmpint > 0 then
            begin
              FormShowUniverseStove.LabelAnimator.Caption :=
                'Delay ' + Format('%d', [tmpint]) + 'MS';
              Exit;
            end;

            tmpStove := ThisForge.GetCurrStove;

            ThisForge.InitStoveStuffsToBeChozen;
            tmpStove.tmpID1 := 0;
            tmpStove.tmpID2 := 0;

            For i := 0 to 7 do
            begin
              tmpStove.Rooms[i].Stuff.StuffID := 0;
              tmpStove.Rooms[i].Stuff.StuffAttr := $4d2;
            end;

            if not ThisForge.FillStove then Exit; // Items do not meet refining condition

            ThisForge.WriteStoveInstruction;
            SendMessage(myhwnd, WM_LBUTTONDOWN, MK_LBUTTON, 0);
            SendMessage(myhwnd, WM_LBUTTONUP, 0, 0);
            FForgeOldTime := GetTime;
            tmpStep.SubStepIndex:=tmpStep.SubStepIndex+1;
          end;
        2: // Cleanup
          begin
            FormShowStuffs.ShowStuffs;
            FormShowUniverseStove.ShowUniverseStove;
            FormShowUniverseStove.LabelAnimator.Caption := '炼化中..';

            if ThisForge.HasCurrStoveFinished then
            begin
              FormShowUniverseStove.LabelAnimator.Caption := '炼化完成';
              ThisForge.GotoNextStove;

              if ThisForge.IsFinish then
              begin // 完成了
                ThisForge.Clean;
                tmpStep.SubStepIndex:=0;

                ThisForge.UnPatchUniverseStove;
                ThisForge.Free;
                ThisForge:=Nil;

                tmpTransaction.GotoNextStep;
              end
              else tmpStep.SubStepIndex:=1;
            end;
          end;
      end;
  	//--------------------------------------------------------------------------
		// 呼叫 NPC
  	//--------------------------------------------------------------------------
    ActCallNPC:
      case tmpStep.SubStepIndex of
        0: // 找到NPC并开始呼叫
          begin
            for i := 0 to Ord(High(TNPCID)) do
            begin
              if NPCs[i].Name = tmpStep.X then 	// 比较 NPC 名字
              begin
                tmpStep.CalledNPCID := TNPCID(i);// NPCIDsArray[i];
                BeginCallNPC(tmpStep.CalledNPCID);
                tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
                Exit;
              end;
            end;
          end;
        1: // 等待 SatisfiedCond，结束呼叫NPC
          begin
            tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(
              NPCs[Ord(tmpStep.CalledNPCID)].SatisfiedCond);
            if tmpWin <> Nil then
            begin
              EndCallNPC;
              tmpStep.SubStepIndex := 0;
              tmpTransaction.GotoNextStep;
            end;
          end;
      end;
  	//--------------------------------------------------------------------------
		// 停止工作
  	//--------------------------------------------------------------------------
    ActTerminate:
      begin
        tmpTransaction.State := 1; // 无论如何，这个大步骤都算完成了
        ThisWork.CanWork := False;
        ShowMessage('Script stopped: ' + tmpStep.X);
      end;
  	//--------------------------------------------------------------------------
		// 拥有物品：等待满足此物品，达到指定数量级
  	//--------------------------------------------------------------------------
    ActHaveStuff: // 等待满足此物品
      begin
        if
          StrToIntDef(tmpStep.Z, 0) <= ThisUser.FindItemCount(tmpStep.X, tmpStep.Y)
        then
          tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 物品数目：等待满足此物品，等于指定数量级
  	//--------------------------------------------------------------------------
    ActStuffNum: // 与ActHaveStuff不同的是，严格限制物品数目
      begin
        if
          StrToIntDef(tmpStep.Z, 0) = ThisUser.FindItemCount(tmpStep.X, tmpStep.Y)
        then tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 跳至步骤 N
  	//--------------------------------------------------------------------------
    ActJumpToTransN:
      begin
        tmpTransaction.Init;
        TimerDoTransaction.Enabled := False;
        TimerWork.Enabled := True;
        tmpTransaction.State := 1;
        if GetUserEnvState = UserEnvDialog then CancelNPCDialog;

        ThisWork.GotoTrans(StrToIntDef(tmpStep.X, 0), True);
        FormShowWorkTransactions.ShowTransactions;

        if tmpHealTransaction <> nil then
        begin
          ThisWork.DeleteTransaction(ThisWork.GetSize() - 1);
          tmpHealTransaction := nil;
        end;
      end;
  	//--------------------------------------------------------------------------
		// 拥有宠物：等待满足此宠物，达到指定数量级
  	//--------------------------------------------------------------------------
    ActHavePet: // 等待满足此宠物
      begin
        if
          StrToIntDef(tmpStep.Z, 0) <= ThisUser.FindPetCount(tmpStep.X, StrToIntDef(tmpStep.Y, 0))
        then
          tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 宠物数目：等待满足此宠物，等于指定数量级
  	//--------------------------------------------------------------------------
    ActPetNum: // 与ActHavePet不同的是，严格限制宠物数目
      begin
        if
          StrToIntDef(tmpStep.Z, 0) = ThisUser.FindPetCount(tmpStep.X, StrToIntDef(tmpStep.Y,0))
        then
          tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 取消对话
  	//--------------------------------------------------------------------------
    ActCancelNPCDialog:
      begin
        CancelNPCDialog;
        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 等待延时
  	//--------------------------------------------------------------------------
    ActDelay:
      case tmpStep.SubStepIndex of
        0:
          begin
            tmpTransaction.SetOldTime;
            tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
          end;
        1:
          begin
            if not tmpTransaction.HasPassedInterval(StrToIntDef(tmpStep.X, 0)) then Exit;
            tmpTransaction.ClearOldTime;
            tmpStep.SubStepIndex := 0;
            tmpTransaction.GotoNextStep;
          end;
      end;
  	//--------------------------------------------------------------------------
		// 进入战斗
  	//--------------------------------------------------------------------------
    ActActiveBattle:
      case tmpStep.SubStepIndex of
        0:
          begin
            //Initialize battle
            FormMain.UpdateMarchingPetInfo;
            if (tmpStep.X = 'Atk') or (tmpStep.X = 'Attack') then FormGeneralSet.RadioGroupHumanAct.ItemIndex := 0
            else if (tmpStep.X = 'Def') or (tmpStep.X = 'Defend') then FormGeneralSet.RadioGroupHumanAct.ItemIndex := 1
            else if (tmpStep.X = 'Capture') then FormGeneralSet.RadioGroupHumanAct.ItemIndex := 2;

            if (tmpStep.Y = 'Atk') or (tmpStep.Y = 'Attack') then FormGeneralSet.RadioGroupPetAct.ItemIndex := 0
            else if (tmpStep.Y = 'Def') or (tmpStep.Y = 'Defend') then FormGeneralSet.RadioGroupPetAct.ItemIndex := 1;

            if tmpStep.Z = 'Fight' then FormGeneralSet.RadioGroupWhatToDoWhenNoMonsterToCapture.ItemIndex := 0
            else if tmpStep.Z = 'Run' then FormGeneralSet.RadioGroupWhatToDoWhenNoMonsterToCapture.ItemIndex := 1;

            //Verify healing settings
            if not FormGeneralSet.CheckBoxNoHeal.Checked then
            begin
              if ThisUser.FindLifeItem() = 0 then
              begin
                if ThisUser.ItemCount = 16 then
                begin
                  //end here, inventory is full
                  tmpTransaction.State := 1; // 无论如何，这个大步骤都算完成了
                  ThisWork.CanWork := False;
                  ShowMessage('Script Aborted, Battle Failed, Inventory Full');
                end
                else
                begin
                  //insert healing steps
                  tmpReturnTransNum := ThisWork.FTransactionIndex;
                  tmpHealTransaction := ThisWork.AddTransaction('Get Potions');
                  if FormGeneralSet.cmbStore.Text = 'WaterCity Pharmacy' then tmpPharmMap := '100000';
                  if FormGeneralSet.cmbStore.Text = 'TreeCity Pharmacy' then tmpPharmMap := '100006';
                  if FormGeneralSet.cmbStore.Text = 'HillCity Pharmacy' then tmpPharmMap := '100059';
                  if FormGeneralSet.cmbStore.Text = 'SandCity Pharmacy' then tmpPharmMap := '200000';
                  if FormGeneralSet.cmbStore.Text = 'SnowCity Pharmacy' then tmpPharmMap := '300000';
                  if FormGeneralSet.cmbStore.Text = 'OceanCity Pharmacy' then tmpPharmMap := '400000';
                  if FormGeneralSet.cmbStore.Text = 'NewHillCity Pharmacy' then tmpPharmMap := '100099';

                  tmpHealTransaction.AddStep(ActGotoMap,tmpPharmMap,'','');
                  tmpHealTransaction.AddStep(ActCallNPC,FormGeneralSet.cmbStore.Text,'','');
                  tmpHealTransaction.AddStep(ActBuyStuff,FormGeneralSet.ComboBoxMed.Text,'TQ-Anonym','');
                  tmpHealTransaction.AddStep(ActQuitShop,'','','');

                  //return to previous
                  prevMap := ReadCurrMapID();
                  GetCurrPosXY(prevX, prevY);
                  tmpHealTransaction.AddStep(ActGotoMap,IntToStr(prevMap),'','');
                  tmpHealTransaction.AddStep(ActMoveToPos,IntToStr(prevX),IntToStr(prevY),'');
                  tmpHealTransaction.AddStep(ActJumpToTransN,IntToStr(tmpReturnTransNum),'','');
                  ThisWork.FTransactionIndex := ThisWork.GetSize() - 1;
                end;
              end;
            end;

            tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
          end;
        1:
          begin
            //Initiate Battle
            if GetUserEnvState <> UserEnvBattle then
            begin
              for i := 0 to HLInfoList.GlobalHL.Count - 1 do
              begin
                tmpWin := HLInfoList.GlobalHL.Items[i];
                if tmpWin.ClassName = 'TPUtilWindow' then
                  SendMessage(tmpWin.Window, WM_COMMAND, IDM_Battle, 0);
              end;
            end;

            tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
          end;
        2:
          begin
            if GetUserEnvState = UserEnvBattle then
            begin
              tmpStep.SubStepIndex := 0;
              tmpTransaction.GotoNextStep;
            end;
          end;
      end;
  	//--------------------------------------------------------------------------
		// 捉宠设置
  	//--------------------------------------------------------------------------
    ActSetCapture:
      begin
        FormMain.EditMonsterToCapture.Text := tmpStep.X;
        FormMain.EditCaptureLevelFrom.Text := IntToStr(StrToIntDef(tmpStep.Y, 0));
        FormMain.EditCaptureLevelTo.Text := IntToStr(StrToIntDef(tmpStep.Z, 0));
        tmpTransaction.GotoNextStep;
      end;

    ActSetHeal:
      begin
        if tmpStep.X = 'Store' then
        begin
          for setHealIter := 0 to FormGeneralSet.cmbStore.Items.Count do
          begin
            if FormGeneralSet.cmbStore.Items[setHealIter] = tmpStep.Y then
            begin
              FormGeneralSet.cmbStore.ItemIndex := setHealIter;
              FormGeneralSet.cmbStoreChange(FormGeneralSet.cmbStore); // sarah: refresh medicine list when store is changed
              Break;
            end;
          end;
        end;

        if tmpStep.X = 'Medicine' then
        begin
          for setHealIter := 0 to FormGeneralSet.ComboBoxMed.Items.Count do
          begin
            if FormGeneralSet.ComboBoxMed.Items[setHealIter] = tmpStep.Y then
            begin
              FormGeneralSet.ComboBoxMed.ItemIndex := setHealIter;
              Break;
            end;
          end;
        end;

        if tmpStep.X = 'Level' then
        begin
          if tmpStep.Y = 'True' then
          begin
            FormGeneralSet.CheckBoxFullBlood.Checked := true;
          end;
          if tmpStep.Y = 'False' then
          begin
            FormGeneralSet.CheckBoxFullBlood.Checked := false;
          end;
        end;

        if tmpStep.X = 'Disable' then
        begin
          if tmpStep.Y = 'True' then
          begin
            FormGeneralSet.CheckBoxNoHeal.Checked := true;
          end;
          if tmpStep.Y = 'False' then
          begin
            FormGeneralSet.CheckBoxNoHeal.Checked := false;
          end;
        end;

        if tmpStep.X = 'Player' then
        begin
          FormGeneralSet.EditPlayerLife.Text := tmpStep.Y;
        end;
        if tmpStep.X = 'Pet' then
        begin
          FormGeneralSet.EditPetLife.Text := tmpStep.Y;
        end;

        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 定位窗口
  	//--------------------------------------------------------------------------
    ActLocateWindow:
      begin
        tmpStep.X := StringReplace(tmpStep.X, '[username]', HLInfoList.GlobalHL.UserName, [rfReplaceAll, rfIgnoreCase]);
        tmpStep.Y := StringReplace(tmpStep.Y, '[username]', HLInfoList.GlobalHL.UserName, [rfReplaceAll, rfIgnoreCase]);
        if tmpStep.Y = '' then myhwnd := 0 // 没有父窗口
        else
        begin
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(tmpStep.Y);
          if tmpWin = Nil then
          begin
            ThisWork.CanWork := False;
            ShowMessage('Parent Window not found：' + tmpStep.Y + '，script stopped.');
            Exit;
          end
          else myhwnd := tmpWin.Window;
        end;

        if tmpStep.Z = 'Indirect' then tmpBoolean := False
        else tmpBoolean := True;
        myhwnd := HLInfoList.GlobalHL.
          LocateChildWindowWNDByTitle(myhwnd, tmpStep.X, tmpBoolean);
        if myhwnd = 0 then
        begin
          ThisWork.CanWork := False;
          ShowMessage('Window not found：' + tmpStep.Y + '，script stopped.');
          Exit;
        end;

        FLocateHwnd := myhwnd; // 保护窗口句柄
        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 窗口单击
  	//--------------------------------------------------------------------------
    ActWinLeftClick:
      begin
        tmpStep.X := StringReplace(tmpStep.X, '[username]', HLInfoList.GlobalHL.UserName, [rfReplaceAll, rfIgnoreCase]);
        if tmpStep.X <> '※' then
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(tmpStep.X)
        else  // 使用“定位窗口”中的窗口句柄
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowID(FLocateHwnd);
        if tmpWin = nil then Exit;
        myhwnd := tmpWin.Window;

        LeftClickOnSomeWindow_Post(myhwnd,
          StrToIntDef(tmpStep.Y, 0), StrToIntDef(tmpStep.Z, 0));
        Sleep(200);
        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 窗口双击
  	//--------------------------------------------------------------------------
    ActWinLeftDblClick:
      begin
        tmpStep.X := StringReplace(tmpStep.X, '[username]', HLInfoList.GlobalHL.UserName, [rfReplaceAll, rfIgnoreCase]);
        if tmpStep.X <> '※' then
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(tmpStep.X)
        else  // 使用“定位窗口”中的窗口句柄
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowID(FLocateHwnd);
        if tmpWin = nil then Exit;
        myhwnd := tmpWin.Window;

        LeftDblClickOnSomeWindow_Post(myhwnd,
          StrToIntDef(tmpStep.Y, 0), StrToIntDef(tmpStep.Z, 0));
        Sleep(200);
        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 窗口右键
  	//--------------------------------------------------------------------------
    ActWinRightClick:
      begin
        tmpStep.X := StringReplace(tmpStep.X, '[username]', HLInfoList.GlobalHL.UserName, [rfReplaceAll, rfIgnoreCase]);
        if tmpStep.X <> '※' then
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(tmpStep.X)
        else  // 使用“定位窗口”中的窗口句柄
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowID(FLocateHwnd);
        if tmpWin = nil then Exit;
        myhwnd := tmpWin.Window;

        RightClickOnSomeWindow_Post(myhwnd, StrToIntDef(tmpStep.Y, 0), StrToIntDef(tmpStep.Z, 0));
        Sleep(200);
        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 等待窗口
  	//--------------------------------------------------------------------------
    ActWaitWindow:
      begin
        tmpStep.X := StringReplace(tmpStep.X, '[username]', HLInfoList.GlobalHL.UserName, [rfReplaceAll, rfIgnoreCase]);
        tmpStep.Y := StringReplace(tmpStep.Y, '[username]', HLInfoList.GlobalHL.UserName, [rfReplaceAll, rfIgnoreCase]);
        if tmpStep.Y = '' then myhwnd := 0 // 没有父窗口
        else
        begin
          tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(tmpStep.Y);
          if tmpWin = Nil then Exit // 返回，下次再来判断
          else myhwnd := tmpWin.Window;
        end;

        if tmpStep.Z = 'Indirect' then tmpBoolean := False
        else tmpBoolean := True;

        if HLInfoList.GlobalHL.
          LocateChildWindowWNDByTitle(myhwnd, tmpStep.X, tmpBoolean) = 0 then Exit;

        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// Kungfu
  	//--------------------------------------------------------------------------
    ActSetWGAttr:   // 设置武功属性（名称、内、系数等）
      begin
        ThisWGAttrs.MC := tmpStep.X;
        ThisWGAttrs.XS := tmpStep.Y;
        ThisWGAttrs.NL := tmpStep.Z;
        tmpString := CanCreateWG;
        if (tmpString <> '') and (tmpString <> 'Full') then
        begin
          ThisWGAttrs.MC := '';
          ThisWGAttrs.XS := '';
          ThisWGAttrs.NL := '';
          ThisWork.CanWork := False;
          ShowMessage(tmpString);
        end
        else tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// Kungfu Appearance
  	//--------------------------------------------------------------------------
    ActSetWGDisp:   // 显示形式
      begin
        if (StrToIntDef(tmpStep.X, -1) < 1) or (StrToIntDef(tmpStep.X, -1) > 8) then
        begin
          ShowMessage('The starting position cannot be ' + tmpStep.X);
          ThisWork.CanWork := False;
          Exit;
        end;

        if (StrToIntDef(tmpStep.Y, -1) < 1) or (StrToIntDef(tmpStep.Y, -1) > 19) then
        begin
          ShowMessage('Flight trajectory cannot be ' + tmpStep.Y);
          ThisWork.CanWork := False;
          Exit;
        end;

        if (StrToIntDef(tmpStep.Z, -1) < 1) or (StrToIntDef(tmpStep.Z, -1) > 20) then
        begin
          ShowMessage('Explosion cannot be ' + tmpStep.Z);
          ThisWork.CanWork := False;
          Exit;
        end;

        ThisWGAttrs.QS := tmpStep.X;
        ThisWGAttrs.GJ := tmpStep.Y;
        ThisWGAttrs.BZ := tmpStep.Z;

        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// Create Kungfu
  	//--------------------------------------------------------------------------
    ActCreateWG:
      begin
        FormShowWGs.ShowWGs;

        tmpString := CanCreateWG;
        if tmpString <> '' then
        begin
          tmpStep.SubStepIndex := 0;
          tmpTransaction.GotoNextStep;
          Exit;
        end;

        case tmpStep.SubStepIndex of
          0: // 打开创招窗口
            begin
              ThisCreateWG.Free;
              ThisCreateWG := TCreateWG.Create;
              ThisCreateWG.PatchCreateWG;

              tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Create Kungfu');
              if tmpWin=Nil then // 没有找到自创绝招窗口
              begin
                for i := 0 to HLInfoList.GlobalHL.Count - 1 do
                begin
                  tmpWin := HLInfoList.GlobalHL.Items[i];
                  if tmpWin.ClassName = 'TPUtilWindow' then
                  	PostMessage(tmpWin.Window, WM_COMMAND, IDM_CreateWG, 0);
                end;
              end
              else
              begin
                if IsWindowEnabled(tmpWin.Window) then EnableWindow(tmpWin.Window, False);
                if IsWindowVisible(tmpWin.Window) then ShowWindow(tmpWin.Window, SW_HIDE);

                tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
              end;
            end;
          1: // 创招
            begin
              if not ThisCreateWG.DoCreateWG then Exit
              else tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;

            end;
          2: // 等待创招窗口消失
            begin
              if HLInfoList.GlobalHL.ItemOfWindowTitle('Create Kungfu') <> nil then Exit;
              tmpStep.SubStepIndex := 0;
              FormShowWGs.ShowWGs;

              ThisCreateWG.UnPatchCreateWG;
              ThisCreateWG.Free;
              ThisCreateWG := Nil;

              tmpTransaction.GotoNextStep;
            end;
        end;
      end;
  	//--------------------------------------------------------------------------
		// 删除武功
  	//--------------------------------------------------------------------------
    ActDeleteWGs:
      begin
        FormShowWGs.ShowWGs;

        if tmpStep.SubStepIndex = 0 then // 初始化
        begin
        end;

        case tmpStep.SubStepIndex of
          0: // 初始化
            begin
             tmpint := StrToIntDef(tmpStep.X, 0);
              if (tmpint < 1) or (tmpint > 10) then
              begin
                ShowMessage('Deletion setting is wrong，you cannot start delete from ' + tmpStep.X + ' 招开始删招');
                ThisWork.CanWork := False;
                Exit;
              end;

              ThisCreateWG.Free;
              ThisCreateWG := TCreateWG.Create;
              ThisCreateWG.PatchCreateWG;

              ThisCreateWG.DeleteFrom := tmpint;

              if tmpStep.Y = 'Easy' then
                ThisCreateWG.DeleteWGRemainIndicator := DelWGRemainEasyWG
              else if tmpStep.Y = '※保留系数' then
                ThisCreateWG.DeleteWGRemainIndicator := StrToFloatDef(tmpStep.Z, DelWGNoIndicator)
              else
                ThisCreateWG.DeleteWGRemainIndicator := DelWGNoIndicator;

              if HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Character''s Status') = nil then
              begin
                for i := 0 to HLInfoList.GlobalHL.Count - 1 do
                begin
                  tmpWin := HLInfoList.GlobalHL.Items[i];
                  if tmpWin.ClassName = 'TPUtilWindow' then
                  	PostMessage(tmpWin.Window, WM_COMMAND, IDM_HumanAttr, 0);
                end;
              end;

              tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
            end;
          1: // 找到删招窗口
            begin
              tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Kungfu');
              if tmpWin = Nil then
              begin
                tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Other Info');
                if tmpWin = Nil then Exit;
                myhwnd := HLInfoList.GlobalHL.
                  LocateChildWindowWNDByTitle(tmpWin.Window, 'Kungfu(&M)', False);
                if myhwnd = 0 then Exit;

                LeftClickOnSomeWindow_Post(myhwnd, 0, 0);
              end
              else
              begin
                if IsWindowVisible(tmpWin.Window) then ShowWindow(tmpWin.Window, SW_HIDE);
                tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
              end;
            end;
          2: // 删招
            begin
              ThisUser.GetWGs;
              if ThisCreateWG.DeleteFrom > ThisUser.WGCount then
              begin
                tmpStep.SubStepIndex := 4;
                Exit;
              end;

              if not ThisCreateWG.DoDeleteWGs then Exit
              else tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
            end;
          3: // 等待武功真正被删掉
            begin
              ThisUser.GetWGs;
              if ThisCreateWG.OldWGCount <> ThisUser.WGCount + 1 then Exit;

              FormShowWGs.ShowWGs;
              tmpStep.SubStepIndex := 2;
            end;
          4: // 收尾工作
            begin
              tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Kungfu');
              if tmpWin <> nil then
              begin
                Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
                Exit;
              end;

              tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Character''s Status');
              if tmpWin <> nil then
              begin
                Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
                Exit;
              end;

              ThisCreateWG.UnPatchCreateWG;
              ThisCreateWG.Free;
              ThisCreateWG := Nil;

              tmpStep.SubStepIndex := 0;
              FormShowWGs.ShowWGs;
              tmpTransaction.GotoNextStep;
            end;
        end;
      end;
      ActSetAttr:
      begin
        case tmpStep.SubStepIndex of
          0:
          begin
            ThisUser.GetAttr;
            ThisUser.OldRemaining := ThisUser.RemainingPoints;

            if ((tmpStep.X <> 'Life') and (tmpStep.X <> 'Attack') and (tmpStep.X <> 'Defense')
              and (tmpStep.X <> 'Defence') and (tmpStep.X <> 'Mana') and (tmpStep.X <> 'Dexterity'))
              or (tmpStep.Y = '') then
            begin  // Unhandled action, skip step
              tmpTransaction.GotoNextStep;
              Exit;
            end;

            if (StrToInt(tmpStep.Y) > ThisUser.OldRemaining) then
            begin
              ShowMessage('Script ended because it tried to add more stats then existed: ' + tmpStep.X + ' ' + tmpStep.Y);
              ThisWork.CanWork := False;
              Exit;
            end;

            if HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Character''s Status') = nil then
            begin
              for i := 0 to HLInfoList.GlobalHL.Count - 1 do
              begin
                tmpWin := HLInfoList.GlobalHL.Items[i];
                if tmpWin.ClassName = 'TPUtilWindow' then
                  PostMessage(tmpWin.Window, WM_COMMAND, IDM_HumanAttr, 0);
              end;
            end
            else tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
          end;

          1:
          begin
            tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Character''s Status');

            myhwnd := HLInfoList.GlobalHL.
              LocateChildWindowWNDByTitle(tmpWin.Window, 'Attribute', False);
            if myhwnd = 0 then Exit;

            LeftClickOnSomeWindow_Post(myhwnd, 0, 0);
            tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
          end;

          2:
          begin
            //add stats and close window
            ThisUser.AddStats(tmpStep.X, StrToInt(tmpStep.Y));

            tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle(HLInfoList.GlobalHL.UserName + ' - Character''s Status');
            if tmpWin <> nil then
            begin
              Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
            end;

            tmpStep.SubStepIndex := 0;
            tmpTransaction.GotoNextStep;
            Sleep(100);
            FormMain.ResetAttributes;
          end;

        end;
      end;
      ActSetMarch:
      begin
        case tmpStep.SubStepIndex of
          0:
          begin
            //Open Pet List
            if (tmpStep.X = '') OR (StrToInt(tmpStep.X) <= 0) OR (StrToInt(tmpStep.X) > 5) then
            begin  // Unhandled action, skip step
              ShowMessage('Script ended because an invalid pet slot was provided');
              ThisWork.CanWork := False;
              Exit;
            end;

            if HLInfoList.GlobalHL.ItemOfWindowTitle('Pet''s Status') = nil then
            begin
              HLInfoList.GlobalHL.LocateToPlayWindow(tmpWin);
              if tmpWin = nil then Exit; // 没有找到
              //LeftClickOnSomeWindow_Send(tmpWin.Window, 140, 490);
              SendMessage(tmpWin.Window, WM_LBUTTONDOWN, MK_LBUTTON, 140 + 490 * 65536);
              PostMessage(tmpWin.Window, WM_LBUTTONUP, 0, 140 + 490 * 65536);
              Sleep(100);
            end
            else tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
          end;

          1:
          begin
            tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Pet''s Status');

            myhwnd := HLInfoList.GlobalHL.
              LocateChildWindowWNDByTitle(tmpWin.Window, 'Pet List', False);
            if myhwnd = 0 then Exit;

            myhwnd := HLInfoList.GlobalHL.LocatePetMarchingButton(StrToInt(tmpStep.X));
            if myhwnd = 0 then Exit;

            LeftClickOnSomeWindow_Post(myhwnd, 0, 0);
            tmpStep.SubStepIndex := tmpStep.SubStepIndex + 1;
          end;

          2:
          begin
            //close window
            tmpWin := HLInfoList.GlobalHL.ItemOfWindowTitle('Pet''s Status');
            if tmpWin <> nil then
            begin
              Sendmessage(tmpWin.Window, WM_CLOSE, 0, 0);
            end;

            ThisUser.GetPets;
            FormMain.UpdateMarchingPetInfo;
            FormShowPets.UpdateMarchingPetInfo;
            tmpStep.SubStepIndex := 0;
            tmpTransaction.GotoNextStep;
            Sleep(100);
          end;

        end;
      end;
    ActRecordPetStats:
      begin
        ThisUser.RecordPetStats;
        tmpStep.SubStepIndex := 0;
        tmpTransaction.GotoNextStep;
      end;
    ActLoadPetStats:
      begin
        ThisUser.GetPetStats(ThisUser.GetMarchingPet().ID);
        tmpStep.SubStepIndex := 0;
        tmpTransaction.GotoNextStep;
      end;
  	//--------------------------------------------------------------------------
		// 未知指令
  	//--------------------------------------------------------------------------
    ActUnknown:
      begin
        ThisWork.CanWork := False;
        ShowMessage('Encounted an unknown command: ' + tmpStep.X + '，script stopped');
      end;
  end;
end;

procedure TFormTimers.TimerReadMapInfoTimer(Sender: TObject);
var
  tmpMap: TMapInfo;
begin
  if (FormMain.Handle <> GetForeGroundWindow)
    and (FormGeneralSet.Handle <> GetForeGroundWindow)
    and (FormSetWGAttr.Handle <> GetForeGroundWindow)
  then
    SetWindowPos(FormMain.Handle, HWND_TOPMOST, 0, 0, 0, 0,
    	SWP_NOMOVE OR SWP_NOSIZE OR SWP_NOACTIVATE);

  if FReadMapInfoCounter >= GameMaps.Count then
  begin
    TimerReadMapInfo.Interval := 500;
    Exit;
  end;

  while (FReadMapInfoCounter < GameMaps.Count) do
  begin
    tmpMap := GameMaps.Items[FReadMapInfoCounter];
    if tmpMap.ID = 0 then
    begin
      GameMaps.ReadOneMap(tmpMap.PosInMapList);
      Exit;
    end
    else
      FReadMapInfoCounter := FReadMapInfoCounter + 1;
  end;
end;

procedure TFormTimers.FormCreate(Sender: TObject);
begin
  FForgeOldTime := 0;
end;

end.

