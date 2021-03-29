#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=tengu.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Region Imports
#include "config/GWA2.au3"
#include "config/GWA2_Headers.au3"
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>
#include <ScrollBarsConstants.au3>
#EndRegion

#Region Interface and General Variables
Global $firstrun = True
Global $hero
Global $updated = 1

Global $nbFails = 0
Global $nbRuns = 0
Global $nbCitations = 0
Global $bRunning = False
Global $bInitialized = False
Global $bCanContinue = True

Global $render = True
Global $GWPID = -1
#EndRegion 

#Region Bot specific Variables
Global $Kaineng = 194
Global $Kaineng2 = 817
Global $mikuID = 58

Global $skill_bar_justice = 1
Global $skill_bar_100b = 2
Global $skill_bar_exLimite = 3
Global $skill_bar_toubillon = 4
Global $skill_bar_sod = 5
Global $skill_bar_shadowRefug = 6
Global $skill_bar_EBON = 7
Global $skill_bar_sceau = 8

;A/W ppl :OwFTQza+Z6qovgnYH8AylJXMAAA
;1 Ogden :OwUTMynCxRlcXXJb6KSApHkBAA
;2 Tahlk :OwUTMynCxRlcXXJb6KSApHkBAA
;3 Norgu :OQNEAqoz1pcCDROM9muAkBfE
;4 Zhed :OgNDwYrPP1CSS9YTrFDI0i4B
;5 Razah :OQhDAqsDKnwQkDTvpnBExFD
;6 Gwen :OQhDAqwDKngGkDTvpnBExFD
;7 Vekk :OgljgoMp5SXVfDLgKN3Y1Y0ChDA
#EndRegion

#Region Interface
Opt("GUIOnEventMode", True)

$GUI = GUICreate("Tengu Farm A/W 2.2 by Cheeshead", 310, 265)

$gSettings = GUICtrlCreateGroup("Settings", 5, 2, 190, 70)
$txtName = GUICtrlCreateCombo("", 20, 20, 160, 20)
GUICtrlSetData(-1, GetLoggedCharNames())
$gStats = GUICtrlCreateGroup("Stats", 5, 75, 190, 75)
$lblCitations = GUICtrlCreateLabel("Commendations : ", 20, 93, 160, 20)
$stCitations = GUICtrlCreateLabel($nbCitations, 100, 93, 50, 20, $SS_CENTER)
Local $gold = GUICtrlCreateCheckbox("Golds", 200, 0)
Local $green = GUICtrlCreateCheckbox("Greens", 200, 20)
Local $pcons = GUICtrlCreateCheckbox("Pcons", 200, 40)
;~ Local $Mesmers = GUICtrlCreateCheckbox("M", 260, 0)

$gShields = GUICtrlCreateGroup("Shields", 5, 180, 280, 40)
Local $diamond = GUICtrlCreateCheckbox("Diamond", 10, 193)
Local $Iridescent = GUICtrlCreateCheckbox("Iridescent", 75, 193)
Local $bladed = GUICtrlCreateCheckbox("Bladed", 145, 193)
Local $spiked = GUICtrlCreateCheckbox("Spiked", 200, 193)

$gOther = GUICtrlCreateGroup("Other", 5, 220, 280, 40)
Local $jitte = GUICtrlCreateCheckbox("Jitte", 160, 233)
Local $dragon = GUICtrlCreateCheckbox("Dragon Staff", 75, 233)
Local $bo = GUICtrlCreateCheckbox("Bo Staff", 10, 233)

$lblRuns = GUICtrlCreateLabel("Number of Runs : ", 20, 113, 160, 20)
$stRuns = GUICtrlCreateLabel("", 100, 113, 50, 20, $SS_CENTER)
GUICtrlSetData($stRuns, $nbRuns & "  (" & $nbFails & ")")
$bStart = GUICtrlCreateButton("Start", 5, 153, 190, 25, $WS_GROUP)
$StatusLabel = GUICtrlCreateEdit("", 200, 80, 110, 90, 2097220)
; Local $cbxOnTop = GUICtrlCreateCheckbox("On Top", 125, 45)
Local $cbxHideGW = GUICtrlCreateCheckbox("Render?", 125, 45)
GUISetState(@SW_SHOW)

