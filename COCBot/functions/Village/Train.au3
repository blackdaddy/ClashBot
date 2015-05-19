;Uses the location of manually set Barracks to train specified troops

; Train the troops (Fill the barracks)

Func GetTrainPos($troopKind)
	Switch $troopKind
		Case $eBarbarian ; 261, 366: 0x39D8E0
			Return $TrainBarbarian
		Case $eArcher ; 369, 366: 0x39D8E0
			Return $TrainArcher
		Case $eGiant ; 475, 366: 0x3DD8E0
			Return $TrainGiant
		Case $eGoblin ; 581, 366: 0x39D8E0
			Return $TrainGoblin
		Case $eWallbreaker ; 688, 366, 0x3AD8E0
			Return $TrainWallbreaker
		Case $eMinion
			Return $TrainMinion
		Case $eHog
			Return $TrainHog
		Case $eValkyrie
			Return $TrainValkyrie
		Case Else
			SetLog("Don't know how to train the troop " & $troopKind & " yet")
			Return 0
	EndSwitch
EndFunc   ;==>GetTrainPos

Func TrainIt($troopKind, $howMuch = 1, $iSleep = 100)
	_CaptureRegion()
	Local $pos = GetTrainPos($troopKind)
	If IsArray($pos) Then
		If CheckPixel($pos) Then
			ClickP($pos, $howMuch, 20)
			_log("TrainIt called : " & $troopKind & "," & $howMuch & @CRLF)
			If _Sleep($iSleep) Then Return False
			Return True
		EndIf
	EndIf
EndFunc   ;==>TrainIt

Func IsTrainingNow()
	Local $DeletePos = _PixelSearch(486, 184, 507, 198, Hex(0xD10201, 6), 10) ;Finds Train Troops button
	If IsArray($DeletePos) Then
		Return True
	EndIf
	Return False
EndFunc

