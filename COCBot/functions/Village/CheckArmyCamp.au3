Func CheckArmyCamp()
	SetLog("Checking Army Camp...", $COLOR_BLUE)
	ZoomOut()

	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If $ArmyPos[0] = "" Then
		LocateCamp()
		SaveConfig()
    EndIf

    If _Sleep(100) Then Return
	Click($ArmyPos[0], $ArmyPos[1]) ;Click Army Camp

    If _Sleep(1000) Then Return

	_CaptureRegion()
	If _Sleep(500) Then Return
	Local $BArmyPos = _PixelSearch(309, 581, 433, 583, Hex(0x4084B8, 6), 5) ;Finds Info button
	If IsArray($BArmyPos) = False Then
		SetLog("Your Army Camp is not available", $COLOR_RED)
		$armyCheckingFailed = True
	 Else
		$armyCheckingFailed = False
		Click($BArmyPos[0], $BArmyPos[1]) ;Click Info button
		If _Sleep(2000) Then Return

		_CaptureRegion()
		Switch $icmbRaidcap
			Case 0 ; 70%
				Local $Campbar = _PixelSearch(620, 210, 622, 213, Hex(0x37A800, 6), 10)
			Case 1 ; 80%
				Local $Campbar = _PixelSearch(649, 210, 651, 213, Hex(0x37A800, 6), 10)
			Case 2 ; 90%
				Local $Campbar = _PixelSearch(677, 210, 679, 213, Hex(0x37A800, 6), 10)
			Case 3 ; 100%
				Local $Campbar = _PixelSearch(707, 210, 709, 213, Hex(0x37A800, 6), 10)
		EndSwitch
		$CurCamp = Number(getOther(586, 193, "Camp"))

		_log("CheckArmyCamp : $FirstStart = " & $FirstStart & ", $CurCamp = " & $CurCamp & ", $icmbRaidcap = " & $icmbRaidcap & ", $icmbRaidcap = " & $icmbRaidcap & ", $Campbar = " & IsArray($Campbar))

		If $CurCamp > 0 Then
			SetLog("Total Troop Capacity: " & $CurCamp & "/" & $itxtcampCap, $COLOR_GREEN)
	    Else
			Local $res = _PixelSearch(225, 380, 240, 395, Hex(0xC9C6B6, 6), 5)
			If IsArray($res) = False Then
			   $armyCheckingFailed = True
			   ClickP($TopLeftClient) ;Click Away
			   SetLog("Failed to read your Army camp.", $COLOR_RED)
			   Return
			EndIf

			SetLog("Empty Army camp.", $COLOR_ORANGE)
	    EndIf

		If $CurCamp >= ($itxtcampCap * (GUICtrlRead($cmbRaidcap) / 100)) Or IsArray($Campbar) = True Then
			$fullArmy = True
		Else
			_CaptureRegion()
			$ArmyComp = 0
			$CurGiant = 0
			$CurWB = 0
			$CurArch = 0
			$CurBarb = 0
			$CurGoblin = 0

			For $i = 0 To 6
				Local $TroopKind = _GetPixelColor(230 + 71 * $i, 359)
				Local $TroopKind2 = _GetPixelColor(230 + 71 * $i, 385)
				Local $TroopName = "Unknown"
				Local $TroopQ = getOther(229 + 71 * $i, 413, "Camp")
				If _ColorCheck($TroopKind, Hex(0xF85CCB, 6), 20) Then
					$CurArch -= $TroopQ
					$TroopName = "Archers"
				ElseIf _ColorCheck($TroopKind, Hex(0xF8E439, 6), 20) Then
					$CurBarb -= $TroopQ
					$TroopName = "Barbarians"
				ElseIf _ColorCheck($TroopKind, Hex(0xF8D198, 6), 20) Then
					$CurGiant -= $TroopQ
					$TroopName = "Giants"
				ElseIf _ColorCheck($TroopKind, Hex(0x93EC60, 6), 20) Then
					$CurGoblin -= $TroopQ
					$TroopName = "Goblins"
				ElseIf _ColorCheck($TroopKind, Hex(0x48A8E8, 6), 20) Then
					$CurWB -= $TroopQ
					$TroopName = "Wallbreakers"
				ElseIf _ColorCheck($TroopKind, Hex(0x131D38, 6), 20) Then
					$CurMinion -= $TroopQ
					$TroopName = "Minions"
				ElseIf _ColorCheck($TroopKind2, Hex(0x212018, 6), 20) Then
					$CurHog -= $TroopQ
					$TroopName = "Hogs"
				ElseIf _ColorCheck($TroopKind, Hex(0x983B08, 6), 20) Then
					$CurValkyrie -= $TroopQ
					$TroopName = "Valkyries"
				EndIf
				If $TroopQ <> 0 Then SetLog("- " & $TroopName & " " & $TroopQ, $COLOR_GREEN)
			Next

		   _log("Checking current troops : $CurBarb = " & $CurBarb & ", $CurArch = " & $CurArch & ", $CurWB = " & $CurWB & ", $CurGiant = " & $CurGiant & ", $CurGoblin = " & $CurGoblin)
		EndIf
		If $fullArmy Then
			SetLog("Army Camp Full : " & $fullArmy, $COLOR_RED)
		EndIf
		ClickP($TopLeftClient) ;Click Away
		$FirstCampView = True
	EndIf
EndFunc   ;==>CheckArmyCamp
