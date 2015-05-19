Func VillageReport()
	ClickP($TopLeftClient) ;Click Away
	If _Sleep(500) Then Return

	SetLog("Village Report", $COLOR_GREEN)

	$FreeBuilder = GetOther(324, 23, "Builder")
	Setlog("Num. of Free Builders: " & $FreeBuilder, $COLOR_GREEN)
	GUICtrlSetData($lblresultbuilder, $FreeBuilder)

	$TrophyCountOld = GUICtrlRead($lblresulttrophynow)
	$TrophyCount = getOther(50, 74, "Trophy")

	If $FirstAttack = 1 Then
		 GUICtrlSetData($lblresulttrophiesdropped, $TrophyCount - $TrophyCountOld)
	EndIf

	SetLog("Opening Builder page to read Resources..", $COLOR_BLUE)
	Click(388, 30) ; Click Builder Button
	_CaptureRegion()
	Local $i = 0
	_WaitForPixel(819, 39, Hex(0xF8FCFF, 6), 20, 10000, 200)
	If _ColorCheck(_GetPixelColor(318, 637), Hex(0xD854D0, 6), 20) Then
		$GoldCount = GetOther(356, 625, "Resource")
		$ElixirCount = GetOther(195, 625, "Resource")
		$GemCount = GetOther(543, 625, "Gems")
		SetLog("Resources: [G]: " & $GoldCount & " [E]: " & $ElixirCount & " [GEM]: " & $GemCount, $COLOR_GREEN)
		If $FirstAttack = 1 Then
			$GoldGained += $LastRaidGold
			$ElixirGained += $LastRaidElixir
			$TrophyGained += $LastRaidTrophy
			if $PushBulletEnabled = 1 and $PushBullettotalraid = 1 Then
			   _Push("Total Raid", "[G]: " & _NumberFormat($GoldGained) & " [E]: " & _NumberFormat($ElixirGained) & " [T]: " & $TrophyGained & " [Attacked]: " & GUICtrlRead($lblresultvillagesattacked) & " [Skipped]: " & GUICtrlRead($lblresultvillagesskipped) & " [Trophies Won]: " & GUICtrlRead($lblresulttrophiesdropped) & " [Wall Upgrade]: " & GUICtrlRead($lblwallupgradecount) & " [Run Time]: " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
			   SetLog("Push: Total Raid",$COLOR_GREEN)
			EndIf
		 EndIf
		 If $PushBulletEnabled = 1 and $PushBulletvillagereport = 1 Then
			_Push("Village Report", "[G]: " &_NumberFormat($GoldCount) & " [E]: " & _NumberFormat($ElixirCount) & " [T]: " & $TrophyCount & " [GEM]: " & $GemCount)
			SetLog("Push: Village Report",$COLOR_GREEN)
		 EndIf
	Else
		$GoldCount = GetOther(440, 625, "Resource")
		$ElixirCount = GetOther(282, 625, "Resource")
		$DarkCount = GetOther(125, 625, "Resource")
		$GemCount = GetOther(606, 625, "Gems")
		SetLog("Resources: [G]: " & $GoldCount & " [E]: " & $ElixirCount & " [D]: " & $DarkCount & " [GEM]: " & $GemCount, $COLOR_GREEN)
		If $FirstAttack = 1 Then
			$GoldGained += $LastRaidGold
			$ElixirGained += $LastRaidElixir
			$DarkGained += $LastRaidDarkElixir
			$TrophyGained += $LastRaidTrophy
			if $PushBulletEnabled = 1 and $PushBullettotalraid = 1 Then
				_Push("Total Raid", "[G]: " & _NumberFormat($GoldGained) & " [E]: " & _NumberFormat($ElixirGained) & " [D]: " & _NumberFormat($DarkGained) & " [T]: " & $TrophyGained & " [Attacked]: " & GUICtrlRead($lblresultvillagesattacked) & " [Skipped]: " & GUICtrlRead($lblresultvillagesskipped) & " [Trophies Won]: " & GUICtrlRead($lblresulttrophiesdropped) & " [Wall Upgrade]: " & GUICtrlRead($lblwallupgradecount) & " [Run Time]: " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
				SetLog("Push: Total Raid",$COLOR_GREEN)
			EndIf
		EndIf
    	If $PushBulletEnabled = 1 and $PushBulletvillagereport = 1 Then
			_Push("Village Report", "[G]: " & _NumberFormat($GoldCount) & " [E]: " & _NumberFormat($ElixirCount) & " [D]: " & _NumberFormat($DarkCount) & " [T]: " & $TrophyCount & " [GEM]: " & $GemCount)
			SetLog("Push: Village Report",$COLOR_GREEN)
		EndIf
	EndIf
	Click(820, 40) ; Close Builder/Shop
	If $FirstAttack = 0 Then
		GUICtrlSetData($lblresultgoldtstart, $GoldCount)
		GUICtrlSetData($lblresultelixirstart, $ElixirCount)
		GUICtrlSetData($lblresultdestart, $DarkCount)
		GUICtrlSetData($lblresulttrophystart, $TrophyCount)
		$BuilderCountStart = $FreeBuilder
	Else
		If GUICtrlRead($lblpushbulletenabled) = $GUI_CHECKED and GUICtrlRead($lblfreebuilder) = $GUI_CHECKED Then
			If $FreeBuilder > $BuilderCountStart Then
				_Push("Free Builder Available", "You have a free builder available")
				SetLog("You have a free builder available")
			EndIf
		EndIf
		GUICtrlSetData($lblresultgoldgain, $GoldGained)
	    GUICtrlSetData($lblresultelixirgain, $ElixirGained)
	    GUICtrlSetData($lblresultdegain, $DarkGained)
	    GUICtrlSetData($lblresulttrophiesdropped, $TrophyGained)

		GUICtrlSetData($lblresultgoldlast, $LastRaidGold)
	    GUICtrlSetData($lblresultelixirlast, $LastRaidElixir)
	    GUICtrlSetData($lblresultdelast, $LastRaidDarkElixir)
	    GUICtrlSetData($lblresulttrophylast, $LastRaidTrophy)

	    if $PushBulletEnabled = 1 and $PushBulletlastraid = 1 And $PushBullettype = 0 and $Raid = 1 Then
		If _Sleep(2000) Then Return
			_PushFile($FileName, "loots", "image/jpeg", "Last Raid", $FileName)
			$Raid = 0
	    EndIf
	    if $PushBulletEnabled = 1 and $PushBulletlastraid = 1 And $PushBullettype = 1 and $Raid = 1 Then
			_Push("Last Raid", "[G]: " & _NumberFormat($LastRaidGold) & " [E]: " & _NumberFormat($LastRaidElixir) & " [D]: " & _NumberFormat($LastRaidDarkElixir) & " [T]: " & $LastRaidTrophy)
			SetLog("Push: Last Raid",$COLOR_GREEN)
			$Raid = 0
		EndIf
	EndIf
	GUICtrlSetData($lblresultgoldnow, $GoldCount)
	GUICtrlSetData($lblresultelixirnow, $ElixirCount)
	GUICtrlSetData($lblresultdenow, $DarkCount)
	GUICtrlSetData($lblresulttrophynow, $TrophyCount)

	GUICtrlSetData($lblresultgoldnowM, $GoldCount)
	GUICtrlSetData($lblresultelixirnowM, $ElixirCount)
	GUICtrlSetData($lblresultdenowM, $DarkCount)
	;Reset Values
	$LastRaidGold = 0
	$LastRaidElixir = 0
	$LastRaidDarkElixir = 0
	$LastRaidTrophy = 0
	$FirstAttack = 1
EndFunc   ;==>VillageReport
