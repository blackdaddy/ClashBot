Func TrainDark()
	If $ichkDarkTroop = 0 Then Return

	If $DarkBarrackPos[0][0] = "" Then
		LocateDarkBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf

	Global $LeftRax1, $LeftRax2, $TrainDrax1, $TrainDrax2, $ClickRax1, $ClickRax2

	If $fullArmy Or $FirstDarkTrain Then
		$TrainDrax1 = True
		$TrainDrax2 = True
	EndIf

	If $TrainDrax1 = False And $TrainDrax2 = False Then Return

	SetLog("Training Dark Troops...", $COLOR_BLUE)

	For $i = 0 To 1
		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(500) Then ExitLoop

		Click($DarkBarrackPos[$i][0], $DarkBarrackPos[$i][1]) ;Click Dark Barrack
		If _Sleep(500) Then ExitLoop

		Local $TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x603818, 6), 5) ;Finds Train Troops button
		If IsArray($TrainPos) = False Then
			SetLog("Dark Barrack " & $i + 1 & " is not available", $COLOR_RED)
			If _Sleep(500) Then ExitLoop
		Else
			Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
			If _Sleep(800) Then ExitLoop

			If $fullArmy Or $FirstDarkTrain Then
				If Not _ColorCheck(_GetPixelColor(497, 195), Hex(0xE0E4D0, 6), 20) Then
					Click(496, 190, 80, 2)
				EndIf
			EndIf