GUICtrlSetOnEvent($bStart, "EventHandler")
GUISetOnEvent($GUI_EVENT_CLOSE, "EventHandler")
GUICtrlSetOnEvent($cbxHideGW, "EventHandler")
;GUICtrlSetOnEvent($cbxOnTop, "EventHandler")

Func EventHandler()
	Switch @GUI_CtrlId
		Case $GUI_EVENT_CLOSE
			Exit
		Case $bStart
			If $bRunning = True Then
				GUICtrlSetData($bStart, "Will pause after this run")
				GUICtrlSetState($bStart, $GUI_DISABLE)
				$bRunning = False
			ElseIf $bInitialized Then
				GUICtrlSetData($bStart, "Pause")
				$bRunning = True
			Else
				$bRunning = True
				GUICtrlSetData($bStart, "Initializing...")
				GUICtrlSetState($bStart, $GUI_DISABLE)
				GUICtrlSetState($txtName, $GUI_DISABLE)
;~ 				WinSetTitle($GUI, "", GUICtrlRead($txtName))
				If GUICtrlRead($txtName) = "" Then
					If Initialize(ProcessExists("gw.exe"), True, True, False) = False Then
						MsgBox(0, "Error", "Guild Wars it not running.")
						Exit
					EndIf
				Else
					If Initialize(GUICtrlRead($txtName), True, True, False) = False Then
						MsgBox(0, "Error", "Can't find a Guild Wars client with that character name.")
						Exit
					EndIf
				EndIf
				GUICtrlSetData($bStart, "Pause")
				GUICtrlSetState($bStart, $GUI_ENABLE)
				WinSetTitle($GUI, "", GetCharname() & " - Ministry Widow Remake")
				$bInitialized = True
				$GWPID = -1
			EndIf
		;Case $disableGraph
			;ClearMemory()
			;TOGGLERENDERING()
			;If $render = True Then
				;$render = False
			;Else
				;$render = True
			;EndIf
		;Case $cbxOnTop
			;WinSetOnTop($GUI, "", GUICtrlRead($cbxOnTop) == $GUI_CHECKED)
		;Case $cbxHideGW
			;If $mGWProcHandle <> 0 Then DisableRendering()
	EndSwitch
EndFunc   ;==>EventHandler
#EndRegion

#Region Main Loop
Do
	Sleep(100)
Until $bInitialized

While 1
	If $bRunning = True Then
		If GetMapID() <> $Kaineng And GetMapID() <> $Kaineng2 Then
			TravelTo($Kaineng)
		EndIf

		If $firstrun = True Then
			Sleep(100)
			$firstrun = False
		EndIf
		If $updated = 0 Then
			GUICtrlSetData($stRuns, $nbRuns & "  (" & $nbFails & ")")
			$updated = 1
			If $render = False Then
				EnableRendering()
				WinSetState(GetWindowHandle(), "", @SW_SHOW)
				Sleep(Random(2000, 2500))
				DisableRendering()
				WinSetState(GetWindowHandle(), "", @SW_HIDE)
				ClearMemory()
			EndIf
		EndIf

		$bCanContinue = True

		logFile("Start run")
		$updated = 0
		DoJob()
	Else
		If $updated = 0 Then
			GUICtrlSetData($stRuns, $nbRuns & "  (" & $nbFails & ")")
			$updated = 1
			If $render = False Then
				EnableRendering()
				WinSetState(GetWindowHandle(), "", @SW_SHOW)
				Sleep(Random(2000, 2500))
				DisableRendering()
				WinSetState(GetWindowHandle(), "", @SW_HIDE)
				ClearMemory()
			EndIf
			If $bRunning = False Then
				GUICtrlSetData($bStart, "Resume")
				GUICtrlSetState($bStart, $GUI_ENABLE)
				logFile("Bot stopped!")
			EndIf
		EndIf
		Sleep(100)
	EndIf
WEnd
#EndRegion

 Func IsRechargedHero($lSkill, $aHero)
	Return GetSkillbarSkillRecharge($lSkill, $aHero) == 0
 EndFunc

