;==>ReArm
Func ReArm()
	If $ichkTrap = 0 Then Return

	SetLog("Checking if Village needs Rearming..", $COLOR_BLUE)

	If $TownHallPos[0] = -1 Then
		LocateTownHall()
		SaveConfig()
		If _Sleep(1000) Then Return
	EndIf

	ClickP($TopLeftClient) ; Click away
	If _Sleep(1000) Then Return
	Click($TownHallPos[0], $TownHallPos[1])
	If _Sleep(1000) Then Return

	Local $x1 = 240, $y1 = 563, $x2 = 670, $y2 = 600 ;Coordinates for button search

	;Traps
	Local $offColors[3][3] = [[0x8B7E79, 26, 25], [0xE2C73A, 70, 7], [0x2B2D1F, 76, 0]] ; 2nd pixel brown wrench, 3rd pixel gold, 4th pixel edge of button
	Local $RearmPixel = _MultiPixelSearch($x1, $y1, $x2, $y2, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30) ; first white pixel of button
	If IsArray($RearmPixel) Then
		Click($RearmPixel[0] + 20, $RearmPixel[1] + 20) ; Click RearmButton
		If _WaitForPixel(350, 420, Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Rearmed Traps", $COLOR_ORANGE)
		EndIf
	EndIf

	;Xbow
	Local $offColors[3][3] = [[0x95673D, 31, 26], [0xEF6CEE, 70, 7], [0x2B2D1F, 76, 0]]; xbow, elixir, edge
	Local $XbowPixel = _MultiPixelSearch($x1, $y1, $x2, $y2, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30) ; button start
	If IsArray($XbowPixel) Then
		Click($XbowPixel[0] + 20, $XbowPixel[1] + 20) ; Click XbowButton
		If _WaitForPixel(350, 420, Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Reloaded X-Bows", $COLOR_ORANGE)
		EndIf
	EndIf

	;Inferno
	Local $offColors[3][3] = [[0xF82D08, 22, 18], [0x5E4B68, 69, 7], [0x2B2D1F, 76, 0]]; inferno, dark, edge
	Local $InfernoPixel = _MultiPixelSearch($x1, $y1, $x2, $y2, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30)
	If IsArray($InfernoPixel) Then
		Click($InfernoPixel[0] + 20, $InfernoPixel[1] + 20) ; Click InfernoButton
		If _WaitForPixel(350, 420, Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Reloaded Infernos", $COLOR_ORANGE)
		EndIf
	EndIf

	ClickP($TopLeftClient) ; Click away
EndFunc   ;==>ReArm
