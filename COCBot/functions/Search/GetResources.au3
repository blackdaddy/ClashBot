;Uses the getGold,getElixir... functions and uses CompareResources until it meets conditions.
;Will wait ten seconds until getGold returns a value other than "", if longer than 10 seconds - calls checkNextButton
;-clicks next if checkNextButton returns true, otherwise will restart the bot.

Func GetResources() ;Reads resources
	While 1
		Local $i = 0
		Local $x = 0
		Local $txtDead = "-"
		While getGold(51, 66) = "" ; Loops until gold is readable
			If _Sleep(500, False) Then ExitLoop (2)
			$i += 1
			If $i >= 20 Then ; If gold cannot be read by 10 seconds
				If checkNextButton() And $x <= 20 Then ;Checks for Out of Sync or Connection Error during search
					Click(750, 500) ;Click Next
					$x += 1
				Else
					SetLog("Cannot locate Next button, Restarting Bot", $COLOR_RED)
					if GUICtrlRead($lblpushbulletenabled) = $GUI_CHECKED and GUICtrlRead($lblerror) = $GUI_CHECKED Then
						_Push("Disconnected","Your bot got disconnected while searching for enemy..")
					EndIf
					checkMainScreen()
					$Restart = True
					ExitLoop (2)
				EndIf
				$i = 0
			EndIf
		WEnd
		If _Sleep(300, False) Then ExitLoop (2)

		$searchDead = checkDeadBase()
		$searchTH = checkTownhall()
		$searchGold = getGold(51, 66)
		$searchElixir = getElixir(51, 66 + 29)
		$searchTrophy = getTrophy(51, 66 + 90)

		If $searchDead Then $txtDead = "Dead"

		If $searchTrophy <> "" Then
			$searchDark = getDarkElixir(51, 66 + 57)
		Else
			$searchDark = 0
			$searchTrophy = getTrophy(51, 66 + 60)
		EndIf

		If $THx > 227 And $THx < 627 And $THy > 151 And $THy < 419 And $searchTH <> "-" Then
			$THLoc = "In"
		ElseIf $searchTH <> "-" Then
			$THLoc = "Out"
		Else
			$THLoc = $searchTH
			$THx = 0
			$THy = 0
		EndIf

		$SearchCount += 1 ; Counter for number of searches
		SetLog("(" & $SearchCount & ") [G]: " & $searchGold & Tab($searchGold, 7) & "[E]: " & $searchElixir & Tab($searchElixir, 7) & "[D]: " & $searchDark & Tab($searchDark, 4) & "[T]: " & $searchTrophy & Tab($searchTrophy, 3) & "[TH]: " & $searchTH & ", " & $THLoc & ", " & $txtDead, $COLOR_BLUE)
		ExitLoop
	WEnd
EndFunc   ;==>GetResources