Func DoJob()
	If CountFreeSlots() < 5 Then
		logFile("Going to Merchant")
		Merchant()
	EndIf
	GoToQuest()
	EnterQuest()
	PrepareToFight()
	Fight()
	If $bCanContinue Then
		GoToStairs()
	Else
		logFile("Fail at Miku")
	EndIf
	If $bCanContinue Then Survive()
	If $bCanContinue Then PickUpLoot()
	If $bCanContinue Then Sleep (100)
	If $bCanContinue Then PickUpLoot()

	If $bCanContinue Then
		$nbRuns += 1
	Else
		$nbFails += 1
		$nbRuns += 1
	EndIf

EndFunc   ;==>DoJob

Func Merchant()
	GoToMerchant()
	Ident(1)
	Ident(2)
	Ident(3)
	Sell(1)
	DepositGold()
;~ 	StoreGoldies()
EndFunc   ;==>Merchant

Func GoToMerchant()
	Local $lMerchant = GetNearestAgentToCoords(1448.00, -2024.00)
	GoToNPC($lMerchant)
EndFunc   ;==>GoToMerchant

Func GoToQuest()
	Local $lMe, $coordsX, $coordsY
	If $nbRuns = 0 Then
		DisableHeroSkillSlot(4, 8)
;~ 		If GUICtrlRead($Mesmers) = $GUI_CHECKED Then
;~ 			DisableHeroSkillSlot(5, 8)
;~ 			DisableHeroSkillSlot(7, 8)
;~ 		EndIf
	EndIf

	$lMe = GetAgentByID(-2)
	$coordsX = DllStructGetData($lMe, 'X')
	$coordsY = DllStructGetData($lMe, 'Y')

	If - 1400 < $coordsX And $coordsX < -550 And - 2000 < $coordsY And $coordsY < -1100 Then
		MoveTo(1474, -1197, 0)
	EndIf
;~ 	If 2300 < $coordsX And $coordsX < 3000 And -4000 < $coordsY and $coordsY < -3500 Then
;~ 	ElseIf 2800 < $coordsX and $coordsX < 3500 And -1700 < $coordsY And $coordsY < -1100 Then
;~ 	ElseIf 2300 < $coordsX And $coordsX < 2800 And 300 < $coordsY And $coordsY < 1000 Then
EndFunc   ;==>GoToQuest

Func EnterQuest()
	Local $NPC = GetNearestNPCToCoords(2240, -1264)
	GoToNPC($NPC)
	Sleep(250)
	Dialog(0x00000084)
	Sleep(500)
	WaitMapLoading()
EndFunc   ;==>EnterQuest

Func PrepareToFight()
	Local $lDeadLock, $lDeadLock2
	Local $lMiku

	$lMiku = GetAgentByID($mikuID)

	Sleep(2000)
	Sleep(3500)
	Sleep(3500)
	Sleep(3500)

    CommandAll(-5536, -4765)

	CommandHero(1, -5399, -4965)
	CommandHero(2, -5877, -4479)
	CommandHero(3, -5669, -4640)

    MoveTo(-6550, -5382)
	$lDeadLock = TimerInit()
	Do
		Sleep(10)
	Until GetNumberOfFoesInRangeOfAgent(-2, 4250) <> 0 Or TimerDiff($lDeadLock) > 5000

	$lDeadLock2 = TimerInit()

	Do
		$lMiku = GetAgentByID($mikuID)
		HelpMiku($lMiku)
		Sleep(250)
	Until TimerDiff($lDeadLock2) > 5000

	UseSkillEx($skill_bar_100b) ; On met une ward pour les copains
    UseSkillEx($skill_bar_justice)
    Sleep (5000)
	UseSkillEx($skill_bar_exLimite)
	UseSkillEx($skill_bar_toubillon, GetNearestEnemyToAgent(-2))
	Sleep (3000)
EndFunc   ;==>PrepareToFight



Func Fight()
	Local $lMiku, $lMob
	Local $lDeadLock, $lDeadLock2

;~ 	Do
;~ 		$lMiku=GetAgentByName($miku)

;~ 		HelpMiku($lMiku)

;~ 		If GetIsDead($lMiku) Then $bCanContinue = False

