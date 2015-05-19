Func TrainCustom()

	If $barrackPos[0][0] = "" Then
		LocateBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf

 	Global $LeftTrain0, $LeftTrain1, $LeftTrain2, $LeftTrain3
 	Global $ClickTrain0, $ClickTrain1, $ClickTrain2, $ClickTrain3
	Global $Trainrax0, $Trainrax1, $Trainrax2, $Trainrax3

	If $fullArmy Or $FirstTrain Then
		$Trainrax0 = True
		$Trainrax1 = True
		$Trainrax2 = True
		$Trainrax3 = True
	 EndIf

	SetLog("Training Custom Troops...", $COLOR_BLUE)

	For $i = 0 To 3 ;iterate through barracks
		If _Sleep(500) Then ExitLoop

		ClickP($TopLeftClient) ;Click Away

		If _Sleep(500) Then ExitLoop

		Click($barrackPos[$i][0], $barrackPos[$i][1]) ;Click Barrack
		If _Sleep(500) Then ExitLoop

		Local $TrainPos = _PixelSearch(155, 590, 694, 605, Hex(0x6D4018, 6), 10) ;Finds Train Troops button
		If IsArray($TrainPos) = False Then
			SetLog("Barrack " & $i + 1 & " is not available!!", $COLOR_RED)
			If _Sleep(500) Then ExitLoop
		Else
			Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
			SetLog("Barrack " & $i + 1 & " Training...", $COLOR_GREEN)
			If _Sleep(1000) Then ExitLoop

			If $fullArmy Or $FirstTrain Then
				If Not _ColorCheck(_GetPixelColor(497, 195), Hex(0xE0E4D0, 6), 20) Then
					Click(496, 190, 80, 2)
				EndIf
			EndIf

