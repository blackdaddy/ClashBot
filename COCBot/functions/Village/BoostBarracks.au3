;==>BoostBarracks
Func BoostBarracks()
	If (GUICtrlRead($cmbBoostBarracks) > 0) And ($boostsEnabled = 1) Then
		If $barrackPos[0][0] = "" Then
			LocateBarrack()
			SaveConfig()
			If _Sleep(2000) Then Return
		EndIf
		While 1
			SetLog("Boosting Barracks", $COLOR_BLUE)


			ClickP($TopLeftClient) ;Click Away
			If _Sleep(1000) Then ExitLoop
			Click($barrackPos[0][0], $barrackPos[0][1])
			If _Sleep(1000) Then ExitLoop
			_CaptureRegion()
			$Boost = _PixelSearch(410, 603, 493, 621, Hex(0xfffd70, 6), 10)
			If IsArray($Boost) Then
				Click($Boost[0], $Boost[1])
				If _WaitForPixel(420, 375, Hex(0xd2ec78, 6), 20) Then
					Click(420, 375)
					If _WaitForPixel(586, 267, Hex(0xd80405, 6), 20, 2000, 500) Then
						_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, 0)
						SetLog("Not enough gems", $COLOR_RED)
					Else
						_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, (GUICtrlRead($cmbBoostBarracks) - 1))
						SetLog('Boost completed. Remaining :' & (GUICtrlRead($cmbBoostBarracks)), $COLOR_GREEN)
					EndIf
				Else
					SetLog("Barracks are already Boosted", $COLOR_ORANGE)
				EndIf
				If _Sleep(500) Then ExitLoop
				ClickP($TopLeftClient) ;Click Away
			Else
				SetLog("Barracks are already Boosted", $COLOR_ORANGE)
				If _Sleep(1000) Then Return
			EndIf

			ExitLoop
		WEnd
	EndIf


EndFunc   ;==>BoostBarracks