;~ 	Until GetNumberOfFoesInRangeOfAgent(-2, 8000) <= 5 Or $bCanContinue = False

	CancelAll()
	CancelHero(1)
	CancelHero(2)
	CancelHero(3)

	$lDeadLock = TimerInit()
	Do
		$lMob = GetNearestEnemyToAgent(-2)
		$lMiku = GetAgentByID($mikuID)
		Attack($lMob)
		HelpMiku($lMiku)
	    UseSkillEx($skill_bar_EBON)

		Sleep(250)
		If GetisDead($lMiku) Then $bCanContinue = False
	Until GetNumberOfFoesInRangeOfAgent(-2, 2000) = 0 Or $bCanContinue = False Or TimerDiff($lDeadLock) > 150000

	If $bCanContinue Then
		MoveTo(-5961, -5082)

		$lDeadLock2 = TimerInit()

		Do
			Sleep(50)
		Until GetNumberOfFoesInRangeOfAgent(-2, 3000) <= 20 Or TimerDiff($lDeadLock2) > 60000
		Sleep(3000)
	EndIf
EndFunc   ;==>Fight


Func HelpMiku($aMiku)
	If DllStructGetData($aMiku, 'HP') < 0.4 Then
		;UseHeroSkill(4, 2, $aMiku) ; Lien spi de Zhed
		;UseHeroSkill(2, 1, $aMiku)
		;UseHeroSkill(4, 6)
	EndIf
EndFunc   ;==>HelpMiku

Func GoToStairs()

	CommandAll(-6200, -290)
	;$item = GetItemBySlot(4,5)
   	  ;UseItem($item)

	MoveTo(-4790, -3441)
	MoveTo(-4608, -2120)
	MoveTo(-4222, -1545)
	MoveTo(-4664, -672)
	MoveTo(-3825, 134)
	MoveTo(-3067, 633)
	MoveTo(-2663, 644)
	MoveTo(-2214, -334)
	MoveTo(-878, -1877)
	MoveTo(-770, -3052)
	MoveTo(-699, -3773)
	MoveTo(-1070, -4192, 0)
	CommandHero(1, -5399, -4965)
    CommandHero(2, -5399, -4965)
	CommandHero(3, -5399, -4965)



	logFile("@ stairs")
EndFunc   ;==>GoToStairs

Func Survive()
	Local $lDeadLock
	Local $lMe, $lNrj

	$lDeadLock = TimerInit()
	Do
		Sleep(250)
	Until GetNumberOfFoesInRangeOfAgent(-2, 200) <> 0 Or TimerDiff($lDeadLock) > 32000

	$lDeadLock = TimerInit()
	Do
		UseSkillEx($skill_bar_sod)
		UseSkillEx($skill_bar_shadowRefug)
		Sleep (200)
		UseSkillEx($skill_bar_exLimite, GetNearestEnemyToAgent(-2))

		$lMe = GetAgentByID(-2)
		;If IsDllStruct(GetEffect(480)) Then UseHeroSkill(1, 1)
		;If IsDllStruct(GetEffect(480)) Then UseHeroSkill(2, 1)
		;If IsDllStruct(GetEffect(480)) Then UseHeroSkill(1, 6)
		;If IsDllStruct(GetEffect(480)) Then UseHeroSkill(2, 6)
		;If IsDllStruct(GetEffect(500)) Then UseHeroSkill(3, 8)
		If IsRecharged($skill_bar_sceau) Then UseSkillEx($skill_bar_sceau)

	Until GetIsDead(-2) Or GetNumberOfFoesInRangeOfAgent(-2, 200) = 60 Or TimerDiff($lDeadLock) > 45000

	Do
		$lNrj = GetEnergy(-2)
		Sleep(250)
	Until $lNrj > 15 Or GetIsDead(-2)
	   CommandAll(-6200, -290)
	   CommandHero(1, -6707, -5242)
       CommandHero(2, -6707, -5242)
       CommandHero(3, -6707, -5242)
	   sleep (750)

	logFile("Spiking")

    UseSkillEx($skill_bar_sod)
    UseSkillEx($skill_bar_shadowRefug)
	UseSkillEx($skill_bar_EBON)
	UseSkillEx($skill_bar_justice)

	Do
		$lNrj = GetEnergy(-2)
		Sleep(250)
	Until $lNrj > 10 Or GetIsDead(-2)

	UseSkillEx($skill_bar_100b)
	UseSkillEx($skill_bar_exLimite)
	UseSkillEx($skill_bar_sod)

	Sleep(200)

	UseSkillEx($skill_bar_toubillon, GetNearestEnemyToAgent(-2))

	UseSkillEx($skill_bar_sceau)
	PickUpLoot()
	UseSkillEx($skill_bar_sod)
    UseSkillEx($skill_bar_shadowRefug)
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	UseSkillEx($skill_bar_sceau)
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
	UseSkillEx($skill_bar_sod)
	PickUpLoot()
    UseSkillEx($skill_bar_shadowRefug)
	PickUpLoot()
	PickUpLoot()
	PickUpLoot()
    UseSkillEx($skill_bar_sceau)

	If GetIsDead(-2) Then
		$bCanContinue = False
		logFile("Fail at the end")

	EndIf
 EndFunc   ;==>Survive


