#include <ButtonConstants.au3>
#include "config/GWA2.au3"
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include "config/GWA2_Headers.au3"
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region declarations
Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)
Global $bag_slots[5] = [0, 20, 5, 10, 10]
Global $spawned = False
global  $ensuresafety = False  ; will zone  until it finds empty dis , and wont kneel if people in town
global const $warrsupply = 35121
global const $champion = 1943
Global Const $fow = 34
Global Const $grog = 30885
global const $chantry = 393
Global Const $embark = 857
global const $toa = 138
Global Const $shard = 945
Global Const $scroll = 22280
Global Const $scrollitem = GetItemByModelID($scroll)
Global Const $darkremains = 522
Global Const $ruby = 937
Global Const $saph = 938
Global Const $obbykey = 5971
Global Const $ITEM_ID_Snowman_Summoner = 6376
Global Const $ITEM_ID_Fruitcake = 21492
Global Const $ITEM_ID_Eggnog = 6375
Global Const $ITEM_ID_Mischievious_Tonic = 31020
Global Const $ITEM_ID_Frosty_Tonic = 30648
Global Const $RARITY_GOLD = 2624
Global Const $RARITY_PURPLE = 2626
Global Const $RARITY_BLUE = 2623
Global Const $RARITY_WHITE = 2621
global $town = $toa ;start town
global $shardcount = 0
Global $wins = 0
Global $fails = 0
Global $shardcount = 0
Global $RenderingEnabled = True
Global $BotRunning = False
Global $BotInitialized = False
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Global Const $skill_id_shroud = 1031
global const $skill_id_iau = 2356
global const $skill_id_wd =450
global const $skill_id_mb = 2417
Global Const $ds = 3
Global Const $sf = 2
Global Const $shroud = 1
Global Const $hos = 5
Global Const $wd = 4
Global Const $iau = 6
Global Const $de = 7
Global Const $mb = 8
; Store skills energy cost
Global $skillCost[9]
$skillCost[$ds] = 5
$skillCost[$sf] = 5
$skillCost[$shroud] = 10
$skillCost[$wd] = 4
$skillCost[$hos] = 5
$skillCost[$iau] = 5
$skillCost[$de] = 5
$skillCost[$mb] = 10
#EndRegion declarations
#Region ### START Koda GUI section ### Form=c:\users\dada\documents\fowbot.kxf
$Form1 = GUICreate("t0c farmzor", 220, 375, 1031, 651)
$Checkbox1 = GUICtrlCreateCheckbox("ensure safety", 8, 192, 97, 17)
   GUICtrlSetState(-1,$gui_checked)
   GUICtrlSetOnEvent(-1,"safety")
