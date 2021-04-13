#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include-once
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include "config/GWA2.au3"
#include "config/GWA2_Headers.au3"
#include "config/ReFeathers/farmingroute.au3"
#include <GuiEdit.au3>

Global $configpath = "config/ReFeathers/config.ini"

Global $RARITY_White = 2621, $RARITY_Blue = 2623, $RARITY_Purple = 2626, $RARITY_Gold = 2624, $RARITY_Green = 2627

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Change the next line to your character name:
Global $strName = ""

; Build Template: OACjAqiK5OQzH318bWOPbNTnJA

Global $LL = 250 ; Seitungs Harbor
Global $LI = 242 ; Shing Jea Monestary
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Opt("GUIOnEventMode", 1)
Global $feather = 0
Global $crests = 0
Global $class = "Rt"
Global $boolRun = False
Global $intPrevious = -1
Global $intCash = -1
Global $intGold = 0
Global $intRuns = 0
Global $Rendering = True
Global $Runs = 0
Global $Deaths = 0
Global $grog = 30855
Global $golds = 2511
Global $tots = 28434
Global $hp_start
Global $merch
Global $gwpid = -1

#Region ### START Koda GUI section ### Form=C:\Program Files\AutoIt3\Koda Form Designer\Forms\ReFeather.kxf
$Form1 = GUICreate("Farm plume 1.1.0", 618, 290, 100, 100)
$charactername = GUICtrlCreateInput("", 344, 24, 121, 21)
$startbutton = GUICtrlCreateButton("Start", 8, 224, 233, 57)
$cbxHideGW = GUICtrlCreateCheckbox("Disable Graphics", 264, 80, 177, 17)
GUICtrlSetOnEvent($cbxHideGW, "gui_eventHandler")
$storegolds = GUICtrlCreateCheckbox("Store golds at chest", 264, 104, 137, 17)
$Group4 = GUICtrlCreateGroup("ID and sell from bag:", 496, 8, 113, 121)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$usebag1 = GUICtrlCreateCheckbox("Num. 1", 505, 32, 95, 17)
$usebag2 = GUICtrlCreateCheckbox("Num. 2", 505, 56, 95, 17)
$usebag3 = GUICtrlCreateCheckbox("Num. 3", 505, 80, 95, 17)
$usebag4 = GUICtrlCreateCheckbox("Num. 4", 505, 104, 95, 17)
$Group2 = GUICtrlCreateGroup("pick up items of color:", 248, 136, 121, 145)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$pickupgreen = GUICtrlCreateCheckbox("green", 257, 160, 95, 17)
$pickupgold = GUICtrlCreateCheckbox("gold", 257, 184, 95, 17)
$pickuppurple = GUICtrlCreateCheckbox("purple", 257, 208, 95, 17)
$pickupblue = GUICtrlCreateCheckbox("blue", 257, 232, 95, 17)
$pickupwhite = GUICtrlCreateCheckbox("white", 257, 256, 95, 17)
$Group3 = GUICtrlCreateGroup("ident items of color:", 376, 136, 113, 145)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$identgold = GUICtrlCreateCheckbox("gold", 393, 160, 95, 17)
$identpurple = GUICtrlCreateCheckbox("purple", 393, 184, 95, 17)
$identblue = GUICtrlCreateCheckbox("blue", 393, 208, 95, 17)
$Group1 = GUICtrlCreateGroup("sell items of color:", 496, 136, 113, 145)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$sellgreen = GUICtrlCreateCheckbox("green", 505, 160, 95, 17)
$sellgold = GUICtrlCreateCheckbox("gold", 505, 184, 95, 17)
$sellpurple = GUICtrlCreateCheckbox("purple", 505, 208, 95, 17)
$sellblue = GUICtrlCreateCheckbox("blue", 505, 232, 95, 17)
$Group5 = GUICtrlCreateGroup("Information", 8, 8, 233, 209)
$Label3 = GUICtrlCreateLabel("Total runs:", 24, 40, 54, 17)
$Label4 = GUICtrlCreateLabel("Number of Deaths", 24, 64, 90, 17)
$Label5 = GUICtrlCreateLabel("Total gold earned:", 24, 88, 90, 17)
$Label6 = GUICtrlCreateLabel("Feathers got:", 24, 112, 66, 17)
$Label7 = GUICtrlCreateLabel("Feathered Crests got:", 24, 136, 105, 17)
$Label8 = GUICtrlCreateLabel("Status:", 48, 168, 37, 17)
$run = GUICtrlCreateLabel("-", 136, 40, 95, 17, $SS_CENTER)
$death = GUICtrlCreateLabel("-", 136, 64, 95, 17, $SS_CENTER)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label1 = GUICtrlCreateLabel("Character name:", 256, 27, 82, 17)
$Label2 = GUICtrlCreateLabel("(only needed for multiple accounts)", 280, 46, 168, 17)
$gold = GUICtrlCreateLabel("-", 136, 88, 95, 17, $SS_CENTER)
$feathers = GUICtrlCreateLabel("-", 136, 112, 95, 17, $SS_CENTER)
$featheredcrests = GUICtrlCreateLabel("-", 136, 136, 95, 17, $SS_CENTER)
$statuslbl = GUICtrlCreateLabel("Ready to begin", 24, 184, 204, 17, $SS_CENTER)

