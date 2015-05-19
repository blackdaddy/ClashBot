;Goes into a match, breaks shield if it has to

Func PrepareSearch() ;Click attack button and find match button, will break shield
	While 1
		SetLog("Searching...")
		Click(60, 614);Click Attack Button
		If _Sleep(1000) Then ExitLoop
		Click(217, 510);Click Find a Match Button
		If _Sleep(3000) Then ExitLoop
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(287, 494), Hex(0xEEAC28, 6), 50) Then
			Click(217, 510);Click Find a Match again if stuck at find match screen
		EndIf
		If _Sleep(1000) Then ExitLoop
		_CaptureRegion()
		Local $offColors[3][3] = [[0x202C0D, 105, 0], [0x60B010, 30, 30], [0xFFFFFF, 20, 20]] ; 2nd pixel edge of button, 3rd pixel dark green of button, 4th pixel white of ok
		Local $ShieldPixel = _MultiPixelSearch(480, 380, 586, 411, 1, 1, Hex(0xD0E878, 6), $offColors, 30) ; light green pixel of button
		If IsArray($ShieldPixel) Then
			Click($ShieldPixel[0], $ShieldPixel[1]);Click Okay To Break Shield
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>PrepareSearch
