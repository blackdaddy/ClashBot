Global $atkDElix[19]

For $i = 0 To 10
	$atkDElix[$i] = @ScriptDir & "\images\DElix\" & $i + 1 & ".bmp"
Next

For $i = 11 To 18
	$atkDElix[$i] = @ScriptDir & "\images\DElix6\" & $i - 10 & ".bmp"
Next

Global $Tolerance1 = 80

Func checkDarkElix()
	If _Sleep(500) Then Return
	For $i = 0 To 18
		_CaptureRegion()
		$DELocation = _ImageSearch($atkDElix[$i], 1, $DElixx, $DElixy, $Tolerance1)
		If $DELocation = 1 Then
			Return $DELocation
		EndIf
	Next
	If $DELocation = 0 Then
		$DElixx = 0
		$DElixy = 0
		Return $DELocation
	EndIf
EndFunc   ;==>checkDarkElix
