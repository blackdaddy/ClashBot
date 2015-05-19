Func RequestCC()
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		If $CCPos[0] = -1 Then
			LocateClanCastle()
			SaveConfig()
			If _Sleep(1000) Then Return
		EndIf
		While 1
			SetLog("Requesting for Clan Castle's Troops", $COLOR_BLUE)
			Click($CCPos[0], $CCPos[1])
			If _Sleep(1000) Then ExitLoop
			_CaptureRegion()
			$RequestTroop = _PixelSearch(310, 580, 553, 622, Hex(0x608C90, 6), 10)
			If IsArray($RequestTroop) Then
				Click($RequestTroop[0], $RequestTroop[1])
				If _WaitForPixel(340, 245, Hex(0xCC4010, 6), 20) Then
					If GUICtrlRead($txtRequest) <> "" Then
						Click(430, 140) ;Select text for request
						If _Sleep(1000) Then ExitLoop
						$TextRequest = GUICtrlRead($txtRequest)
						ControlSend($Title, "", "", $TextRequest, 0)
					EndIf
					If _Sleep(1000) Then ExitLoop
					Click(524, 228)
					;Click(340, 228)
				Else
					SetLog("Request's already been made", $COLOR_ORANGE)
					ClickP($TopLeftClient, 2)
				EndIf
			Else
				SetLog("Clan Castle not available", $COLOR_RED)
			EndIf
			ExitLoop
		WEnd
	EndIf
EndFunc   ;==>RequestCC