Func CanPickUp2($aitem)
	$ModelID = DllStructGetData(($aitem), 'ModelID')
	$ExtraID = DllStructGetData($aitem, "ExtraId")
	$lRarity = GetRarity($aitem)

   	If $ModelID == 36985 Then
		$nbCitations += 1
		GUICtrlSetData($stCitations, $nbCitations)
		Return True
	ElseIf GUICtrlRead($gold) = $GUI_CHECKED Then
		If $lRarity = 2624 Then
			Return True ; gold items
		EndIf
	ElseIf GUICtrlRead($green) = $GUI_CHECKED Then
		If $lRarity = 2627 Then
			Return True ; green items
		EndIf
	ElseIf GUICtrlRead($pcons) = $GUI_CHECKED Then
		If $ModelID = 28434 Or $ModelID = 21833 Or $ModelID = 22752 Or $ModelID = 22269 Or $ModelID = 28436 Or $ModelID = 31152 Or $ModelID = 31151 Or $ModelID = 31153 Or $ModelID = 35121 Or $ModelID = 28433 Or $ModelID = 26784 Or $ModelID = 6370 Or $ModelID = 21488 Or $ModelID = 21489 Or $ModelID = 22191 Or $ModelID = 24862 Or $ModelID = 21492 Or $ModelID = 22644 Or $ModelID = 30855 Or $ModelID = 5585 Or $ModelID = 24593 Or $ModelID = 6375 Or $ModelID = 22190 Or $ModelID = 6049 Or $ModelID = 910 Or $ModelID = 28435 Or $ModelID = 6369 Or $ModelID = 21809 Or $ModelID = 21810 Or $ModelID = 21813 Or $ModelID = 6376 Or $ModelID = 6368 Or $ModelID = 29436 Or $ModelID = 21491 Then
			Return True ; pcons
		EndIf
	ElseIf GUICtrlRead($bo) = $GUI_CHECKED Then
			If $ModelID = 735 Then
				Return True
			EndIf
    ElseIf GUICtrlRead($bladed) = $GUI_CHECKED Then
			If $ModelID = 778 Then
				Return True
			EndIf
	;ElseIf
	;		If GUICtrlRead($spiked) = $GUI_CHECKED Then
	;		If $ModelID = 871 Then
	;			Return True
	;		EndIf
	;ElseIf GUICtrlRead($spiked) = $GUI_CHECKED Then
	;		If $ModelID = 872 Then
	;			Return True
	;		EndIf
	;ElseIf GUICtrlRead($jitte) = $GUI_CHECKED Then
	;		If $ModelID = 741 Then
	;			Return True
	;		EndIf
	;ElseIf GUICtrlRead($diamond) = $GUI_CHECKED Then
	;		If $ModelID = 2294 Then
	;			Return True
	;		EndIf
	;ElseIf GUICtrlRead($Iridescent) = $GUI_CHECKED Then
	;		If $ModelID = 2298 Then
	;			Return True
	;		EndIf
	;ElseIf GUICtrlRead($Iridescent) = $GUI_CHECKED Then
	;		If $ModelID = 2299 Then
	;			Return True
	;		EndIf
    ;ElseIf GUICtrlRead($Iridescent) = $GUI_CHECKED Then
	;		If $ModelID = 2297 Then
	;			Return True
	;		EndIf
    ;   EndIf
    EndIf
EndFunc

func gohomekain()
	RNDSLP(1000)
KEYSEND("-")
RNDSLP(200)
Send("/resign",1)
RNDSLP(300)
KEYSEND("RETURN")
RNDSLP(1000)

EndFunc

Func StoreGoldies()
	Store(1, 20)
	Store(2, 5)
	Store(3, 10)
EndFunc   ;==>StoreGoldies