Opt("GUIOnEventMode",1)
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseHandler")
GUICtrlSetOnEvent($startbutton, "Init")
GUICtrlSetOnEvent($storegolds, "UpdateConfig")
GUICtrlSetOnEvent($sellgreen, "UpdateConfig")
GUICtrlSetOnEvent($sellgold, "UpdateConfig")
GUICtrlSetOnEvent($sellpurple, "UpdateConfig")
GUICtrlSetOnEvent($sellblue, "UpdateConfig")
GUICtrlSetOnEvent($identgold, "UpdateConfig")
GUICtrlSetOnEvent($identpurple, "UpdateConfig")
GUICtrlSetOnEvent($identblue, "UpdateConfig")
GUICtrlSetOnEvent($pickupgreen, "UpdateConfig")
GUICtrlSetOnEvent($pickupgold, "UpdateConfig")
GUICtrlSetOnEvent($pickuppurple, "UpdateConfig")
GUICtrlSetOnEvent($pickupblue, "UpdateConfig")
GUICtrlSetOnEvent($pickupwhite, "UpdateConfig")
GUICtrlSetOnEvent($usebag1, "UpdateConfig")
GUICtrlSetOnEvent($usebag2, "UpdateConfig")
GUICtrlSetOnEvent($usebag3, "UpdateConfig")
GUICtrlSetOnEvent($usebag4, "UpdateConfig")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

ReadConfig()

While 1
	Sleep(100)
	If $boolRun Then
		If (IDorsellsomething() And $merch) OR $Runs == 0 Then SellAndBack()
		SwitchMode(0)
		EnterArea()
		Farm()

		$intGold += GetGoldCharacter() - $intCash
		$intCash = GetGoldCharacter()
		$intRuns += 1
		$Runs += 1

		GUICtrlSetData($run, $intRuns)
		GUICtrlSetData($gold, $intGold)
		Update("Stats updated")
		RndSleep(2500)

		If Not $boolRun Then
			Update("Bot was paused")
			GUICtrlSetData($startbutton, "Start")
			GUICtrlSetState($startbutton, $GUI_ENABLE)
			GUICtrlSetState($charactername, $GUI_ENABLE)
		EndIf
	EndIf
WEnd

Func CloseHandler()
	If not $rendering Then
		AdlibUnRegister("_ReduceMemory")
	EndIf
	Exit
 EndFunc

 func gui_eventHandler()
	switch (@GUI_CtrlId)
		case $GUI_EVENT_CLOSE
			exit
	  Case $cbxHideGW
			If GUICtrlRead($cbxHideGW) = 1 Then
				DisableRendering()
				AdlibRegister("reduceMemory", 20000)
				WinSetState(GetWindowHandle(), "", @SW_HIDE)
			Else
				EnableRendering()
				AdlibUnRegister("reduceMemory")
				WinSetState(GetWindowHandle(), "", @SW_SHOW)
			EndIf
	endswitch
endfunc

Func IDorsellsomething()
	If GetChecked($identblue) then Return True
	If GetChecked($identpurple) then Return True
	If GetChecked($identgold) then Return True
	If GetChecked($sellblue) then Return True
	If GetChecked($sellpurple) then Return True
	If GetChecked($sellgold) then Return True
	If GetChecked($sellgreen) then Return True
	Return false
EndFunc

Func Update($text)
	GUICtrlSetData($statuslbl, $text)
	;WinSetTitle($cGUI, "", $intRuns & " - " & $intGold & "g")
EndFunc   ;==>Update

Func GetChecked($GUICtrl)
	Return (GUICtrlRead($GUICtrl)==$GUI_Checked)
EndFunc

Func SetState($GUICtrl,$boolean)
	If $boolean == "True" Then
		GUICtrlSetState($GUICtrl,$GUI_Checked)
	Else
		GUICtrlSetState($GUICtrl,$GUI_UnChecked)
	EndIf
EndFunc

Func ReadConfig()
	if FileExists($configpath) Then
		SetState($storegolds,IniRead($configpath,"general","storegolds","False"))
		SetState($usebag1,IniRead($configpath,"usebags","bag1","False"))
		SetState($usebag2,IniRead($configpath,"usebags","bag2","False"))
		SetState($usebag3,IniRead($configpath,"usebags","bag3","False"))
		SetState($usebag4,IniRead($configpath,"usebags","bag4","False"))
		SetState($pickupgreen,IniRead($configpath,"pickup","green","False"))
		SetState($pickupgold,IniRead($configpath,"pickup","gold","False"))
		SetState($pickuppurple,IniRead($configpath,"pickup","purple","False"))
		SetState($pickupblue,IniRead($configpath,"pickup","blue","False"))
		SetState($pickupwhite,IniRead($configpath,"pickup","white","False"))
		SetState($identgold,IniRead($configpath,"identify","gold","False"))
		SetState($identpurple,IniRead($configpath,"identify","purple","False"))
		SetState($identblue,IniRead($configpath,"identify","blue","False"))
		SetState($sellgreen,IniRead($configpath,"sell","green","False"))
		SetState($sellgold,IniRead($configpath,"sell","gold","False"))
		SetState($sellpurple,IniRead($configpath,"sell","purple","False"))
		SetState($sellblue,IniRead($configpath,"sell","blue","False"))
	EndIf
