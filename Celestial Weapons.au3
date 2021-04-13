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
#include <GuiEdit.au3>

Global $RARITY_White = 2621, $RARITY_Blue = 2623, $RARITY_Purple = 2626, $RARITY_Gold = 2624, $RARITY_Green = 2627

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Change the next line to your character name:
Global $strName = ""

; Build Template: 
$skillbar = "OgcTYnL/ZiHRn5AKu8uU4A3B6AA"

Global $NQ = 216 ; Nahpui Quarter
Global $WB = 239 ; Wajing Basar

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Opt("GUIOnEventMode", 1)
Global $feather = 0
Global $crests = 0
Global $class = "R"
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

;Celestial Weapons
Global $CelestialWeapons = [ _
	942, _ ; Shild (Strength)
	943, _ ; Shild (Tactic)
	926, _ ; Cepter (Channeling, Earth)
	1068, _ ; Longbow
	790, _ ; Sword
	761, _ ; Daggers
	747, _ ; Axe
	769, _ ; Hammer
	785 _ ; Staff
]

;Rare Materials
Global $amber = 6532
Global $monstereye = 931
Global $ruby = 937

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
		
		Travel($NQ)
		LoadSkillTemplate($skillbar)
		SwitchMode(1)
		If InventoryCheck() Then
			SellAndBack()
		EndIf
		SetupResignPosition()
		
		While $boolRun
			If InventoryCheck() Then
				SellAndBack()
			EndIf
			Farm()
		WEnd

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
	if FileExists("config.ini") Then
		SetState($storegolds,IniRead("config.ini","general","storegolds","False"))
		SetState($usebag1,IniRead("config.ini","usebags","bag1","False"))
		SetState($usebag2,IniRead("config.ini","usebags","bag2","False"))
		SetState($usebag3,IniRead("config.ini","usebags","bag3","False"))
		SetState($usebag4,IniRead("config.ini","usebags","bag4","False"))
		SetState($pickupgreen,IniRead("config.ini","pickup","green","False"))
		SetState($pickupgold,IniRead("config.ini","pickup","gold","False"))
		SetState($pickuppurple,IniRead("config.ini","pickup","purple","False"))
		SetState($pickupblue,IniRead("config.ini","pickup","blue","False"))
		SetState($pickupwhite,IniRead("config.ini","pickup","white","False"))
		SetState($identgold,IniRead("config.ini","identify","gold","False"))
		SetState($identpurple,IniRead("config.ini","identify","purple","False"))
		SetState($identblue,IniRead("config.ini","identify","blue","False"))
		SetState($sellgreen,IniRead("config.ini","sell","green","False"))
		SetState($sellgold,IniRead("config.ini","sell","gold","False"))
		SetState($sellpurple,IniRead("config.ini","sell","purple","False"))
		SetState($sellblue,IniRead("config.ini","sell","blue","False"))
	EndIf
EndFunc

Func UpdateConfig()

	Local $udata = "bag1="&GetChecked($usebag1)&@LF&"bag2="&GetChecked($usebag2)&@LF&"bag3="&GetChecked($usebag3)&@LF&"bag4="&GetChecked($usebag4)
	IniWriteSection("config.ini", "usebags", $udata)

	Local $pdata = "green="&GetChecked($pickupgreen)&@LF&"gold="&GetChecked($pickupgold)&@LF&"purple="&GetChecked($pickuppurple)&@LF&"blue="&GetChecked($pickupblue)&@LF&"white="&GetChecked($pickupwhite)
	IniWriteSection("config.ini", "pickup", $pdata)

	Local $idata = "gold="&GetChecked($identgold)&@LF&"purple="&GetChecked($identpurple)&@LF&"blue="&GetChecked($identblue)
	IniWriteSection("config.ini", "identify", $idata)

	Local $sdata = "green="&GetChecked($sellgreen)&@LF&"gold="&GetChecked($sellgold)&@LF&"purple="&GetChecked($sellpurple)&@LF&"blue="&GetChecked($sellblue)
	IniWriteSection("config.ini", "sell", $sdata)
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
	RndSleep(1000)
	IDAndSell()
	If GetGoldCharacter() > 80000 Then
		Update("Depositing gold")
		DepositGold(70000)
		$intCash = GetGoldCharacter()
	EndIf
EndFunc   ;==>SellAndBack

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