Func Store($bagIndex, $numOfSlots)
	For $i = 1 To $numOfSlots
		ConsoleWrite("Checking items: " & $bagIndex & ", " & $i & @CRLF)
		$aitem = GetItemBySlot($bagIndex, $i)
		$ModelID = DllStructGetData(($aitem), 'ModelID')
		$ExtraID = DllStructGetData($aitem, "ExtraId")
		$lRarity = GetRarity($aitem)
		If DllStructGetData($aitem, 'ID') <> 0 And $lRarity = 2624 Then
			Do
				For $bag = 8 To 16
					$slot = FindEmptySlot($bag)
					$slot = @extended
					If $slot <> 0 Then
						$FULL = False
						$nbag = $bag
						$nSlot = $slot
						ExitLoop 2; finding first empty $slot in $bag and jump out
					Else
						$FULL = True; no empty slots :(
						logFile("Chest is full")
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aitem, $nbag, $nSlot)
;~ 					ConsoleWrite("Gold item moved ...."& @CRLF)
				Sleep(Random(450, 550))
			EndIf
		EndIf
	Next
EndFunc   ;==>Store

Func GetNumberOfFoesInRangeOfAgent($aAgent = -2, $aRange = 1250)
	Local $lAgent, $lDistance
	Local $lCount = 0

	If Not IsDllStruct($aAgent) Then $aAgent = GetAgentByID($aAgent)

	For $i = 1 To GetMaxAgents()
		$lAgent = GetAgentByID($i)
		If BitAND(DllStructGetData($lAgent, 'typemap'), 262144) Then ContinueLoop
		If DllStructGetData($lAgent, 'Type') <> 0xDB Then ContinueLoop
		If DllStructGetData($lAgent, 'Allegiance') <> 3 Then ContinueLoop

		If DllStructGetData($lAgent, 'HP') <= 0 Then ContinueLoop
		If BitAND(DllStructGetData($lAgent, 'Effects'), 0x0010) > 0 Then ContinueLoop
		$lDistance = GetDistance($lAgent)
		$agenty = DllStructGetData($lAgent, 'Y')
		If $agenty < -4500 Then
			$lCount += 1
		EndIf
		If $lDistance > $aRange Then ContinueLoop
		$lCount += 1
	Next
	Return $lCount
EndFunc   ;==>GetNumberOfFoesInRangeOfAgentbis

Func logFile($msg)
	GUICtrlSetData($StatusLabel, GUICtrlRead($StatusLabel) & $msg & @CRLF)
	_GUICtrlEdit_Scroll($StatusLabel, $SB_SCROLLCARET)
	_GUICtrlEdit_Scroll($StatusLabel, $SB_LINEUP)
EndFunc   ;==>logFile

Func INVENTORYCHECK()
	If CountInvSlots() < 3 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>INVENTORYCHECK
Func CountInvSlots()
	Local $bag
	Local $temp = 0
	$bag = GetBag(1)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(2)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(3)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	Return $temp
EndFunc   ;==>CountInvSlots
Func SECUREIDKIT()
	If FINDIDKIT() = 0 Then
		If GETGOLDCHARACTER() < 500 And GETGOLDSTORAGE() > 499 Then
			WITHDRAWGOLD(500)
			Sleep(Random(200, 300))
		EndIf
		Do
			BUYITEM(6, 1, 500)
			RNDSLEEP(500)
		Until FINDIDKIT() <> 0
		RNDSLEEP(500)
	EndIf
