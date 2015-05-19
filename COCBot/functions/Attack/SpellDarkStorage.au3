Func SpellDarkStorage()
	If $SpellDarkStorage = 0 Or $searchDark = 0 Then Return

	Local $SDark
    Local $LightPosition[11]
	Local $LightSpell
	$SDark = getDarkElixir(51, 66 + 57)
	$DELocation = checkDarkElix()

	SetLog("Dark Elixir Left: " & $SDark & " / Dark Elixir Target: " & $itxtSpellDarkStorage, $COLOR_BLUE)

	$LSpell = -1
    For $i = 0 To 10
	  $LightSpell = IdentifySpell($i)
	  If $LightSpell = $eLSpell Then
	  $LightPosition[$i] = $LightSpell
	  $LSpell = $i
	  EndIf
	Next

	If ($SDark - $itxtSpellDarkStorage >= 0) And ($DELocation = 1) And ($LSpell <> -1) Then
		SetLog("Found Dark Storage at PosX: " & $DElixx & ", PosY: " & $DElixy & ", activate Lightning Skill", $COLOR_BLUE)
		Click(68 + (72 * $LSpell), 595) ;Select Spell
		If _Sleep(500) Then Return
		Click($DElixx, $DElixy)
		If _Sleep(3000) Then Return
		$CreateSpell = True
	ElseIf $LSpell = -1 Then
		SetLog("Lightning Spell is not ready", $COLOR_RED)
	ElseIf ($SDark - $itxtSpellDarkStorage <= -1) Then
		SetLog("Dark Elixir do not meet min requirement", $COLOR_RED)
	ElseIf $DELocation = 0 Then
		SetLog("Unable to locate Dark Storage or Dark Storage is empty", $COLOR_RED)
EndIf
	ClickP($TopLeftClient) ;Click Away
EndFunc   ;==>SpellDarkStorage