Func Farm()
	While GetMapID() = $NQ
		MoveTo(-21648,13750)
	WEnd
	While not GetMapIsLoaded()
		Sleep(100)
	Wend
	Update("Running to Farmspot")
	MoveTo(7860,-17800)
	MoveTo(4000,-17000)
	MoveTo(2700,-16500)
	Update("Casting Run Skills")
	UseSkillEx(1)
	UseSkillEx(2)
	UseSkillEx(3)
	UseSkillEx(4)
	Update("Running to FarmRoute Waypoint 1")
	MoveAndUseSF(-700,-16000)
	MoveAndUseSF(-900,-15400)
	MoveAndUseSF(-700,-14400)
	if GetIsdead(-2) then
		HardLeave()
		return false
	endif

	Update("Running to FarmRoute Waypoint 2")
	MoveAndUseSF(800,-14500)
	if GetIsdead(-2) then
		HardLeave()
		return false
	endif

	Update("Preballing")
	Local $preballingTimer = 1500
	While $preballingTimer>0
		StayAlive()
		$preballingTimer = $preballingTimer - 100
	Wend

	Update("Running to FarmRoute Waypoint 3")
	MoveAndUseSF(1067,-14978)
	if GetIsdead(-2) then
		HardLeave()
		return false
	endif

	Update("Balling Monks")
	UseSkillEx(5)
	
	Local $ballingtime = 2000
	While IsRecharged(6)
		UseSkill(6,-2)
		Sleep(100)
		$ballingtime = $ballingtime - 100
	Wend
	Sleep($ballingtime)

	Update("Balling Necros")
	MoveTo(400,-14200)
	MoveTo(-400,-14200)
	$enemy = DllStructGetData(GetNearestAgentToCoords(-220,-14400), 'ID')
	MoveTo(-850,-14500)
	if GetIsdead(-2) then
		HardLeave()
		return false
	endif
	
	Update("Waiting for SF")
	While Not IsRecharged(2)
		Sleep(50)
	WEnd
	UseSkillEx(2)

	Update("Setting up EOE")
	UseSkillEx(8)
	Update("Kill! >:O")
	UseSkillEx(7, $enemy)
	MoveTo(-220,-14400)
	
	$Timeout = 0
	While not GetIsDead($enemy)
		Sleep(100)
		$Timeout = $Timeout + 100
		if $Timeout>8000 then ExitLoop
	WEnd
	Sleep(100)
	
	Update("Loot :D")
	PickUpLootCW()
	Update("Repeat")
	Hardleave()
	
EndFunc   ;==>Farm

Func MoveAndUseSF($lDestX,$lDestY)
	While ComputeDistance(DllStructGetData(GetAgentByID(), 'X'), DllStructGetData(GetAgentByID(), 'Y'), $lDestX, $lDestY)>100
		if not StayAlive() then
			return false
		endif
		if Not GetIsMoving(-2) then
			Move($lDestX,$lDestY)
		Endif
	WEnd
	return true
EndFunc

Func StayAlive($timer=100)
	If IsRecharged(2) And DllStructGetData(GetEffect(826), 'SkillID') <> 826 And GetEnergy(-2)>=20 then
		UseSkillEx(1)
		UseSkillEx(2)
	EndIf
	Sleep($timer)
	return not GetIsDead(-2)
EndFunc

Func SetupResignPosition()
	While GetMapID() = $NQ
		MoveTo(-21648,13750)
	WEnd
	While not GetMapIsLoaded()
		Sleep(100)
	Wend
	While GetMapID() = $WB
		MoveTo(9050,-20000)
	WEnd
	While not GetMapIsLoaded()
		Sleep(100)
	Wend
EndFunc

Func Dist($x1,$y1,$x2,$y2)
	$x1 = ($x1-$x2)*($x1-$x2)
	$y1 = ($y1-$y2)*($y1-$y2)
	Return Sqrt($x1+$y2)
EndFunc

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
	
	;Open Xunlai
	MoveTo(-20637,7701,100)
	GoNearestNPCToCoords(-20637,7701)
	
	;GoToMerch
	MoveTo(-18693,10132,100)
	GoNearestNPCToCoords(-18693,10132)
	
	;Buy ID KIT if not available
	SecureIDKit()

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
		If GetGoldCharacter() < 500 Then
			WithdrawGold(500)
			Sleep(Random(200, 300))
		EndIf
		Do
			BuySuperiorIDKit()
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

	For $i = 0 To Ubound($CelestialWeapons) -1
		If $m = $CelestialWeapons[$i] Then
			Return False
		Endif
	Next

	If $m = 854 Then ;Zangen
		Return True
	EndIf
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
	ElseIf $m = $amber Or $m = $ruby Or $m = $monstereye Then
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
	ElseIf $m = 954 Then ;chitin
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>CanSell

Func PickUpLootCW()
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
	ElseIf $r = $RARITY_White And GetChecked($pickupwhite) Then
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
#endregion
