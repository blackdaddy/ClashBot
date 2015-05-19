;Saves all of the GUI values to the config.

Func saveConfig() ;Saves the controls settings to the config
	;Search Settings------------------------------------------------------------------------
	IniWrite($config, "search", "searchDeadGold", GUICtrlRead($txtDeadMinGold))
	IniWrite($config, "search", "searchDeadElixir", GUICtrlRead($txtDeadMinElixir))
	IniWrite($config, "search", "searchDeadDark", GUICtrlRead($txtDeadMinDarkElixir))
	IniWrite($config, "search", "searchDeadTrophy", GUICtrlRead($txtDeadMinTrophy))
	IniWrite($config, "search", "searchGold", GUICtrlRead($txtMinGold))
	IniWrite($config, "search", "searchElixir", GUICtrlRead($txtMinElixir))
	IniWrite($config, "search", "searchDark", GUICtrlRead($txtMinDarkElixir))
	IniWrite($config, "search", "searchTrophy", GUICtrlRead($txtMinTrophy))
	IniWrite($config, "search", "AnyAndOr", _GUICtrlComboBox_GetCurSel($cmbAny))
	IniWrite($config, "search", "DeadAndOr", _GUICtrlComboBox_GetCurSel($cmbDead))
	IniWrite($config, "search", "THLevel", _GUICtrlComboBox_GetCurSel($cmbTH))
	IniWrite($config, "search", "DeadTHLevel", _GUICtrlComboBox_GetCurSel($cmbDeadTH))

	If GUICtrlRead($chkDeadGE) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionDeadGoldElixir", 1)
	Else
		IniWrite($config, "search", "conditionDeadGoldElixir", 0)
	EndIf

	If GUICtrlRead($chkDeadMeetDE) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionDeadDark", 1)
	Else
		IniWrite($config, "search", "conditionDeadDark", 0)
	EndIf

	If GUICtrlRead($chkDeadMeetTrophy) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionDeadTrophy", 1)
	Else
		IniWrite($config, "search", "conditionDeadTrophy", 0)
	EndIf

	If GUICtrlRead($chkDeadMeetTH) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionDeadTHLevel", 1)
	Else
		IniWrite($config, "search", "conditionDeadTHLevel", 0)
	EndIf

	If GUICtrlRead($chkDeadMeetTHO) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionDeadTHOutside", 1)
	Else
		IniWrite($config, "search", "conditionDeadTHOutside", 0)
	EndIf

	If GUICtrlRead($chkMeetGE) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionGoldElixir", 1)
	Else
		IniWrite($config, "search", "conditionGoldElixir", 0)
	EndIf

	If GUICtrlRead($chkMeetDE) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionDark", 1)
	Else
		IniWrite($config, "search", "conditionDark", 0)
	EndIf

	If GUICtrlRead($chkMeetTrophy) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionTrophy", 1)
	Else
		IniWrite($config, "search", "conditionTrophy", 0)
	EndIf

	If GUICtrlRead($chkMeetTH) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionTHLevel", 1)
	Else
		IniWrite($config, "search", "conditionTHLevel", 0)
	EndIf

	If GUICtrlRead($chkMeetTHO) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionTHOutside", 1)
	Else
		IniWrite($config, "search", "conditionTHOutside", 0)
	EndIf

	If GUICtrlRead($chkAlertSearch) = $GUI_CHECKED Then
		IniWrite($config, "search", "AlertBaseFound", 1)
	Else
		IniWrite($config, "search", "AlertBaseFound", 0)
	EndIf

	If GUICtrlRead($chkTakeLootSS) = $GUI_CHECKED Then
		IniWrite($config, "search", "TakeLootSnapShot", 1)
	Else
		IniWrite($config, "search", "TakeLootSnapShot", 0)
	EndIf

	If GUICtrlRead($chkTakeTownSS) = $GUI_CHECKED Then
		IniWrite($config, "search", "TakeAllTownSnapShot", 1)
	Else
		IniWrite($config, "search", "TakeAllTownSnapShot", 0)
	EndIf

	;Attack Settings-------------------------------------------------------------------------
	IniWrite($config, "attack", "deploy-dead", _GUICtrlComboBox_GetCurSel($cmbDeadDeploy))
	IniWrite($config, "attack", "algorithm-dead", _GUICtrlComboBox_GetCurSel($cmbDeadAlgorithm))

	If GUICtrlRead($chkDeadUseKing) = $GUI_CHECKED Then
		IniWrite($config, "attack", "king-dead", 1)
	Else
		IniWrite($config, "attack", "king-dead", 0)
	EndIf

	If GUICtrlRead($chkDeadUseQueen) = $GUI_CHECKED Then
		IniWrite($config, "attack", "queen-dead", 1)
	Else
		IniWrite($config, "attack", "queen-dead", 0)
	EndIf

	If GUICtrlRead($chkDeadUseClanCastle) = $GUI_CHECKED Then
		IniWrite($config, "attack", "use-cc-dead", 1)
	Else
		IniWrite($config, "attack", "use-cc-dead", 0)
	EndIf

	If GUICtrlRead($chkDeadAttackTH) = $GUI_CHECKED Then
		IniWrite($config, "attack", "townhall-dead", 1)
	Else
		IniWrite($config, "attack", "townhall-dead", 0)
	EndIf

	IniWrite($config, "attack", "deploy", _GUICtrlComboBox_GetCurSel($cmbDeploy))
	IniWrite($config, "attack", "algorithm", _GUICtrlComboBox_GetCurSel($cmbAlgorithm))

	If GUICtrlRead($chkUseKing) = $GUI_CHECKED Then
		IniWrite($config, "attack", "king-all", 1)
	Else
		IniWrite($config, "attack", "king-all", 0)
	EndIf

	If GUICtrlRead($chkUseQueen) = $GUI_CHECKED Then
		IniWrite($config, "attack", "queen-all", 1)
	Else
		IniWrite($config, "attack", "queen-all", 0)
	EndIf

	If GUICtrlRead($chkUseClanCastle) = $GUI_CHECKED Then
		IniWrite($config, "attack", "use-cc", 1)
	Else
		IniWrite($config, "attack", "use-cc", 0)
	EndIf

	If GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
		IniWrite($config, "attack", "townhall", 1)
	Else
		IniWrite($config, "attack", "townhall", 0)
	EndIf

	IniWrite($config, "attack", "UnitD", _GUICtrlComboBox_GetCurSel($cmbUnitDelay))
	IniWrite($config, "attack", "WaveD", _GUICtrlComboBox_GetCurSel($cmbWaveDelay))
	IniWrite($config, "attack", "randomatk", GUICtrlRead($Randomspeedatk))

	;Donate Settings-------------------------------------------------------------------------
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkRequest", 1)
	Else
		IniWrite($config, "donate", "chkRequest", 0)
	EndIf
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If GUICtrlRead($chkDonateAllBarbarians) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllBarbarians", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllBarbarians", 0)
	EndIf

	If GUICtrlRead($chkDonateAllArchers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllArchers", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllArchers", 0)
	EndIf

	If GUICtrlRead($chkDonateAllGiants) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllGiants", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllGiants", 0)
	EndIf
	;```````````````````````````````````````````````
	If GUICtrlRead($chkDonateBarbarians) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateBarbarians", 1)
	Else
		IniWrite($config, "donate", "chkDonateBarbarians", 0)
	EndIf

	If GUICtrlRead($chkDonateArchers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateArchers", 1)
	Else
		IniWrite($config, "donate", "chkDonateArchers", 0)
	EndIf

	If GUICtrlRead($chkDonateGiants) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateGiants", 1)
	Else
		IniWrite($config, "donate", "chkDonateGiants", 0)
	EndIf

	IniWrite($config, "donate", "xCCPos", $CCPos[0])
	IniWrite($config, "donate", "yCCPos", $CCPos[1])

	IniWrite($config, "donate", "txtRequest", GUICtrlRead($txtRequest))

	IniWrite($config, "donate", "txtDonateBarbarians", StringReplace(GUICtrlRead($txtDonateBarbarians), @CRLF, "|"))
	IniWrite($config, "donate", "txtDonateArchers", StringReplace(GUICtrlRead($txtDonateArchers), @CRLF, "|"))
	IniWrite($config, "donate", "txtDonateGiants", StringReplace(GUICtrlRead($txtDonateGiants), @CRLF, "|"))
	;Troop Settings--------------------------------------------------------------------------
	IniWrite($config, "troop", "raidcapacity", _GUICtrlComboBox_GetCurSel($cmbRaidcap))
	IniWrite($config, "troop", "composition", _GUICtrlComboBox_GetCurSel($cmbTroopComp))
	IniWrite($config, "troop", "capacity", GUICtrlRead($txtCapacity))
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 9 Then
		IniWrite($config, "troop", "barbarian", GUICtrlRead($txtBarbarians))
		IniWrite($config, "troop", "archer", GUICtrlRead($txtArchers))
		IniWrite($config, "troop", "goblin", GUICtrlRead($txtGoblins))
	EndIf
	IniWrite($config, "troop", "giant", GUICtrlRead($txtNumGiants))
	IniWrite($config, "troop", "WB", GUICtrlRead($txtNumWallbreakers))
	IniWrite($config, "troop", "troop1", _GUICtrlComboBox_GetCurSel($cmbBarrack1))
	IniWrite($config, "troop", "troop2", _GUICtrlComboBox_GetCurSel($cmbBarrack2))
	IniWrite($config, "troop", "troop3", _GUICtrlComboBox_GetCurSel($cmbBarrack3))
	IniWrite($config, "troop", "troop4", _GUICtrlComboBox_GetCurSel($cmbBarrack4))

	IniWrite($config, "troop", "Darktroop1", _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1))
	IniWrite($config, "troop", "Darktroop2", _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2))
	IniWrite($config, "troop", "DarkRax1", GUICtrlRead($txtDarkBarrack1))
	IniWrite($config, "troop", "DarkRax2", GUICtrlRead($txtDarkBarrack2))
	;Custom Troop 2 Settings--------------------------------------------------------------------------
	IniWrite($config, "troop", "CustomRax1", GUICtrlRead($txtFirstTroop1))
	IniWrite($config, "troop", "CustomRax2", GUICtrlRead($txtFirstTroop2))
	IniWrite($config, "troop", "CustomRax3", GUICtrlRead($txtFirstTroop3))
	IniWrite($config, "troop", "CustomRax4", GUICtrlRead($txtFirstTroop4))
	IniWrite($config, "troop", "CustomtroopF1", _GUICtrlComboBox_GetCurSel($cmbFirstTroop1))
	IniWrite($config, "troop", "CustomtroopF2", _GUICtrlComboBox_GetCurSel($cmbFirstTroop2))
	IniWrite($config, "troop", "CustomtroopF3", _GUICtrlComboBox_GetCurSel($cmbFirstTroop3))
	IniWrite($config, "troop", "CustomtroopF4", _GUICtrlComboBox_GetCurSel($cmbFirstTroop4))
	IniWrite($config, "troop", "CustomtroopS1", _GUICtrlComboBox_GetCurSel($cmbSecondTroop1))
	IniWrite($config, "troop", "CustomtroopS2", _GUICtrlComboBox_GetCurSel($cmbSecondTroop2))
	IniWrite($config, "troop", "CustomtroopS3", _GUICtrlComboBox_GetCurSel($cmbSecondTroop3))
	IniWrite($config, "troop", "CustomtroopS4", _GUICtrlComboBox_GetCurSel($cmbSecondTroop4))

	;Other Settings--------------------------------------------------------------------------
	If GUICtrlRead($chkWalls) = $GUI_CHECKED Then
		IniWrite($config, "other", "auto-wall", 1)
	Else
		IniWrite($config, "other", "auto-wall", 0)
	EndIf
	IniWrite($config, "other", "walllvl", _GUICtrlComboBox_GetCurSel($cmbWalls))
	IniWrite($config, "other", "walltolerance", _GUICtrlComboBox_GetCurSel($cmbTolerance))

	If GUICtrlRead($UseGold) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 0)
	ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 1)
	ElseIf GUICtrlRead($UseGoldElix) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 2)
	EndIf

	IniWrite($config, "other", "minwallgold", GUICtrlRead($txtWallMinGold))
	IniWrite($config, "other", "minwallelixir", GUICtrlRead($txtWallMinElixir))
	If GUICtrlRead($chkUpgrade1) = $GUI_CHECKED Then
		IniWrite($config, "other", "BuildUpgrade1", 1)
	Else
		IniWrite($config, "other", "BuildUpgrade1", 0)
	EndIf
	If GUICtrlRead($chkUpgrade2) = $GUI_CHECKED Then
		IniWrite($config, "other", "BuildUpgrade2", 1)
	Else
		IniWrite($config, "other", "BuildUpgrade2", 0)
	EndIf
	If GUICtrlRead($chkUpgrade3) = $GUI_CHECKED Then
		IniWrite($config, "other", "BuildUpgrade3", 1)
	Else
		IniWrite($config, "other", "BuildUpgrade3", 0)
	EndIf
	IniWrite($config, "other", "BuildUpgradeX1", GUICtrlRead($txtUpgradeX1))
	IniWrite($config, "other", "BuildUpgradeY1", GUICtrlRead($txtUpgradeY1))
	IniWrite($config, "other", "BuildUpgradeX2", GUICtrlRead($txtUpgradeX2))
	IniWrite($config, "other", "BuildUpgradeY2", GUICtrlRead($txtUpgradeY2))
	IniWrite($config, "other", "BuildUpgradeX3", GUICtrlRead($txtUpgradeX3))
	IniWrite($config, "other", "BuildUpgradeY3", GUICtrlRead($txtUpgradeY3))
	;General Settings--------------------------------------------------------------------------
	Local $frmBotPos = WinGetPos($sBotTitle)
	IniWrite($config, "general", "frmBotPosX", $frmBotPos[0])
	IniWrite($config, "general", "frmBotPosY", $frmBotPos[1])
	IniWrite($config, "general", "MinTrophy", GUICtrlRead($txtMinimumTrophy))
	IniWrite($config, "general", "MaxTrophy", GUICtrlRead($txtMaxTrophy))

	;Push Bullet--------------------------------------------------------------------------
	If GUICtrlRead($lblpushbulletenabled) = $GUI_CHECKED Then
		IniWrite($config, "notification", "pushbullet", 1)
	Else
		IniWrite($config, "notification", "pushbullet", 0)
	EndIf

	If GUICtrlRead($lblvillagereport) = $GUI_CHECKED Then
		IniWrite($config, "notification", "villagereport", 1)
	Else
		IniWrite($config, "notification", "villagereport", 0)
	 EndIf

	If GUICtrlRead($lblmatchfound) = $GUI_CHECKED Then
		IniWrite($config, "notification", "matchfound", 1)
	Else
		IniWrite($config, "notification", "matchfound", 0)
   EndIf

	If GUICtrlRead($lbllastraid) = $GUI_CHECKED Then
		IniWrite($config, "notification", "lastraid", 1)
	Else
		IniWrite($config, "notification", "lastraid", 0)
	 EndIf

	If GUICtrlRead($lbltotalraid) = $GUI_CHECKED Then
		IniWrite($config, "notification", "totalraid", 1)
	Else
		IniWrite($config, "notification", "totalraid", 0)
    EndIf

    If GUICtrlRead($lblpushbulletdebug) = $GUI_CHECKED Then
		IniWrite($config, "notification", "debug", 1)
	Else
		IniWrite($config, "notification", "debug", 0)
	 EndIf

    If GUICtrlRead($lblpushbulletremote) = $GUI_CHECKED Then
		IniWrite($config, "notification", "remote", 1)
	Else
		IniWrite($config, "notification", "remote", 0)
   EndIf

    If GUICtrlRead($lblpushbulletdelete) = $GUI_CHECKED Then
		IniWrite($config, "notification", "delete", 1)
	Else
		IniWrite($config, "notification", "delete", 0)
	 EndIf

	If GUICtrlRead($lblfreebuilder) = $GUI_CHECKED Then
		IniWrite($config, "notification", "builder", 1)
	Else
		IniWrite($config, "notification", "builder", 0)
   EndIf

    If GUICtrlRead($lblerror) = $GUI_CHECKED Then
		IniWrite($config, "notification", "error", 1)
	Else
		IniWrite($config, "notification", "error", 0)
	EndIf

    IniWrite($config, "notification", "accounttoken", GUICtrlRead($pushbullettokenvalue))

    If GUICtrlRead($UseJPG) = $GUI_CHECKED Then
		IniWrite($config, "notification", "lastraidtype", 0)
	ElseIf GUICtrlRead($UseText) = $GUI_CHECKED Then
		IniWrite($config, "notification", "lastraidtype", 1)
	Else
		IniWrite($config, "notification", "lastraidtype", 0)
	EndIf

	IniWrite($config, "notification", "interval", GUICtrlRead($lblpushbulletintervalvalue))
	IniWrite($config, "notification", "messages", GUICtrlRead($lblpushbulletmessagesvalue))

	;Misc Settings--------------------------------------------------------------------------
	IniWrite($config, "misc", "reconnectdelay", GUICtrlRead($txtReconnect))
	IniWrite($config, "misc", "returnhomedelay", GUICtrlRead($txtReturnh))
	IniWrite($config, "misc", "kingskilldelay", GUICtrlRead($txtKingSkill))
	IniWrite($config, "misc", "queenskilldelay", GUICtrlRead($txtQueenSkill))
	IniWrite($config, "misc", "SpellDark", GUICtrlRead($txtSpellDarkStorage))
	IniWrite($config, "misc", "searchspd", _GUICtrlComboBox_GetCurSel($cmbSearchsp))
	IniWrite($config, "misc", "xTownHall", $TownHallPos[0])
	IniWrite($config, "misc", "yTownHall", $TownHallPos[1])
	IniWrite($config, "misc", "xArmy", $ArmyPos[0])
	IniWrite($config, "misc", "yArmy", $ArmyPos[1])
	IniWrite($config, "misc", "xKing", $KingPos[0])
	IniWrite($config, "misc", "yKing", $KingPos[1])
	IniWrite($config, "misc", "xQueen", $QueenPos[0])
	IniWrite($config, "misc", "yQueen", $QueenPos[1])
	IniWrite($config, "misc", "xSFactory", $SFactoryPos[0])
	IniWrite($config, "misc", "ySFactory", $SFactoryPos[1])

	For $i = 0 To 3 ;Covers all 4 Barracks
		IniWrite($config, "troop", "xBarrack" & $i + 1, $barrackPos[$i][0])
		IniWrite($config, "troop", "yBarrack" & $i + 1, $barrackPos[$i][1])
	Next

	For $i = 0 To 1 ;Cover 2 Dark Barracks
		IniWrite($config, "troop", "xDarkBarrack" & $i + 1, $DarkBarrackPos[$i][0])
		IniWrite($config, "troop", "yDarkBarrack" & $i + 1, $DarkBarrackPos[$i][1])
	Next

	If GUICtrlRead($chkDarkTroop) = $GUI_CHECKED Then
		IniWrite($config, "troop", "chkDarkTroop", 1)
	Else
		IniWrite($config, "troop", "chkDarkTroop", 0)
	EndIf

	If GUICtrlRead($chkSpellDarkStorage) = $GUI_CHECKED Then
		IniWrite($config, "misc", "SpellDarkStorage", 1)
	Else
		IniWrite($config, "misc", "SpellDarkStorage", 0)
	EndIf

	If GUICtrlRead($chkTrap) = $GUI_CHECKED Then
		IniWrite($config, "misc", "chkTrap", 1)
	Else
		IniWrite($config, "misc", "chkTrap", 0)
	EndIf

	If GUICtrlRead($chkBoostRax1) = $GUI_CHECKED Then
		IniWrite($config, "misc", "BoostRax1", 1)
	Else
		IniWrite($config, "misc", "BoostRax1", 0)
	EndIf

	If GUICtrlRead($chkBoostRax2) = $GUI_CHECKED Then
		IniWrite($config, "misc", "BoostRax2", 1)
	Else
		IniWrite($config, "misc", "BoostRax2", 0)
	EndIf

	If GUICtrlRead($chkBoostRax3) = $GUI_CHECKED Then
		IniWrite($config, "misc", "BoostRax3", 1)
	Else
		IniWrite($config, "misc", "BoostRax3", 0)
	EndIf

	If GUICtrlRead($chkBoostRax4) = $GUI_CHECKED Then
		IniWrite($config, "misc", "BoostRax4", 1)
	Else
		IniWrite($config, "misc", "BoostRax4", 0)
	EndIf

	If GUICtrlRead($chkBoostKing) = $GUI_CHECKED Then
		IniWrite($config, "misc", "BoostKing", 1)
	Else
		IniWrite($config, "misc", "BoostKing", 0)
	EndIf

	If GUICtrlRead($chkBoostQueen) = $GUI_CHECKED Then
		IniWrite($config, "misc", "BoostQueen", 1)
	Else
		IniWrite($config, "misc", "BoostQueen", 0)
	EndIf

	If GUICtrlRead($chkBackground) = $GUI_CHECKED Then
		IniWrite($config, "general", "Background", 1)
	Else
		IniWrite($config, "general", "Background", 0)
	EndIf

	If GUICtrlRead($chkBotStop) = $GUI_CHECKED Then
		IniWrite($config, "general", "BotStop", 1)
	Else
		IniWrite($config, "general", "BotStop", 0)
	EndIf

	If GUICtrlRead($chkForceBS) = $GUI_CHECKED Then
		IniWrite($config, "general", "ForceBS", 1)
	Else
		IniWrite($config, "general", "ForceBS", 0)
	EndIf

	If GUICtrlRead($chkNoAttack) = $GUI_CHECKED Then
		IniWrite($config, "general", "NoAttack", 1)
	Else
		IniWrite($config, "general", "NoAttack", 0)
	EndIf

	If GUICtrlRead($chkDonateOnly) = $GUI_CHECKED Then
		IniWrite($config, "general", "DonateOnly", 1)
	Else
		IniWrite($config, "general", "DonateOnly", 0)
	EndIf

	IniWrite($config, "general", "Command", _GUICtrlComboBox_GetCurSel($cmbBotCommand))
	IniWrite($config, "general", "Cond", _GUICtrlComboBox_GetCurSel($cmbBotCond))
	#cs
		For $i = 0 To 16 ;Covers all Collectors
		IniWrite($config, "general", "xCollector" & $i + 1, $collectorPos[$i][0])
		IniWrite($config, "general", "yCollector" & $i + 1, $collectorPos[$i][1])
		Next
	#ce

EndFunc   ;==>saveConfig
