#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <config/GWA2.au3>
#include <config/GWA2_Headers.au3>

#Region ### START Koda GUI section ### Form=c:\users\mikro\downloads\koda_1.7.3.0\forms\followbot.kxf
$FollowBot = GUICreate("Follow Bot", 262, 363, 352, 130)
$edt_charname = GUICtrlCreateInput("", 96, 8, 153, 21)
$Label1 = GUICtrlCreateLabel("Character Name", 8, 8, 81, 17)
$StationarySkills = GUICtrlCreateGroup("Use this Skills while standing", 8, 232, 241, 89)
$cb_skill5_standing = GUICtrlCreateCheckbox("Skill 5", 112, 248, 81, 17)
$cb_skill6_standing = GUICtrlCreateCheckbox("Skill 6", 112, 264, 81, 17)
$cb_skill7_standing = GUICtrlCreateCheckbox("Skill 7", 112, 280, 81, 17)
$cb_skill8_standing = GUICtrlCreateCheckbox("Skill 8", 112, 296, 81, 17)
$cb_skill4_standing = GUICtrlCreateCheckbox("Skill 4", 24, 296, 81, 17)
$cb_skill2_standing = GUICtrlCreateCheckbox("Skill 2", 24, 264, 81, 17)
$cb_skill3_standing = GUICtrlCreateCheckbox("Skill 3", 24, 280, 81, 17)
$cb_skill1_standing = GUICtrlCreateCheckbox("Skill 1", 24, 248, 81, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$btn_follow = GUICtrlCreateButton("Follow", 8, 328, 75, 25)
$btn_loot = GUICtrlCreateButton("Pickup Loot", 88, 328, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$btn_stop = GUICtrlCreateButton("Stop", 176, 328, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$Group2 = GUICtrlCreateGroup("Follow Player", 8, 40, 241, 97)
$rb_player1 = GUICtrlCreateRadio("Player 1", 24, 64, 57, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$rb_player2 = GUICtrlCreateRadio("Player 2", 24, 80, 57, 17)
$rb_player3 = GUICtrlCreateRadio("Player 3", 24, 96, 57, 17)
$rb_player4 = GUICtrlCreateRadio("Player 4", 24, 112, 57, 17)
$rb_player6 = GUICtrlCreateRadio("Player 6", 128, 80, 57, 17)
$rb_player5 = GUICtrlCreateRadio("Player 5", 128, 64, 57, 17)
$rb_player7 = GUICtrlCreateRadio("Player 7", 128, 96, 57, 17)
$rb_player8 = GUICtrlCreateRadio("Player 8", 128, 112, 57, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$MovingSkills = GUICtrlCreateGroup("Use this Skills while moving", 6, 141, 241, 89)
$cb_skill5_moving = GUICtrlCreateCheckbox("Skill 5", 110, 157, 81, 17)
$cb_skill6_moving = GUICtrlCreateCheckbox("Skill 6", 110, 173, 81, 17)
$cb_skill7_moving = GUICtrlCreateCheckbox("Skill 7", 110, 189, 81, 17)
$cb_skill8_moving = GUICtrlCreateCheckbox("Skill 8", 110, 205, 81, 17)
$cb_skill4_moving = GUICtrlCreateCheckbox("Skill 4", 22, 205, 81, 17)
$cb_skill2_moving = GUICtrlCreateCheckbox("Skill 2", 22, 173, 81, 17)
$cb_skill3_moving = GUICtrlCreateCheckbox("Skill 3", 22, 189, 81, 17)
$cb_skill1_moving = GUICtrlCreateCheckbox("Skill 1", 22, 157, 81, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

#Region GUI Event Handler
Opt("GUIOnEventMode", 1)

Func EventHandler()
	Switch (@GUI_CtrlId)
		Case $btn_follow
			$boolRun = True
			GUICtrlSetState($edt_charname, $GUI_DISABLE)
			GUICtrlSetState($btn_follow, $GUI_DISABLE)
			GUICtrlSetState($btn_stop, $GUI_ENABLE)
			GUICtrlSetState($btn_loot, $GUI_ENABLE)
			If GUICtrlRead($edt_charname) = "" Then
				If Initialize(ProcessExists("gw.exe")) = False Then
					MsgBox(0, "Error", "Guild Wars it not running.")
					$boolRun = false
					GUICtrlSetState($btn_follow, $GUI_ENABLE)
					GUICtrlSetState($btn_stop, $GUI_DISABLE)
					GUICtrlSetState($btn_loot, $GUI_DISABLE)
					Exit
				EndIf
			Else
				If Initialize(GUICtrlRead($edt_charname), True, True) = False Then
					MsgBox(0, "Error", "Can't find a Guild Wars client with that character name.")
					$boolRun = false
					GUICtrlSetState($btn_follow, $GUI_ENABLE)
					GUICtrlSetState($btn_stop, $GUI_DISABLE)
					GUICtrlSetState($btn_loot, $GUI_DISABLE)
					Exit
				EndIf
			EndIf
		Case $btn_stop
			$boolRun = false
			GUICtrlSetState($btn_follow, $GUI_ENABLE)
			GUICtrlSetState($btn_stop, $GUI_DISABLE)
			GUICtrlSetState($btn_loot, $GUI_DISABLE)
		Case $btn_loot
			$boolRun = false
			PickUpLoot()
			Main()
			$boolRun = true
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
 EndFunc

GUICtrlSetOnEvent($btn_follow, "EventHandler")
GUICtrlSetOnEvent($btn_stop, "EventHandler")
GUICtrlSetOnEvent($btn_loot, "EventHandler")
GUISetOnEvent($GUI_EVENT_CLOSE, "EventHandler")
#EndRegion GUI Event Handler

#Region Loot
Global Const $RARITY_Gold = 2624

Global Const $ID_Goldcoins = 2511
Global Const $ID_Lockpicks = 22751

Global Const $ID_Dyes = 146

;~ Special Drops (Event Items)
Global $Special_Drops[] = [ _
21492, 21812, 22269, 22644, 22752, 28436, 36681, 35124, 36682, _
910, 6375, 22190, 28435, 30855, 556, 5656, 18345, 21491, 37765, _
21833, 28434, 6370, 21488, 21489, 22191, 26784, 28433, 15837, _
21490, 30648, 31020, 6376, 21809, 21810, 21813, 36683, 2513, _
5585, 6049, 6366, 6367, 15477, 19171, 24593, 31145, 31146, _
15528, 15479, 19170, 31150, 35125, 28431, 28432, 6368, 6369]

Global $Elite_Tomes[] = [21790, 21792, 21793, 21786, 21788, 21795, 21787, 21791, 21789, 21794]

Func PickUpLoot()
	Local $lAgent
	Local $aitem
	Local $lDeadlock
	For $i = 1 To GetMaxAgents()
	If GetIsDead(-2) Then Return
	$lAgent = GetAgentByID($i)
	If DllStructGetData($lAgent, 'Type') <> 0x400 Then ContinueLoop
	$aitem = GetItemByAgentID($i)
	If CanPickUp($aitem) Then
	PickUpItem($aitem)
	$lDeadlock = TimerInit()
	While GetAgentExists($i)
	Sleep(100)
	If GetIsDead(-2) Then Return
	If TimerDiff($lDeadlock) > 10000 Then ExitLoop
	WEnd
	EndIf
	Next
EndFunc

Func CanPickUp($aitem)
	Local $iModelID = DllStructGetData($aitem, 'ModelID')
	Local $iType = DllStructGetData($aitem, 'Type')
	Local $iExtraID = DllStructGetData($aItem, 'ExtraID')
	Local $iRarity = GetRarity($aitem)
	Local $Ecto = 930
	;TODO

	If $iModelID = $ID_Goldcoins Then Return True
	If $iRarity = $RARITY_Gold Then Return True
	If $iModelID = $ID_Lockpicks Then Return True
	If $iModelID = $ID_Dyes and $iExtraID>9 Then Return True
	
	For $index = 0 To UBound($Special_Drops)-1 
		If $iModelID = $Special_Drops[$index] Then Return True
	Next

	For $index = 0 To UBound($Elite_Tomes)-1 
		If $iModelID = $Elite_Tomes[$index] Then Return True
	Next
	If $iModelID = $Ecto then return true
	Return False
EndFunc
#EndRegion Loot

Global $boolRun = false
Initialize(WinGetProcess("Guild Wars"))

While 1
	While 1
		If Not $boolRun Then
			While Not $boolRun
				Sleep(500)
			WEnd
		EndIf
		Main()
	WEnd
WEnd

#Region Main
Func Main()
	Local $leader = GetLeader()
	If $leader<=0 Then Return
	$leaderAgent = GetAgentByPlayerNumber($leader)
	If GetIsMoving($leaderAgent) then GoPlayer($leaderAgent)
	While GetIsMoving(-2)
		sleep(100)
		If Not GetIsMoving($leaderAgent) and GetDistance($leaderAgent)<100 Then 
			CastStationary()
		Else
			CastMoving()
			$leaderAgent = GetAgentByPlayerNumber($leader)
			if GetDistance($leaderAgent)>100 Then
				GoPlayer($leaderAgent)
			EndIf		
		EndIf
	WEnd
EndFunc	;=>Main

Func CastStationary()
	If GUICtrlRead($cb_skill1_standing) = $GUI_CHECKED and IsRecharged(1) Then UseSkillEx(1)
	If GUICtrlRead($cb_skill2_standing) = $GUI_CHECKED and IsRecharged(2) Then UseSkillEx(2)
	If GUICtrlRead($cb_skill3_standing) = $GUI_CHECKED and IsRecharged(3) Then UseSkillEx(3)
	If GUICtrlRead($cb_skill4_standing) = $GUI_CHECKED and IsRecharged(4) Then UseSkillEx(4)
	If GUICtrlRead($cb_skill5_standing) = $GUI_CHECKED and IsRecharged(5) Then UseSkillEx(5)
	If GUICtrlRead($cb_skill6_standing) = $GUI_CHECKED and IsRecharged(6) Then UseSkillEx(6)
	If GUICtrlRead($cb_skill7_standing) = $GUI_CHECKED and IsRecharged(7) Then UseSkillEx(7)
	If GUICtrlRead($cb_skill8_standing) = $GUI_CHECKED and IsRecharged(8) Then UseSkillEx(8)
EndFunc

Func CastMoving()
	If GUICtrlRead($cb_skill1_moving) = $GUI_CHECKED and IsRecharged(1) Then UseSkillEx(1)
	If GUICtrlRead($cb_skill2_moving) = $GUI_CHECKED and IsRecharged(2) Then UseSkillEx(2)
	If GUICtrlRead($cb_skill3_moving) = $GUI_CHECKED and IsRecharged(3) Then UseSkillEx(3)
	If GUICtrlRead($cb_skill4_moving) = $GUI_CHECKED and IsRecharged(4) Then UseSkillEx(4)
	If GUICtrlRead($cb_skill5_moving) = $GUI_CHECKED and IsRecharged(5) Then UseSkillEx(5)
	If GUICtrlRead($cb_skill6_moving) = $GUI_CHECKED and IsRecharged(6) Then UseSkillEx(6)
	If GUICtrlRead($cb_skill7_moving) = $GUI_CHECKED and IsRecharged(7) Then UseSkillEx(7)
	If GUICtrlRead($cb_skill8_moving) = $GUI_CHECKED and IsRecharged(8) Then UseSkillEx(8)
EndFunc

Func GetLeader()
	If GUICtrlRead($rb_player1) = $GUI_CHECKED Then Return 1
	If GUICtrlRead($rb_player2) = $GUI_CHECKED Then Return 2
	If GUICtrlRead($rb_player3) = $GUI_CHECKED Then Return 3
	If GUICtrlRead($rb_player4) = $GUI_CHECKED Then Return 4
	If GUICtrlRead($rb_player5) = $GUI_CHECKED Then Return 5
	If GUICtrlRead($rb_player6) = $GUI_CHECKED Then Return 6
	If GUICtrlRead($rb_player7) = $GUI_CHECKED Then Return 7
	If GUICtrlRead($rb_player8) = $GUI_CHECKED Then Return 8
	Return 0
EndFunc
#endRegion Main