Func Train()
	If $barrackPos[0][0] = "" Then
		LocateBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf

	SetLog("Training Troops....", $COLOR_BLUE)

	If $fullArmy Then ; reset all for cook again on startup
		$ArmyComp = 0
	EndIf

    ; checkint remaining training troops count
    $CurGiant += GUICtrlRead($txtNumGiants)
    $CurWB += GUICtrlRead($txtNumWallbreakers)
    $CurArch += (($itxtcampCap * ((GUICtrlRead($cmbRaidcap) + 5) / 100)) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers) * 2)) * GUICtrlRead($txtArchers) / 100
    $CurArch = Round($CurArch) + 4; ===> make sure always cook full
    $CurBarb += (($itxtcampCap * ((GUICtrlRead($cmbRaidcap) + 5) / 100)) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers) * 2)) * GUICtrlRead($txtBarbarians) / 100
    $CurBarb = Round($CurBarb)
    $CurGoblin += (($itxtcampCap * ((GUICtrlRead($cmbRaidcap) + 5) / 100)) - (GUICtrlRead($txtNumGiants) * 5) - (GUICtrlRead($txtNumWallbreakers) * 2)) * GUICtrlRead($txtGoblins) / 100
    $CurGoblin = Round($CurGoblin)

    If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 8 Then
	   SetLog("Total Remaining Troops", $COLOR_GREEN)
	   SetLog("- Giant : " & $CurGiant, $COLOR_ORANGE)
	   SetLog("- Archer : " & $CurArch, $COLOR_ORANGE)
	   SetLog("- Babarian : " & $CurBarb, $COLOR_ORANGE)
	   SetLog("- Goblin : " & $CurGoblin, $COLOR_ORANGE)
	   SetLog("- WallBreaker : " & $CurWB, $COLOR_ORANGE)
    EndIf

	Local $GiantEBarrack, $WallEBarrack, $ArchEBarrack, $BarbEBarrack, $GoblinEBarrack
	$GiantEBarrack = Floor($CurGiant / 4)
	$WallEBarrack = Floor($CurWB / 4)
	$ArchEBarrack = Floor($CurArch / 4)
	$BarbEBarrack = Floor($CurBarb / 4)
	$GoblinEBarrack = Floor($CurGoblin / 4)

	For $i = 0 To 3 ;iterate through barracks
		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(500) Then ExitLoop

		Click($barrackPos[$i][0], $barrackPos[$i][1]) ;Click Barrack
		If _Sleep(500) Then ExitLoop

		Local $TrainPos = _PixelSearch(155, 590, 694, 605, Hex(0x6D4018, 6), 15) ;Finds Train Troops button
		If IsArray($TrainPos) = False Then
			SetLog("Barrack " & $i + 1 & " is not available!", $COLOR_RED)
			handleBarracksError($i)
			If _Sleep(500) Then ExitLoop
		Else
			Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
			If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then SetLog("Barrack " & $i + 1 & " Training...", $COLOR_GREEN)
			If _Sleep(1000) Then ExitLoop

			If IsTrainingNow() Then
			   SetLog("Barrack " & $i + 1 & " training now.", $COLOR_BLUE)

			   If _Sleep(100) Then ExitLoop
			   ClickP($TopLeftClient, 2, 250); Click away twice with 250ms delay
			   ContinueLoop
			EndIf

			If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then ; Use Barracks
				_CaptureRegion()
				While _ColorCheck(_GetPixelColor(420, 190), Hex(0xF0F0F0, 6), 20)
					Click(420, 190, 20) ;Removing useless troops
					_CaptureRegion()
				WEnd

				Switch $barrackTroop[$i]
					Case 0
						While _WaitForPixel(220, 320, Hex(0xF89683, 6), 20, 800, 50)
							Click(220, 320, 20) ;Barbarian
						WEnd
					Case 1
						While _WaitForPixel(325, 330, Hex(0xF8C3B0, 6), 20, 800, 50)
							Click(325, 320, 20) ;Archer
						WEnd
					Case 2
						While _WaitForPixel(430, 320, Hex(0xE68358, 6), 20, 800, 50)
							Click(430, 320, 5) ;Giant
						WEnd
					Case 3
						While _WaitForPixel(535, 310, Hex(0x7AA440, 6), 20, 800, 50)
							Click(535, 320, 20) ;Goblin
						WEnd
					Case 4
						While _WaitForPixel(640, 290, Hex(0x5FC6D6, 6), 20, 800, 50)
							Click(640, 320, 10) ;Wall Breaker
						WEnd
					Case 5
						While _WaitForPixel(220, 410, Hex(0x58C0D8, 6), 20, 800, 50)
							Click(220, 425, 5) ;Balloon
						WEnd
					Case 6
						While _WaitForPixel(325, 425, Hex(0xA46052, 6), 20, 800, 50)
							Click(325, 425, 5) ;Wizard
						WEnd
					Case 7
						While _WaitForPixel(430, 425, Hex(0xEFBB96, 6), 20, 800, 50)
							Click(430, 425, 5) ;Healer
						WEnd
					Case 8
						While _WaitForPixel(535, 410, Hex(0x8B7CA8, 6), 20, 800, 50)
							Click(535, 425, 5) ;Dragon
						WEnd
					Case 9
						While _WaitForPixel(640, 410, Hex(0x7092AC, 6), 20, 800, 50)
							Click(640, 425, 5) ;PEKKA
						WEnd
					Case Else
						If _Sleep(50) Then ExitLoop
						_CaptureRegion()
				EndSwitch
			Else ; Custom Troops
				SetLog("====== Barrack " & $i + 1 & " : ======", $COLOR_BLUE)
				_CaptureRegion()

				If IsTrainingNow() Then; always removing all current training troops..
				    SetLog("Removing all making troops.", $COLOR_ORANGE)
					;While _WaitForPixel(496, 200, Hex(0x880000, 6), 20, 500, 10)
					Click(496, 190, 80, 2)
					;WEnd
				 EndIf

				If _Sleep(500) Then ExitLoop

				If GUICtrlRead($txtArchers) <> "0" And $CurArch > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If $CurArch > 0 Then
						If $ArchEBarrack = 0 Then
							TrainIt($eArcher, 1)
						ElseIf $ArchEBarrack >= $CurArch Then
							TrainIt($eArcher, $CurArch)
						Else
							TrainIt($eArcher, $ArchEBarrack)
						EndIf
					EndIf
				EndIf

				If GUICtrlRead($txtNumGiants) <> "0" And $CurGiant > 0 Then
					;If _ColorCheck(_GetPixelColor(475, 366), Hex(0x3DD8E0, 6), 20) And $CurGiant > 0 Then
					If $CurGiant > 0 Then
						If $GiantEBarrack = 0 Then
							TrainIt($eGiant, 1)
						ElseIf $GiantEBarrack >= $CurGiant Or $GiantEBarrack = 0 Then
							TrainIt($eGiant, $CurGiant)
						Else
							TrainIt($eGiant, $GiantEBarrack)
						EndIf
					EndIf
				EndIf


				If GUICtrlRead($txtNumWallbreakers) <> "0" And $CurWB > 0 Then
					;If _ColorCheck(_GetPixelColor(688, 366), Hex(0x3AD8E0, 6), 20) And $CurWB > 0  Then
					If $CurWB > 0 Then
						If $WallEBarrack = 0 Then
							TrainIt($eWallbreaker, 1)
						ElseIf $WallEBarrack >= $CurWB Or $WallEBarrack = 0 Then
							TrainIt($eWallbreaker, $CurWB)
						Else
							TrainIt($eWallbreaker, $WallEBarrack)
						EndIf
					EndIf
				EndIf


				If GUICtrlRead($txtBarbarians) <> "0" And $CurBarb > 0 Then
					;If _ColorCheck(_GetPixelColor(369, 366), Hex(0x39D8E0, 6), 20) And $CurBarb > 0 Then
					If $CurBarb > 0 Then
						If $BarbEBarrack = 0 Then
							TrainIt($eBarbarian, 1)
						ElseIf $BarbEBarrack >= $CurBarb Or $BarbEBarrack = 0 Then
							TrainIt($eBarbarian, $CurBarb)
						Else
							TrainIt($eBarbarian, $BarbEBarrack)
						EndIf
					EndIf
				EndIf


				If GUICtrlRead($txtGoblins) <> "0" And $CurGoblin > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurGoblin > 0 Then
					If $CurGoblin > 0 Then
						If $GoblinEBarrack = 0 Then
							TrainIt($eGoblin, 1)
						ElseIf $GoblinEBarrack >= $CurGoblin Or $GoblinEBarrack = 0 Then
							TrainIt($eGoblin, $CurGoblin)
						Else
							TrainIt($eGoblin, $GoblinEBarrack)
						EndIf
					EndIf
			    EndIf

			EndIf
		EndIf
		If _Sleep(100) Then ExitLoop
		ClickP($TopLeftClient, 2, 250); Click away twice with 250ms delay
	Next
	SetLog("Training Troops Complete...", $COLOR_BLUE)
	resetBarracksError()
    $FirstStart = False
EndFunc   ;==>Train
