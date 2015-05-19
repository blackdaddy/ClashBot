Opt("GUIOnEventMode", 1)
Opt("MouseClickDelay", 10)
Opt("MouseClickDownDelay", 10)
Opt("TrayMenuMode", 3)

_GDIPlus_Startup()

Global Const $64Bit = StringInStr(@OSArch, "64") > 0
Global Const $DEFAULT_HEIGHT = 720
Global Const $DEFAULT_WIDTH = 860
Global $Initiate = 0
Global Const $REGISTRY_KEY_DIRECTORY = "HKEY_LOCAL_MACHINE\SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0"

Func GUIControl($hWind, $iMsg, $wParam, $lParam)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam
	#forceref $hWind, $iMsg, $wParam, $lParam
	Switch $iMsg
		Case 273
			Switch $nID
				Case $GUI_EVENT_CLOSE
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($txtLog)
					SaveConfig()
					Exit
				Case $btnStop
					If $RunState Then btnStop()
				Case $btnAtkNow
					If $RunState Then btnAtkNow()
				Case $btnHide
					If $RunState Then btnHide()
				Case $cmbTroopComp
					cmbTroopComp()
				Case $chkRequest
					chkRequest()
				Case $tabMain
					tabMain()
				Case $Randomspeedatk
					Randomspeedatk()
				Case $chkNoAttack
					If GUICtrlRead($chkNoAttack) = $GUI_CHECKED Then
						GUICtrlSetState($chkDonateOnly, $GUI_UNCHECKED)
					EndIf
				Case $chkDonateOnly
					If GUICtrlRead($chkDonateOnly) = $GUI_CHECKED Then
						GUICtrlSetState($chkNoAttack, $GUI_UNCHECKED)
					EndIf
				Case $chkMeetGE
					If GUICtrlRead($chkMeetGE) = $GUI_UNCHECKED Then
						GUICtrlSetState($chkSpellDarkStorage, $GUI_UNCHECKED)
						GUICtrlSetState($chkSpellDarkStorage, $GUI_DISABLE)
					ElseIf GUICtrlRead($chkMeetGE) = $GUI_CHECKED Then
						GUICtrlSetState($chkSpellDarkStorage, $GUI_ENABLE)
					EndIf
			EndSwitch
		Case 274
			Switch $wParam
				Case 0xf060
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($txtLog)
					SaveConfig()
					Exit
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl

