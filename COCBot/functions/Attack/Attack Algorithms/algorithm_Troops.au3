; Improved attack algorithm, using Barbarians, Archers, Goblins, Giants and Wallbreakers as they are available
Func DropOnEdge2($troop, $edge, $number, $slotsPerEdge = 0, $edge2 = -1)
	If $number = 0 Then Return
	SelectDropTroupe($troop) ;Select Troop
	If _Sleep(100) Then Return
	If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
	If $number = 1 Or $slotsPerEdge = 1 Then ; Drop on a single point per edge => on the middle
		Click($edge[2][0], $edge[2][1], $number)
		If _Sleep(SetSleep(0)) Then Return
	ElseIf $slotsPerEdge = 2 Then ; Drop on 2 points per edge
		Local $half = Ceiling($number / 2)
		Click($edge[1][0], $edge[1][1], $half)
		If _Sleep(SetSleep(0)) Then Return
		Click($edge[3][0], $edge[3][1], $number - $half)
		If _Sleep(SetSleep(0)) Then Return
	Else
		Local $minX = $edge[0][0]
		Local $maxX = $edge[4][0]
		Local $minY = $edge[0][1]
		Local $maxY = $edge[4][1]
		If $edge2 <> -1 Then
			Local $minX2 = $edge2[0][0]
			Local $maxX2 = $edge2[4][0]
			Local $minY2 = $edge2[0][1]
			Local $maxY2 = $edge2[4][1]
		EndIf
		Local $nbTroopsLeft = $number
		For $i = 0 To $slotsPerEdge - 1
			Local $nbtroopPerSlot = Round($nbTroopsLeft / ($slotsPerEdge - $i)) ; progressively adapt the number of drops to fill at the best
			Local $posX = $minX + (($maxX - $minX) * $i) / ($slotsPerEdge - 1)
			Local $posY = $minY + (($maxY - $minY) * $i) / ($slotsPerEdge - 1)
			Click($posX, $posY, $nbtroopPerSlot)
			If $edge2 <> -1 Then
				Local $posX2 = $maxX2 - (($maxX2 - $minX2) * $i) / ($slotsPerEdge - 1)
				Local $posY2 = $maxY2 - (($maxY2 - $minY2) * $i) / ($slotsPerEdge - 1)
				Click($posX2, $posY2, $nbtroopPerSlot)
				$nbTroopsLeft -= $nbtroopPerSlot
			Else
				$nbTroopsLeft -= $nbtroopPerSlot
			EndIf
			If _Sleep(SetSleep(0)) Then Return
		Next
	EndIf
EndFunc   ;==>DropOnEdge2

Func DropOnEdges2($troop, $nbSides, $number, $slotsPerEdge = 0)
	If $nbSides = 0 Or $number = 1 Then
		OldDropTroop($troop, $Edges[0], $number);
		Return
	EndIf
	If $nbSides < 1 Then Return
	Local $nbTroopsLeft = $number
	If $nbSides = 4 Then
		For $i = 0 To $nbSides - 3
			Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
			DropOnEdge2($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i + 2])
			$nbTroopsLeft -= $nbTroopsPerEdge
		Next
		Return
	EndIf
	For $i = 0 To $nbSides - 1
		If $nbSides = 1 Or ($nbSides = 3 And $i = 2) Then
			Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i))
			DropOnEdge2($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge)
		ElseIf ($nbSides = 2 And $i = 0) Or ($nbSides = 3 And $i <> 1) Then
			Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
			DropOnEdge2($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i + 1])
		EndIf
		$nbTroopsLeft -= $nbTroopsPerEdge
	Next
EndFunc   ;==>DropOnEdges2

Func LaunchTroop2($troopKind, $nbSides, $waveNb, $maxWaveNb, $slotsPerEdge = 0)
	Local $troop = -1
	Local $troopNb = 0
	Local $name = ""
	For $i = 0 To 8 ; identify the position of this kind of troop
		If $atkTroops[$i][0] = $troopKind Then
			$troop = $i
			$troopNb = Ceiling($atkTroops[$i][1] / $maxWaveNb)
			Local $plural = 0
			If $troopNb > 1 Then $plural = 1
			$name = NameOfTroop($troopKind, $plural)
		EndIf
	Next

	If ($troop = -1) Or ($troopNb = 0) Then
		;if $waveNb > 0 Then SetLog("Skipping wave of " & $name & " (" & $troopKind & ") : nothing to drop" )
		Return False; nothing to do => skip this wave
	EndIf

	Local $waveName = "first"
	If $waveNb = 2 Then $waveName = "second"
	If $waveNb = 3 Then $waveName = "third"
	If $maxWaveNb = 1 Then $waveName = "only"
	If $waveNb = 0 Then $waveName = "last"
	SetLog("Dropping " & $waveName & " wave of " & $troopNb & " " & $name, $COLOR_BLUE)
	DropOnEdges2($troop, $nbSides, $troopNb, $slotsPerEdge)
	Return True
