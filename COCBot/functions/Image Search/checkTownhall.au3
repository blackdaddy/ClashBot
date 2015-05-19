Global $atkTH[5]
$atkTH[0] = @ScriptDir & "\images\TH\townhall6.bmp"
$atkTH[1] = @ScriptDir & "\images\TH\townhall7.bmp"
$atkTH[2] = @ScriptDir & "\images\TH\townhall8.bmp"
$atkTH[3] = @ScriptDir & "\images\TH\townhall9.bmp"
$atkTH[4] = @ScriptDir & "\images\TH\townhall10.bmp"

Global $Tolerance1 = 80

Func checkTownhall()
	_CaptureRegion()
	For $i = 0 To 4
		$THLocation = _ImageSearch($atkTH[$i], 1, $THx, $THy, $Tolerance1) ; Getting TH Location
		If $THLocation = 1 Then
			Return $THText[$i]
		EndIf
	Next
	If $THLocation = 0 Then Return "-"
EndFunc   ;==>checkTownhall