Func SetTime()
	Local $time = _TicksToTime(Int(TimerDiff($sTimer)), $hour, $min, $sec)
	If _GUICtrlTab_GetCurSel($tabMain) = 7 Then GUICtrlSetData($lblresultruntime, StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
EndFunc   ;==>SetTime

Func SetTimeRC()
    if GUICtrlRead($lblpushbulletenabled) = $GUI_CHECKED and GUICtrlRead($lblpushbulletremote) = $GUI_CHECKED Then
		  _RemoteControl()
	EndIf
EndFunc   ;==>SetTime

Func Initiate()
	If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
		Local $BSsize = [ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")[2], ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")[3]]
		Local $fullScreenRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "FullScreen")
		Local $guestHeightRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "GuestHeight")
		Local $guestWidthRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "GuestWidth")
		Local $windowHeightRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "WindowHeight")
		Local $windowWidthRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "WindowWidth")

		Local $BSx = ($BSsize[0] > $BSsize[1]) ? $BSsize[0] : $BSsize[1]
		Local $BSy = ($BSsize[0] > $BSsize[1]) ? $BSsize[1] : $BSsize[0]

		$RunState = True

		If $BSx <> 860 Or $BSy <> 720 Then
			RegWrite($REGISTRY_KEY_DIRECTORY, "FullScreen", "REG_DWORD", "0")
			RegWrite($REGISTRY_KEY_DIRECTORY, "GuestHeight", "REG_DWORD", $DEFAULT_HEIGHT)
			RegWrite($REGISTRY_KEY_DIRECTORY, "GuestWidth", "REG_DWORD", $DEFAULT_WIDTH)
			RegWrite($REGISTRY_KEY_DIRECTORY, "WindowHeight", "REG_DWORD", $DEFAULT_HEIGHT)
			RegWrite($REGISTRY_KEY_DIRECTORY, "WindowWidth", "REG_DWORD", $DEFAULT_WIDTH)
			SetLog("Please restart your computer for the applied changes to take effect.", $COLOR_ORANGE)
			_Sleep(3000)
			$MsgRet = MsgBox(BitOR($MB_OKCANCEL, $MB_SYSTEMMODAL), "Restart Computer", "Restart your computer for the applied changes to take effect." & @CRLF & "If your BlueStacks is the correct size  (860 x 720), click OK.", 10)
			If $MsgRet <> $IDOK Then
				btnStop()
				Return
			EndIf
		EndIf

		WinActivate($Title)

		SetLog("~~~~Welcome to " & $sBotTitle & "!~~~~", $COLOR_PURPLE)
		SetLog($Compiled & " running on " & @OSArch & " OS", $COLOR_GREEN)
		SetLog("Bot is starting...", $COLOR_ORANGE)

		$AttackNow = False
		$FirstStart = True
		$PauseBot = False
		$Checkrearm = True
		$CreateSpell = True
		GUICtrlSetState($cmbBoostBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateCamp, $GUI_DISABLE)
		GUICtrlSetState($btnFindWall, $GUI_DISABLE)
		GUICtrlSetState($btnSearchMode, $GUI_DISABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_DISABLE)
		GUICtrlSetState($chkBackground, $GUI_DISABLE)
		GUICtrlSetState($chkNoAttack, $GUI_DISABLE)
		GUICtrlSetState($chkDonateOnly, $GUI_DISABLE)
		GUICtrlSetState($chkForceBS, $GUI_DISABLE)
		GUICtrlSetState($txtCapacity, $GUI_DISABLE)
		GUICtrlSetState($cmbRaidcap, $GUI_DISABLE)
		GUICtrlSetState($btnLocateTownHall, $GUI_DISABLE)
		GUICtrlSetState($btnLocateKingAltar, $GUI_DISABLE)
		GUICtrlSetState($btnLocateQueenAltar, $GUI_DISABLE)
		GUICtrlSetState($btnLocateClanCastle2, $GUI_DISABLE)
		GUICtrlSetState($btnLocateSFactory, $GUI_DISABLE)
		GUICtrlSetState($btnLocateUp1, $GUI_DISABLE)
		GUICtrlSetState($btnLocateUp2, $GUI_DISABLE)
		GUICtrlSetState($btnLocateUp3, $GUI_DISABLE)
		$sTimer = TimerInit()
		AdlibRegister("SetTime", 1000)
		if $PushBulletinterval <> 0 Then
			AdlibRegister("SetTimeRC", 60000 * $PushBulletinterval)
		Else
			AdlibRegister("SetTimeRC", 60000)
		EndIf
		runBot()
	Else
		SetLog("Not in Game!", $COLOR_RED)
		btnStop()
	EndIf
EndFunc   ;==>Initiate

Func Open()
	If $64Bit Then ;If 64-Bit
		ShellExecute("C:\Program Files (x86)\BlueStacks\HD-StartLauncher.exe")
		SetLog("Starting BlueStacks", $COLOR_GREEN)
		Sleep(290)
		SetLog("Waiting for BlueStacks to initiate...", $COLOR_GREEN)
		Check()
	Else ;If 32-Bit
		ShellExecute("C:\Program Files\BlueStacks\HD-StartLauncher.exe")
		SetLog("Starting BlueStacks", $COLOR_GREEN)
		Sleep(290)
		SetLog("Waiting for BlueStacks to initiate...", $COLOR_GREEN)
		Check()
	EndIf
EndFunc   ;==>Open

Func Check()
	If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
		SetLog("BlueStacks Loaded, took " & ($Initiate) & " seconds to begin.", $COLOR_GREEN)
		Initiate()
	Else
		Sleep(1000)
		$Initiate = $Initiate + 1

		Check()
	EndIf
