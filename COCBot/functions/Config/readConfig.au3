;Reads config file and sets variables

Func readConfig() ;Reads config and sets it to the variables
	If FileExists($config) Then
		;Search Settings------------------------------------------------------------------------
		$MinDeadGold = IniRead($config, "search", "searchDeadGold", "50000")
		$MinDeadElixir = IniRead($config, "search", "searchDeadElixir", "50000")
		$MinDeadDark = IniRead($config, "search", "searchDeadDark", "0")
		$MinDeadTrophy = IniRead($config, "search", "searchDeadTrophy", "0")
		$MinGold = IniRead($config, "search", "searchGold", "80000")
		$MinElixir = IniRead($config, "search", "searchElixir", "80000")
		$MinDark = IniRead($config, "search", "searchDark", "0")
		$MinTrophy = IniRead($config, "search", "searchTrophy", "0")
		$icmbAny = IniRead($config, "search", "AnyAndOr", "0")
		$icmbDead = IniRead($config, "search", "DeadAndOr", "0")
		$icmbTH = IniRead($config, "search", "THLevel", "0")
		$icmbDeadTH = IniRead($config, "search", "DeadTHLevel", "0")

		$chkConditions[0] = IniRead($config, "search", "conditionDeadGoldElixir", "0")
		$chkConditions[1] = IniRead($config, "search", "conditionDeadDark", "0")
		$chkConditions[2] = IniRead($config, "search", "conditionDeadTrophy", "0")
		$chkConditions[3] = IniRead($config, "search", "conditionDeadTHLevel", "0")
		$chkConditions[4] = IniRead($config, "search", "conditionDeadTHOutside", "0")
		$chkConditions[5] = IniRead($config, "search", "conditionGoldElixir", "0")
		$chkConditions[6] = IniRead($config, "search", "conditionDark", "0")
		$chkConditions[7] = IniRead($config, "search", "conditionTrophy", "0")
		$chkConditions[8] = IniRead($config, "search", "conditionTHLevel", "0")
		$chkConditions[9] = IniRead($config, "search", "conditionTHOutside", "0")

		$AlertBaseFound = IniRead($config, "search", "AlertBaseFound", "0")
		$TakeLootSnapShot = IniRead($config, "search", "TakeLootSnapShot", "0")
		$TakeAllTownSnapShot = IniRead($config, "search", "TakeAllTownSnapShot", "0")
		;Attack Settings-------------------------------------------------------------------------
		$deployDeadSettings = IniRead($config, "attack", "deploy-dead", "0")
		$icmbDeadAlgorithm = IniRead($config, "attack", "algorithm-dead", "0")
		$checkDeadUseKing = IniRead($config, "attack", "king-dead", "0")
		$checkDeadUseQueen = IniRead($config, "attack", "queen-dead", "0")
		$checkDeadUseClanCastle = IniRead($config, "attack", "use-cc-dead", "0")
		$checkDeadAttackTH = IniRead($config, "attack", "townhall-dead", "0")
		$deploySettings = IniRead($config, "attack", "deploy", "0")
		$icmbAlgorithm = IniRead($config, "attack", "algorithm", "0")
		$checkUseKing = IniRead($config, "attack", "king-all", "0")
		$checkUseQueen = IniRead($config, "attack", "queen-all", "0")
		$checkUseClanCastle = IniRead($config, "attack", "use-cc", "0")
		$checkAttackTH = IniRead($config, "attack", "townhall", "0")
		$icmbUnitDelay = IniRead($config, "attack", "UnitD", "0")
		$icmbWaveDelay = IniRead($config, "attack", "WaveD", "0")
		$iRandomspeedatk = IniRead($config, "attack", "randomatk", "0")

		;Donate Settings-------------------------------------------------------------------------
		$CCPos[0] = IniRead($config, "donate", "xCCPos", "0")
		$CCPos[1] = IniRead($config, "donate", "yCCPos", "0")

		$ichkRequest = IniRead($config, "donate", "chkRequest", "0")
		$itxtRequest = IniRead($config, "donate", "txtRequest", "")

		$ichkDonateBarbarians = IniRead($config, "donate", "chkDonateBarbarians", "0")
		$ichkDonateAllBarbarians = IniRead($config, "donate", "chkDonateAllBarbarians", "0")
		$itxtDonateBarbarians = StringReplace(IniRead($config, "donate", "txtDonateBarbarians", "barbarians|barb|any"), "|", @CRLF)

		$ichkDonateArchers = IniRead($config, "donate", "chkDonateArchers", "0")
		$ichkDonateAllArchers = IniRead($config, "donate", "chkDonateAllArchers", "0")
		$itxtDonateArchers = StringReplace(IniRead($config, "donate", "txtDonateArchers", "archers|arch|any"), "|", @CRLF)

		$ichkDonateGiants = IniRead($config, "donate", "chkDonateGiants", "0")
		$ichkDonateAllGiants = IniRead($config, "donate", "chkDonateAllGiants", "0")
		$itxtDonateGiants = StringReplace(IniRead($config, "donate", "txtDonateGiants", "giants|giant|any"), "|", @CRLF)
		;Troop Settings--------------------------------------------------------------------------
		$icmbRaidcap = IniRead($config, "troop", "raidcapacity", "0")
		$icmbTroopComp = IniRead($config, "troop", "composition", "0")
		$itxtcampCap = IniRead($config, "troop", "capacity", "0")
		$BarbariansComp = IniRead($config, "troop", "barbarian", "0")
		$ArchersComp = IniRead($config, "troop", "archer", "0")
		$GiantsComp = IniRead($config, "troop", "giant", "0")
		$GoblinsComp = IniRead($config, "troop", "goblin", "0")
		$WBComp = IniRead($config, "troop", "WB", "0")
		$ichkDarkTroop = IniRead($config, "troop", "chkDarkTroop", "0")
		$itxtDarkBarrack1 = IniRead($config, "troop", "DarkRax1", "0")
		$itxtDarkBarrack2 = IniRead($config, "troop", "DarkRax2", "0")
		;Custom Troop 2 Settings--------------------------------------------------------------------------

		For $i = 0 To 3 ;Covers all 4 Barracks
			$itxtFirstTroop[$i] = IniRead($config, "troop", "CustomRax" & $i + 1, "0")
			$CustomTroopF[$i] = IniRead($config, "troop", "CustomtroopF" & $i + 1, "0")
			$CustomTroopS[$i] = IniRead($config, "troop", "CustomtroopS" & $i + 1, "0")
		Next

		;Other Settings--------------------------------------------------------------------------
		;Walls
		$ichkWalls = IniRead($config, "other", "auto-wall", "0")
		$icmbWalls = IniRead($config, "other", "walllvl", "0")
		$iUseStorage = IniRead($config, "other", "use-storage", "0")
		$itxtWallMinGold = IniRead($config, "other", "minwallgold", "0")
		$itxtWallMinElixir = IniRead($config, "other", "minwallelixir", "0")
		$icmbTolerance = IniRead($config, "other", "walltolerance", "0")
		$ichkUpgrade1 = IniRead($config, "other", "BuildUpgrade1", "0")
		$ichkUpgrade2 = IniRead($config, "other", "BuildUpgrade2", "0")
		$ichkUpgrade3 = IniRead($config, "other", "BuildUpgrade3", "0")
		$itxtUpgradeX1 = IniRead($config, "other", "BuildUpgradeX1", "0")
		$itxtUpgradeY1 = IniRead($config, "other", "BuildUpgradeY1", "0")
		$itxtUpgradeX2 = IniRead($config, "other", "BuildUpgradeX2", "0")
		$itxtUpgradeY2 = IniRead($config, "other", "BuildUpgradeY2", "0")
		$itxtUpgradeX3 = IniRead($config, "other", "BuildUpgradeX3", "0")
		$itxtUpgradeY3 = IniRead($config, "other", "BuildUpgradeY3", "0")
		;General Settings--------------------------------------------------------------------------
		$frmBotPosX = IniRead($config, "general", "frmBotPosX", "207")
		$frmBotPosY = IniRead($config, "general", "frmBotPosY", "158")
		$itxtMinTrophy = IniRead($config, "general", "MinTrophy", "2000")
		$itxtMaxTrophy = IniRead($config, "general", "MaxTrophy", "3000")
		$ichkBackground = IniRead($config, "general", "Background", "0")
		$ichkBotStop = IniRead($config, "general", "BotStop", "0")
		$icmbBotCommand = IniRead($config, "general", "Command", "0")
		$icmbBotCond = IniRead($config, "general", "Cond", "0")
		$ichkForceBS = IniRead($config, "general", "ForceBS", "0")
		$ichkNoAttack = IniRead($config, "general", "NoAttack", "0")
		$ichkDonateOnly = IniRead($config, "general", "DonateOnly", "0")

		;Misc Settings--------------------------------------------------------------------------
		$itxtReconnect = IniRead($config, "misc", "reconnectdelay", "0")
		$itxtReturnh = IniRead($config, "misc", "returnhomedelay", "0")
		$itxtKingSkill = IniRead($config, "misc", "kingskilldelay", "0")
		$itxtQueenSkill = IniRead($config, "misc", "queenskilldelay", "0")
		$itxtSpellDarkStorage = IniRead($config, "misc", "SpellDark", "0")
		$SpellDarkStorage = IniRead($config, "misc", "SpellDarkStorage", "0")
		$icmbSearchsp = IniRead($config, "misc", "searchspd", "0")
		$ichkTrap = IniRead($config, "misc", "chkTrap", "0")
		$TownHallPos[0] = IniRead($config, "misc", "xTownHall", "-1")
		$TownHallPos[1] = IniRead($config, "misc", "yTownHall", "-1")
		$ArmyPos[0] = IniRead($config, "misc", "xArmy", "0")
		$ArmyPos[1] = IniRead($config, "misc", "yArmy", "0")
		$KingPos[0] = IniRead($config, "misc", "xKing", "0")
		$KingPos[1] = IniRead($config, "misc", "yKing", "0")
		$QueenPos[0] = IniRead($config, "misc", "xQueen", "0")
		$QueenPos[1] = IniRead($config, "misc", "yQueen", "0")
		$SFactoryPos[0] = IniRead($config, "misc", "xSFactory", "0")
		$SFactoryPos[1] = IniRead($config, "misc", "ySFactory", "0")
		$ichkBoostRax1 = IniRead($config, "misc", "BoostRax1", "0")
		$ichkBoostRax2 = IniRead($config, "misc", "BoostRax2", "0")
		$ichkBoostRax3 = IniRead($config, "misc", "BoostRax3", "0")
		$ichkBoostRax4 = IniRead($config, "misc", "BoostRax4", "0")
		$ichkBoostKing = IniRead($config, "misc", "BoostKing", "0")
		$ichkBoostQueen = IniRead($config, "misc", "BoostQueen", "0")
		;Push Bullet--------------------------------------------------------------------------
		$PushBulletEnabled = IniRead($config, "notification", "pushbullet", "0")
		$PushBullettoken = IniRead($config, "notification", "accounttoken", "")
	    $PushBullettype = IniRead($config, "notification", "lastraidtype", "0")
		$PushBulletvillagereport = IniRead($config, "notification", "villagereport", "0")
		$PushBulletmatchfound = IniRead($config, "notification", "matchfound", "0")
		$PushBulletlastraid = IniRead($config, "notification", "lastraid", "0")
		$PushBullettotalraid = IniRead($config, "notification", "totalraid", "0")
		$PushBulletdebug = IniRead($config, "notification", "debug", "0")
	    $PushBulletremote = IniRead($config, "notification", "remote", "0")
		$PushBulletdelete = IniRead($config, "notification", "delete", "0")
		$PushBulletbuilder = IniRead($config, "notification", "builder", "0")
		$PushBulleterror = IniRead($config, "notification", "error", "0")
		$PushBulletinterval = IniRead($config, "notification", "interval", "10")
		$PushBulletmessages = IniRead($config, "notification", "messages", "100")

		For $i = 0 To 3 ;Covers all 4 Barracks
			$barrackPos[$i][0] = IniRead($config, "troop", "xBarrack" & $i + 1, "0")
			$barrackPos[$i][1] = IniRead($config, "troop", "yBarrack" & $i + 1, "0")
			$barrackTroop[$i] = IniRead($config, "troop", "troop" & $i + 1, "0")
		Next

		For $i = 0 To 1 ;Cover 2 Dark Barracks
			$DarkBarrackPos[$i][0] = IniRead($config, "troop", "xDarkBarrack" & $i + 1, "0")
			$DarkBarrackPos[$i][1] = IniRead($config, "troop", "yDarkBarrack" & $i + 1, "0")
			$DarkBarrackTroop[$i] = IniRead($config, "troop", "Darktroop" & $i + 1, "0")
		Next
		#cs
			For $i = 0 To 16 ;Covers all Collectors
			$collectorPos[$i][0] = IniRead($config, "general", "xCollector" & $i + 1, "0")
			$collectorPos[$i][1] = IniRead($config, "general", "yCollector" & $i + 1, "0")
			Next
		#ce
	Else
		Return False
	EndIf
EndFunc   ;==>readConfig
