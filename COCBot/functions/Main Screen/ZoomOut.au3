Func ZoomOut() ;ZoomOut with a valid check and return!
    $i = 0
    _CaptureRegion(0, 0, 860, 2)
    If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then SetLog("Zooming Out", $COLOR_GREEN)
    While (_GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6)) AND $i <= 20
        If _Sleep(600) Then Return
        If ControlSend($Title, "", "", "{DOWN}") Then $i += 1
        _CaptureRegion(0, 0, 860, 2)
    WEnd
    If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then
        Return False
    Else
        Return True
    EndIf
EndFunc