EndFunc   ;==>Check

Func btnStart()
	If GUICtrlRead($lblpushbulletenabled) = $GUI_CHECKED and GUICtrlRead($pushbullettokenvalue) = "" Then
		SetLog ("Please set PushBullet account token")
		Return
	EndIf

	GUICtrlSetState($btnStart, $GUI_HIDE)
	GUICtrlSetState($btnStop, $GUI_SHOW)
	GUICtrlSetState($lblgoldnowM, $GUI_SHOW)
	GUICtrlSetState($lblresultgoldnowM, $GUI_SHOW)
	GUICtrlSetState($imggoldnowM, $GUI_SHOW)
	GUICtrlSetState($lblelixirnowM, $GUI_SHOW)
	GUICtrlSetState($lblresultelixirnowM, $GUI_SHOW)
	GUICtrlSetState($imgelixirnowM, $GUI_SHOW)
	GUICtrlSetState($lbldenowM, $GUI_SHOW)
	GUICtrlSetState($lblresultdenowM, $GUI_SHOW)
	GUICtrlSetState($imgdenowM, $GUI_SHOW)
	CreateLogFile()

	SaveConfig()
	readConfig()
	applyConfig()

	_GUICtrlEdit_SetText($txtLog, "")

	If WinExists($Title) Then
		DisableBS($HWnD, $SC_MINIMIZE)
		DisableBS($HWnD, $SC_CLOSE)
		Initiate()
	Else
		Open()
	EndIf
EndFunc   ;==>btnStart

Func btnStop()
	If $RunState Then
		$RunState = False
		$AttackNow = False
		$PauseBot = False
		EnableBS($HWnD, $SC_MINIMIZE)
		EnableBS($HWnD, $SC_CLOSE)
		GUICtrlSetState($btnLocateBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_ENABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_ENABLE)
		GUICtrlSetState($btnLocateTownHall, $GUI_ENABLE)
		GUICtrlSetState($btnLocateKingAltar, $GUI_ENABLE)
		GUICtrlSetState($btnLocateQueenAltar, $GUI_ENABLE)
		GUICtrlSetState($btnLocateCamp, $GUI_ENABLE)
		GUICtrlSetState($btnLocateSFactory, $GUI_ENABLE)
		GUICtrlSetState($btnLocateUp1, $GUI_ENABLE)
		GUICtrlSetState($btnLocateUp2, $GUI_ENABLE)
		GUICtrlSetState($btnLocateUp3, $GUI_ENABLE)
		GUICtrlSetState($btnFindWall, $GUI_ENABLE)
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		GUICtrlSetState($chkNoAttack, $GUI_ENABLE)
		GUICtrlSetState($chkDonateOnly, $GUI_ENABLE)
		GUICtrlSetState($chkForceBS, $GUI_ENABLE)
		GUICtrlSetState($txtCapacity, $GUI_ENABLE)
		GUICtrlSetState($cmbRaidcap, $GUI_ENABLE)
		GUICtrlSetState($btnLocateClanCastle2, $GUI_ENABLE)
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		GUICtrlSetState($cmbBoostBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStop, $GUI_HIDE)
		GUICtrlSetState($lblgoldnowM, $GUI_HIDE)
		GUICtrlSetState($lblresultgoldnowM, $GUI_HIDE)
		GUICtrlSetState($imggoldnowM, $GUI_HIDE)
		GUICtrlSetState($lblelixirnowM, $GUI_HIDE)
		GUICtrlSetState($lblresultelixirnowM, $GUI_HIDE)
		GUICtrlSetState($imgelixirnowM, $GUI_HIDE)
		GUICtrlSetState($lbldenowM, $GUI_HIDE)
		GUICtrlSetState($lblresultdenowM, $GUI_HIDE)
		GUICtrlSetState($imgdenowM, $GUI_HIDE)

		AdlibUnRegister("SetTime")
		AdlibUnRegister("SetTimeRC")
		_BlockInputEx(0, "", "", $HWnD)

		FileClose($hLogFileHandle)
		SetLog("ClashBot has stopped", $COLOR_ORANGE)
	EndIf