EndFunc

Func UpdateConfig()

	Local $udata = "bag1="&GetChecked($usebag1)&@LF&"bag2="&GetChecked($usebag2)&@LF&"bag3="&GetChecked($usebag3)&@LF&"bag4="&GetChecked($usebag4)
	IniWriteSection($configpath, "usebags", $udata)

	Local $pdata = "green="&GetChecked($pickupgreen)&@LF&"gold="&GetChecked($pickupgold)&@LF&"purple="&GetChecked($pickuppurple)&@LF&"blue="&GetChecked($pickupblue)&@LF&"white="&GetChecked($pickupwhite)
	IniWriteSection($configpath, "pickup", $pdata)

	Local $idata = "gold="&GetChecked($identgold)&@LF&"purple="&GetChecked($identpurple)&@LF&"blue="&GetChecked($identblue)
	IniWriteSection($configpath, "identify", $idata)

	Local $sdata = "green="&GetChecked($sellgreen)&@LF&"gold="&GetChecked($sellgold)&@LF&"purple="&GetChecked($sellpurple)&@LF&"blue="&GetChecked($sellblue)
	IniWriteSection($configpath, "sell", $sdata)
EndFunc

Func Init()
	$boolRun = Not $boolRun
	If $boolRun Then
		GUICtrlSetData($startbutton, "Initializing...")
		GUICtrlSetState($startbutton, $GUI_DISABLE)
		GUICtrlSetState($charactername, $GUI_DISABLE)
		If GUICtrlRead($charactername) = "" Then
			If Initialize(ProcessExists("gw.exe")) = False Then
				MsgBox(0, "Error", "Guild Wars Is not running.")
				Exit
			EndIf
			$gwpid=ProcessExists("gw.exe")
		Else
			If Initialize(GUICtrlRead($charactername), True, True) = False Then
				MsgBox(0, "Error", "Can't find a Guild Wars client with that character name.")
				Exit
			EndIf
			$lWinList = ProcessList('gw.exe')
			For $i = 1 To $lWinList[0][0]
				$mGWHwnd = $lWinList[$i][1]
				MemoryOpen($mGWHwnd)
				If StringRegExp(ScanForCharname(), GUICtrlRead($charactername)) = 1 Then
					$gwpid = $mGWHwnd
					ExitLoop
				EndIf
			Next
		EndIf
		GUICtrlSetState($startbutton, $GUI_ENABLE)
		GUICtrlSetData($startbutton, "Pause")
		$lMe = GetAgentByID(-2)
		$hp_start = DllStructGetData($lMe, 'MaxHP')
		$merch = true
		if DllStructGetData($lMe, 'Primary') == 4 Then
			Update("Detected Necromancer")
			$class = "N"
		EndIf
		If $intCash = -1 Then
			$intCash = GetGoldCharacter()
		EndIf
	Else
		GUICtrlSetData($startbutton, "BOT WILL HALT AFTER THIS RUN")
		GUICtrlSetState($startbutton, $GUI_DISABLE)
	EndIf
EndFunc   ;==>EventHandler



Func _ReduceMemory()
    If $gwpid <> -1 Then
        Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $gwpid)
        Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
        DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
    Else
        Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)
    EndIf

    Return $ai_Return[0]
EndFunc;==> _ReduceMemory()

