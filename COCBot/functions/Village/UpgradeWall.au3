Global $wallbuild
Global $walllowlevel

Func UpgradeWall()
	If GUICtrlRead($chkWalls) <> $GUI_CHECKED Then
		SetLog("Upgrade Wall option disabled, skipping upgrading", $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf

	SetLog("Attempting upgrade of walls...")

	If $FreeBuilder = 0 Then
		SetLog("No builders available", $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf

	If Not checkWall() Then
		SetLog("Cannot find Walls level " & $icmbWalls + 4 & ", skipping upgrading", $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf

	Local $iWallMinGold = Number(GUICtrlRead($txtWallMinGold))
	Local $iWallMinElixir = Number(GUICtrlRead($txtWallMinElixir))
	Local $iGoldStorage = Number($GoldCount)
	Local $iElixirStorage = Number($ElixirCount)
	Local $iBeforeGoldStorage = $iGoldStorage + 1
	Local $iBeforeElixirStorage = $iElixirStorage + 1

	If GUICtrlRead($UseGold) = $GUI_CHECKED Then
		$iUseStorage = 1
	ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
		$iUseStorage = 2
	ElseIf GUICtrlRead($UseGoldElix) = $GUI_CHECKED Then
		$iUseStorage = 3
	EndIf

	If $iUseStorage <> 2 And $iGoldStorage > $iWallMinGold Then ; Upgrade using Gold
		While $iGoldStorage > $iWallMinGold And $iGoldStorage < $iBeforeGoldStorage ; extra check to ensure previous upgrade succeeded and gold in villagereport decreased
			$iBeforeGoldStorage = $iGoldStorage
			If checkWall() Then
				SetLog("Found Wall level " & $icmbWalls + 4 & ", upgrading with Gold...", $COLOR_GREEN)
				ClickP($TopLeftClient) ; Click Away
				If _Sleep(600) Then ExitLoop
				Click($WallX, $WallY)
				If _Sleep(600) Then ExitLoop

				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(510, 570), Hex(0xE8C438, 6), 20) Then ; wall level 8 or higher
					If _ColorCheck(_GetPixelColor(500, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
						SetLog("Not enough Gold to upgrade wall", $COLOR_ORANGE)
						ClickP($TopLeftClient) ; Click Away
						ExitLoop
					EndIf
				ElseIf _ColorCheck(_GetPixelColor(557, 570), Hex(0xEAD544, 6), 20) Then ; wall level 7 or lower
					If _ColorCheck(_GetPixelColor(549, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
						SetLog("Not enough Gold to upgrade wall", $COLOR_ORANGE)
						ClickP($TopLeftClient) ; Click Away
						ExitLoop
					EndIf
				Else
					SetLog("Invalid Wall Found", $COLOR_RED)
					ExitLoop
				EndIf

				; Wall found successfully
				Click(505, 596) ; Click Upgrade
				If _Sleep(2000) Then ExitLoop
				Click(472, 482) ; Click Okay
				SetLog("Upgrading Done !!!", $COLOR_BLUE) ; Done upgrade
				GUICtrlSetData($lblwallupgradecount, GUICtrlRead($lblwallupgradecount)+ 1)
				If _Sleep(1000) Then ExitLoop
				ClickP($TopLeftClient) ; Click away
				If _Sleep(1000) Then ExitLoop

				; Update gold count
				VillageReport()
				$iGoldStorage = Number($GoldCount)
			Else
				SetLog("Cannot find Walls level " & $icmbWalls + 4 & ", finished upgrading...", $COLOR_GREEN)
				Return
			EndIf
		WEnd
	ElseIf $iUseStorage <> 2 Then
		SetLog("Gold is lower than Minimum setting for upgrade...", $COLOR_RED)
	EndIf

	If $iUseStorage <> 1 And $icmbWalls < 4 Then
		SetLog("Wall level too low to upgrade with Elixir", $COLOR_RED)
		Return
	EndIf

	If $iUseStorage <> 1 And $iElixirStorage > $iWallMinElixir Then ; Upgrade using Elixir
		While $iElixirStorage > $iWallMinElixir And $iElixirStorage < $iBeforeElixirStorage ; extra check to ensure previous upgrade succeeded and elixir in villagereport decreased
			$iBeforeElixirStorage = $iElixirStorage
			If checkWall() Then
				SetLog("Found Wall level " & $icmbWalls + 4 & ", upgrading with Elixir...", $COLOR_GREEN)
				ClickP($TopLeftClient) ; Click Away
				If _Sleep(600) Then ExitLoop
				Click($WallX, $WallY)
				If _WaitForPixel(605, 570, Hex(0xF857F0, 6), 20, 600) Then
					If _ColorCheck(_GetPixelColor(596, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
						SetLog("Not enough Elixir to upgrade wall", $COLOR_ORANGE)
						ClickP($TopLeftClient) ; Click Away
						ExitLoop
					EndIf
				Else
					SetLog("Invalid Wall Found", $COLOR_RED)
					ExitLoop
				EndIf

				; Wall found successfully
				Click(560, 596) ; Click Upgrade
				If _Sleep(2000) Then ExitLoop
				Click(472, 482) ; Click Okay
				SetLog("Upgrading Done !!!", $COLOR_BLUE) ; Done upgrade
				GUICtrlSetData($lblwallupgradecount, GUICtrlRead($lblwallupgradecount)+ 1)
				If _Sleep(1000) Then ExitLoop
				ClickP($TopLeftClient) ; Click away
				If _Sleep(1000) Then ExitLoop

				; Update elixir count
				VillageReport()
				$iElixirStorage = Number($ElixirCount)
			Else
				SetLog("Cannot find Walls level " & $icmbWalls + 4 & ", finished upgrading...", $COLOR_GREEN)
				Return
			EndIf
		WEnd
	ElseIf $iUseStorage <> 1 Then
		SetLog("Elixir is lower than Minimum setting for upgrade...", $COLOR_RED)
	EndIf
EndFunc   ;==>UpgradeWall
