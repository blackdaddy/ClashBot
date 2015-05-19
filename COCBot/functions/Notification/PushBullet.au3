#include <Array.au3>
#include <String.au3>

Func _RemoteControl()
   $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
   $access_token = $PushBullettoken
   $oHTTP.Open("Get", "https://api.pushbullet.com/v2/pushes?active=true", False)
   $oHTTP.SetCredentials($access_token, "", 0)
   $oHTTP.SetRequestHeader("Content-Type", "application/json")
   $oHTTP.Send()
   $Result = $oHTTP.ResponseText

   if $Result = "" Then Return

   Local $title = _StringBetween($Result, '"title":"', '"', "", False)
   Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)
   Local $findstr = StringRegExp ($Result, '"title":"Bot')

   if $findstr = 1 Then
     for $x = 0 to UBound($title) - 1
		 if $title <> "" or $iden <> "" Then
			$title[$x] = StringLower(StringStripWS($title[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES))
			$iden[$x] = StringStripWS($iden[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

			if $title[$x] = "bot help" Then
			   SetLog("Your request has been received. Help has been sent")
			   _Push("Request for Help","You can remotely control your bot using the following command format\n\nBot <command> where <command> is:\n\nPause - pause the bot\nResume - resume the bot\nStats - send bot current statistics\nLogs - send the current log file\nBot Boost1 - Boost 1 barrack\nBot Boost2 - Boost 2 barracks\Bot Boost3 - Boost 3 barracks\nBot BoostAll - Boost all barracks\nHelp - send this help message\n\nEnter the command in the title of the message")
			   _DeleteMessage($iden[$x])
			Elseif $title[$x] = "bot pause" Then
			    If $PauseBot = False Then
				   SetLog("Your request has been received. Bot is now paused")
				  _Push("Request to Pause","Your request has been received. Bot is now paused")
				  ;Local $hWnd = WinWait("[CLASS:AutoIt v3 GUI]", "", 10)
				  ;WinActivate($hWnd)
				  ;ControlClick("[CLASS:AutoIt v3 GUI]", "Stop Bot", "[CLASS:Button; TEXT:Stop Bot]", "left", "1")
				  ;$StBot = 1
				  $PauseBot = True
			   Else
				   SetLog("Your bot is currently paused, no action was taken")
				  _Push("Request to Pause","Your bot is currently paused, no action was taken")
			   EndIf
			   _DeleteMessage($iden[$x])
			Elseif $title[$x] = "bot resume" Then
			   If $PauseBot = True Then
				  SetLog("Your request has been received. Bot is now resumed")
				  _Push("Request to Resume","Your request has been received. Bot is now resumed")
				  $PauseBot = False
				  ;Local $hWnd = WinWait("[CLASS:AutoIt v3 GUI]", "", 10)
				  ;WinActivate($hWnd)
				  ;ControlClick("[CLASS:AutoIt v3 GUI]", "Start Bot", "[CLASS:Button; TEXT:Start Bot]", "left", "1")
			   Else
				   SetLog("Your bot is currently running, no action was taken")
				  _Push("Request to Resume","Your bot is currently running, no action was taken")
			   EndIf
			   _DeleteMessage($iden[$x])
			Elseif $title[$x] = "bot stats" Then
			   SetLog("Your request has been received. Statistics sent")
			   _Push("Request for Stats","Resources at Start\n-Gold:  " & GUICtrlRead($lblresultgoldtstart) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirstart) & "\n-DE:  " & GUICtrlRead($lblresultdestart) & "\n-Trophies:  " & GUICtrlRead($lblresulttrophystart) & "\n\nCurrent Resources \n-Gold:  " & GUICtrlRead($lblresultgoldnow) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirnow) & "\n-DE:  " & GUICtrlRead($lblresultdenow) & "\n-Trophies:  " & GUICtrlRead($lblresulttrophynow) & "\n\nLast Raid\n-Gold:  " & GUICtrlRead($lblresultgoldlast) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirlast) & "\n-DE:  " & GUICtrlRead($lblresultdelast) & "\n-Trophies:  " & GUICtrlRead($lblresulttrophylast) & "\n\nTotal Raid\n-Gold:  " & GUICtrlRead($lblresultgoldgain) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirgain) & "\n-DE:  " & GUICtrlRead($lblresultdegain) & "\n-Trophies Won:  " & GUICtrlRead($lblresulttrophiesdropped) &  "\n\nOther Stats\n-Attacked:  " & GUICtrlRead($lblresultvillagesattacked) & "\n-Skipped:  " & GUICtrlRead($lblresultvillagesskipped) & "\n-Wall Upgrade:  " & GUICtrlRead($lblwallupgradecount) & "\n-Search Cost:  " & GUICtrlRead($lblresultsearchcost) & "\n-Bot Run Time:  " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
			   _DeleteMessage($iden[$x])
			Elseif $title[$x] = "bot logs" Then
			    SetLog("Your request has been received. Log is now sent")
			   _PushFile($sLogFileName, "logs", "text/plain; charset=utf-8", "Current Logs", $sLogFileName)
			   _DeleteMessage($iden[$x])
			Elseif $title[$x] = "bot boost1" Then
				if GUICtrlRead($cmbBoostBarracks) < 5 Then
				   GUICtrlSetData($cmbBoostBarracks, GUICtrlRead($cmbBoostBarracks) + 1)
				   GUICtrlSetState($chkBoostRax1, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax2, $GUI_UNCHECKED)
				   GUICtrlSetState($chkBoostRax3, $GUI_UNCHECKED)
				   GUICtrlSetState($chkBoostRax4, $GUI_UNCHECKED)
				   _Push("Barrack Boost", "Barrack 1 will be boosted on return to village")
				Else
					_Push("Barrack Boost", "You have already reached maximum barracks boost setting")
				EndIf
				_DeleteMessage($iden[$x])
			Elseif $title[$x] = "bot boost2" Then
				if GUICtrlRead($cmbBoostBarracks) < 5 Then
				   GUICtrlSetData($cmbBoostBarracks, GUICtrlRead($cmbBoostBarracks) + 1)
				   GUICtrlSetState($chkBoostRax1, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax2, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax3, $GUI_UNCHECKED)
				   GUICtrlSetState($chkBoostRax4, $GUI_UNCHECKED)
				   _Push("Barrack Boost", "Barracks 1 and 2 will be boosted on return to village")
				Else
					_Push("Barrack Boost", "You have already reached maximum barracks boost setting")
				EndIf
				_DeleteMessage($iden[$x])
			Elseif $title[$x] = "bot boost3" Then
				if GUICtrlRead($cmbBoostBarracks) < 5 Then
				   GUICtrlSetData($cmbBoostBarracks, GUICtrlRead($cmbBoostBarracks) + 1)
				   GUICtrlSetState($chkBoostRax1, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax2, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax3, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax4, $GUI_UNCHECKED)
				   _Push("Barrack Boost", "Barracks 1, 2 and 3 will be boosted on return to village")
				Else
					_Push("Barrack Boost", "You have already reached maximum barracks boost setting")
				EndIf
				_DeleteMessage($iden[$x])
			Elseif $title[$x] = "bot boostall" Then
				if GUICtrlRead($cmbBoostBarracks) < 5 Then
				   GUICtrlSetData($cmbBoostBarracks, GUICtrlRead($cmbBoostBarracks) + 1)
				   GUICtrlSetState($chkBoostRax1, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax2, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax3, $GUI_CHECKED)
				   GUICtrlSetState($chkBoostRax4, $GUI_CHECKED)
				   _Push("Barrack Boost", "All barracks will be boosted on return to village")
				Else
					_Push("Barrack Boost", "You have already reached maximum barracks boost setting")
				EndIf
				_DeleteMessage($iden[$x])
			EndIf
			$title[$x] = ""
			$iden[$x] = ""
		 EndIf
	  Next
   EndIf

   If UBound($iden) > $PushBulletmessages and $PushBulletmessages <> 0 Then
			For $x = $PushBulletmessages to UBound($title) - 1
				$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes/" & $iden[$x], False)
				$oHTTP.SetCredentials($access_token, "", 0)
				$oHTTP.SetRequestHeader("Content-Type", "application/json")
				$oHTTP.Send()
			Next
   EndIf