Func SellAndBack()
	Travel($LL)
	$foundspawn = False
	Do
		Update("Searching for spawn")
		;to chest
		$lme = GetAgentByID(-2)
		$mex = DllStructGetData($lme,"X")
		$mey = DllStructGetData($lme,"Y")
		if 18600<$mex and $mex<20000 and 9000<$mey and $mey<10000 Then
			Update("found spawn #1")
			MoveTo(18478,9415,100)
			Sleep(Random(100,500))
			MoveTo(16821,9924,100)
			Sleep(Random(100,800))
			$foundspawn = True
		ElseIf 17500<$mex and $mex<18600 and 10000<$mey and $mey<11550 Then
			Update("found spawn #2")
			MoveTo(19390,10213,100)
			Sleep(Random(200,700))
			MoveTo(18478,9415,100)
			Sleep(Random(100,500))
			MoveTo(16821,9924,100)
			Sleep(Random(100,800))
			$foundspawn = True
		ElseIf 15000<$mex and $mex<17500 and 11550<$mey and $mey<13000 Then
			Update("found spawn #3")
			MoveTo(16821,9924,100)
			Sleep(Random(100,800))
			$foundspawn = True
		Else
			Update("Couldnot find spawn")
			Travel($LI)
			Sleep(Random(800,2000))
			Travel($LL)
		EndIf
	until $foundspawn

	Update("Selling bags stuff")
	RndSleep(1000)
	IDAndSell()
	If GetGoldCharacter() > 80000 Then
		Update("Depositing gold")
		DepositGold(70000)
		$intCash = GetGoldCharacter()
	EndIf
	 If InventoryCheck() Then                                      ;maby additional checkbox therefor
		$boolRun = False
		Update("Bot stopped, low inventory space")
		GUICtrlSetData($startbutton, "Start")
		GUICtrlSetState($charactername, $GUI_ENABLE)
		GUICtrlSetState($startbutton, $GUI_ENABLE)
		If ProcessExists("Gw.exe") Then
			ProcessClose("Gw.exe")
			MsgBox(0, "", "Bot stopped, low inventory space")
			Exit
		EndIf
	EndIf

	;from merchant to area
	MoveTo(17002,12778,100)
	Sleep(Random(100,800))
	MoveTo(18012,13664,100)
	Sleep(Random(80,700))
	MoveTo(18859,13224,100)
	Sleep(Random(120,500))
	MoveTo(19088,13416,100)
	Sleep(Random(200,700))
	MoveTo(18288,14884,100)
	Sleep(Random(100,500))
	MoveTo(18783,16107,100)
	Sleep(Random(100,800))
	EnterArea()
	Sleep(Random(200,700))
	ReverseDirection()
	LeaveArea()
	Sleep(Random(200,700))
	ReverseDirection()
	Sleep(Random(200,700))
	$merch = false
EndFunc   ;==>SellAndBack

Func EnterArea()
	Do
		MoveTo(17171,17331)
		PingSleep()
		Move(16800,17500)
		Sleep(5000)
		WaitForLoad()
	Until GetMapID() <> $LL
EndFunc

Func LeaveArea()
	Do
		MoveTo(10724,-13226)
		PingSleep()
		Move(10800,-13250)
		Sleep(5000)
		WaitForLoad()
	Until GetMapID() == $LL
EndFunc

Func HardLeave()
	Sleep(Random(3000,5000))
	Resign()
	Sleep(Random(4000,6000))
	ReturnToOutpost()
	WaitForLoad()
EndFunc

Func Travel($map)
	If GetMapID() <> $map Then
		TravelTo($map)
		WaitForLoad()
	EndIf
EndFunc

Func MoveAndUseSkills($aX, $aY)
	Local $lBlocked = 0
	Local $lMe
	Local $lastHP = 0

	Update("Moving on Farming-Route!")
	;Update("Moving to "&string($aX)&", "&string($aY))
	Move($aX, $aY)
	Do
		Sleep(40)
		$isDead = GetIsDead(-2)

		If $isDead Then ;Restart farm when dead
			Sleep(Random(1000,3000))
			;HardLeave()
			Return 0
		EndIf
		$lMe = GetAgentByID(-2)
		If DllStructGetData($lMe, 'HP') < $lastHP Then
			if Nuke()==0 Then return 0
			Move($aX, $aY, 100)
			;Update("Moving to "&string($aX)&", "&string($aY))
			Update("Moving on Farming-Route!")
		EndIf
		KeepUpBoon()
		$lastHP = DllStructGetData($lMe, 'HP')
		If GetIsMoving($lMe) = False Then
			$lBlocked += 1
			Move($aX, $aY, 100)
		EndIf

	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $aX, $aY) < 110 Or $lBlocked > 8

	Return 1
EndFunc   ;==>MoveAndUseSkills

Func Farm()
	Update("Calculating waypoints...")
	Local $route=CreateFarmingRoute()
	Update("Running to farming route")
	MoveTo(9545,-11478)
	MoveTo(11226,-9199,100)
	Local $i = 0
	While $i<UBound($route, 1)
		KeepUpBoon()
		if MoveAndUseSkills($route[$i][0],$route[$i][1])==0 then
			If GetIsDead(-2) Then
				$Deaths += 1
				GUICtrlSetData($death, $Deaths)
				while GetIsDead(-2)
					Sleep(Random(2000,5000))
				WEnd
				Local $p = (1 - DllStructGetData(GetAgentByID(-2),'MaxHP') / $hp_start) * 100
				If $p <= 40 Then
					Update($p&"% DP so far")
					$i = 0
					Local $x = DllStructGetData(GetAgentByID(-2),'X'),$y = DllStructGetData(GetAgentByID(-2),'Y')
					For $j = 1 To UBound($route) - 1
						if Dist($x,$y,$route[$i][0],$route[$i][1]) > Dist($x,$y,$route[$j][0],$route[$j][1]) Then $i = $j
					Next
				Else
					Update("Too much DP... Restarting")
					HardLeave()
					Return 0
				EndIf
			Else
				Return 0
			EndIf
		Else
			$i+=1
		EndIf
	WEnd
	PingSleep()
	Update("Run succesful")
	Sleep(Random(1000,3000))
	HardLeave()
	return 1
EndFunc   ;==>Farm

Func Dist($x1,$y1,$x2,$y2)
	$x1 = ($x1-$x2)*($x1-$x2)
	$y1 = ($y1-$y2)*($y1-$y2)
	Return Sqrt($x1+$y2)
