;Will detect how much gold per search
Func CheckCostPerSearch()
    If $SearchCost <> 0 Then Return

	SetLog("Checking Townhall Level...", $COLOR_BLUE)

	If $TownHallPos[0] = -1 Then
		LocateTownHall()
		SaveConfig()
		If _Sleep(1000) Then Return
	EndIf

	ClickP($TopLeftClient) ;Click Away
	If _Sleep(500) Then Return

	Click($TownHallPos[0], $TownHallPos[1]) ; Click Townhall
	If _Sleep(500) Then Return

	Local $Info = _PixelSearch(240, 550, 484, 650, Hex(0x4084B8, 6), 5) ;Finds Info button
	If IsArray($Info) = False Then
	  SetLog("Townhall Info Button is not available", $COLOR_RED)
	  If _Sleep(500) Then Return
	Else
	  Click($Info[0], $Info[1]) ;Click Info Button

		If _Sleep(800) Then Return
		Local $THLevel = getOther(495, 136, "Townhall")

		If $THLevel = "1" Then
			$SearchCost = 10
		ElseIf $THLevel = "2" Then
			$SearchCost = 50
		ElseIf $THLevel = "3" Then
			$SearchCost = 75
		ElseIf $THLevel = "4" Then
			$SearchCost = 110
		ElseIf $THLevel = "5" Then
			$SearchCost = 170
		ElseIf $THLevel = "6" Then
			$SearchCost = 250
		ElseIf $THLevel = "7" Then
			$SearchCost = 380
		ElseIf $THLevel = "8" Then
			$SearchCost = 580
		ElseIf $THLevel = "9" Then
			$SearchCost = 750
		ElseIf $THLevel = "10" Then
			$SearchCost = 1000
		EndIf

	    SetLog("Townhall Level " & $THLevel &", Gold Cost Per Search: " & $SearchCost, $COLOR_GREEN)
	EndIf
	ClickP($TopLeftClient, 2, 250); Click away twice with 250ms delay
EndFunc   ;==>CheckGoldCostPerSearch