;Dark Barrack 1
			If GUICtrlRead($txtDarkBarrack1) <> "0" And $i = 0 And $TrainDrax1 = True Then
				If $DarkBarrackTroop[$i] = 0 Then
					Local $troopMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					If $itxtDarkBarrack1 <= 20 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eMinion, $itxtDarkBarrack1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
					ElseIf $itxtDarkBarrack1 > 20 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eMinion, 20)
						$LeftRax1 = ($itxtDarkBarrack1 - 20)
						$ClickRax1 = $LeftRax1
						SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
					ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 > ($troopMinion < 20) Then
						TrainIt($eMinion, (20 - $troopMinion))
						$LeftRax1 = ($ClickRax1 - (20 - $troopMinion))
						$ClickRax1 = $LeftRax1
						SetLog("Dark Barrack 1 Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
					ElseIf $LeftRax1 > 1 And ($troopMinion < 20) And $LeftRax1 <= ($troopMinion < 20) Then
						TrainIt($eMinion, $LeftRax1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
					ElseIf $LeftRax1 <= 1 And ($troopMinion < 20) Then
						TrainIt($eMinion, $LeftRax1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Minion Completed...", $COLOR_BLUE)
					Else
						SetLog("Dark Barrack 1 Training in progress, Minion Remaining : " & $LeftRax1, $COLOR_BLUE)
					EndIf
				EndIf

				If $DarkBarrackTroop[$i] = 1 Then
					Local $troopHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					If $itxtDarkBarrack1 <= 10 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eHog, $itxtDarkBarrack1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
					ElseIf $itxtDarkBarrack1 > 10 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eHog, 10)
						$LeftRax1 = ($itxtDarkBarrack1 - 10)
						$ClickRax1 = $LeftRax1
						SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
					ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 > ($troopHog < 10) Then
						TrainIt($eHog, (10 - $troopHog))
						$LeftRax1 = ($ClickRax1 - (10 - $troopHog))
						$ClickRax1 = $LeftRax1
						SetLog("Dark Barrack 1 Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
					ElseIf $LeftRax1 > 1 And ($troopHog < 10) And $LeftRax1 <= ($troopHog < 10) Then
						TrainIt($eHog, $LeftRax1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
					ElseIf $LeftRax1 <= 1 And ($troopHog < 10) Then
						TrainIt($eHog, $LeftRax1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Hog Completed...", $COLOR_BLUE)
					Else
						SetLog("Dark Barrack 1 Training in progress, Hog Remaining : " & $LeftRax1, $COLOR_BLUE)
					EndIf
				EndIf

				If $DarkBarrackTroop[$i] = 2 Then
					Local $troopValkyrie = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					If $itxtDarkBarrack1 <= 7 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eValkyrie, $itxtDarkBarrack1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
					ElseIf $itxtDarkBarrack1 > 7 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eValkyrie, 7)
						$LeftRax1 = ($itxtDarkBarrack1 - 7)
						$ClickRax1 = $LeftRax1
						SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
					ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 > ($troopValkyrie < 7) Then
						TrainIt($eValkyrie, (7 - $troopValkyrie))
						$LeftRax1 = ($ClickRax1 - (7 - $troopValkyrie))
						$ClickRax1 = $LeftRax1
						SetLog("Dark Barrack 1 Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
					ElseIf $LeftRax1 > 1 And ($troopValkyrie < 7) And $LeftRax1 <= ($troopValkyrie < 7) Then
						TrainIt($eValkyrie, $LeftRax1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
					ElseIf $LeftRax1 <= 1 And ($troopValkyrie < 7) Then
						TrainIt($eValkyrie, $LeftRax1)
						$TrainDrax1 = False
						SetLog("Dark Barrack 1 Train Valkyrie Completed...", $COLOR_BLUE)
					Else
						SetLog("Dark Barrack 1 Training in progress, Valkyrie Remaining : " & $LeftRax1, $COLOR_BLUE)
					EndIf
				EndIf
			EndIf

;Dark Barrack 2
			If GUICtrlRead($txtDarkBarrack2) <> "0" And $i = 1 And $TrainDrax2 = True Then
				If $DarkBarrackTroop[$i] = 0 Then
					Local $troopMinion2 = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					If $itxtDarkBarrack2 <= 20 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eMinion, $itxtDarkBarrack2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
					ElseIf $itxtDarkBarrack2 > 20 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eMinion, 20)
						$LeftRax2 = ($itxtDarkBarrack2 - 20)
						$ClickRax2 = $LeftRax2
						SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
					ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 > ($troopMinion2 < 20) Then
						TrainIt($eMinion, (20 - $troopMinion2))
						$LeftRax2 = ($ClickRax2 - (20 - $troopMinion2))
						$ClickRax2 = $LeftRax2
						SetLog("Dark Barrack 2 Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
					ElseIf $LeftRax2 > 1 And ($troopMinion2 < 20) And $LeftRax2 <= ($troopMinion2 < 20) Then
						TrainIt($eMinion, $LeftRax2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
					ElseIf $LeftRax2 <= 1 And ($troopMinion2 < 20) Then
						TrainIt($eMinion, $LeftRax2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Minion Completed...", $COLOR_BLUE)
					Else
						SetLog("Dark Barrack 2 Training in progress, Minion Remaining : " & $LeftRax2, $COLOR_BLUE)
					EndIf
				EndIf

				If $DarkBarrackTroop[$i] = 1 Then
					Local $troopHog2 = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					If $itxtDarkBarrack2 <= 10 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eHog, $itxtDarkBarrack2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
					ElseIf $itxtDarkBarrack2 > 10 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eHog, 10)
						$LeftRax2 = ($itxtDarkBarrack2 - 10)
						$ClickRax2 = $LeftRax2
						SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
					ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 > ($troopHog2 < 10) Then
						TrainIt($eHog, (10 - $troopHog2))
						$LeftRax2 = ($ClickRax2 - (10 - $troopHog2))
						$ClickRax2 = $LeftRax2
						SetLog("Dark Barrack 2 Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
					ElseIf $LeftRax2 > 1 And ($troopHog2 < 10) And $LeftRax2 <= ($troopHog2 < 10) Then
						TrainIt($eHog, $LeftRax2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
					ElseIf $LeftRax2 <= 1 And ($troopHog2 < 10) Then
						TrainIt($eHog, $LeftRax2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Hog Completed...", $COLOR_BLUE)
					Else
						SetLog("Dark Barrack 2 Training in progress, Hog Remaining : " & $LeftRax2, $COLOR_BLUE)
					EndIf
				EndIf

				If $DarkBarrackTroop[$i] = 2 Then
					Local $troopValkyrie2 = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					If $itxtDarkBarrack2 <= 7 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eValkyrie, $itxtDarkBarrack2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
					ElseIf $itxtDarkBarrack2 > 7 And ($fullArmy Or $FirstDarkTrain) Then
						TrainIt($eValkyrie, 7)
						$LeftRax2 = ($itxtDarkBarrack2 - 7)
						$ClickRax2 = $LeftRax2
						SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
					ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 > ($troopValkyrie2 < 7) Then
						TrainIt($eValkyrie, (7 - $troopValkyrie2))
						$LeftRax2 = ($ClickRax2 - (7 - $troopValkyrie2))
						$ClickRax2 = $LeftRax2
						SetLog("Dark Barrack 2 Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
					ElseIf $LeftRax2 > 1 And ($troopValkyrie2 < 7) And $LeftRax2 <= ($troopValkyrie2 < 7) Then
						TrainIt($eValkyrie, $LeftRax2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
					ElseIf $LeftRax2 <= 1 And ($troopValkyrie2 < 7) Then
						TrainIt($eValkyrie, $LeftRax2)
						$TrainDrax2 = False
						SetLog("Dark Barrack 2 Train Valkyrie Completed...", $COLOR_BLUE)
					Else
						SetLog("Dark Barrack 2 Training in progress, Valkyrie Remaining : " & $LeftRax2, $COLOR_BLUE)
					EndIf
				EndIf
			EndIf

		EndIf
		If _Sleep(100) Then ExitLoop
		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
	Next
	SetLog("Dark Troop Training Complete...", $COLOR_BLUE)
	$FirstDarkTrain = False
EndFunc   ;==>TrainDark
