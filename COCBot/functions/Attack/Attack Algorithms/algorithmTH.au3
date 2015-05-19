Func algorithmTH() ;Attack Algorithm TH
	Local $attackTH = ($searchDead) ? $checkDeadAttackTH : $checkAttackTH
	If $attackTH = 1 Then
		$LeftTHx = 40
		$RightTHx = 30
		$BottomTHy = 30
		$TopTHy = 30
		$GetTHLoc = 0
		If $THLocation = 0 Then
			SetLog("Can't get Townhall location", $COLOR_RED)
		ElseIf $THx > 227 And $THx < 627 And $THy > 151 And $THy < 419 Then
			SetLog("Townhall location (" & $THx & ", " & $THy & ")")
			SetLog("Townhall is in Center of Base. Ignore Attacking Townhall", $COLOR_ORANGE)
			$THLocation = 0
		Else
			SetLog("Townhall location (" & $THx & ", " & $THy & ")")
		EndIf
		If _Sleep(100, False) Then Return
		While 1
			Local $i = 0
			If $Barb <> -1 And $THLocation <> 0 Then
				$atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
				Local $numBarbPerSpot = Ceiling($atkTroops[$Barb][1] / 3)
				If $atkTroops[$Barb][1] <> 0 Then
					Click(68 + (72 * $Barb), 595) ;Select Troop
					If _Sleep(100, False) Then ExitLoop (2)
					If $attackTH = 1 Then
						If $GetTHLoc = 0 Then
							If $THx < 287 And $THx > 584 And $THy < 465 Then
								$i = 0
								$atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
								While $atkTroops[$Barb][1] <> 0
									Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), 1, 1) ; BottomLeft
									$AtkTroopTH = Number(getNormal(40 + (72 * $Barb), 565))
									SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
									$LeftTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
								$i = 0
								$atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
								While $atkTroops[$Barb][1] <> 0
									Click(($THx + $RightTHx), ($THy + $RightTHx - 10), 1, 1) ; BottomRight
									$AtkTroopTH = Number(getNormal(40 + (72 * $Barb), 565))
									SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
									$RightTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
							EndIf
							$i = 0
							$atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
							While $atkTroops[$Barb][1] <> 0
								Click(($THx + $TopTHy - 10), ($THy - $TopTHy), 1, 1) ; TopRight
								$AtkTroopTH = Number(getNormal(40 + (72 * $Barb), 565))
								SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
								$TopTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
							$i = 0
							$atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
							While $atkTroops[$Barb][1] <> 0
								Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), 1, 1) ; TopLeft
								$AtkTroopTH = Number(getNormal(40 + (72 * $Barb), 565))
								SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
								$BottomTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
						EndIf
						SetLog("Attacking Townhall with first wave Barbarians", $COLOR_BLUE)
						For $i = 2 To 4
							If $GetTHLoc = $i Then $numBarbPerSpot = Ceiling($numBarbPerSpot / $i)
						Next
						If $THx < 287 And $THx > 584 And $THy < 465 Then
							Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), $numBarbPerSpot, 200) ; BottomLeft
							Click(($THx + $RightTHx), ($THy + $RightTHx - 10), $numBarbPerSpot, 200) ; BottomRight
						EndIf
						Click(($THx + $TopTHy - 10), ($THy - $TopTHy), $numBarbPerSpot, 200) ; TopRight
						Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), $numBarbPerSpot, 200) ; TopLeft
					EndIf
				EndIf
				If _Sleep(1000, False) Then ExitLoop
			EndIf
			If $Arch <> -1 And $THLocation <> 0 Then
				$atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
				Local $numArchPerSpot = Ceiling($atkTroops[$Arch][1] / 3)
				If $atkTroops[$Arch][1] <> 0 Then
					Click(68 + (72 * $Arch), 595) ;Select Troop
					If _Sleep(100, False) Then ExitLoop (2)
					If $attackTH = 1 Then
						If $GetTHLoc = 0 Then
							If $THx < 287 And $THx > 584 And $THy < 465 Then
								$i = 0
								$atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
								While $atkTroops[$Arch][1] <> 0
									Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), 1, 1) ; BottomLeft
									$AtkTroopTH = Number(getNormal(40 + (72 * $Arch), 565))
									SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
									$LeftTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
								$i = 0
								$atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
								While $atkTroops[$Arch][1] <> 0
									Click(($THx + $RightTHx), ($THy + $RightTHx - 10), 1, 1) ; BottomRight
									$AtkTroopTH = Number(getNormal(40 + (72 * $Arch), 565))
									SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
									$RightTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
							EndIf
							$i = 0
							$atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
							While $atkTroops[$Arch][1] <> 0
								Click(($THx + $TopTHy - 10), ($THy - $TopTHy), 1, 1) ; TopRight
								$AtkTroopTH = Number(getNormal(40 + (72 * $Arch), 565))
								SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
								$TopTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
							$i = 0
							$atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
							While $atkTroops[$Arch][1] <> 0
								Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), 1, 1) ; TopLeft
								$AtkTroopTH = Number(getNormal(40 + (72 * $Arch), 565))
								SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
								$BottomTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
						EndIf
						SetLog("Attacking Townhall with first wave of Archers", $COLOR_BLUE)
						$LeftTHx += 10
						$RightTHx += 10
						$BottomTHy += 10
						$TopTHy += 10
						For $i = 2 To 4
							If $GetTHLoc = $i Then $numArchPerSpot = Ceiling($numArchPerSpot / $i)
						Next
						If $THx < 287 And $THx > 584 And $THy < 465 Then
							Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), $numArchPerSpot, 200) ; BottomLeft
							Click(($THx + $RightTHx), ($THy + $RightTHx - 10), $numArchPerSpot, 200) ; BottomRight
						EndIf
						Click(($THx + $TopTHy - 10), ($THy - $TopTHy), $numArchPerSpot, 200) ; TopRight
						Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), $numArchPerSpot, 200) ; TopLeft
					EndIf
				EndIf
			EndIf
			ExitLoop
		WEnd
		If $THLocation <> 0 Then
			PrepareAttack(True) ;Check remaining quantities
		EndIf
	EndIf
EndFunc   ;==>algorithmTH