$Combo1 = GUICtrlCreateCombo("", 8, 8, 105, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, GetLoggedCharNames())
$Button1 = GUICtrlCreateButton("Initalize", 8, 32, 107, 17)
GUICtrlSetOnEvent(-1, "GuiButtonHandler")
$Group1 = GUICtrlCreateGroup("Runs", 16, 56, 105, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$Label1 = GUICtrlCreateLabel("wins :", 13, 67, 31, 17)
GUICtrlSetColor(-1, 0x008000)
$Label2 = GUICtrlCreateLabel("fails : ", 13, 89, 31, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Label3 = GUICtrlCreateLabel("shards : ", 13, 111, 31, 17)
GUICtrlSetColor(-1, 0x008000)
$shardlabel = GUICtrlCreateLabel("0", 48, 111, 20, 17)
GUICtrlSetColor(-1, 0xFF0000)
$winlabel = GUICtrlCreateLabel("0", 48, 67, 20, 17)
GUICtrlSetColor(-1, 0x008000)
$faillabel = GUICtrlCreateLabel("0", 48, 89, 20, 17)
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("entrance method", 16, 128, 105, 57)
$kneelm = GUICtrlCreateRadio("Kneel", 16, 144, 113, 17)
   GUICtrlSetState(-1, $gui_checked)
$scrollm = GUICtrlCreateRadio("Scroll", 16, 160, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("", 8, 232, 105, 35)
$slabel = GUICtrlCreateLabel("waiting on action     ", 54, 286, 131, 57)
GUICtrlSetFont(-1, 12, 400, 0, "MS Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Checkbox2 = GUICtrlCreateCheckbox("disable rendering", 8, 216, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "ToggleRendering")
GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
#Region funcs
Func _exit()
	Exit
EndFunc   ;==>_exit


Func GuiButtonHandler()
	If $BotRunning Then
		GUICtrlSetData($Button, "Will pause after this run")
		GUICtrlSetState($Button, $GUI_DISABLE)
		$BotRunning = False
	ElseIf $BotInitialized Then
		GUICtrlSetData($Button, "Pause")
		$BotRunning = True
	Else
		Out("Initializing")
		Local $CharName = GUICtrlRead($Combo1)
		If $CharName == "" Then
			If Initialize(ProcessExists("gw.exe")) = False Then
				MsgBox(0, "Error", "Guild Wars is not running.")
				Exit
			EndIf
		Else
			If Initialize($CharName) = False Then
				MsgBox(0, "Error", "Could not find a Guild Wars client with a character named '" & $CharName & "'")
				Exit
			EndIf
		EndIf
		GUICtrlSetState($Checkbox2, $GUI_ENABLE)
		GUICtrlSetState($Combo1, $GUI_DISABLE)
		GUICtrlSetData($Button1, "Pause")
		$BotRunning = True
		$BotInitialized = True
		 setmaxmemory()
	  EndIf
EndFunc   ;==>GuiButtonHandler

Func safety()
	if GUICtrlRead($Checkbox1) = $gui_checked Then
	   $ensuresafety = True
	   out("safe mode")
    Else
	   $ensuresafety = False
	   out("will ignore people")
    EndIf
EndFunc
Func ToggleRendering()
	$RenderingEnabled = Not $RenderingEnabled
	If $RenderingEnabled Then
		EnableRendering()
		WinSetState(GetWindowHandle(), "", @SW_SHOW)
	Else
		DisableRendering()
		WinSetState(GetWindowHandle(), "", @SW_HIDE)
		ClearMemory()
	EndIf
EndFunc   ;==>ToggleRendering
Func Out($msg)
	GUICtrlSetData($slabel, "[" & @HOUR & ":" & @MIN & "]" & $msg)
EndFunc   ;==>Out
Func UseSkillExFOW($lSkill, $lTgt = -2, $aTimeout = 3000)
	$mSkillbar = GetSkillbar()
	If GetIsDead(-2) Then Return
	If Not IsRechargedFOW($lSkill) Then Return
	If GetEnergy(-2) < $skillCost[$lSkill] Then Return
	Local $Skill = GetSkillByID(DllStructGetData($mSkillbar, 'Id' & $lSkill))
	If DllStructGetData($mSkillbar, 'AdrenalineA' & $lSkill) < DllStructGetData($lSkill, 'Adrenaline') Then Return False
	Local $lDeadlock = TimerInit()
	UseSkill($lSkill, $lTgt)
	Do
		Sleep(50)
		If GetIsDead(-2) = 1 Then Return
	Until (Not IsRechargedFOW($lSkill)) Or (TimerDiff($lDeadlock) > $aTimeout)

	If $lSkill > 1 Then RndSleep(350)
EndFunc   ;==>UseSkillEx

Func UseSF()
	If IsRechargedFOW($sf) Then
		UseSkillExFOW($sf)
	EndIf
	If isRechargedFOW($shroud) and  GetEffectTimeRemaining($skill_id_iau) > 1 Then
		 useSkillExFOW($shroud)
	EndIf
    if GetEffectTimeRemaining($skill_id_shroud) < 10 then
	   useSkillExFOW($shroud)
    EndIf
EndFunc   ;==>UseSF
Func MoveRunning($lDestX, $lDestY)
	If GetIsDead(-2) Then Return False

	Local $lMe, $lTgt
	Local $lBlocked = 0
	Local $ChatStuckTimer = TimerInit()

	Move($lDestX, $lDestY)

	Do
		RndSleep(500)

		TargetNearestEnemy()
		$lMe = GetAgentByID(-2)
		$lTgt = GetAgentByID(-1)

		If GetIsDead($lMe) Then Return False
	    if $lblocked > 1 Then
		   If TimerDiff($ChatStuckTimer) > 3000 Then
					SendChat("stuck", "/")
					$ChatStuckTimer = TimerInit()
			EndIf
		 EndIf
		UseSF()
		If $lBlocked = 5 Then
			UseSkillExFOW($hos,-1)
			Sleep(100)
			Move($lDestX, $lDestY)
			If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
				$lBlocked = 1
			Else
				$lBlocked = 0
			EndIf
		 EndIf
		 If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			Move($lDestX, $lDestY)
		EndIf

		If DllStructGetData($lMe, 'hp') < 0.2 Then
			UseSkillExFOW($hos)
		 EndIf
	    if gethascondition($lme) and  DllStructGetData($lMe, 'hp') < 0.4 Then
			UseSkillExFOW($hos)
		 EndIf
		 If GetDistance() > 1100 Then ;
			If TimerDiff($ChatStuckTimer) > 3000 Then ;
			   SendChat("stuck", "/")
			   $ChatStuckTimer = TimerInit()
			   RndSleep(GetPing())
			endIf
		 EndIf

	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < 250
	Return True
EndFunc   ;==>MoveRunning


Func WaitFor($lMs,$class = 1 ) ;class cause we dont want to hos @ rangers
	If GetIsDead(-2) Then Return
   $lMe = GetAgentByID(-2)
	Local $lTimer = TimerInit()
	if $class = 1 Then
	Do
	   if GetEffectTimeRemaining($skill_id_wd) < 1 then Return
		Sleep(100)
		If GetIsDead(-2) Then Return
		If IsRechargedFOW($iau)  Then
			UseSkillExFOW($iau)
		 EndIf

		If DllStructGetData($lMe, 'hp') < 0.3 Then
			UseSkillExFOW($hos)
		 EndIf
		 if gethascondition($lme) and DllStructGetData($lMe, 'hp') < 0.4 Then
			UseSkillExFOW($hos)
		 EndIf
		UseSF()
		if IsRechargedFOW($mb) and geteffecttimeremaining($skill_id_mb) = 0 Then
		   UseSkillExFOW($mb)
		 EndIf
	 Until TimerDiff($lTimer) > $lMs or GetIsDead(-2)
  Else
	 Do
		Sleep(100)
		If GetIsDead(-2) Then Return
		If IsRechargedFOW($iau) Then
			UseSkillExFOW($iau)
		 EndIf
		UseSF()
	 Until TimerDiff($lTimer) > $lMs
  EndIf
EndFunc   ;==>WaitFor
Func useitembyslot($abag, $aslot)
	Local $item = getitembyslot($abag, $aslot)
	Return sendpacket(8, $HEADER_ITEM_USE, DllStructGetData($item, "ID"))
EndFunc   ;==>useitembyslot
Func loop()
	If Not $RenderingEnabled Then ClearMemory()
   If getmapid() <> $fow then Return
   	out("moving to first spot")
	UseSkillExFOW($sf)
	UseSkillExFOW($ds)
	UseSkillExFOW($de)
	moveto(-21131, -2390)
	MoveRunning(-16494, -3113)
	out("starting to ball abbys")
	Sleep(1000)
	UseSkillExFOW($iau)
	If IsRechargedFOW($ds) Then
		UseSkillExFOW($ds)
	EndIf
	If IsRechargedFOW($ds) Then
		UseSkillExFOW($ds)
	 EndIf
    UseSkillExFOW($mb)
	MoveRunning(-14453, -3536)
   	UseSkillExFOW($ds)
	UseSkillExFOW($wd)
	$whirletimer = TimerInit()
	MoveRunning(-13684, -2077)
	MoveRunning(-14113, -418)
	out("whirling abbys")
	waitfor(38000 - TimerDiff($whirletimer))
	out("abbys dead")
	PickUpLootFOW()
	out("looting abbys")
	
	MoveRunning(-13684, -2077)
	out("balling rangers")
	MoveRunning(-15826, -3046)
	rndsleep(1500)
	moveto(-16002, -3031)
	out("checking skills")
	Do
	   if getisdead(-2) then Return
		WaitFor(1500)
	Until IsRechargedFOW($mb) and IsRechargedFOW($wd)
	moveto(-16004, -3202)
	MoveRunning(-15272, -3004)
	UseSkillExFOW($iau)
	UseSkillExFOW($ds)
	UseSkillExFOW($mb)
	If IsRechargedFOW($wd) Then
		UseSkillExFOW($wd)
	EndIf
	If IsRechargedFOW($mb) Then
		UseSkillExFOW($mb)
	 EndIf
    out("killing rangers")
	MoveRunning(-14453, -3536)
	moverunning(-14209, -2935)
	moverunning(-14535, -2615)
	waitfor(27000,2)
	moveto(-14506, -2633)
	out("looting rangers")
	PickUpLootFOW()
	If Not getisdead(-2) Then
		$wins = $wins + 1
		GUICtrlSetData($winlabel, $wins)
	Else
		$fails = $fails + 1
		GUICtrlSetData($faillabel, $fails)
	 EndIf
	  $spawned = False
EndFunc   ;==>loop
Func PickUpLootFOW()
	Local $lMe
	Local $lBlockedTimer
	Local $lBlockedCount = 0
	Local $lItemExists = True
	For $i = 1 To GetMaxAgents()

		$lMe = GetAgentByID(-2)
		If DllStructGetData($lMe, 'HP') <= 0.0 Then Return -1
		$lAgent = GetAgentByID($i)
		If Not GetIsMovable($lAgent) Then ContinueLoop
		If Not GetCanPickUp($lAgent) Then ContinueLoop
		$lItem = GetItemByAgentID($i)
		If canpickup($lItem) Then
			Do
			    if $lBlockedCount > 2 Then
					 UseSkillExFOW($hos)
			   EndIf
;~ 				If GetDistance($lItem) > 150 Then Move(DllStructGetData($lItem, 'X'), DllStructGetData($lItem, 'Y'), 100)
				PickUpItem($lItem)
				Sleep(GetPing())
				Do
					Sleep(100)
					$lMe = GetAgentByID(-2)
				Until DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0
				$lBlockedTimer = TimerInit()
				Do
					Sleep(3)
					$lItemExists = IsDllStruct(GetAgentByID($i))
				Until Not $lItemExists Or TimerDiff($lBlockedTimer) > Random(5000, 7500, 1)
				If $lItemExists Then $lBlockedCount += 1
			Until Not $lItemExists Or $lBlockedCount > 5
		EndIf
	Next
EndFunc   ;==>PickUpLootFOW
Func canpickup($lItem)

   $m = DllStructGetData($lItem, 'ModelID')
   $c = DllStructGetData($lItem, 'ExtraID')
   if GetRarity($lItem) = $RARITY_GOLD Then
      out(DllStructGetData($lItem, 'NameString'))
	  Return True
   Elseif  $m = $ruby Or $m = $obbykey Or $m = $saph Or $m = $darkremains Or $m = $scroll Or $m = 30855 Then
	  Return True
   ElseIf $m = 929 Then ; Dust
		Return True
   ElseIf $m = 2511 Then ; Dust
		Return True
   ElseIf $m = 6376 Then ; Snowman
		Return True
   ElseIf $m = 21492 Then  ;fruitcake
		Return True
   ElseIf $m = 6375 Then ; Eggnog
		Return True
   ElseIf $m = 30648 Then ; Frosty Tonic
		Return True
   ElseIf $m = 31020 Then ; Mischievous Tonic
		Return True
   ElseIf $m = 30855 Then ; Grog
		Return True
   ElseIf ($m = 146 And ($c = 10 Or $c = 12 Or $c = 13)) Or $m = 22751 Then ;Dyes/Lockpicks
	  Return True
   ElseIf $m = $shard Then
	  $shardcount = $shardcount + 1
	  GUICtrlSetData($shardlabel,$shardcount)
	  Return True
   Else
	  Return False
   EndIf
EndFunc   ;==>canpickup
Func enterfow()
	If GUICtrlRead($scrollm) = $gui_checked Then
		If getmapid() <> $embark Then
			travelto($embark)
		EndIf
		enterscroll()
	 Else
		enterkneel()
		WaitMapLoading($fow)
	EndIf
EndFunc   ;==>enterfow
Func enterscroll()
	Out("using scroll")
	useitembymodelid($scroll)
	WaitMapLoading($fow)
 EndFunc   ;==>enterscroll
Func enterkneel()
   if $ensuresafety  Then
	  do
		 rndtravel($town)
		 rndsleep(200)
	  until isdisempty()
	else
	  rndtravel($town)
   EndIf
   if getmapid() = $chantry Then
	  out("zoning to chantry")
	  rndsleep(400)
	  kneel(-9979,1171)

   elseif getmapid() = $toa Then
	  out("zoning to toa")
	  rndsleep(200)
	  kneel(-2522,18731)

   EndIf
EndFunc
 func moveandcheckdis($ax,$ay,$arandom = 65) ; for noids , replace this with moveto() in kneel,will change dis as soon as it detect s1
   	Local $lBlocked = 0
	Local $lMe
	Local $lMapLoading = GetMapLoading(), $lMapLoadingOld
	Local $lDestX = $aX + Random(-$aRandom, $aRandom)
	Local $lDestY = $aY + Random(-$aRandom, $aRandom)
    $notalone  = False
	Move($lDestX, $lDestY, 0)

	Do
		Sleep(100)
		$lMe = GetAgentByID(-2)

		If DllStructGetData($lMe, 'HP') <= 0 Then ExitLoop

		$lMapLoadingOld = $lMapLoading
		$lMapLoading = GetMapLoading()
		If $lMapLoading <> $lMapLoadingOld Then ExitLoop

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			$lDestX = $aX + Random(-$aRandom, $aRandom)
			$lDestY = $aY + Random(-$aRandom, $aRandom)
			Move($lDestX, $lDestY, 0)
		 EndIf
	    if not isdisempty() Then
		   enterfow()
		 EndIf
	  Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < 100 Or $lBlocked > 14

EndFunc
 func kneel($one,$two)
   $Avatar = GetNearestNPCToCoords($one,$two)	;
   local $FailPops = 0
   $spawned = False
  if not $spawned Then
	   moveto($one,$two)
  If DllStructGetData($Avatar, "PlayerNumber") <> $champion Then
    if $ensuresafety Then
	 if not isdisempty() Then
		  enterfow()
	   EndIf
	  EndIf
	   if getmapid() <> $town then Return
		Out("kneeling")
		SendChat("kneel", "/")
		Local $lDeadlock = TimerInit()
		Do
		   if getmapid() <> $town then Return
			Sleep(1500)	; .
			$Avatar = GetNearestNPCToCoords($one,$two)

			If TimerDiff($lDeadlock) > 5000 Then
				moveto($one,$two)
				SendChat("kneel", "/")
				$lDeadlock = TimerInit()
				$FailPops += 1
			 EndIf
		 Until DllStructGetData($Avatar, "PlayerNumber") == $champion  or $FailPops = 2;
	 EndIf

	  if $FailPops > 2 Then
		 	$spawned = False
		 if $town = $chantry Then
			$town = $toa
		 else
			$town = $chantry
		 EndIf
			enterfow()
		 Else
			$spawned = True
		 endif
       EndIf
  if getmapid() <> $town then Return
    if  $spawned  then
	  Out("entering fow")
	  Sleep(2500)
	  GoNearestNPCToCoords(-2429.00,18753.00)
	  Sleep(500)
	  Dialog(0x85)
	  Sleep(400)
	  DIALOG(0x86)
	  Sleep(100)
   endIf
EndFunc
func isdisempty()
   local  $peoplecount = -1
   $lAgentArray = GetAgentArray()
   For $i = 1 To $lAgentArray[0]
	  $aAgent = $lAgentArray[$i]
	  if isagenthuman($aagent) Then
		$peoplecount += 1
	  EndIf
   Next
   if $peoplecount > 0 Then

	  if $town = $chantry then
		 out("dis not empty, going toa")
	     $town = $toa
	  Else
		 out("dis not empty, going  chaantry")
		 $town = $chantry
	  EndIf
   	   Return False
	Else
	   out("dis empty")
	  return True
   EndIf

EndFunc
func isagenthuman($aagent)
    if DllStructGetData($aagent,'Allegiance') <> 1 then Return
	$thename = GetPlayerName($aAgent)
	if $thename = "" then Return
    Return True
EndFunc

 Func RndTravel($aMapID)
   	Local $UseDistricts = 11 ; 7=eu-only, 8=eu+int, 11=all(excluding America)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, us-en, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	waitmaploading($amapid)
EndFunc   ;==>RndTravel
Func useitembymodelid($amodelid)
	Local $lItem
	For $lbag = 1 To 4
		For $lslot = 1 To $bag_slots[$lbag]
			$lItem = getitembyslot($lbag, $lslot)
			If DllStructGetData($lItem, "ModelID") == $amodelid Then Return sendpacket(8, $HEADER_ITEM_USE, DllStructGetData($lItem, "ID"))
		Next
	Next
	Return False
EndFunc   ;==>useitembymodelid
#EndRegion funcs
While Not $BotRunning
	Sleep(100)
WEnd
While 1
	Sleep(50)
	clearmemory()
	enterfow()
	loop()
WEnd
Func IsRechargedFOW($lSkill)
	Return GetSkillbarSkillRecharge($lSkill) == 0
 EndFunc   ;==>IsRechargedFOW


Func GoNearestNPCToCoords($x, $y)
	Do
		RndSleep(250)
		$guy = GetNearestNPCToCoords($x, $y)
	Until DllStructGetData($guy, 'Id') <> 0
	ChangeTarget($guy)
	RndSleep(250)
	Move(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'))
	GoNPC($guy)
	RndSleep(250)
	Do
		RndSleep(750)
		Move(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'))
		GoNPC($guy)
		RndSleep(250)
		$Me = GetAgentByID(-2)
	Until ComputeDistance(DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'), DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y')) < 250
	RndSleep(1000)
EndFunc

