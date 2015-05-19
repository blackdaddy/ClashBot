#include <Constants.au3>
Global $error[4]
$error[0] = False
$error[1] = False
$error[2] = False
$error[3] = False

Func handleBarracksError($i) ;Sets the text for the log
If $i = 0 then $error[0] = True
If $i = 1 then $error[1] = True
If $i = 2 then $error[2] = True
If $i = 3 then $error[3] = True

If $error[0]= True And $error[1]= True And $error[2]= True And $error[3]= True Then
	SetLog("Restarting BlueStack to fix stuck error!", $COLOR_RED)
	Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
	Run($RestartApp & " Android")
	If _Sleep(10000) Then Return
		Do
			If _Sleep(5000) Then Return
		Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
EndIf
EndFunc   ;==>_AllWordsExist

Func resetBarracksError()
	$error[0] = False
	$error[1] = False
	$error[2] = False
	$error[3] = False
EndFunc