EndFunc   ;==>LaunchTroop2

Func algorithm_Troops() ;Attack Algorithm for all existing troops
	$King = -1
	$Queen = -1
	$CC = -1
	$Barb = -1
	$Arch = -1
	For $i = 0 To 8
		If $atkTroops[$i][0] = $eBarbarian Then
			$Barb = $i
		ElseIf $atkTroops[$i][0] = $eArcher Then
			$Arch = $i
		ElseIf $atkTroops[$i][0] = $eCastle Then
			$CC = $i
		ElseIf $atkTroops[$i][0] = $eKing Then
			$King = $i
		ElseIf $atkTroops[$i][0] = $eQueen Then
			$Queen = $i
		EndIf
	Next

	If _Sleep(2000) Then Return
	Local $nbSides = 0

	If $searchDead Then
		Switch $deployDeadSettings
			Case 0 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in a single side...")
				$nbSides = 1
			Case 1 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in two sides...")
				$nbSides = 2
			Case 2 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in three sides...")
				$nbSides = 3
			Case 3 ;Four sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in all sides...")
				$nbSides = 4
		EndSwitch
	Else
		Switch $deploySettings
			Case 0 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in a single side...")
				$nbSides = 1
			Case 1 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in two sides...")
				$nbSides = 2
			Case 2 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in three sides...")
				$nbSides = 3
			Case 3 ;Four sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking in all sides...")
				$nbSides = 4
		EndSwitch
	EndIf
	If ($nbSides = 0) Then Return
	If _Sleep(1000) Then Return

	; ================================================================================?
	; ========= Here is coded the main attack strategy ===============================
	; ========= Feel free to experiment something else ===============================
	; ================================================================================?
	algorithmTH()
	If LaunchTroop2($eGiant, $nbSides, 1, 1, 1) Then
		If _Sleep(400) Then Return
	EndIf
	If LaunchTroop2($eBarbarian, $nbSides, 1, 2) Then
		If _Sleep(400) Then Return
	EndIf
	If LaunchTroop2($eArcher, $nbSides, 1, 2) Then
		If _Sleep(100) Then Return
	EndIf
	If LaunchTroop2($eBarbarian, $nbSides, 2, 2) Then
		If _Sleep(200) Then Return
	EndIf
	If LaunchTroop2($eWallbreaker, $nbSides, 1, 1, 1) Then
		If _Sleep(50) Then Return
	EndIf
	If LaunchTroop2($eGoblin, $nbSides, 1, 2) Then
		If _Sleep(50) Then Return
	EndIf
	If LaunchTroop2($eArcher, $nbSides, 2, 2) Then
		If _Sleep(50) Then Return
	EndIf
	If LaunchTroop2($eGoblin, $nbSides, 2, 2) Then
		If _Sleep(50) Then Return
	EndIf
	; ================================================================================?


	; Deploy Heroes behind troops
	If $nbSides = 1 Then
		dropHeroes($BottomRight[3][0], $BottomRight[3][1], $King, $Queen)
	Else
		dropHeroes($TopLeft[3][0], $TopLeft[3][1], $King, $Queen)
	EndIf

	; Deploy CC behind troops
	If $nbSides = 1 Then
		dropCC($BottomRight[3][0], $BottomRight[3][1], $CC)
	Else
		dropCC($TopLeft[3][0], $TopLeft[3][1], $CC)
	EndIf

	If _Sleep(1000) Then Return

	If _Sleep(100) Then Return
	SetLog("Dropping left over troops", $COLOR_BLUE)
	For $x = 0 To 1
		PrepareAttack(True) ;Check remaining quantities
		For $i = $eBarbarian To $eWallbreaker ; lauch all remaining troops
			If $i = $eBarbarian Or $i = $eArcher Or $i = $eGoblin Then
				LaunchTroop2($i, $nbSides, 0, 1)
			Else
				LaunchTroop2($i, $nbSides, 0, 1, 2)
			EndIf
			If _Sleep(100) Then Return
		Next
	Next

	;Activate KQ's power
	If $checkKPower Or $checkQPower Then
		SetLog("Waiting " & $delayActivateKQ / 1000 & " seconds before activating King/Queen", $COLOR_ORANGE)
		_Sleep($delayActivateKQ)
		If $checkKPower Then
			SetLog("Activate King's power", $COLOR_BLUE)
			SelectDropTroupe($King)
		EndIf
		If $checkQPower Then
			SetLog("Activate Queen's power", $COLOR_BLUE)
			SelectDropTroupe($Queen)
		EndIf
	EndIf

	SetLog("~Finished Attacking, waiting to finish", $COLOR_GREEN)
EndFunc   ;==>algorithm_Troops