EndFunc   ;==>btnStop

Func btnAtkNow()
	$AttackNow = True
	GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
EndFunc   ;==>btnAtkNow

Func btnLocateBarracks()
	$RunState = True
	While 1
		ZoomOut()
		LocateBarrack()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateBarracks

Func btnLocateDarkBarracks()
	$RunState = True
	While 1
		ZoomOut()
		LocateDarkBarrack()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateDarkBarracks

Func btnLocateClanCastle()
	$RunState = True
	While 1
		ZoomOut()
		LocateClanCastle()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateClanCastle

Func btnLocateTownHall()
	$RunState = True
	While 1
		ZoomOut()
		LocateTownHall()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateTownHall

Func btnLocateKingAltar()
	$RunState = True
	While 1
		ZoomOut()
		LocateKingAltar()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateKingAltar

Func btnLocateQueenAltar()
	$RunState = True
	While 1
		ZoomOut()
		LocateQueenAltar()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateQueenAltar

Func btnLocateSFactory()
	$RunState = True
	While 1
		ZoomOut()
		LocateSFactory()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateSFactory

Func btnLocateUp1()
	$RunState = True
	While 1
		ZoomOut()
		LocateUpgrade1()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateUp1

Func btnLocateUp2()
	$RunState = True
	While 1
		ZoomOut()
		LocateUpgrade2()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateUp2

Func btnLocateUp3()
	$RunState = True
	While 1
		ZoomOut()
		LocateUpgrade3()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateUp3

Func btnFindWall()
	$RunState = True
	GUICtrlSetState($chkWalls, $GUI_DISABLE)
	GUICtrlSetState($UseGold, $GUI_DISABLE)
	GUICtrlSetState($UseElixir, $GUI_DISABLE)
	GUICtrlSetState($UseGoldElix, $GUI_DISABLE)
	While 1
		SaveConfig()
		readConfig()
		applyConfig()
		ZoomOut()

		If checkWall() Then
			WinActivate($HWnD)
			Click($WallX, $WallY)
			SetLog("Found Walls level " & $icmbWalls + 4 & " at PosX: " & $WallX & ", PosY: " & $WallY & "...", $COLOR_GREEN)
		Else
			SetLog("Cannot find Walls level " & $icmbWalls + 4 & ", adjust tolerance and try again...", $COLOR_RED)
		EndIf

		ExitLoop
	WEnd
	GUICtrlSetState($chkWalls, $GUI_ENABLE)
	GUICtrlSetState($UseGold, $GUI_ENABLE)
	GUICtrlSetState($UseElixir, $GUI_ENABLE)
	GUICtrlSetState($UseGoldElix, $GUI_ENABLE)
	$RunState = False
EndFunc   ;==>btnFindWall

Func btnLocateCamp()
	$RunState = True
	While 1
		ZoomOut()
		Locatecamp()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateCamp

Func btnDeletelist()
	DeleteList()
EndFunc   ;==>btnDeletelist

Func btnSearchMode()
	While 1
		GUICtrlSetState($btnStart, $GUI_HIDE)
		GUICtrlSetState($btnStop, $GUI_SHOW)

		GUICtrlSetState($btnLocateBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnSearchMode, $GUI_DISABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_DISABLE)
		GUICtrlSetState($chkBackground, $GUI_DISABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_DISABLE)

		$RunState = True
		VillageSearch()
		$RunState = False

		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStop, $GUI_HIDE)

		GUICtrlSetState($btnLocateBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_ENABLE)
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_ENABLE)
		ExitLoop
	WEnd
EndFunc   ;==>btnSearchMode

Func btnHide()
	If $Hide = False Then
		GUICtrlSetData($btnHide, "Show BS")
		$botPos[0] = WinGetPos($Title)[0]
		$botPos[1] = WinGetPos($Title)[1]
		WinMove($Title, "", -32000, -32000)
		$Hide = True
	Else
		GUICtrlSetData($btnHide, "Hide BS")

		If $botPos[0] = -32000 Then
			WinMove($Title, "", 0, 0)
		Else
			WinMove($Title, "", $botPos[0], $botPos[1])
			WinActivate($Title)
		EndIf
		$Hide = False
	EndIf