EndFunc

Func Nuke()
	Update("Kill them all")
	$deadlock = 0
	$target = GetNearestEnemyToAgent(-2)
	Local $lMe = GetAgentByID(-2)
	Local $e = 0, $shouldmove = false
	Do
		if GetIsDead(-2) Then
			;HardLeave()
			Update("Found ourself dead")
			return 0
		EndIf
		PingSleep(50)
		$deadlock += 100
		$e = GetEnergy($lMe)
		if $class == "N" Then
			KeepUpBoon()
			If GetSkillBarSkillRecharge(6) = 0 Then
				If $e >= 15 Then UseSkillEx(6, -2)
			ElseIf GetSkillBarSkillRecharge(5) = 0 Then
				If $e >= 5 Then UseSkillEx(5, -2)
			ElseIf GetSkillBarSkillRecharge(4) = 0 Then
				If $e >= 5 Then UseSkillEx(4, -2)
			ElseIf GetSkillBarSkillRecharge(3) = 0 Then
				UseSkillEx(3, -2)
			ElseIf GetSkillBarSkillRecharge(1) = 0 Then
				If $e >= 5 Then UseSkillEx(1, -2)
			ElseIf GetSkillBarSkillRecharge(7) = 0 Then
				If $e >= 15 Then UseSkillEx(7, -2)
				$shouldmove = true
			Else
				if $shouldmove Then
					MoveAway($lMe, $target)
					$shouldmove=false
				EndIf
			EndIf
		Else
			if GetSkillBarSkillRecharge(3) = 0 and DllStructGetData($lMe, 'HP') < 1/2 Then
				UseSkillEx(3, -2)
			Else
				KeepUpBoon()
				If GetSkillBarSkillRecharge(6) = 0 Then
					If $e >= 15 Then UseSkillEx(6, -2)
				ElseIf GetSkillBarSkillRecharge(5) = 0 Then
					If $e >= 5 Then UseSkillEx(5, -2)
				ElseIf GetSkillBarSkillRecharge(4) = 0 Then
					If $e >= 5 Then UseSkillEx(4, -2)
				ElseIf GetSkillBarSkillRecharge(3) = 0 Then
					UseSkillEx(3, -2)
				ElseIf GetSkillBarSkillRecharge(2) = 0 Then
					If $e >= 15 Then UseSkillEx(2, -2)
				ElseIf GetSkillBarSkillRecharge(1) = 0 Then
					If $e >= 5 Then UseSkillEx(1, -2)
				Else
					Attack($target)
				EndIf
			EndIf
		EndIf
		$target = GetNearestEnemyToAgent(-2)
		ChangeTarget($target)
	Until DllStructGetData($target, 'HP') = 0 Or GetNumberOfFoesInRangeOfAgent1(-2, 1012) = 0 Or $deadlock > 6000 Or GetDistance($target, -2) > 1150
	Sleep(3000)

	Update("Picking up items")
	PickUpLoot()
	If CountSlots() = 0 Then
		Update("Inventory full")
		$merch = true
		Sleep(Random(3000,5000))
		;Travel($LL)
		Return 0
	EndIf
	Update("Waiting for CD")
	Local $lastHP = DllStructGetData($lMe, 'HP')
	Do
		if GetIsDead(-2) Then
			Update("Found ourself dead")
			return 0
		EndIf
		If DllStructGetData($lMe, 'HP') < $lastHP Then
			if Nuke()==0 Then return 0
		EndIf
		KeepUpBoon()
		$lastHP = DllStructGetData($lMe, 'HP')
		Sleep(Random(1000,2000))
		$i=0
		If GetSkillBarSkillRecharge(3) == 0 Then
			$i = $i + 1
		EndIf
		If GetSkillBarSkillRecharge(4) == 0 Then
			$i = $i + 1
		EndIf
		If GetSkillBarSkillRecharge(5) == 0 Then
			$i = $i + 1
		EndIf
		If GetSkillBarSkillRecharge(6) == 0 Then
			$i = $i + 1
		EndIf
	Until $i > 2
	return 1
EndFunc   ;==>Nuke

Func MoveAway($start,$target)
	$xdiff = DllStructGetData($start,"X")-DllStructGetData($target,"X")
	$ydiff = DllStructGetData($start,"Y")-DllStructGetData($target,"Y")
	MoveTo(DllStructGetData($start,"X")+Random()*$xdiff,DllStructGetData($start,"Y")+Random()*$ydiff)
EndFunc

Func KeepUpBoon()
	If $class == "N" Then
		If GetSkillBarSkillRecharge(8) == 0 And DllStructGetData(GetEffect(772), 'SkillID') <> 772 and GetEnergy(-2)>=5 Then UseSkillEx(8, -2)
		PingSleep(250)
		If GetSkillBarSkillRecharge(2) == 0 And DllStructGetData(GetEffect(911), 'SkillID') <> 911 and GetEnergy(-2)>=15 and GetDistance(GetNearestEnemyToAgent(-2))<=1800 Then UseSkillEx(2, -2)
	Else
		If GetSkillBarSkillRecharge(8) == 0 And DllStructGetData(GetEffect(1230), 'SkillID') <> 1230 and GetEnergy(-2)>=10 Then UseSkillEx(8, -2)
		PingSleep(250)
		If GetSkillBarSkillRecharge(7) == 0 And DllStructGetData(GetEffect(1229), 'SkillID') <> 1229 and GetEnergy(-2)>=5 Then UseSkillEx(7, -2)
	EndIf
