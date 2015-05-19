
Func LocateBarrack()
	SetLog("Locating Barracks...", $COLOR_BLUE)
	Local $MsgBox
	While 1
		While 1
			$MsgBox = MsgBox(6 + 262144, "Locate first barrack", "Click Continue then click on your first barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
			If $MsgBox = 11 Then
				$barrackPos[0][0] = FindPos()[0]
				$barrackPos[0][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 0 To 3
					$barrackPos[$i][0] = ""
					$barrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			If _Sleep(500) Then ExitLoop
			$MsgBox = MsgBox(6 + 262144, "Locate second barrack", "Click Continue then click on your second barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
			If $MsgBox = 11 Then
				$barrackPos[1][0] = FindPos()[0]
				$barrackPos[1][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 1 To 3
					$barrackPos[$i][0] = ""
					$barrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			If _Sleep(500) Then ExitLoop
			$MsgBox = MsgBox(6 + 262144, "Locate third barrack", "Click Continue then click on your third barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
			If $MsgBox = 11 Then
				$barrackPos[2][0] = FindPos()[0]
				$barrackPos[2][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 2 To 3
					$barrackPos[$i][0] = ""
					$barrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			If _Sleep(500) Then ExitLoop
			$MsgBox = MsgBox(6 + 262144, "Locate fourth barrack", "Click Continue then click on your fourth barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
			If $MsgBox = 11 Then
				$barrackPos[3][0] = FindPos()[0]
				$barrackPos[3][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				$barrackPos[3][0] = ""
				$barrackPos[3][1] = ""
			EndIf
			If GUICtrlRead($chkRequest) = $GUI_CHECKED And $CCPos[0] = -1 Then LocateClanCastle()
			ExitLoop (2)
		WEnd
	WEnd
	SaveConfig()
	SetLog("-Locating Complete-", $COLOR_BLUE)
	SetLog("-Barrack 1 = " & "(" & $barrackPos[0][0] & "," & $barrackPos[0][1] & ")", $COLOR_GREEN)
	SetLog("-Barrack 2 = " & "(" & $barrackPos[1][0] & "," & $barrackPos[1][1] & ")", $COLOR_GREEN)
	SetLog("-Barrack 3 = " & "(" & $barrackPos[2][0] & "," & $barrackPos[2][1] & ")", $COLOR_GREEN)
	SetLog("-Barrack 4 = " & "(" & $barrackPos[3][0] & "," & $barrackPos[3][1] & ")", $COLOR_GREEN)
EndFunc   ;==>LocateBarrack

Func LocateDarkBarrack()
	SetLog("Locating Dark Barracks...", $COLOR_BLUE)
	Local $MsgBox
	While 1
		While 1
			$MsgBox = MsgBox(6 + 262144, "Locate first Dark Barrack", "Click Continue then click on your first dark barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
			If $MsgBox = 11 Then
				$DarkBarrackPos[0][0] = FindPos()[0]
				$DarkBarrackPos[0][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 0 To 1
					$DarkBarrackPos[$i][0] = ""
					$DarkBarrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			If _Sleep(500) Then ExitLoop
			$MsgBox = MsgBox(6 + 262144, "Locate second Dark Barrack", "Click Continue then click on your second dark barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
			If $MsgBox = 11 Then
				$DarkBarrackPos[1][0] = FindPos()[0]
				$DarkBarrackPos[1][1] = FindPos()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 1 To 1
					$DarkBarrackPos[$i][0] = ""
					$DarkBarrackPos[$i][1] = ""
				Next
				ExitLoop (2)
			EndIf
			ExitLoop (2)
		WEnd
	WEnd
	SaveConfig()
	SetLog("-Locating Complete-", $COLOR_BLUE)
	SetLog("-Dark Barrack 1 = " & "(" & $DarkBarrackPos[0][0] & "," & $DarkBarrackPos[0][1] & ")", $COLOR_GREEN)
	SetLog("-Dark Barrack 2 = " & "(" & $DarkBarrackPos[1][0] & "," & $DarkBarrackPos[1][1] & ")", $COLOR_GREEN)

EndFunc   ;==>LocateDarkBarrack

Func LocateCamp()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Camp", "Click OK then click on one of your camps", 0, $frmBot)
		If $MsgBox = 1 Then
			$ArmyPos[0] = FindPos()[0]
			$ArmyPos[1] = FindPos()[1]
			SetLog("-ArmyCamp =  " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd

	$itxtcampCap = InputBox("Total Camp Capacity", "Enter Your Total Troop Capacity", "200", " M3")
	If $itxtcampCap >= 25 And $itxtcampCap <= 240 Then
		GUICtrlSetData($txtCapacity, $itxtcampCap)
	Else
		MsgBox(4096, "Error", "Please input the correct value")
	EndIf
EndFunc   ;==>LocateCamp

Func LocateClanCastle()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Clan Castle", "Click OK then click on your Clan Castle", 0, $frmBot)
		If $MsgBox = 1 Then
			$CCPos[0] = FindPos()[0]
			$CCPos[1] = FindPos()[1]
			SetLog("-Clan Castle =  " & "(" & $CCPos[0] & "," & $CCPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateClanCastle

Func LocateTownHall()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Townhall", "Click OK then click on your Townhall", 0, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$TownHallPos[0] = FindPos()[0]
			$TownHallPos[1] = FindPos()[1]
			SetLog("-Townhall =  " & "(" & $TownHallPos[0] & "," & $TownHallPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateTownHall

Func LocateKingAltar()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate King Altar", "Click OK then click on your King Altar", 0, $frmBot)
		If $MsgBox = 1 Then
			$KingPos[0] = FindPos()[0]
			$KingPos[1] = FindPos()[1]
			SetLog("-King Altar =  " & "(" & $KingPos[0] & "," & $KingPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateKingAltar

Func LocateQueenAltar()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Queen Altar", "Click OK then click on your Queen Altar", 0, $frmBot)
		If $MsgBox = 1 Then
			$QueenPos[0] = FindPos()[0]
			$QueenPos[1] = FindPos()[1]
			SetLog("-Queen Altar =  " & "(" & $QueenPos[0] & "," & $QueenPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateQueenAltar

Func LocateSFactory()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Spell Factory", "Click OK then click on your Spell Factory", 0, $frmBot)
		If $MsgBox = 1 Then
			$SFactoryPos[0] = FindPos()[0]
			$SFactoryPos[1] = FindPos()[1]
			SetLog("-Spell Factory =  " & "(" & $SFactoryPos[0] & "," & $SFactoryPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateSFactory

Func LocateUpgrade1()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Upgrade Building 1", "Click OK then click on your Building", 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos1[0] = FindPos()[0]
			$BuildPos1[1] = FindPos()[1]
			SetLog("-Building 1 =  " & "(" & $BuildPos1[0] & "," & $BuildPos1[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX1, $BuildPos1[0])
			GUICtrlSetData($txtUpgradeY1, $BuildPos1[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade1

Func LocateUpgrade2()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Upgrade Building 2", "Click OK then click on your Building", 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos2[0] = FindPos()[0]
			$BuildPos2[1] = FindPos()[1]
			SetLog("-Building 1 =  " & "(" & $BuildPos2[0] & "," & $BuildPos2[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX2, $BuildPos2[0])
			GUICtrlSetData($txtUpgradeY2, $BuildPos2[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade2

Func LocateUpgrade3()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Upgrade Building 3", "Click OK then click on your Building", 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos3[0] = FindPos()[0]
			$BuildPos3[1] = FindPos()[1]
			SetLog("-Building 1 =  " & "(" & $BuildPos3[0] & "," & $BuildPos3[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX3, $BuildPos3[0])
			GUICtrlSetData($txtUpgradeY3, $BuildPos3[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade3
