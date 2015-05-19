;Donates troops

Func DonateCC()
	Global $Donate = $ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1 Or $ichkDonateAllBarbarians = 1 Or $ichkDonateAllArchers = 1 Or $ichkDonateAllGiants = 1
	If $Donate = False Then Return
	Local $y = 119
	SetLog("Donating Troops", $COLOR_BLUE)

	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(34, 321), Hex(0xE00300, 6), 20) = False And $CommandStop <> 3 Then
		SetLog("No new chats, skip donating", $COLOR_ORANGE)
		Return
	EndIf

	ClickP($TopLeftClient) ;Click Away
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) = False Then Click(19, 349) ;Clicks chat thing
	If _Sleep(500) Then Return
	Click(189, 24) ; clicking clan tab

	While $Donate
		Local $offColors[3][3] = [[0x000000, 0, -2], [0x262926, 0, 1], [0xF8FCF0, 0, 11]]
		While 1
			If _Sleep(1000) Then ExitLoop
			Global $DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
			If IsArray($DonatePixel) Then
				$Donate = False
				If ($ichkDonateAllBarbarians = 0 And $ichkDonateAllArchers = 0 And $ichkDonateAllGiants = 0) And ($ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1) Then
					_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
					Local $String = getString($DonatePixel[1] - 28)
					If $String = "" Then
						$String = getString($DonatePixel[1] - 17)
					Else
						$String = $String & @CRLF & getString($DonatePixel[1] - 17)
					EndIf

					SetLog("Chat Text: " & $String, $COLOR_GREEN)

					If $ichkDonateBarbarians = 1 Then
						Local $Barbs = StringSplit($itxtDonateBarbarians, @CRLF)
						For $i = 0 To UBound($Barbs) - 1
							If CheckDonate($Barbs[$i], $String) Then
								DonateBarbs()
								ExitLoop
							EndIf
						Next
						If $Donate Then
							If _Sleep(500) Then ExitLoop
							$y = $DonatePixel[1] + 10
							ExitLoop
						EndIf
					EndIf
					If $ichkDonateArchers = 1 Then
						Local $Archers = StringSplit($itxtDonateArchers, @CRLF)
						For $i = 0 To UBound($Archers) - 1
							If CheckDonate($Archers[$i], $String) Then
								DonateArchers()
								ExitLoop
							EndIf
						Next
						If $Donate Then
							If _Sleep(500) Then ExitLoop
							$y = $DonatePixel[1] + 10
							ExitLoop
						EndIf
					EndIf
					If $ichkDonateGiants = 1 Then
						Local $Giants = StringSplit($itxtDonateGiants, @CRLF)
						For $i = 0 To UBound($Giants) - 1
							If CheckDonate($Giants[$i], $String) Then
								DonateGiants()
								ExitLoop
							EndIf
						Next
						If $Donate Then
							If _Sleep(500) Then ExitLoop
							$y = $DonatePixel[1] + 10
							ExitLoop
						EndIf
					EndIf
				Else
					Select
						Case $ichkDonateAllBarbarians = 1
							DonateBarbs()
						Case $ichkDonateAllArchers = 1
							DonateArchers()
						Case $ichkDonateAllGiants = 1
							DonateGiants()
					EndSelect
				EndIf
			Else
				ExitLoop
			EndIf
			If _Sleep(500) Then Return
			ClickP($TopLeftClient) ;Click Away
			$y = $DonatePixel[1] + 10
		WEnd
		$DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
		Local $Scroll = _PixelSearch(285, 650, 287, 700, Hex(0x97E405, 6), 20)
		$Donate = True
		If IsArray($Scroll) Then
			Click($Scroll[0], $Scroll[1])
			$y = 119
			If _Sleep(700) Then ExitLoop
		ElseIf Not IsArray($DonatePixel) Then
			$Donate = False
		EndIf
	WEnd

	If _WaitForPixel(331, 330, Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
		If _Sleep(500) Then Return
	EndIf
	SetLog("Finished Donating", $COLOR_BLUE)
EndFunc   ;==>DonateCC

Func CheckDonate($String, $clanString) ;Checks if it exact
	$Contains = StringMid($String, 1, 1) & StringMid($String, StringLen($String), 1)
	If $Contains = "[]" Then
		If $clanString = StringMid($String, 2, StringLen($String) - 2) Then
			Return True
		Else
			Return False
		EndIf
	Else
		If StringInStr($clanString, $String, 2) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc   ;==>CheckDonate

Func DonateBarbs()
	If $ichkDonateBarbarians = 1 Or $ichkDonateAllBarbarians = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) Then Return
		_CaptureRegion(0, 0, 517, $DonatePixel[1] + 50)
		If _ColorCheck(_GetPixelColor(237, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Then ;Or _ColorCheck(_GetPixelColor(237, $DonatePixel[1] - 10), Hex(0x507C00, 6), 10) Then
			SetLog("Donating Barbarians", $COLOR_BLUE)
			While _WaitForPixelCapture(0, 0, 517, $DonatePixel[1] + 50, 237, $DonatePixel[1] - 5, Hex(0x507C00, 6), 10, 800, 50)
				Click(237, $DonatePixel[1] - 5)
				$CurBarb += 1
			WEnd
			$CurBarb -= 1 ;_WaitForPixel tends to allow one extra click due to delay in picture going grey
			$Donate = True
		ElseIf $ichkDonateAllArchers = 1 Then
			DonateArchers()
			Return
		Else
			SetLog("No troops available for donation, donating later...", $COLOR_ORANGE)
			Return
		EndIf
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	Else
		DonateArchers()
		Return
	EndIf
EndFunc   ;==>DonateBarbs

Func DonateArchers()
	If $ichkDonateArchers = 1 Or $ichkDonateAllArchers = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) Then Return
		_CaptureRegion(0, 0, 517, $DonatePixel[1] + 50)
		If _ColorCheck(_GetPixelColor(315, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Then ;Or _ColorCheck(_GetPixelColor(315, $DonatePixel[1] - 10), Hex(0x507C00, 6), 10) Then
			SetLog("Donating Archers", $COLOR_BLUE)
			While _WaitForPixelCapture(0, 0, 517, $DonatePixel[1] + 50, 315, $DonatePixel[1] - 5, Hex(0x507C00, 6), 10, 800, 50)
				Click(315, $DonatePixel[1] - 5)
				$CurArch += 1
			WEnd
			$CurArch -= 1 ;_WaitForPixel tends to allow one extra click due to delay in picture going grey
			$Donate = True
		ElseIf $ichkDonateAllGiants = 1 Then
			DonateGiants()
			Return
		Else
			SetLog("No troops available for donation, donating later...", $COLOR_ORANGE)
			Return
		EndIf
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	Else
		DonateGiants()
		Return
	EndIf
EndFunc   ;==>DonateArchers

Func DonateGiants()
	If $ichkDonateGiants = 1 Or $ichkDonateAllGiants = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) Then Return
		_CaptureRegion(0, 0, 517, $DonatePixel[1] + 50)
		;Giants Fixed
		If _ColorCheck(_GetPixelColor(400, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Then ;Or _ColorCheck(_GetPixelColor(480, $DonatePixel[1] - 10), Hex(0x507C00, 6), 10) Then
			SetLog("Donating Giants", $COLOR_BLUE)
			While _WaitForPixelCapture(0, 0, 517, $DonatePixel[1] + 50, 400, $DonatePixel[1] - 5, Hex(0x507C00, 6), 10, 800, 50)
				Click(400, $DonatePixel[1] - 5)
				$CurGiant += 1
			WEnd
			$CurGiant -= 1 ;_WaitForPixel tends to allow one extra click due to delay in picture going grey
			$Donate = True
		Else
			SetLog("No troops available for donation, donating later...", $COLOR_ORANGE)
		EndIf
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	Else
		SetLog("No troops available for donation, donating later...", $COLOR_ORANGE)
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	EndIf
EndFunc   ;==>DonateGiants