EndFunc   ;==>BuffsUpKeep

Func InventoryCheck()
	If CountSlots() < 3 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>InventoryCheck

Func CountSlots()
	Local $FreeSlots = 0, $lBag, $aBag
	If GetChecked($usebag1) Then
		$lBag = GetBag(1)
		$FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	EndIf
	If GetChecked($usebag2) Then
		$lBag = GetBag(2)
		$FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	EndIf
	If GetChecked($usebag3) Then
		$lBag = GetBag(3)
		$FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	EndIf
	If GetChecked($usebag4) Then
		$lBag = GetBag(4)
		$FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	EndIf
	Return $FreeSlots
EndFunc   ;==>CountSlots

Func IDAndSell()
	RndSleep(1000)
	Update ("Store Golds")
	MoveTo(17624,8904,100)
	Sleep(Random(150,500))
	GoNearestNPCToCoords(17624,8904)
	If GetChecked($storegolds) Then
		Update("Looking for gold items")
		If GUICtrlRead($usebag1) == $GUI_Checked Then
			GoldIs(1, 20)
		EndIf
		If GUICtrlRead($usebag2) == $GUI_Checked Then
			GoldIs(2, 5)
		EndIf
		If GUICtrlRead($usebag3) == $GUI_Checked Then
			GoldIs(3, 10)
		EndIf
		If GUICtrlRead($usebag4) == $GUI_Checked Then
			GoldIs(4, 10)
		EndIf
	EndIf
	Update("Cleaning inventory")
	RndSleep(1000)

	MoveTo(16821,9924,100)
	Sleep(Random(100,800))
	MoveTo(16568,11932,100)
	Sleep(Random(80,700))
	MoveTo(17219,12378)
	Sleep(Random(120,500))
	GoNearestNPCToCoords(17219,12378)
	If GUICtrlRead($usebag1) == $GUI_Checked Then
		Ident(1)
	EndIf
	If GUICtrlRead($usebag2) == $GUI_Checked Then
		Ident(2)
	EndIf
	If GUICtrlRead($usebag3) == $GUI_Checked Then
		Ident(3)
	EndIf
	If GUICtrlRead($usebag4) == $GUI_Checked Then
		Ident(4)
	EndIf
	SecureIDKit()
	If GUICtrlRead($usebag1) == $GUI_Checked Then
		Sell(1)
	EndIf
	If GUICtrlRead($usebag2) == $GUI_Checked Then
		Sell(2)
	EndIf
	If GUICtrlRead($usebag3) == $GUI_Checked Then
		Sell(3)
	EndIf
	If GUICtrlRead($usebag4) == $GUI_Checked Then
		Sell(4)
	EndIf
	$intGold += GetGoldCharacter() - $intCash
	$intCash = GetGoldCharacter()
	GUICtrlSetData($gold, $intGold)
EndFunc   ;==>IDAndSell

Func GoldIs($bagIndex, $numOfSlots)
	For $i = 1 To $numOfSlots
		ConsoleWrite("Checking items: " & $bagIndex & ", " & $i & @CRLF)
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, 'ID') <> 0 And GetRarity($aItem) = $RARITY_Gold Then
			Do
				For $bag = 8 To 11 ; 6 To 16 are all storage bags
					$slot = FindEmptySlot($bag)
					If $slot <> 0 Then
						$FULL = False
						$nSlot = $slot
						ExitLoop 2; finding first empty $slot in $bag and jump out
					Else
						$FULL = True; no empty slots :(
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $nSlot)
				ConsoleWrite("Gold item moved ...."& @CRLF)
				PingSleep(1000)
			EndIf
		EndIf
	Next
EndFunc   ;==>GoldIs

Func Ident($bagIndex)
	$bag = GetBag($bagIndex)
	Local $r = 0
	For $i = 1 To DllStructGetData($bag, 'slots')
		SecureIDKit()
		$aitem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aitem, 'ID') = 0 Then ContinueLoop
		$r = GetRarity($aItem)
		If $r==$RARITY_Gold and  not GetChecked($identgold) Then ContinueLoop
		If $r==$RARITY_Purple and  not GetChecked($identpurple) Then ContinueLoop
		If $r==$RARITY_Blue and  not GetChecked($identblue) Then ContinueLoop
		If Not GetIsIDed($aitem) Then IdentifyItem($aitem)
		Sleep(Random(400, 750))
	Next
EndFunc   ;==>Ident