EndFunc   ;==>SECUREIDKIT
Func CANSELL($aitem)
	$Q = DllStructGetData($aitem, "quantity")
	$M = DllStructGetData($aitem, "ModelID")
	$R = GETRARITY($aitem)
	If $M = 146 Then ; teintures noires et blanches
		If DllStructGetData($aitem, "ExtraId") > 9 Then
			Return False
		Else
			Return True
		EndIf
	ElseIf $M = 22751 Then ; lockpicks
		Return False
	ElseIf $M = 735 And GUICtrlRead($bo) = $GUI_CHECKED Then ;Bo staff
		Return False
    ElseIf $M = 21833 And GUICtrlRead($lunar) = $GUI_CHECKED Then ;Lunar Token
		Return False
	ElseIf $M = 736 And GUICtrlRead($dragon) = $GUI_CHECKED Then ;Dragon Staff
		Return False
	ElseIf $M = 741 And GUICtrlRead($jitte) = $GUI_CHECKED Then ;Jitte
		Return False
	ElseIf $M = 777 And GUICtrlRead($bladed) = $GUI_CHECKED Then ;Bladed Shield Non Inscribable(str)
		Return False
	ElseIf $M = 778 And GUICtrlRead($bladed) = $GUI_CHECKED Then ;Bladed Shield Non Inscribable(tactics)
		Return False
	ElseIf $M = 871 And GUICtrlRead($spiked) = $GUI_CHECKED Then ;Spiked Targe Non Inscribable(str)
		Return False
	ElseIf $M = 872 And GUICtrlRead($spiked) = $GUI_CHECKED Then ;Spiked Targe Non Inscribable(tactics)
		Return False
	ElseIf $M = 2294 And GUICtrlRead($diamond) = $GUI_CHECKED Then ;Diamond
		Return False
	ElseIf $M = 2624 And GUICtrlRead($diamond) = $GUI_CHECKED Then ;Diamond
		Return False
	ElseIf $M = 2297 And GUICtrlRead($Iridescent) = $GUI_CHECKED Then ;Iri
		Return False
	ElseIf $M = 2298 And GUICtrlRead($Iridescent) = $GUI_CHECKED Then ;Iri
		Return False
	ElseIf $M = 2299 And GUICtrlRead($Iridescent) = $GUI_CHECKED Then ;Iri
		Return False
	ElseIf $M = 5899 Then ; necessaire d'id
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>CANSELL

Func CountChestSlots()
	Local $bag
	Local $temp = 0
	For $i = 8 To 16
		$bag = GetBag($i)
		$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	Next
	Return $temp
EndFunc   ;==>CountChestSlots

Func CountFreeSlots()
	Local $temp = 0
	Local $bag
	$bag = GetBag(1)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(2)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(3)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	Return $temp
EndFunc   ;==>CountFreeSlots

Func Ident($bagIndex)
	For $i = 1 To $bagIndex
		Local $lBag = GetBag($i)
		For $ii = 1 To DllStructGetData($lBag, 'slots')
			If FindIDKit() = 0 Then
				If GetGoldCharacter() < 500 And GetGoldStorage() > 499 Then
					WithdrawGold(500)
					Sleep(Random(200, 300))
				EndIf
				Do
					BuyIDKit()
					RndSleep(500)
				Until FindIDKit() <> 0
				RndSleep(500)
			EndIf
			$aitem = GetItemBySlot($i, $ii)
			If DllStructGetData($aitem, 'ID') = 0 Then ContinueLoop
			IdentifyItem($aitem)
			RndSleep(250)
		Next
	Next
EndFunc   ;==>Ident

Func Sell($bagIndex)
	$bag = GETBAG($bagIndex)
	$numOfSlots = DllStructGetData($bag, "slots")
	For $i = 1 To $numOfSlots
		logFile("Selling item: " & $bagIndex & ", " & $i)
		$aitem = GETITEMBYSLOT($bagIndex, $i)
		If DllStructGetData($aitem, "ID") = 0 Then ContinueLoop
		If CANSELL($aitem) Then
			SELLITEM($aitem)
		EndIf
		RNDSLEEP(250)
	Next
EndFunc   ;==>Sell

Func GONEARESTNPCTOCOORDS($X, $Y)
	Do
		RNDSLEEP(250)
		$GUY = GETNEARESTNPCTOCOORDS($X, $Y)
	Until DllStructGetData($GUY, "Id") <> 0
	CHANGETARGET($GUY)
	RNDSLEEP(250)
	GONPC($GUY)
	RNDSLEEP(250)
	Do
		RNDSLEEP(500)
		MOVETO(DllStructGetData($GUY, "X"), DllStructGetData($GUY, "Y"), 40)
		RNDSLEEP(500)
		GONPC($GUY)
		RNDSLEEP(250)
		$ME = GETAGENTBYID(-2)
	Until COMPUTEDISTANCE(DllStructGetData($ME, "X"), DllStructGetData($ME, "Y"), DllStructGetData($GUY, "X"), DllStructGetData($GUY, "Y")) < 250
	RNDSLEEP(1000)
EndFunc   ;==>GONEARESTNPCTOCOORDS
