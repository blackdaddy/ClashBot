; check Wall function | safar46
Global $Wall[8]
For $i = 0 To 7
	$Wall[$i] = @ScriptDir & "\images\Walls\" & $i + 4 & ".png"
Next

Global $WallX = 0, $WallY = 0, $WallLoc = 0
Global $Tolerance2

Func checkWall()
	Switch _GUICtrlComboBox_GetCurSel($cmbTolerance)
		Case 0
			$Tolerance2 = 55
		Case 1
			$Tolerance2 = 35
		Case 2
			$Tolerance2 = 75
	EndSwitch

	If _Sleep(500) Then Return
	For $i = 0 To 3
		_CaptureRegion()
		$WallLoc = _ImageSearch($Wall[$icmbWalls], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall Location
		If $icmbWalls = 6 And $WallLoc = 0 Then
			$WallLoc = _ImageSearch($Wall[$icmbWalls + 1], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall lvl 11 Location
		EndIf
		If $WallLoc = 1 Then
			Return True
		EndIf
	Next

	Return False
EndFunc   ;==>checkWall