Func SecureIDKit()
	If FindIDKit() = 0 Then
		If GetGoldCharacter() < 500 And GetGoldStorage() > 499 Then
			WithdrawGold(500)
			Sleep(Random(200, 300))
		EndIf
		Do
			BuyItem(4,1,100) ;specially for this vendor
			RndSleep(500)
		Until FindIDKit() <> 0
		RndSleep(500)
	EndIf
EndFunc

Func Sell($bagIndex)
	$bag = GetBag($bagIndex)
	$numOfSlots = DllStructGetData($bag, 'slots')
	For $i = 1 To $numOfSlots
		Update("Selling item: " & $bagIndex & ", " & $i)
		$aitem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aitem, 'ID') = 0 Then ContinueLoop
		If CanSell($aitem) Then
			SellItem($aitem)
		EndIf
		RndSleep(250)
	Next
EndFunc   ;==>Sell

Func CanSell($aitem)
	$q = DllStructGetData($aitem, 'quantity')
	$m = DllStructGetData($aitem, 'ModelID')
	$r = GetRarity($aitem)
	;If $m = 0 OR $q > 1 OR $r = $Rarity_Gold Then
	If $m = 0 Or ($q > 1 And $m <> 146) Then
		Return False
	ElseIf GUICtrlRead($sellgold) <> $GUI_Checked And $r = $RARITY_Gold Then
		Return False
	ElseIf GUICtrlRead($sellgreen) <> $GUI_Checked And $r = $RARITY_Green Then
		Return False
	ElseIf GUICtrlRead($sellpurple) <> $GUI_Checked And $r = $RARITY_Purple Then
		Return False
	ElseIf GUICtrlRead($sellblue) <> $GUI_Checked And $r = $RARITY_Blue Then
		Return False
	ElseIf $m > 21785 And $m < 21806 Then ;Elite/Normal Tomes
		Return False
	ElseIf $m = 146 Then ;Dyes
		If DllStructGetData($aitem,"ExtraId") > 9 Then
			Return False
		Else
			Return True
		EndIf
	ElseIf $m = 22751 Then ;Lockpicks
		Return False
	ElseIf $m = 2991 Or $m = 2992 Or $m = 2989 Or $m = 5899 Then ;Sup ID/Salvage
		Return False
	ElseIf $m = 923 Or $m = 931 Or $m = 6533 Then ;Jade/Eye/Claw
		Return False
	ElseIf $m = 27047 Then ;Glacial Stones
		Return False
	ElseIf $m = 8253 Then ;Feathered Crests
		Return False
	ElseIf $m = 7665 Then ;Feathers
		Return False
	ElseIf $m = 22190 Then ;ales
		Return False
	ElseIf $m = 22191 Then ;clovers
		Return False
	ElseIf $m = 22752 Then ;eggs
		Return False
	ElseIf $m = 22644 Then ;bunnies
		Return False
	ElseIf $m = 22269 Then ;birthdays
		Return False
	ElseIf $m = 28435 Then ;ciders
		Return False
	ElseIf $m = 910 Then ;ales
		Return False
	ElseIf $m = 22191 Then ;grog
		Return False
	ElseIf $m = 26784 Then ;honeycombs
		Return False
	ElseIf $m = 21810 Then ;poppers
		Return False
	ElseIf $m = 28436 Then ;pie
		Return False
	ElseIf $m = 21809 Then ;rockets
		Return False
	ElseIf $m = 21813 Then ;sparkler
		Return False
	ElseIf $m = 18345 Then ;tokens
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>CanSell

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
	$m = DllStructGetData($aitem, 'ModelID')
	$r = GetRarity($aitem)
	If $m == 921 Or $m == 28434 Or $m == 30855 Or $m = 2511 Then
		Return True
	ElseIf $r = $RARITY_Green And GetChecked($pickupgreen) Then
		Return True
	ElseIf $r = $RARITY_Gold And GetChecked($pickupgold) Then
		Return True
	ElseIf $r = $RARITY_Purple And GetChecked($pickuppurple) Then
		Return True
	ElseIf $r = $RARITY_Blue And GetChecked($pickupblue) Then
		Return True
	ElseIf $r = $RARITY_White And GetChecked($pickupwhite) Then
		Return True
	ElseIf $m = 146 Then ;Dyes
		If DllStructGetData($aitem,"ExtraId") > 9 Then
			Return True
		Else
			Return False
		EndIf
	ElseIf $m = 22751 Then ;Lockpicks
		Return True
	ElseIf $m > 21785 And $m < 21806 Then ;Elite/Normal Tomes
		Return True
	ElseIf $m = 835 Then ;Feathered Crests   8253
		$crests += 1
		GUICtrlSetData($featheredcrests, $crests)
		Return True
	ElseIf $m = 933 Then ;Feathers    7665
		$feather += DllStructGetData($aitem,"Quantity")
		GUICtrlSetData($feathers, $feather)
		Return True
	ElseIf $m = 27047 Then ;Glacial Stones
		Return True
	ElseIf $m = 22191 OR $m = 22190 Or $m = 22644 Or $m = 22752 Then ;event items
		Return True
	ElseIf $m = 22269 Then ;birthdays
		Return True
	ElseIf $m = 28435 Then ;ciders
		Return True
	ElseIf $m = 910 Then ;ales
		Return True
	ElseIf $m = 22191 Then ;grog
		Return True
	ElseIf $m = 26784 Then ;honeycombs
		Return True
	ElseIf $m = 21810 Then ;poppers
		Return True
	ElseIf $m = 28436 Then ;pie
		Return True
	ElseIf $m = 21809 Then ;rockets
		Return True
	ElseIf $m = 21813 Then ;sparkler
		Return True
	ElseIf $m = 18345 Then ;tokens
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>CanPickUp