;Barrack 1
		 If GUICtrlRead($txtFirstTroop1) <> "0" And $i = 0 And $Trainrax0 = True Then
	   			Switch $CustomTroopF[$i]
					Case 0
					Local $troopBarbarian = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eBarbarian, $itxtFirstTroop[$i])
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eBarbarian, 20)
						$LeftTrain0 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Barbarian Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopBarbarian < 20) And $LeftTrain0 > (20 - $troopBarbarian) Then
						TrainIt($eBarbarian, (20 - $troopBarbarian))
						$LeftTrain0 = ($ClickTrain0 - (20 - $troopBarbarian))
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Barbarian Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopBarbarian < 20) And $LeftTrain0 <= (20 - $troopBarbarian) Then
						TrainIt($eBarbarian, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain0 <= 1 And ($troopBarbarian < 20) Then
						TrainIt($eBarbarian, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " raining in progress, Barbarian Remaining : " & $LeftTrain0, $COLOR_BLUE)
					EndIf

					Case 1
					Local $troopArcher = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eArcher, $itxtFirstTroop[$i])
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eArcher, 20)
						$LeftTrain0 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Archer Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopArcher < 20) And $LeftTrain0 > (20 - $troopArcher) Then
						TrainIt($eArcher, (20 - $troopArcher))
						$LeftTrain0 = ($ClickTrain0 - (20 - $troopArcher))
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Archer Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopArcher < 20) And $LeftTrain0 <= (20 - $troopArcher) Then
						TrainIt($eArcher, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain0 <= 1 And ($troopArcher < 20) Then
						TrainIt($eArcher, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Archer Remaining : " & $LeftTrain0, $COLOR_BLUE)
					EndIf

					Case 2
					Local $troopGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 6 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGiant, $itxtFirstTroop[$i])
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 6 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGiant, 6)
						$LeftTrain0 = ($itxtFirstTroop[$i] - 6)
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Giant Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopGiant < 6) And $LeftTrain0 > (6 - $troopGiant) Then
						TrainIt($eGiant, (6 - $troopGiant))
						$LeftTrain0 = ($ClickTrain0 - (6 - $troopGiant))
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Giant Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopGiant < 6) And $LeftTrain0 <= (6 - $troopGiant) Then
						TrainIt($eGiant, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain0 <= 1 And ($troopGiant < 6) Then
						TrainIt($eGiant, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Giant Remaining : " & $LeftTrain0, $COLOR_BLUE)
					EndIf

					Case 3
					Local $troopGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGoblin, $itxtFirstTroop[$i])
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGoblin, 20)
						$LeftTrain0 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Goblin Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopGoblin < 20) And $LeftTrain0 > (20 - $troopGoblin) Then
						TrainIt($eGoblin, (20 - $troopGoblin))
						$LeftTrain0 = ($ClickTrain0 - (20 - $troopGoblin))
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Goblin Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopGoblin < 20) And $LeftTrain0 <= (20 - $troopGoblin) Then
						TrainIt($eGoblin, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain0 <= 1 And ($troopGoblin < 20) Then
						TrainIt($eGoblin, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Goblin Remaining : " & $LeftTrain0, $COLOR_BLUE)
					EndIf

					Case 4
					Local $troopWallbreaker = Number(getOther(171 + 107 * 4, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 10 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eWallbreaker, $itxtFirstTroop[$i])
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 10 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eWallbreaker, 10)
						$LeftTrain0 = ($itxtFirstTroop[$i] - 10)
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Wallbreaker Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopWallbreaker < 10) And $LeftTrain0 > (10 - $troopWallbreaker) Then
						TrainIt($eWallbreaker, (10 - $troopWallbreaker))
						$LeftTrain0 = ($ClickTrain0 - (10 - $troopWallbreaker))
						$ClickTrain0 = $LeftTrain0
						SetLog("Barrack " & $i+1 & " Wallbreaker Remaining : " & $LeftTrain0, $COLOR_BLUE)
					ElseIf $LeftTrain0 > 1 And ($troopWallbreaker < 10) And $LeftTrain0 <= (10 - $troopWallbreaker) Then
						TrainIt($eWallbreaker, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain0 <= 1 And ($troopWallbreaker < 10) Then
						TrainIt($eWallbreaker, $LeftTrain0)
						$Trainrax0 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Wallbreaker Remaining : " & $LeftTrain0, $COLOR_BLUE)
					EndIf

					Case 5
						If _Sleep(50) Then Return
						$Trainrax0 = False
				EndSwitch
			EndIf

;Barrack 2
		 If GUICtrlRead($txtFirstTroop1) <> "0" And $i = 1 And $Trainrax1 = True Then
	   			Switch $CustomTroopF[$i]
					Case 0
					Local $troopBarbarian = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eBarbarian, $itxtFirstTroop[$i])
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eBarbarian, 20)
						$LeftTrain1 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Barbarian Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopBarbarian < 20) And $LeftTrain1 > (20 - $troopBarbarian) Then
						TrainIt($eBarbarian, (20 - $troopBarbarian))
						$LeftTrain1 = ($ClickTrain1 - (20 - $troopBarbarian))
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Barbarian Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopBarbarian < 20) And $LeftTrain1 <= (20 - $troopBarbarian) Then
						TrainIt($eBarbarian, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain1 <= 1 And ($troopBarbarian < 20) Then
						TrainIt($eBarbarian, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " raining in progress, Barbarian Remaining : " & $LeftTrain1, $COLOR_BLUE)
					EndIf

					Case 1
					Local $troopArcher = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eArcher, $itxtFirstTroop[$i])
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eArcher, 20)
						$LeftTrain1 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Archer Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopArcher < 20) And $LeftTrain1 > (20 - $troopArcher) Then
						TrainIt($eArcher, (20 - $troopArcher))
						$LeftTrain1 = ($ClickTrain1 - (20 - $troopArcher))
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Archer Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopArcher < 20) And $LeftTrain1 <= (20 - $troopArcher) Then
						TrainIt($eArcher, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain1 <= 1 And ($troopArcher < 20) Then
						TrainIt($eArcher, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Archer Remaining : " & $LeftTrain1, $COLOR_BLUE)
					EndIf

					Case 2
					Local $troopGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 6 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGiant, $itxtFirstTroop[$i])
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 6 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGiant, 6)
						$LeftTrain1 = ($itxtFirstTroop[$i] - 6)
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Giant Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopGiant < 6) And $LeftTrain1 > (6 - $troopGiant) Then
						TrainIt($eGiant, (6 - $troopGiant))
						$LeftTrain1 = ($ClickTrain1 - (6 - $troopGiant))
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Giant Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopGiant < 6) And $LeftTrain1 <= (6 - $troopGiant) Then
						TrainIt($eGiant, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain1 <= 1 And ($troopGiant < 6) Then
						TrainIt($eGiant, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Giant Remaining : " & $LeftTrain1, $COLOR_BLUE)
					EndIf

					Case 3
					Local $troopGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGoblin, $itxtFirstTroop[$i])
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGoblin, 20)
						$LeftTrain1 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Goblin Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopGoblin < 20) And $LeftTrain1 > (20 - $troopGoblin) Then
						TrainIt($eGoblin, (20 - $troopGoblin))
						$LeftTrain1 = ($ClickTrain1 - (20 - $troopGoblin))
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Goblin Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopGoblin < 20) And $LeftTrain1 <= (20 - $troopGoblin) Then
						TrainIt($eGoblin, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain1 <= 1 And ($troopGoblin < 20) Then
						TrainIt($eGoblin, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Goblin Remaining : " & $LeftTrain1, $COLOR_BLUE)
					EndIf

					Case 4
					Local $troopWallbreaker = Number(getOther(171 + 107 * 4, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 10 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eWallbreaker, $itxtFirstTroop[$i])
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 10 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eWallbreaker, 10)
						$LeftTrain1 = ($itxtFirstTroop[$i] - 10)
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Wallbreaker Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopWallbreaker < 10) And $LeftTrain1 > (10 - $troopWallbreaker) Then
						TrainIt($eWallbreaker, (10 - $troopWallbreaker))
						$LeftTrain1 = ($ClickTrain1 - (10 - $troopWallbreaker))
						$ClickTrain1 = $LeftTrain1
						SetLog("Barrack " & $i+1 & " Wallbreaker Remaining : " & $LeftTrain1, $COLOR_BLUE)
					ElseIf $LeftTrain1 > 1 And ($troopWallbreaker < 10) And $LeftTrain1 <= (10 - $troopWallbreaker) Then
						TrainIt($eWallbreaker, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain1 <= 1 And ($troopWallbreaker < 10) Then
						TrainIt($eWallbreaker, $LeftTrain1)
						$Trainrax1 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Wallbreaker Remaining : " & $LeftTrain1, $COLOR_BLUE)
					EndIf

					Case 5
						If _Sleep(50) Then Return
						$Trainrax1 = False
				EndSwitch
			EndIf

;Barrack 3
			If GUICtrlRead($txtFirstTroop3) <> "0" And $i = 2 And $Trainrax2 = True Then
	   			Switch $CustomTroopF[$i]
					Case 0
					Local $troopBarbarian = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eBarbarian, $itxtFirstTroop[$i])
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eBarbarian, 20)
						$LeftTrain2 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Barbarian Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopBarbarian < 20) And $LeftTrain2 > (20 - $troopBarbarian) Then
						TrainIt($eBarbarian, (20 - $troopBarbarian))
						$LeftTrain2 = ($ClickTrain2 - (20 - $troopBarbarian))
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Barbarian Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopBarbarian < 20) And $LeftTrain2 <= (20 - $troopBarbarian) Then
						TrainIt($eBarbarian, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain2 <= 1 And ($troopBarbarian < 20) Then
						TrainIt($eBarbarian, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " raining in progress, Barbarian Remaining : " & $LeftTrain2, $COLOR_BLUE)
					EndIf

					Case 1
					Local $troopArcher = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eArcher, $itxtFirstTroop[$i])
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eArcher, 20)
						$LeftTrain2 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Archer Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopArcher < 20) And $LeftTrain2 > (20 - $troopArcher) Then
						TrainIt($eArcher, (20 - $troopArcher))
						$LeftTrain2 = ($ClickTrain2 - (20 - $troopArcher))
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Archer Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopArcher < 20) And $LeftTrain2 <= (20 - $troopArcher) Then
						TrainIt($eArcher, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain2 <= 1 And ($troopArcher < 20) Then
						TrainIt($eArcher, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Archer Remaining : " & $LeftTrain2, $COLOR_BLUE)
					EndIf

					Case 2
					Local $troopGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 6 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGiant, $itxtFirstTroop[$i])
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 6 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGiant, 6)
						$LeftTrain2 = ($itxtFirstTroop[$i] - 6)
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Giant Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopGiant < 6) And $LeftTrain2 > (6 - $troopGiant) Then
						TrainIt($eGiant, (6 - $troopGiant))
						$LeftTrain2 = ($ClickTrain2 - (6 - $troopGiant))
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Giant Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopGiant < 6) And $LeftTrain2 <= (6 - $troopGiant) Then
						TrainIt($eGiant, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain2 <= 1 And ($troopGiant < 6) Then
						TrainIt($eGiant, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Giant Remaining : " & $LeftTrain2, $COLOR_BLUE)
					EndIf

					Case 3
					Local $troopGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGoblin, $itxtFirstTroop[$i])
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGoblin, 20)
						$LeftTrain2 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Goblin Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopGoblin < 20) And $LeftTrain2 > (20 - $troopGoblin) Then
						TrainIt($eGoblin, (20 - $troopGoblin))
						$LeftTrain2 = ($ClickTrain2 - (20 - $troopGoblin))
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Goblin Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopGoblin < 20) And $LeftTrain2 <= (20 - $troopGoblin) Then
						TrainIt($eGoblin, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain2 <= 1 And ($troopGoblin < 20) Then
						TrainIt($eGoblin, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Goblin Remaining : " & $LeftTrain2, $COLOR_BLUE)
					EndIf

					Case 4
					Local $troopWallbreaker = Number(getOther(171 + 107 * 4, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 10 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eWallbreaker, $itxtFirstTroop[$i])
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 10 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eWallbreaker, 10)
						$LeftTrain2 = ($itxtFirstTroop[$i] - 10)
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Wallbreaker Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopWallbreaker < 10) And $LeftTrain2 > (10 - $troopWallbreaker) Then
						TrainIt($eWallbreaker, (10 - $troopWallbreaker))
						$LeftTrain2 = ($ClickTrain2 - (10 - $troopWallbreaker))
						$ClickTrain2 = $LeftTrain2
						SetLog("Barrack " & $i+1 & " Wallbreaker Remaining : " & $LeftTrain2, $COLOR_BLUE)
					ElseIf $LeftTrain2 > 1 And ($troopWallbreaker < 10) And $LeftTrain2 <= (10 - $troopWallbreaker) Then
						TrainIt($eWallbreaker, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain2 <= 1 And ($troopWallbreaker < 10) Then
						TrainIt($eWallbreaker, $LeftTrain2)
						$Trainrax2 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Wallbreaker Remaining : " & $LeftTrain2, $COLOR_BLUE)
					EndIf

					Case 5
						If _Sleep(50) Then Return
						$Trainrax2 = False
				EndSwitch
			EndIf

;Barrack 4
		    If GUICtrlRead($txtFirstTroop4) <> "0" And $i = 3 And $Trainrax3 = True Then
	   			Switch $CustomTroopF[$i]
					Case 0
					Local $troopBarbarian = Number(getOther(171 + 107 * 0, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eBarbarian, $itxtFirstTroop[$i])
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eBarbarian, 20)
						$LeftTrain3 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Barbarian Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopBarbarian < 20) And $LeftTrain3 > (20 - $troopBarbarian) Then
						TrainIt($eBarbarian, (20 - $troopBarbarian))
						$LeftTrain3 = ($ClickTrain3 - (20 - $troopBarbarian))
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Barbarian Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopBarbarian < 20) And $LeftTrain3 <= (20 - $troopBarbarian) Then
						TrainIt($eBarbarian, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain3 <= 1 And ($troopBarbarian < 20) Then
						TrainIt($eBarbarian, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Barbarian Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " raining in progress, Barbarian Remaining : " & $LeftTrain3, $COLOR_BLUE)
					EndIf

					Case 1
					Local $troopArcher = Number(getOther(171 + 107 * 1, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eArcher, $itxtFirstTroop[$i])
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eArcher, 20)
						$LeftTrain3 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Archer Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopArcher < 20) And $LeftTrain3 > (20 - $troopArcher) Then
						TrainIt($eArcher, (20 - $troopArcher))
						$LeftTrain3 = ($ClickTrain3 - (20 - $troopArcher))
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Archer Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopArcher < 20) And $LeftTrain3 <= (20 - $troopArcher) Then
						TrainIt($eArcher, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain3 <= 1 And ($troopArcher < 20) Then
						TrainIt($eArcher, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Archer Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Archer Remaining : " & $LeftTrain3, $COLOR_BLUE)
					EndIf

					Case 2
					Local $troopGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 6 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGiant, $itxtFirstTroop[$i])
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 6 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGiant, 6)
						$LeftTrain3 = ($itxtFirstTroop[$i] - 6)
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Giant Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopGiant < 6) And $LeftTrain3 > (6 - $troopGiant) Then
						TrainIt($eGiant, (6 - $troopGiant))
						$LeftTrain3 = ($ClickTrain3 - (6 - $troopGiant))
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Giant Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopGiant < 6) And $LeftTrain3 <= (6 - $troopGiant) Then
						TrainIt($eGiant, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain3 <= 1 And ($troopGiant < 6) Then
						TrainIt($eGiant, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Giant Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Giant Remaining : " & $LeftTrain3, $COLOR_BLUE)
					EndIf

					Case 3
					Local $troopGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGoblin, $itxtFirstTroop[$i])
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 20 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eGoblin, 20)
						$LeftTrain3 = ($itxtFirstTroop[$i] - 20)
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Goblin Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopGoblin < 20) And $LeftTrain3 > (20 - $troopGoblin) Then
						TrainIt($eGoblin, (20 - $troopGoblin))
						$LeftTrain3 = ($ClickTrain3 - (20 - $troopGoblin))
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Goblin Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopGoblin < 20) And $LeftTrain3 <= (20 - $troopGoblin) Then
						TrainIt($eGoblin, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain3 <= 1 And ($troopGoblin < 20) Then
						TrainIt($eGoblin, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Goblin Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Goblin Remaining : " & $LeftTrain3, $COLOR_BLUE)
					EndIf

					Case 4
					Local $troopWallbreaker = Number(getOther(171 + 107 * 4, 278, "Barrack"))
					If $itxtFirstTroop[$i] <= 10 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eWallbreaker, $itxtFirstTroop[$i])
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					ElseIf $itxtFirstTroop[$i] > 10 And ($fullArmy Or $FirstTrain) Then
						TrainIt($eWallbreaker, 10)
						$LeftTrain3 = ($itxtFirstTroop[$i] - 10)
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Wallbreaker Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopWallbreaker < 10) And $LeftTrain3 > (10 - $troopWallbreaker) Then
						TrainIt($eWallbreaker, (10 - $troopWallbreaker))
						$LeftTrain3 = ($ClickTrain3 - (10 - $troopWallbreaker))
						$ClickTrain3 = $LeftTrain3
						SetLog("Barrack " & $i+1 & " Wallbreaker Remaining : " & $LeftTrain3, $COLOR_BLUE)
					ElseIf $LeftTrain3 > 1 And ($troopWallbreaker < 10) And $LeftTrain3 <= (10 - $troopWallbreaker) Then
						TrainIt($eWallbreaker, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					ElseIf $LeftTrain3 <= 1 And ($troopWallbreaker < 10) Then
						TrainIt($eWallbreaker, $LeftTrain3)
						$Trainrax3 = False
						SetLog("Barrack " & $i+1 & " Train Wallbreaker Completed...", $COLOR_BLUE)
					Else
						SetLog("Barrack " & $i+1 & " Training in progress, Wallbreaker Remaining : " & $LeftTrain3, $COLOR_BLUE)
					EndIf

					Case 5
						If _Sleep(50) Then Return
						$Trainrax3 = False
				EndSwitch
			EndIf

		 If GUICtrlRead($txtFirstTroop1) = "0" Or $Trainrax0 = False and $i = 0 Then
			_CaptureRegion()
			Switch $CustomTroopS[0]
			Case 0
			   While _WaitForPixel(220, 320, Hex(0xF89683, 6), 20, 800, 30)
					 Click(220, 320, 20) ;Barbarian
			   WEnd
			Case 1
			   While _WaitForPixel(325, 330, Hex(0xF8C3B0, 6), 20, 800, 30)
					 Click(325, 320, 20) ;Archer
			   WEnd
			Case 2
			   While _WaitForPixel(430, 320, Hex(0xE68358, 6), 20, 800, 30)
					 Click(430, 320, 5) ;Giant
			   WEnd
			Case 3
			   While _WaitForPixel(535, 310, Hex(0x7AA440, 6), 20, 800, 30)
					 Click(535, 320, 20) ;Goblin
				  WEnd
			Case Else
			   If _Sleep(50) Then Return
			   _CaptureRegion()
			EndSwitch
		 EndIf

		 If GUICtrlRead($txtFirstTroop2) = "0" Or $Trainrax1 = False and $i = 1 Then
			_CaptureRegion()
			Switch $CustomTroopS[1]
			Case 0
			   While _WaitForPixel(220, 320, Hex(0xF89683, 6), 20, 800, 30)
					 Click(220, 320, 20) ;Barbarian
			   WEnd
			Case 1
			   While _WaitForPixel(325, 330, Hex(0xF8C3B0, 6), 20, 800, 30)
					 Click(325, 320, 20) ;Archer
			   WEnd
			Case 2
			   While _WaitForPixel(430, 320, Hex(0xE68358, 6), 20, 800, 30)
					 Click(430, 320, 5) ;Giant
			   WEnd
			Case 3
			   While _WaitForPixel(535, 310, Hex(0x7AA440, 6), 20, 800, 30)
					 Click(535, 320, 20) ;Goblin
				  WEnd
			Case Else
			   If _Sleep(50) Then Return
			   _CaptureRegion()
			EndSwitch
		 EndIf

		 If GUICtrlRead($txtFirstTroop3) = "0" Or $Trainrax2 = False and $i = 2 Then
			_CaptureRegion()
			Switch $CustomTroopS[2]
			Case 0
			   While _WaitForPixel(220, 320, Hex(0xF89683, 6), 20, 800, 30)
					 Click(220, 320, 20) ;Barbarian
			   WEnd
			Case 1
			   While _WaitForPixel(325, 330, Hex(0xF8C3B0, 6), 20, 800, 30)
					 Click(325, 320, 20) ;Archer
			   WEnd
			Case 2
			   While _WaitForPixel(430, 320, Hex(0xE68358, 6), 20, 800, 30)
					 Click(430, 320, 5) ;Giant
			   WEnd
			Case 3
			   While _WaitForPixel(535, 310, Hex(0x7AA440, 6), 20, 800, 30)
					 Click(535, 320, 20) ;Goblin
				  WEnd
			Case Else
			   If _Sleep(50) Then Return
			   _CaptureRegion()
			EndSwitch
		 EndIf

		 If GUICtrlRead($txtFirstTroop4) = "0" Or $Trainrax3 = False and $i = 3 Then
			_CaptureRegion()
			Switch $CustomTroopS[3]
			Case 0
			   While _WaitForPixel(220, 320, Hex(0xF89683, 6), 20, 800, 30)
					 Click(220, 320, 20) ;Barbarian
			   WEnd
			Case 1
			   While _WaitForPixel(325, 330, Hex(0xF8C3B0, 6), 20, 800, 30)
					 Click(325, 320, 20) ;Archer
			   WEnd
			Case 2
			   While _WaitForPixel(430, 320, Hex(0xE68358, 6), 20, 800, 30)
					 Click(430, 320, 5) ;Giant
			   WEnd
			Case 3
			   While _WaitForPixel(535, 310, Hex(0x7AA440, 6), 20, 800, 30)
					 Click(535, 320, 20) ;Goblin
				  WEnd
			Case Else
			   If _Sleep(50) Then Return
			   _CaptureRegion()
			EndSwitch
		 EndIf

	    EndIf
		If _Sleep(100) Then ExitLoop
		ClickP($TopLeftClient, 2, 250); Click away twice with 250ms delay
	Next
	SetLog("Training Troops Complete...", $COLOR_BLUE)
    $FirstTrain = False
 EndFunc   ;==>TrainCustom