EndFunc   ;==>btnHide

Func cmbTroopComp()
    If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> $icmbTroopComp And _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 10 Then
		$icmbTroopComp = _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		SetComboTroopComp()
		_GUICtrlComboBox_SetCurSel($cmbAlgorithm, 9)
		_GUICtrlComboBox_SetCurSel($cmbDeadAlgorithm, 9)
	ElseIf _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> $icmbTroopComp And _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 10 Then
		$icmbTroopComp = _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		$ArmyComp = 0
		$CurArch = 1
		$CurBarb = 1
		$CurGoblin = 1
		$CurGiant = 1
		$CurWB = 1
		SetComboTroopComp()
		_GUICtrlComboBox_SetCurSel($cmbAlgorithm, $icmbTroopComp)
		_GUICtrlComboBox_SetCurSel($cmbDeadAlgorithm, $icmbTroopComp)
	EndIf
EndFunc   ;==>cmbTroopComp

Func SetComboTroopComp()
	Switch _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		Case 0
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, "0")
			GUICtrlSetData($txtArchers, "100")
			GUICtrlSetData($txtGoblins, "0")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 1
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, "100")
			GUICtrlSetData($txtArchers, "0")
			GUICtrlSetData($txtGoblins, "0")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 2
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, "0")
			GUICtrlSetData($txtArchers, "0")
			GUICtrlSetData($txtGoblins, "100")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 3
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, "50")
			GUICtrlSetData($txtArchers, "50")
			GUICtrlSetData($txtGoblins, "0")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 4
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, "60")
			GUICtrlSetData($txtArchers, "30")
			GUICtrlSetData($txtGoblins, "10")

			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 5
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, "50")
			GUICtrlSetData($txtArchers, "50")
			GUICtrlSetData($txtGoblins, "0")

			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 6
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, "60")
			GUICtrlSetData($txtArchers, "30")
			GUICtrlSetData($txtGoblins, "10")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
		Case 7
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, "60")
			GUICtrlSetData($txtArchers, "30")
			GUICtrlSetData($txtGoblins, "10")

			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, $WBComp)
		Case 8
			GUICtrlSetState($cmbBarrack1, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_ENABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_ENABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_ENABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_ENABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_ENABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

		Case 9
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
			GUICtrlSetState($chkDarkTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_DISABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_DISABLE)

			GUICtrlSetData($txtBarbarians, $BarbariansComp)
			GUICtrlSetData($txtArchers, $ArchersComp)
			GUICtrlSetData($txtGoblins, $GoblinsComp)

			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, $WBComp)

		Case 10
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($chkDarkTroop, $GUI_ENABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_ENABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_ENABLE)
			GUICtrlSetState($txtDarkBarrack1, $GUI_ENABLE)
			GUICtrlSetState($txtDarkBarrack2, $GUI_ENABLE)
			GUICtrlSetState($txtFirstTroop1, $GUI_ENABLE)
			GUICtrlSetState($txtFirstTroop2, $GUI_ENABLE)
			GUICtrlSetState($txtFirstTroop3, $GUI_ENABLE)
			GUICtrlSetState($txtFirstTroop4, $GUI_ENABLE)
			GUICtrlSetState($cmbFirstTroop1, $GUI_ENABLE)
			GUICtrlSetState($cmbFirstTroop2, $GUI_ENABLE)
			GUICtrlSetState($cmbFirstTroop3, $GUI_ENABLE)
			GUICtrlSetState($cmbFirstTroop4, $GUI_ENABLE)
			GUICtrlSetState($cmbSecondTroop1, $GUI_ENABLE)
			GUICtrlSetState($cmbSecondTroop2, $GUI_ENABLE)
			GUICtrlSetState($cmbSecondTroop3, $GUI_ENABLE)
			GUICtrlSetState($cmbSecondTroop4, $GUI_ENABLE)
	EndSwitch