EndFunc

Func _PushBullet($pTitle = "", $pMessage = "")
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushBullettoken
    $oHTTP.Open("Get", "https://api.pushbullet.com/v2/devices", False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.Send()
    $Result = $oHTTP.ResponseText
    Local $device_iden = _StringBetween($Result, 'iden":"', '"')
    Local $device_name = _StringBetween($Result, 'nickname":"', '"')
EndFunc   ;==>_PushBullet

Func _Push($pTitle, $pMessage)
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushBullettoken
    $oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.SetRequestHeader("Content-Type", "application/json")
    Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '"}'
    $oHTTP.Send($pPush)
EndFunc   ;==>_Push

Func _PushFile($File, $Folder, $FileType, $title, $body)
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushBullettoken
    $oHTTP.Open("Post", "https://api.pushbullet.com/v2/upload-request", False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.SetRequestHeader("Content-Type", "application/json")

    Local $pPush = '{"file_name": "' & $File & '", "file_type": "' & $FileType &'"}'
    $oHTTP.Send($pPush)
	$Result = $oHTTP.ResponseText
	$Result1 = $Result
	Local $upload_url = _StringBetween($Result, 'upload_url":"', '"')
	Local $awsaccesskeyid = _StringBetween($Result, 'awsaccesskeyid":"', '"')
	Local $acl = _StringBetween($Result, 'acl":"', '"')
	Local $key = _StringBetween($Result, 'key":"', '"')
	Local $signature = _StringBetween($Result, 'signature":"', '"')
	Local $policy = _StringBetween($Result, 'policy":"', '"')
	Local $file_url = _StringBetween($Result, 'file_url":"', '"')

	if $upload_url[0] = "" or $awsaccesskeyid[0] = "" or $acl[0] = "" or $key[0] = "" or $signature[0] = "" or $policy[0] = "" or $file_url[0] = "" Then
		SetLog("Something went wrong during upload authorization")
		Return
	else
		$result=runwait(@ScriptDir & "\curl\curl.exe -i -X POST " & $upload_url[0] & ' -F awsaccesskeyid="' & $awsaccesskeyid[0] & '" -F acl="' & $acl[0] & '" -F key="' & $key[0] & '" -F signature="' & $signature[0] & '" -F policy="' & $policy[0] & '" -F content-type="' & $FileType & '" -F file=@"' & @ScriptDir & '\' & $Folder & '\' & $File & '" -o "' & @ScriptDir & '\logs\curl.log"',"",@SW_HIDE)
	EndIf

	if GUICtrlRead($lblpushbulletdebug) = $GUI_CHECKED Then
	   SetLog('=========================================================================')
	   SetLog($Result)
	   SetLog($upload_url[0])
	   SetLog($acl[0])
	   SetLog($key[0])
	   SetLog($signature[0])
	   SetLog($policy[0])
	   SetLog($awsaccesskeyid[0])
	   SetLog($file_url[0])
	   SetLog($Result1)
	   SetLog(@ScriptDir & "\curl\curl.exe -i -X POST " & $upload_url[0] & ' -F awsaccesskeyid="' & $awsaccesskeyid[0] & '" -F acl="' & $acl[0] & '" -F key="' & $key[0] & '" -F signature="' & $signature[0] & '" -F policy="' & $policy[0] & '" -F content-type="' & $FileType & '" -F file=@"' & @ScriptDir & '\' & $Folder & '\' & $File & '" -o "' & @ScriptDir & '\logs\curl.log"')
	EndIf
	if _FileCountLines(@ScriptDir & '\logs\curl.log') > 8 Then
		Local $hFileOpen = FileOpen(@ScriptDir & '\logs\curl.log')
		Local $sFileRead = FileReadLine($hFileOpen, 8)
		Local $sFileRead1 = StringSplit($sFileRead," ")
		Local $sLink = $sFileRead1[2]
		Local $findstr1 = StringRegExp ($sLink, 'https://')
	Else
		SetLog("Problem encountered while uploading file.")
		Return
	EndIf

    if $findstr1 = 1 Then
	   $oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
	   $oHTTP.SetCredentials($access_token, "", 0)
	   $oHTTP.SetRequestHeader("Content-Type", "application/json")
	   ;Local $pPush = '{"type": "file", "file_name": "' & $FileName & '", "file_type": "' & $FileType & '", "file_url": "' & $file_url[0] & '", "title": "' & $title & '", "body": "' & $body & '"}'
	   Local $pPush = '{"type": "file", "file_name": "' & $File & '", "file_type": "' & $FileType & '", "file_url": "' & $sLink & '", "title": "' & $title & '", "body": "' & $body & '"}'
	   $oHTTP.Send($pPush)
	   $Result = $oHTTP.ResponseText
    Else
	   if GUICtrlRead($lblpushbulletdebug) = $GUI_CHECKED Then
		  SetLog($hFileOpen)
		  SetLog("There is an error and file was not uploaded")
	   EndIf
    EndIf
    if GUICtrlRead($lblpushbulletdebug) = $GUI_CHECKED Then
	   SetLog($Result)
	   SetLog("You can paste this in the forum so we can check whether it is PushBullet problem or mine")
	   SetLog('=========================================================================')
    EndIf
EndFunc   ;==>_Push

Func _DeletePush()
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushBullettoken
    $oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes", False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.SetRequestHeader("Content-Type", "application/json")
    $oHTTP.Send()
EndFunc   ;==>_DeletePush

Func _DeleteMessage($iden)
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushBullettoken
    $oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes/" & $iden, False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.SetRequestHeader("Content-Type", "application/json")
    $oHTTP.Send()
EndFunc   ;==>_Push