#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GUIEdit.au3>
#include <GUIComboBox.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPIProc.au3>
#include <ScreenCapture.au3>
#include <Date.au3>
#include <Misc.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <GUIMenu.au3>
#include <ColorConstants.au3>
#include <GDIPlus.au3>
#include <GuiRichEdit.au3>
#include <GuiTab.au3>

Global Const $COLOR_ORANGE = 0xFFA500

Global $Compiled
If @Compiled Then
	$Compiled = "Executable"
Else
	$Compiled = "Au3 Script"
EndIf

Global $hBitmap; Image for pixel functions
Global $hHBitmap; Handle Image for pixel functions

Global $Title = "BlueStacks App Player" ; Name of the Window
Global $HWnD = WinGetHandle($Title) ;Handle for Bluestacks window

Global $config = @ScriptDir & "\config.ini"
Global $dirLogs = @ScriptDir & "\logs\"
Global $dirLoots = @ScriptDir & "\Loots\"
Global $dirAllTowns = @ScriptDir & "\AllTowns\"
Global $sLogPath ; `Will create a new log file every time the start button is pressed
Global $hLogFileHandle
Global $Restart = False
Global $RunState = False
Global $AttackNow = False
Global $AlertBaseFound = 0
Global $TakeLootSnapShot = 1
Global $TakeAllTownSnapShot = 0
Global $ReqText

Global $cmbTroopComp ;For Event change on ComboBox Troop Compositions
Global $iCollectCounter = 0 ; Collect counter, when reaches $COLLECTATCOUNT, it will collect
Global $COLLECTATCOUNT = 8 ; Run Collect() after this amount of times before actually collect
;---------------------------------------------------------------------------------------------------
Global $BSpos[2] ; Inside BlueStacks positions relative to the screen
;---------------------------------------------------------------------------------------------------
;Search Settings
Global $searchGold, $searchElixir, $searchDark, $searchTrophy, $searchDead, $searchTH ; Resources of bases when searching
Global $MinDeadGold, $MinDeadElixir, $MinDeadDark, $MinDeadTrophy, $MaxDeadTH, $MinGold, $MinElixir, $MinDark, $MinTrophy, $MaxTH ; Minimum Resources conditions
Global $chkConditions[10] ;Conditions (meet gold...)
Global $icmbTH, $icmbDeadTH, $icmbAny, $icmbDead
Global $THLocation
Global $THx = 0, $THy = 0
Global $THText[5] ; Text of each Townhall level
$THText[0] = "4-6"
$THText[1] = "7"
$THText[2] = "8"
$THText[3] = "9"
$THText[4] = "10"
Global $SearchCount = 0 ;Number of searches
Global $THaddtiles, $THside, $THi

;Troop types
Global Enum $eBarbarian, $eArcher, $eGiant, $eGoblin, $eWallbreaker, $eKing, $eQueen, $eCastle, $eLSpell, $eMinion, $eHog, $eValkyrie

;Attack Settings
Global $TopLeft[5][2] = [[79, 281], [170, 205], [234, 162], [296, 115], [368, 66]]
Global $TopRight[5][2] = [[480, 63], [540, 104], [589, 146], [655, 190], [779, 278]]
Global $BottomLeft[5][2] = [[79, 342], [142, 389], [210, 446], [276, 492], [339, 539]]
Global $BottomRight[5][2] = [[523, 537], [595, 484], [654, 440], [715, 393], [779, 344]]
Global $Edges[4] = [$BottomRight, $TopLeft, $BottomLeft, $TopRight]

Global $atkTroops[9][2] ;9 Slots of troops -  Name, Amount
Global $fullArmy ;Check for full army or not

Global $deployDeadSettings ;Method of deploy found in attack settings
Global $icmbDeadAlgorithm ;Algorithm to use when attacking
Global $checkDeadUseKing ;King attack settings
Global $checkDeadUseQueen ;Queen attack settings
Global $checkDeadUseClanCastle ; Use Clan Castle settings
Global $checkDeadAttackTH ; Attack Outside Townhall settings

Global $deploySettings ;Method of deploy found in attack settings
Global $icmbAlgorithm ;Algorithm to use when attacking
Global $checkUseKing ;King attack settings
Global $checkUseQueen ;Queen attack settings
Global $checkUseClanCastle ; Use Clan Castle settings
Global $checkAttackTH ; Attack Outside Townhall settings
Global $icmbUnitDelay, $icmbWaveDelay, $iRandomspeedatk

Global $checkKPower = False ; Check for King activate power
Global $checkQPower = False ; Check for Queen activate power
;Global $delayActivateKQ = 10000 ;Delay before activating KQ

Global $THLoc

Global $King, $Queen, $CC, $Barb, $Arch, $Minion, $Hog, $Valkyrie
Global $LeftTHx, $RightTHx, $BottomTHy, $TopTHy
Global $AtkTroopTH
Global $GetTHLoc

;Misc Settings
Global $itxtReconnect
Global $itxtReturnh
Global $icmbSearchsp
Global $ichkTrap
Global $itxtKingSkill ;Delay before activating King Skill
Global $itxtQueenSkill ;Delay before activating Queen Skill
Global $itxtSpellDarkStorage
Global $SpellDarkStorage
Global $DELocation, $DElixx = 0, $DElixy = 0
Global $LSpell
Global $CreateSpell = True
Global $ichkBoostRax1, $ichkBoostRax2, $ichkBoostRax3, $ichkBoostRax4, $ichkBoostKing, $ichkBoostQueen

;Boosts Settings
Global $BoostAll
Global $remainingBoosts = 0 ;  remaining boost to active during session
Global $boostsEnabled = 1 ; is this function enabled
Global $chkBoostKing
Global $chkBoostQueen
Global $chkBoostRax1
Global $chkBoostRax2
Global $chkBoostRax3
Global $chkBoostRax4

;Donate Settings
Global $CCPos[2] = [-1, -1] ;Position of clan castle

Global $ichkRequest = 0 ;Checkbox for Request box
Global $itxtRequest = "" ;Request textbox

Global $ichkDonateAllBarbarians = 0
Global $ichkDonateBarbarians = 0
Global $itxtDonateBarbarians = ""

Global $ichkDonateAllArchers = 0
Global $ichkDonateArchers = 0
Global $itxtDonateArchers = ""

Global $ichkDonateAllGiants = 0
Global $ichkDonateGiants = 0
Global $itxtDonateGiants = ""

;Troop Settings
Global $icmbRaidcap
Global $icmbTroopComp ;Troop Composition
Global $itxtcampCap
Global $ichkDarkTroop
Global $BarbariansComp
Global $ArchersComp
Global $GiantsComp
Global $GoblinsComp
Global $WBComp
Global $CurBarb, $CurArch, $CurGiant, $CurGoblin, $CurWB, $CurMinion, $CurHog, $CurValkyrie
Global $ArmyComp
Global $TownHallPos[2] = [-1, -1] ;Position of TownHall
Global $barrackPos[4][2] ;Positions of each barracks
Global $barrackTroop[4] ;Barrack troop set
Global $DarkBarrackPos[2][2]
Global $DarkBarrackTroop[2]
Global $itxtDarkBarrack1, $itxtDarkBarrack2
Global $CustomTroopF[4]
Global $CustomTroopS[4]
Global $itxtFirstTroop[4]

Global $ArmyPos[2]
Global $KingPos[2]
Global $QueenPos[2]
Global $SFactoryPos[2]
Global $BuildPos1[2]
Global $BuildPos2[2]
Global $BuildPos3[2]

;Other Settings
Global $ichkWalls
Global $icmbWalls
Global $iUseStorage
Global $itxtWallMinGold
Global $itxtWallMinElixir
Global $icmbTolerance
Global $itxtReconnect
Global $ichkUpgrade1, $ichkUpgrade2, $ichkUpgrade3
Global $itxtUpgradeX1, $itxtUpgradeY1, $itxtUpgradeX2, $itxtUpgradeY2, $itxtUpgradeX3, $itxtUpgradeY3
Global $iTimeTroops = 0
Global $iTimeGiant = 120
Global $iTimeWall = 120
Global $iTimeArch = 25
Global $iTimeGoblin = 35
Global $iTimeBarba = 20

;General Settings
Global $botPos[2] ; Position of bot used for Hide function
Global $frmBotPosX ; Position X of the GUI
Global $frmBotPosY ; Position Y of the GUI
Global $Hide = False ; If hidden or not

Global $ichkBotStop, $icmbBotCommand, $icmbBotCond, $icmbHoursStop
Global $CommandStop = -1
Global $MeetCondStop = False
Global $UseTimeStop = -1
Global $TimeToStop = -1

Global $itxtMinTrophy ; Trophy after drop
Global $itxtMaxTrophy ; Max trophy before drop trophy
Global $ichkBackground ; Background mode enabled disabled
Global $ichkForceBS = 0
Global $ichkNoAttack = 0, $ichkDonateOnly = 0
Global $collectorPos[17][2] ;Positions of each collectors

Global $break = @ScriptDir & "\images\break.bmp"
Global $device = @ScriptDir & "\images\device.bmp"

Global $GoldCount = 0, $ElixirCount = 0, $DarkCount = 0, $GemCount = 0, $FreeBuilder = 0
Global $resArmy = 0
Global $FirstAttack = 0
Global $CurTrophy = 0
Global $sTimer, $hour, $min, $sec
Global $CurCamp, $TotalCamp = 0
Global $NoLeague
Global $FirstStart = True
Global $FirstDarkTrain = True
Global $FirstTrain = True
Global $DCattack = 0
Global $Checkrearm = True
Global $lblgoldnowM, $lblresultgoldnowM, $imggoldnowM, $lblelixirnowM, $lblresultelixirnowM, $imgelixirnowM, $lbldenowM, $lblresultdenowM, $imgdenowM

;PushBullet
Global $GoldGained = 0, $ElixirGained = 0, $DarkGained = 0, $TrophyGained = 0
Global $GoldCountOld = 0, $ElixirCountOld = 0, $DarkCountOld = 0, $TrophyOld = 0
Global $PushBulletEnabled = 0
Global $PushBullettoken = ""
Global $PushBullettype = 0
Global $FileName = ""
Global $PushBulletvillagereport = 0
Global $PushBulletmatchfound = 0
Global $PushBulletlastraid = 0
Global $PushBullettotalraid = 0
Global $PushBulletdebug = 0
Global $PushBulletremote = 0
Global $PushBulletdelete = 0
Global $PushBulletbuilder = 0
Global $PushBulleterror = 0
Global $sLogFileName
Global $Raid = 0
Global $PushBulletinterval = 10
Global $PushBulletmessages = 100

;GoldCostPerSearch
Global $SearchCost = 0
Global $BuilderCountStart = 0

;Remote Control
Global $PauseBot = False

;Last Raid
Global $LastRaidGold = 0
Global $LastRaidElixir = 0
Global $LastRaidDarkElixir = 0
Global $LastRaidTrophy = 0