EndFunc   ;==>SetComboTroopComp

Func chkBackground()
	If GUICtrlRead($chkBackground) = $GUI_CHECKED Then
		$ichkBackground = 1
		GUICtrlSetState($btnHide, $GUI_ENABLE)
	Else
		$ichkBackground = 0
		GUICtrlSetState($btnHide, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkBackground

Func chkNoAttack()
	If GUICtrlRead($chkNoAttack) = $GUI_CHECKED Then
	   if GUICtrlRead($lblpushbulletenabled) = $GUI_CHECKED Then
		  SetLog("Please disable PushBullet if you intend to use donate only mode")
		  GUICtrlSetState($chkNoAttack, $GUI_UNCHECKED)
	   else
		$CommandStop = 0
		SetLog("~~~Donate / Train Only Activated~~~", $COLOR_PURPLE)
		EndIf
	 ElseIf GUICtrlRead($chkDonateOnly) = $GUI_CHECKED Then
		 if GUICtrlRead($lblpushbulletenabled) = $GUI_CHECKED Then
		 SetLog("Please disable PushBullet if you intend to do donate only mode")
		 GUICtrlSetState($chkDonateOnly, $GUI_UNCHECKED)
		 else
		$CommandStop = 3
		SetLog("~~~Donate Only Activated~~~", $COLOR_PURPLE)
		EndIf
	Else
		$CommandStop = -1
	 EndIf
EndFunc   ;==>chkNoAttack

;Func btnLocateCollectors()
;	$RunState = True
;	While 1
;		ZoomOut()
;		LocateCollectors()
;		ExitLoop
;	WEnd
;	$RunState = False
;EndFunc   ;==>btnLocateCollectors

Func chkRequest()
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		$ichkRequest = 1
		GUICtrlSetState($txtRequest, $GUI_ENABLE)
	Else
		$ichkRequest = 0
		GUICtrlSetState($txtRequest, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkRequest

Func Randomspeedatk()
	If GUICtrlRead($Randomspeedatk) = $GUI_CHECKED Then
		$iRandomspeedatk = 1
		GUICtrlSetState($cmbUnitDelay, $GUI_DISABLE)
		GUICtrlSetState($cmbWaveDelay, $GUI_DISABLE)
	Else
		$iRandomspeedatk = 0
		GUICtrlSetState($cmbUnitDelay, $GUI_ENABLE)
		GUICtrlSetState($cmbWaveDelay, $GUI_ENABLE)
	EndIf
EndFunc   ;==>Randomspeedatk

Func tabMain()
	If _GUICtrlTab_GetCurSel($tabMain) = 0 Then
		ControlShow("", "", $txtLog)
	Else
		ControlHide("", "", $txtLog)
	EndIf
EndFunc   ;==>tabMain

Func DisableBS($HWnD, $iButton)
	ConsoleWrite('+ Window Handle: ' & $HWnD & @CRLF)
	$hSysMenu = _GUICtrlMenu_GetSystemMenu($HWnD, 0)
	_GUICtrlMenu_RemoveMenu($hSysMenu, $iButton, False)
	_GUICtrlMenu_DrawMenuBar($HWnD)
EndFunc   ;==>DisableBS

Func EnableBS($HWnD, $iButton)
	ConsoleWrite('+ Window Handle: ' & $HWnD & @CRLF)
	$hSysMenu = _GUICtrlMenu_GetSystemMenu($HWnD, 1)
	_GUICtrlMenu_RemoveMenu($hSysMenu, $iButton, False)
	_GUICtrlMenu_DrawMenuBar($HWnD)
EndFunc   ;==>EnableBS

;---------------------------------------------------
If FileExists($config) Then
	readConfig()
	applyConfig()
EndIf

GUIRegisterMsg($WM_COMMAND, "GUIControl")
GUIRegisterMsg($WM_SYSCOMMAND, "GUIControl")
;---------------------------------------------------