Func GoNearestNPCToCoords($x, $y)
	Do
		RndSleep(250)
		$guy = GetNearestNPCToCoords($x, $y)
	Until DllStructGetData($guy, 'Id') <> 0
	ChangeTarget($guy)
	RndSleep(250)
	GoNPC($guy)
	RndSleep(250)
	Do
		RndSleep(500)
		MoveTo(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 40)
		RndSleep(500)
		GoNPC($guy)
		RndSleep(250)
		$Me = GetAgentByID(-2)
	Until ComputeDistance(DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'), DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y')) < 250
	RndSleep(1000)
EndFunc   ;==>GoNearestNPCToCoords

Func WaitForLoad()               ;used
	Update("Loading zone")
	InitMapLoad()
	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)

	Until $load == 2 And DllStructGetData($lMe, 'X') == 0 And DllStructGetData($lMe, 'Y') == 0 Or $deadlock > 9000

	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)

	Until $load <> 2 And DllStructGetData($lMe, 'X') <> 0 And DllStructGetData($lMe, 'Y') <> 0 Or $deadlock > 20000
	Update("Load complete")
EndFunc   ;==>WaitForLoad

;=================================================================================================
; Function:            GetNearestItemToAgent($aAgent)
; Description:        Get nearest item lying on floor around $aAgent ($aAgent = -2 ourself), necessary to work with PickUpItems func
; Parameter(s):        $aAgent: ID of Agent
; Requirement(s):    GW must be running and Memory must have been scanned for pointers (see Initialize())
; Return Value(s):    On Success - Returns ID of nearest item
;                    @extended  - distance to item
; Author(s):        GWCA team, recoded by ddarek
;=================================================================================================

Func PingSleep($msExtra = 0)
	$ping = GetPing()
	Sleep($ping + $msExtra)
EndFunc   ;==>PingSleep

Func GetNumberOfFoesInRangeOfAgent1($aAgent = -2, $fMaxDistance = 1012)
	Local $lDistance, $lCount = 0

	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	For $i = 1 To GetMaxAgents()
		$lAgentToCompare = GetAgentByID($i)
		If GetIsDead($lAgentToCompare) <> 0 Then ContinueLoop
		If DllStructGetData($lAgentToCompare, 'Allegiance') = 0x3 Or DllStructGetData($lAgentToCompare, 'Type') = 0xDB Then
			$lDistance = GetDistance($lAgentToCompare, $aAgent)
			If $lDistance < $fMaxDistance Then
				$lCount += 1
			EndIf
		EndIf
	Next

	Return $lCount
EndFunc   ;==>GetNumberOfFoesInRangeOfAgent


;=================================================================================================
; Function:			FindEmptySlot($bagIndex)
; Description:		This function also searches the storage
; Parameter(s):		Parameter = bagIndex to start searching from
;
; Requirement(s):	GW must be running and Memory must have been scanned for pointers (see Initialize())
; Return Value(s):	Returns integer with item slot. If any of the returns = 0, then no empty slots were found
; Author(s):		GWCA team, recoded by ddarek
;=================================================================================================
Func FindEmptySlot($bagIndex) ;Parameter = bag index to start searching from.	Returns integer with item slot. This function also searches the storage. If any of the returns = 0, then no empty slots were found
	Local $lItemInfo, $aSlot

	For $aSlot = 1 To DllStructGetData(GetBag($bagIndex), 'Slots')
		Sleep(40)
		ConsoleWrite("Checking: " & $bagIndex & ", " & $aSlot & @CRLF)
		$lItemInfo = GetItemBySlot($bagIndex, $aSlot)
		If DllStructGetData($lItemInfo, 'ID') = 0 Then
			ConsoleWrite($bagIndex & ", " & $aSlot & "  <-Empty! " & @CRLF)
			$lReturn = $aSlot
			ExitLoop
		Else
			$lReturn = 0
		EndIf
	Next
	Return $lReturn
 EndFunc   ;==>FindEmptySlot
 #region memory
;;=== MEMORY
Func reduceMemory()
	Local $ai_return = DllCall("psapi.dll", "int", "EmptyWorkingSet", "long", -1)
	Return $ai_return[0]
EndFunc   ;==>reduceMemory

	Local $array = ScanGW()
	If $array[0] <= 1 Then Return ''
	Local $ret = $array[1]
	For $i = 2 To $array[0]
		$ret &= "|"
		$ret &= $array[$i]
	Next
	Return $ret

Func Upd($text)
	GUICtrlSetData($lblStatus, $text)
EndFunc

#endregion
