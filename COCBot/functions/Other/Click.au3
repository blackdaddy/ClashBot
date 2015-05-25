Func Click($x, $y, $times = 1, $speed = 0)
	Local $xx, $yy
	_CaptureRegion()
	If _ImageSearchArea($device, 0, 237, 321, 293, 346, $xx, $yy, 80) Then
		SetLog("Another Device has connected, reconnect in " & $itxtReconnect & " minutes ", $COLOR_RED)
		If _Sleep($itxtReconnect * 60000) Then Return
	EndIf

	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($Title, "", "", "left", "1", $x, $y)
			If _Sleep($speed) Then ExitLoop
		Next
	Else
		ControlClick($Title, "", "", "left", "1", $x, $y)
	EndIf
EndFunc   ;==>Click

; ClickP : takes an array[2] (or array[4]) as a parameter [x,y]
Func ClickP($point, $howMuch = 1, $speed = 0)
	Click($point[0], $point[1], $howMuch, $speed)
EndFunc   ;==>ClickP
