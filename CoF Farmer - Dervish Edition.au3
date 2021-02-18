#Region About
#cs
I was not able to find the autor's name, so please if you now the guy how wrote the bot
Please let me know, I would like to credit him for the work !
~        Autor

#################################
#                               #
#  CoF Farmer - Dervish Edition #
#                               #
#            Updated            #
#         by DeeperBlue         #
#         February 2019         #
#                               #
#################################

Changelog V1.1 (February the 06th 2019) by DeeperBlue :
    - GUI Update :
        - Switched character selector to a refreshable one.
        - Added a Dust counter.
        - Added a Rin counter.
        - Added a Diessa counter.
        - Added a Lockpicks counter.
    - Updated to use the last GWA2 v.4.2.0 .
        - Rendering function properly closes GW window (not only freezing graphics).
    - Bot loads the Dervish farming build into player's skillbar.
    - CanPickUp() function increases the new counters.
    - Properly travels to a random region in the outpost.
    - Made the "ReadMe" a bit clearer.
    - Cleaned CoF_Dervish_Bot.au3's code. Put functions in regions and intensly commented the code to make it easier to understand for everybody.
    - Deleted a bunch of unused functions.
    - Bot sets up resign at start (once) even if player already is at Doomlore.

Changelog V1.2 (March the 2nd 2019) by DeeperBlue :
    - GUI Update :
        - Added Pickup Gold checkbox
        - Added Sell Gold checkbox
        - Added Authorized bags checkboxes
        - Added GUI Activation/Deactivation when bot is started or paused.
    - Added a functions to handle buy/sell/ident.
    - Added functions to make the bot buy kits befor trying to ident.
    - Checking Sell Gold will make the bot ident and then sell the gold.
    - Moved the build loading instruction to prevent the bot from trying to load a build without being sure to be in an outpost
    - The bot takes the blessing at shrine when entering farm.
    - Updated to a newer GWA2 library version.
    - Added the GlobalItem2 library to the Api.
    
Changelog V1.4 (April the 19th 2020) by DeeperBlue :
    - Fixed with new GWA2.

TODO :

#ce
#EndRegion About

#Region Include
#include "config/CoF/GW_CoFApi.au3"
#EndRegion Include

#Region Declarations
    #Region Const
Global Const $WEAPON_SLOT_SCYTHE = 1
Global Const $WEAPON_SLOT_STAFF = 2
    #EndRegion

    #Region Variables
        #Region Internal
Global $BotRunning = False
Global $BotInitialized = False
Global $BoolInitResign = False

Global $MerchOpened = False
Global $HWND
        #EndRegion

        #Region Counter
            #Region Drops
Global $Bones = 0
Global $Dusts = 0
Global $Lockpick = 0
Global $Rin = 0
Global $Diessa = 0
            #EndRegion

            #Region Stats
Global $Runs = 0
Global $Fails = 0
Global $Seconds = 0
Global $Minutes = 0
Global $Hours = 0
Global $TotalSeconds = 0
Global $CurGold = 0
Global $CurStorage = 0
            #EndRegion
        #EndRegion
    #EndRegion
#EndRegion Declarations

#Region GUI
Func ToggleRendering()
	If GUICtrlRead($RenderingBox) == $GUI_CHECKED Then
		DisableRendering()
		WinSetState(GetWindowHandle(), "", @SW_HIDE)
		ClearMemory()
	Else
		EnableRendering()
		WinSetState(GetWindowHandle(), "", @SW_SHOW)
	EndIf
EndFunc

Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)
$Gui = GUICreate("CoF Farmer - Dervish Edition", 362,420, -1, -1)

GUICtrlCreateGroup("Select a Character", 10, 5, 150, 43)
    $CharInput = GUICtrlCreateCombo("", 20, 20, 109, 21, $CBS_DROPDOWNLIST)
        GUICtrlSetData(-1, GetLoggedCharNames())
        GUICtrlSetOnEvent(-1, "GuiStartHandler")
    $iRefresh = GUICtrlCreateButton("", 132, 19, 22.8, 22.8, $BS_ICON)
        GUICtrlSetImage($iRefresh, "shell32.dll", -239, 0)
        GUICtrlSetOnEvent(-1, "RefreshInterface")

$StartButton = GUICtrlCreateButton("Start", 10, 375, 150, 30)
GUICTRLSETFONT(-1, 11, 400, 0)
   GUICtrlSetOnEvent(-1, "GuiButtonHandler")
$RenderingBox = GUICtrlCreateCheckbox("Doesn't work", 180, 248, 110, 17)
   GUICtrlSetOnEvent(-1, "ToggleRendering")
   GUICtrlSetState($RenderingBox, $GUI_DISABLE)

$TakeBless = GUICtrlCreateCheckbox("Take Blessing", 180, 268, 110, 17)
   GUICtrlSetOnEvent(-1, "ToggleRendering")
   GUICtrlSetState($RenderingBox, $GUI_DISABLE)

$GoldIdent = GUICtrlCreateCheckbox("Don't Ident Golds", 180, 288, 110, 17)
   GUICtrlSetOnEvent(-1, "ToggleRendering")
   GUICtrlSetState($RenderingBox, $GUI_DISABLE)

GUICtrlCreateGroup("Run Stats Counters", 10, 50, 150, 80)
    GUICtrlCreateLabel("Runs:", 20, 62, 31, 15)
        $RunsCount = GUICtrlCreateLabel("0", 95, 62, 60, 15, $SS_CENTER)
    GUICtrlCreateLabel("Fails:", 20, 77, 31, 15)
        $FailsCount = GUICtrlCreateLabel("0", 95, 77, 60, 15, $SS_CENTER)
    GUICtrlCreateLabel("Average Time:", 20, 89, 65, 15)
        $AvgTimeCount = GUICtrlCreateLabel("0", 95, 89, 60, 15, $SS_CENTER)
    GUICtrlCreateLabel("Total Time:", 20, 104, 49, 15)
        $TotTimeCount = GUICtrlCreateLabel("0", 95, 104, 60, 15, $SS_CENTER)

	GUICtrlCreateGroup("Authorized Bags", 10, 132, 150, 82) ;Selling bag function (not checked = ignore bag)
	$RadioAuthBags = GUICtrlCreateRadio("",143, 145, 10, 17)
        GUICtrlSetOnEvent(-1, "RadiosHandler")
    $AuthBag1 = GUICtrlCreateCheckbox("Bag 1 (20 slots)",    20, 145, 110, 15)
	$AuthBag2 = GUICtrlCreateCheckbox("Bag 2 (5/10 slots)" , 20, 160, 130, 15)
	$AuthBag3 = GUICtrlCreateCheckbox("Bag 3 (10/15 slots)", 20, 175, 130, 15)
	$AuthBag4 = GUICtrlCreateCheckbox("Bag 4 (10/15 slots)", 20, 190, 130, 15)

	GUICtrlCreateGroup("Settings", 10, 215, 150, 145)
	$RadioAuthPS = GUICtrlCreateRadio("",143, 230, 10, 17)
        GUICtrlSetOnEvent(-1, "RadiosHandler2")	
    $PickGold = GUICtrlCreateCheckbox("Pickup golds", 20, 230, 130, 15)
    $PickPurple = GUICtrlCreateCheckbox("Pickup purples", 20, 245, 130, 15)
    $PickBlue = GUICtrlCreateCheckbox("Pickup blues", 20, 260, 130, 15)
    $PickWhite = GUICtrlCreateCheckbox("Pickup whites", 20, 275, 130, 15)	
    $SellGold = GUICtrlCreateCheckbox("Keep golds", 20, 290, 130, 15)	
	GUICtrlCreateGroup("Drops Counters", 180, 132, 150, 95)
    GUICtrlCreateLabel("Bones:", 190, 145, 76, 15)
        $BoneCount = GUICtrlCreateLabel("0", 265, 145, 40, 15, $SS_CENTER)
    GUICtrlCreateLabel("Dusts:", 190, 160, 76, 15)
        $DustCount = GUICtrlCreateLabel("0", 265, 160, 40, 15, $SS_CENTER)
    GUICtrlCreateLabel("Lockpicks:", 190, 175, 76, 15)
        $LockpickCount = GUICtrlCreateLabel("0", 265, 175, 40, 15, $SS_CENTER)
    GUICtrlCreateLabel("Rin:", 190, 190, 76, 15)
        $RinCount = GUICtrlCreateLabel("0", 265, 190, 40, 15, $SS_CENTER)
    GUICtrlCreateLabel("Diessa:", 190, 205, 76, 15)
        $DiessaCount = GUICtrlCreateLabel("0", 265, 205, 40, 15, $SS_CENTER)
	GUICtrlCreateGroup("Le Fric c'est Chic !", 180, 315, 165, 95)
Global Const $goldies =	 GUICtrlCreateLabel("Cash: " & $CurGold, 175, 355, 110, 15, $SS_CENTER)
Global Const $GoldiesSt = GUICtrlCreateLabel("$ Storage: " & $CurStorage, 175, 370, 110, 15, $SS_CENTER)


$StatusLabel = GUICtrlCreateEdit("", 165, 11, 188, 118, BitOR(0x0040, 0x0080, 0x1000, 0x00200000))
    GUICtrlSetFont($StatusLabel, 9, 400, 0, "Arial")
    GUICtrlSetColor($StatusLabel, 4047615)
    GUICtrlSetBkColor($StatusLabel, 0)

   #Region Disable GUI
        DeactivateAllGUI()
    #EndRegion Disable GUI

GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
GUISetState(@SW_SHOW)
#EndRegion GUI

#Region Loops
Out("Version 1.4 04/20")
Out("Ready to start.")
While Not $BotRunning
   Sleep(500)
WEnd

AdlibRegister("TimeUpdater", 1000)
;Setup()
While 1
    If Not $BotRunning Then
        AdlibUnRegister("TimeUpdater")
        Out("Bot is paused.")
        GUICtrlSetState($StartButton, $GUI_ENABLE)
        GUICtrlSetData($StartButton, "Start")
        GUICtrlSetOnEvent($StartButton, "GuiButtonHandler")
        While Not $BotRunning
            Sleep(500)
        WEnd
        AdlibRegister("TimeUpdater", 1000)
    EndIf
    MainLoop()
WEnd

Func MainLoop()
Local $Gron = GetNearestNPCToCoords(-19090, 17980)
    DeactivateAllGUI(0)
   $CurStorage = GetGoldStorage()
   GUICtrlSetData($GoldiesSt, "$ Storage: " & $CurStorage)	

    If ((GetMapID() == $MAP_ID_DOOMLORE) AND ($BoolInitResign)) Then		
        Zone_Fast_Way()
	
    Else
		GoToNPC($Gron)
		Dialog($THIRD_DIALOG)
		IdentItemToMerchant()
		SellItemToMerchant()
		DepositGold()
        Setup()
        Zone_Fast_Way()
	
    EndIf
    Out("Entering Cathedral")
	If GUICtrlRead($TakeBless) == $GUI_CHECKED Then GoToNPC(GetNearestNPCToCoords(-18250, -8595))
	If GUICtrlRead($TakeBless) == $GUI_CHECKED Then Out("Taking Blessing.")
    Sleep(500)
    Dialog(132)
    Sleep(500)

    AggroAndPrepare()
    Out("Killing Cryptos.")
    Kill()
    If GetIsDead(-2) Then
        $Fails += 1
        Out("Run failed: Dead.")
        GUICtrlSetData($FailsCount,$Fails)
    Else
        $Runs += 1
        Out("Run completed in " & GetTime() & ".")
        GUICtrlSetData($RunsCount,$Runs)
        GUICtrlSetData($AvgTimeCount,AvgTime())
    EndIf
    If GUICtrlRead($RenderingBox) == $GUI_CHECKED Then ClearMemory()
    Out("Returning to Doomlore.")
    Resign()
    RndSleep(5000)
    ReturnToOutpost()
    WaitMapLoading($MAP_ID_DOOMLORE)
EndFunc

 

; Func CountSlots()
	; Local $FreeSlots = 0, $lBag, $aBag
	; If GetChecked($AuthBag1) Then
		; $lBag = GetBag(1)
		; $FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	; EndIf
	; If GetChecked($AuthBag2) Then
		; $lBag = GetBag(2)
		; $FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	; EndIf
	; If GetChecked($AuthBag3) Then
		; $lBag = GetBag(3)
		; $FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	; EndIf
	; If GetChecked($AuthBag4) Then
		; $lBag = GetBag(4)
		; $FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	; EndIf
	; Return $FreeSlots
; EndFunc 
#EndRegion Loops

#Region GUI handeling Functions
	#Region GUI base function
Func GuiButtonHandler() ;Handle the bot's start/pause
   If $BotRunning Then
	  Out("Will pause after this run.")
	  GUICtrlSetData($StartButton, "force pause NOW")
	  GUICtrlSetOnEvent($StartButton, "Resign")
	  ;GUICtrlSetState($StartButton, $GUI_DISABLE)
	  $BotRunning = False
   ElseIf $BotInitialized Then
	  GUICtrlSetData($StartButton, "Pause")
	  $BotRunning = True
   Else
	  Out("Initializing...")
	  Local $CharName = GUICtrlRead($CharInput)
	  If $CharName == "" Then
		 If Initialize(ProcessExists("gw.exe"), True, True) = False Then
			   MsgBox(0, "Error", "Guild Wars is not running.")
			   Exit
		 EndIf
	  Else
		 If Initialize($CharName, True) = False Then
			   MsgBox(0, "Error", "Could not find a Guild Wars client with a character named '" & $CharName & "'")
			   Exit
		 EndIf
	  EndIf
	  $HWND = GetWindowHandle()
	  GUICtrlSetState($RenderingBox, $GUI_ENABLE)
	  GUICtrlSetState($CharInput, $GUI_DISABLE)
	  Local $charname = GetCharname()
	  GUICtrlSetData($CharInput, $charname, $charname)
	  GUICtrlSetData($StartButton, "Pause")
	  WinSetTitle($Gui, "", "Bones Farmer - " & $charname)
	  $BotRunning = True
	  $BotInitialized = True
	  SetMaxMemory()
   EndIf
EndFunc

Func GuiStartHandler() ;Handle Start/Stop toggling based on character selection (preventing user from starting bot befor choosing a character)
    If (GUICtrlRead($CharInput, "") <> "") Then
        GUICtrlSetState($StartButton, $GUI_ENABLE)
        ActivateAllGUI()
    Else
        GUICtrlSetState($StartButton, $GUI_DISABLE)
        DeactivateAllGUI()
	EndIf
EndFunc

Func RadiosHandler() ;Handle radios that check all checkboxes
    If (GUICtrlRead($RadioAuthBags) == $GUI_CHECKED) Then
		GUICtrlSetState($AuthBag1, $GUI_CHECKED)
		GUICtrlSetState($AuthBag2, $GUI_CHECKED)
		GUICtrlSetState($AuthBag3, $GUI_CHECKED)
		GUICtrlSetState($AuthBag4, $GUI_CHECKED)

		GUICtrlSetState($RadioAuthBags, $GUI_UNCHECKED)
    EndIf
EndFunc

Func RadiosHandler2() ;Handle radios that check all checkboxes
    If (GUICtrlRead($RadioAuthPS) == $GUI_CHECKED) Then
		GUICtrlSetState($PickGold, $GUI_CHECKED)
		GUICtrlSetState($PickPurple, $GUI_CHECKED)
		GUICtrlSetState($PickBlue, $GUI_CHECKED)
		GUICtrlSetState($PickWhite, $GUI_CHECKED)
		GUICtrlSetState($SellGold, $GUI_CHECKED)
		GUICtrlSetState($RadioAuthPS, $GUI_UNCHECKED)
    EndIf
EndFunc

Func ActivateAllGUI() ;Activate selectors and checkboxes (except Start/Pause button and Rendering checkbox)
	GUICtrlSetState($StartButton, $GUI_ENABLE)
	GUICtrlSetState($RenderingBox, $GUI_ENABLE)
	GUICtrlSetState($TakeBless, $GUI_ENABLE)
	;Checkboxes
    GUICtrlSetState($PickGold, $GUI_ENABLE)
    GUICtrlSetState($PickPurple, $GUI_ENABLE)
    GUICtrlSetState($PickBlue, $GUI_ENABLE)
    GUICtrlSetState($PickWhite, $GUI_ENABLE)	
    GUICtrlSetState($SellGold, $GUI_ENABLE)	
    GUICtrlSetState($AuthBag1, $GUI_ENABLE)
    GUICtrlSetState($AuthBag2, $GUI_ENABLE)
    GUICtrlSetState($AuthBag3, $GUI_ENABLE)
    GUICtrlSetState($AuthBag4, $GUI_ENABLE)
    GUICtrlSetState($RadioAuthBags, $GUI_ENABLE)
	GUICtrlSetState($RadioAuthPS, $GUI_ENABLE)
	GUICtrlSetState($GoldIdent, $GUI_ENABLE)
	
EndFunc

Func DeactivateAllGUI($Selectors = 1) ;Deactivate selectors and checkboxes (except Start/Pause button and Rendering checkbox)
;~ Pass $Selectors as 0 to make it not deactivate selectors

    If $Selectors Then
		GUICtrlSetState($StartButton, $GUI_DISABLE)
		GUICtrlSetState($RenderingBox, $GUI_DISABLE)
		GUICtrlSetState($TakeBless, $GUI_DISABLE)
	    GUICtrlSetState($PickGold, $GUI_DISABLE)
		GUICtrlSetState($PickPurple, $GUI_DISABLE)
		GUICtrlSetState($PickBlue, $GUI_DISABLE)
		GUICtrlSetState($PickWhite, $GUI_DISABLE)	
		GUICtrlSetState($SellGold, $GUI_DISABLE)
		GUICtrlSetState($GoldIdent, $GUI_DISABLE)
    EndIf


    GUICtrlSetState($AuthBag1, $GUI_DISABLE)
    GUICtrlSetState($AuthBag2, $GUI_DISABLE)
    GUICtrlSetState($AuthBag3, $GUI_DISABLE)
    GUICtrlSetState($AuthBag4, $GUI_DISABLE)
    GUICtrlSetState($RadioAuthBags, $GUI_DISABLE)
	GUICtrlSetState($RadioAuthPS, $GUI_DISABLE)
	
EndFunc

Func _exit() ;Enables Rendering and close the bot
   If GUICtrlRead($RenderingBox) == $GUI_CHECKED Then
	  DisableRendering()
	  WinSetState(GetWindowHandle(), "", @SW_HIDE)
	  Sleep(500)
   EndIf
   Exit
EndFunc

Func RefreshInterface()
    Local $CharName[1]
	Local $lWinList = ProcessList("gw.exe")

    Switch $lWinList[0][0]
		Case 0
            MsgBox(16, "PreFarmer_Bot", "Please open Guild Wars and log into a character before running this program.")
            Exit
        Case Else
            For $i = 1 To $lWinList[0][0]
                MemoryOpen($lWinList[$i][1])
                $lOpenProcess = DllCall($mKernelHandle, 'int', 'OpenProcess', 'int', 0x1F0FFF, 'int', 1, 'int', $lWinList[$i][1])
                $GWHandle = $lOpenProcess[0]
                If $GWHandle Then
                    $CharacterName = ScanForCharname()
                    If IsString($CharacterName) Then
                        ReDim $CharName[UBound($CharName) + 1]
                        $CharName[$i] = $CharacterName
                    EndIf
                EndIf
                $GWHandle = 0
            Next
            GUICtrlSetData($CharInput, _ArrayToString($CharName, "|"), $CharName[1])
    EndSwitch
EndFunc

Func Out($msg) ;Prints message in the Status console (NO TIMESTAMP)
   GUICtrlSetData($StatusLabel, GUICtrlRead($StatusLabel) & " " & $msg & @CRLF)
   _GUICtrlEdit_Scroll($StatusLabel, $SB_SCROLLCARET)
   _GUICtrlEdit_Scroll($StatusLabel, $SB_LINEUP)
EndFunc

Func Out_2($msg) ;Prints message in the Status console with timestamp
   GUICtrlSetData($StatusLabel, GUICtrlRead($StatusLabel) & "[" & @HOUR & ":" & @MIN & "]" & " " & $msg & @CRLF)
   _GUICtrlEdit_Scroll($StatusLabel, $SB_SCROLLCARET)
   _GUICtrlEdit_Scroll($StatusLabel, $SB_LINEUP)
EndFunc

    #EndRegion

    #Region GUI Enhancement
Func GetTime()
   Local $Time = GetInstanceUpTime()
   Local $Seconds = Floor($Time/1000)
   Local $Minutes = Floor($Seconds/60)
   Local $Hours = Floor($Minutes/60)
   Local $Second = $Seconds - $Minutes*60
   Local $Minute = $Minutes - $Hours*60
   If $Hours = 0 Then
	  If $Second < 10 Then $InstTime = $Minute&':0'&$Second
	  If $Second >= 10 Then $InstTime = $Minute&':'&$Second
   ElseIf $Hours <> 0 Then
	  If $Minutes < 10 Then
		 If $Second < 10 Then $InstTime = $Hours&':0'&$Minute&':0'&$Second
		 If $Second >= 10 Then $InstTime = $Hours&':0'&$Minute&':'&$Second
	  ElseIf $Minutes >= 10 Then
		 If $Second < 10 Then $InstTime = $Hours&':'&$Minute&':0'&$Second
		 If $Second >= 10 Then $InstTime = $Hours&':'&$Minute&':'&$Second
	  EndIf
   EndIf
   Return $InstTime
EndFunc

Func AvgTime()
   Local $Time = GetInstanceUpTime()
   Local $Seconds = Floor($Time/1000)
   $TotalSeconds += $Seconds
   Local $AvgSeconds = Floor($TotalSeconds/$Runs)
   Local $Minutes = Floor($AvgSeconds/60)
   Local $Hours = Floor($Minutes/60)
   Local $Second = $AvgSeconds - $Minutes*60
   Local $Minute = $Minutes - $Hours*60
   If $Hours = 0 Then
	  If $Second < 10 Then $AvgTime = $Minute&':0'&$Second
	  If $Second >= 10 Then $AvgTime = $Minute&':'&$Second
   ElseIf $Hours <> 0 Then
	  If $Minutes < 10 Then
		 If $Second < 10 Then $AvgTime = $Hours&':0'&$Minute&':0'&$Second
		 If $Second >= 10 Then $AvgTime = $Hours&':0'&$Minute&':'&$Second
	  ElseIf $Minutes >= 10 Then
		 If $Second < 10 Then $AvgTime = $Hours&':'&$Minute&':0'&$Second
		 If $Second >= 10 Then $AvgTime = $Hours&':'&$Minute&':'&$Second
	  EndIf
   EndIf
   Return $AvgTime
EndFunc

Func TimeUpdater()
	$Seconds += 1
	If $Seconds = 60 Then
		$Minutes += 1
		$Seconds = $Seconds - 60
	EndIf
	If $Minutes = 60 Then
		$Hours += 1
		$Minutes = $Minutes - 60
	EndIf
	If $Seconds < 10 Then
		$L_Sec = "0" & $Seconds
	Else
		$L_Sec = $Seconds
	EndIf
	If $Minutes < 10 Then
		$L_Min = "0" & $Minutes
	Else
		$L_Min = $Minutes
	EndIf
	If $Hours < 10 Then
		$L_Hour = "0" & $Hours
	Else
		$L_Hour = $Hours
	EndIf
	GUICtrlSetData($TotTimeCount, $L_Hour & ":" & $L_Min & ":" & $L_Sec)
EndFunc
    #EndRegion
#EndRegion

#Region Bot init Functions
Func Setup() ;Travels to Doomlore, leaves group and switch to normal mode
Local $Gron = GetNearestNPCToCoords(-19090, 17980)
   If GetMapID() <> $MAP_ID_DOOMLORE Then
	  Out("Travelling to Doomlore.")
	  RndTravel($MAP_ID_DOOMLORE)
   EndIf
   SwitchMode(0)
   RndSleep(500)
   SetUpFastWay()

   $BoolInitResign = True
EndFunc

Func SetUpFastWay() ;Setup resign and starts farm
   $CurGold = GetGoldCharacter()
   GUICtrlSetData($goldies, "Cash: " & $CurGold)
   $CurStorage = GetGoldStorage()
   GUICtrlSetData($GoldiesSt, "$ Storage: " & $CurStorage)
    LoadSkillTemplate($SkillBarTemplate)

	Local $Gron = GetNearestNPCToCoords(-19090, 17980)

	Out("Setting up resign.")
	GoToNPC($Gron)
	Dialog($FIRST_DIALOG)
	RndSleep(GetPing()+250)
	Dialog($SECOND_DIALOG)
	WaitMapLoading($MAP_ID_COF)
	Move(-19300, -8250)
	RndSleep(2500)
	WaitMapLoading($MAP_ID_DOOMLORE)
	RndSleep(500)
	Return True
EndFunc

Func Zone_Fast_Way() ;Starts farm
	Out("Zoning.")
	; InventoryCheck()	
	CheckIfInventoryIsFull()

	Local $Gron = GetNearestNPCToCoords(-19090, 17980)
	GoToNPC($Gron)
    Dialog($THIRD_DIALOG) ;Trade	
    IdentItemToMerchant()
    SellItemToMerchant()

    GoToNPC($Gron)
	Dialog($FIRST_DIALOG)
	RndSleep(GetPing()+250)
	Dialog($SECOND_DIALOG)
	WaitMapLoading($MAP_ID_COF)
    Return True
EndFunc

#EndRegion

#Region Combat Functions
Func AggroAndPrepare() ;Prepares players with enchants and aggro mobs
   MoveTo(-16850, -8930)
   UseSkillExCoF($vop)
   UseSkillExCoF($grenths)
   UseSkillExCoF($vos)
   UseSkillExCoF($mystic)
   MoveTo(-15220, -8950)
   UseSkill($iau, -2)
EndFunc

Func CheckVoS() ;Checks the Vow of Silence still active all time
	If GetEffectTimeRemaining($vos) < 10 Then
		UseSkillExCoF($pious)
		UseSkillExCoF($grenths)
		UseSkillExCoF($vos)
	EndIf
EndFunc

Func Kill() ;Kills mobs
   If GetMapLoading() == 2 Then Disconnected()
   If GetIsDead(-2) Then Return
   CheckVos()
   While GetNumberOfFoesInRangeOfAgent(-2,800) > 0
	  If GetMapLoading() == 2 Then Disconnected()
	  If GetIsDead(-2) Then Return
	  If GetSkillbarSkillAdrenaline($crippling) >= 150 Then
		CheckVoS()
		TargetNearestEnemy()
		UseSkill($crippling, -1)
		RndSleep(800)
	  EndIf
	  If GetSkillbarSkillAdrenaline($reap) >= 120 Then
		 CheckVoS()
		 TargetNearestEnemy()
		 UseSkill($reap, -1)
		 RndSleep(800)
	  EndIf
	  Sleep(100)
	  CheckVos()
	  TargetNearestEnemy()
	  Attack(-1)
   WEnd
   RndSleep(200)
   If Not CheckIfInventoryIsFull() Then PickUpLootCoF()
EndFunc

Func UseSkillExCoF($lSkill, $lTgt = -2, $aTimeout = 3000) ;Uses a skill and wait for it to be used.
    If GetIsDead(-2) Then Return
    If Not IsRecharged($lSkill) Then Return
    Local $Skill = GetSkillByID(GetSkillBarSkillID($lSkill, 0))
    Local $Energy = StringReplace(StringReplace(StringReplace(StringMid(DllStructGetData($Skill, 'Unknown4'), 6, 1), 'C', '25'), 'B', '15'), 'A', '10')
    If GetEnergy(-2) < $Energy Then Return
    Local $lAftercast = DllStructGetData($Skill, 'Aftercast')
    Local $lDeadlock = TimerInit()
    UseSkill($lSkill, $lTgt)
    Do
	    Sleep(50)
	    If GetIsDead(-2) = 1 Then Return
	    Until (Not IsRecharged($lSkill)) Or (TimerDiff($lDeadlock) > $aTimeout)
    Sleep($lAftercast * 1000)
EndFunc   ;==>UseSkillExCoF

    #Region Player & Mobs Interactions Functions
Func GetNumberOfFoesInRangeOfAgent($aAgent = -2, $aRange = 1250)
   If GetMapLoading() == 2 Then Disconnected()
   Local $lAgent, $lDistance
   Local $lCount = 0, $lAgentArray = GetAgentArray(0xDB)
   If Not IsDllStruct($aAgent) Then $aAgent = GetAgentByID($aAgent)
   For $i = 1 To $lAgentArray[0]
	  $lAgent = $lAgentArray[$i]
	  If BitAND(DllStructGetData($lAgent, 'typemap'), 262144) Then
		If StringLeft(GetAgentName($lAgent), 7) <> "Servant" Then ContinueLoop
	  EndIf
	  If DllStructGetData($lAgent, 'Allegiance') <> 3 Then ContinueLoop
	  If DllStructGetData($lAgent, 'HP') <= 0 Then ContinueLoop
	  If BitAND(DllStructGetData($lAgent, 'Effects'), 0x0010) > 0 Then ContinueLoop
	  ;If StringLeft(GetAgentName($lAgent), 7) <> "Sensali" Then ContinueLoop
	  $lDistance = GetDistance($lAgent)
	  If $lDistance > $aRange Then ContinueLoop
	  $lCount += 1
   Next
   Return $lCount
EndFunc
    #EndRegion
#EndRegion

#Region Environnement Interactions Functions
Func PickUpLootCoF()
    If GetMapLoading() == 2 Then Disconnected()
    Local $lMe, $lAgent, $lItem
    Local $lBlockedTimer
    Local $lBlockedCount = 0
    Local $lItemExists = True
	   $CurGold = GetGoldCharacter()
   GUICtrlSetData($goldies, "Cash: " & $CurGold)
    For $i = 1 To GetMaxAgents()
        If GetMapLoading() == 2 Then Disconnected()
        $lMe = GetAgentByID(-2)
        If DllStructGetData($lMe, 'HP') <= 0.0 Then Return
        $lAgent = GetAgentByID($i)
        If Not GetIsMovable($lAgent) Then ContinueLoop
        If Not GetCanPickUp($lAgent) Then ContinueLoop
        $lItem = GetItemByAgentID($i)
        If CanPickUp($lItem) Then
                Do
                    If GetMapLoading() == 2 Then Disconnected()
                    ;If $lBlockedCount > 2 Then UseSkillExCoF(6,-2)
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
EndFunc

Func CanPickUp($lItem) ;Checks if the bot can pick up the looted item
    If GetMapLoading() == 2 Then Disconnected()
    Local $Quantity
    Local $ModelID = DllStructGetData($lItem, 'ModelID')
    Local $ExtraID = DllStructGetData($lItem, 'ExtraID')
    Local $lType = DllStructGetData($lItem, 'Type')
    Local $lRarity = GetRarity($lItem)
   $CurGold = GetGoldCharacter()
   GUICtrlSetData($goldies, "Cash: " & $CurGold)

    If $ModelID == 146 And ($ExtraID == 10 Or $ExtraID == 12) Then Return True	; Black and White Dye
    If $ModelID == 921 Then	; Bones
        $Bones += DllStructGetData($lItem, 'Quantity')
        GUICtrlSetData($BoneCount,$Bones)
        Return True
    EndIf
    If $ModelID == 929 Then ; Dust
        $Dusts += DllStructGetData($lItem, 'Quantity')
        GUICtrlSetData($DustCount,$Dusts)
        Return True
    EndIf
    If $ModelID == 24353 Then ; Diessa
        $Diessa += DllStructGetData($lItem, 'Quantity')
        GUICtrlSetData($DiessaCount,$Diessa)
        Return True
    EndIf
    If $ModelID == 24354 Then ; Rin
        $Rin += DllStructGetData($lItem, 'Quantity')
        GUICtrlSetData($RinCount,$Rin)
        Return True
    EndIf
    If $ModelID == 22751 Then ; Lockpick
        $Lockpick += DllStructGetData($lItem, 'Quantity')
        GUICtrlSetData($LockpickCount,$Lockpick)
        Return True
    EndIf
    If CheckArrayPscon($ModelID) Then Return True; ==== Pcons ==== or all event items
    If $ModelID == 2511 And GetGoldCharacter() < 99000 Then Return True	;2511 = Gold Coins
    ;If $lType == 24 Then Return True ;Shields
    If (($lRarity == $RARITY_Gold) AND (GUICtrlRead($PickGold) == $GUI_CHECKED)) Then Return True
	If (($lRarity == $RARITY_Purple) AND (GUICtrlRead($PickPurple) == $GUI_CHECKED)) Then Return True
	If (($lRarity == $RARITY_Blue) AND (GUICtrlRead($PickBlue) == $GUI_CHECKED)) Then Return True
	If (($lRarity == $RARITY_White) AND (GUICtrlRead($PickWhite) == $GUI_CHECKED)) Then Return True	
	

    Return False
EndFunc

Func CheckArrayPscon($ModelID) ;Checks if loot's modelID is a pcons model (return True if it is)
	For $p = 0 To (UBound($Array_pscon) -1)
		If ($ModelID == $Array_pscon[$p]) Then Return True
	Next
EndFunc
#EndRegion

#Region Extra Functions
	#Region Map interaction Functions
Func RndTravel($aMapID) ;Travel to a random region in the outpost
	Local $UseDistricts = 11 ; 7=eu-only, 8=eu+int, 11=all(excluding America)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, us-en, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, 1, 0, 0)
	waitmaploading($aMapID)
EndFunc   ;==>RndTravel
    #EndRegion

    #Region Count/Items Functions
Func CountSlots() ;Returns the number of slots remaining in the authorized bags (if no authorized bag, returns -1)
	Local $bag
	Local $temp = 0

	If (GUICtrlRead($AuthBag1) == $GUI_CHECKED) Then
		$bag = GetBag(1)
		$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	EndIf
	If (GUICtrlRead($AuthBag2) == $GUI_CHECKED) Then
		$bag = GetBag(2)
		$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	EndIf
	If (GUICtrlRead($AuthBag3) == $GUI_CHECKED) Then
		$bag = GetBag(3)
		$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	EndIf
	If (GUICtrlRead($AuthBag4) == $GUI_CHECKED) Then
		$bag = GetBag(4)
		$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	EndIf
	If ((GUICtrlRead($AuthBag1) == $GUI_UNCHECKED) AND (GUICtrlRead($AuthBag2) == $GUI_UNCHECKED) AND (GUICtrlRead($AuthBag3) == $GUI_UNCHECKED) AND (GUICtrlRead($AuthBag4) == $GUI_UNCHECKED)) Then ;If no bags authorized, return -1 (the bot is never gonna be marked as full and won't go to merchant)
		$temp = -1
	EndIf
	Return $temp
EndFunc   ;==>CountSlots

Func CheckIfInventoryIsFull() ;Returns True if not slot remaining, Else return False
	If ((CountSlots() <= 3) AND (CountSlots() >= 0)) Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>CheckIfInventoryIsFull
    #EndRegion Count/Items Functions

    #Region Sell Functions
Func CanSell($aitem) ;Lists the unauthorized items to be sold and check if the item input can be sold
	Local $m = DllStructGetData($aitem, 'ModelID')
	Local $i = DllStructGetData($aitem, 'extraId')
    Local $lItemID = DllStructGetData($aItem, 'ID')
	Local $iRarity = GetRarity($lItemID)
	Local $lModelID = DllStructGetData($aItem, 'ModelID')
	If $iRarity == $RARITY_Gold Then
		If GUICtrlRead($SellGold) == $GUI_CHECKED Then
			Return True
	    Else
			Return False	
		EndIf
	EndIf
EndFunc    ;==>CanSell

Func Sell($bagIndex)
	Local $bag = GetBag($bagIndex)
	Local $numOfSlots = DllStructGetData($bag, 'slots')
   $CurGold = GetGoldCharacter()
   GUICtrlSetData($goldies, "Cash: " & $CurGold)
	For $i = 1 To $numOfSlots
		Local $aItem = GetItemBySlot($bagIndex, $i)
	    Local $lModelID = DllStructGetData($aItem, 'ModelID')
		If StackableReturnTrue($lModelID) Or CanSell($aitem) Then 
	    Else
		   SellItem($aItem)
		EndIf
		RndSleep(250)
	Next
EndFunc

Func StackableReturnTrue($lModelID)
    ;If $lModelID == 954						Then Return True //zangen
    ;If $lModelID == 854						Then Return True //und chitin
    If $lModelID == $ITEM_ID_LOCKPICKS 		Then Return True
    If $lModelID == $ITEM_ID_ID_KIT			Then Return True
    ; If $lModelID == $ITEM_ID_ID_KITSUP		Then Return True
    If $lModelID == $ITEM_ID_SALVAGE_KIT	Then Return True	
    If $lModelID == $ITEM_ID_MEYES			Then Return True
    If $lModelID == $ITEM_ID_RUBY			Then Return True
    If $lModelID == $ITEM_ID_AMBER			Then Return True
	; If $lModelID == $ITEM_ID_CHITIN			Then Return True
	If $lModelID == $ITEM_EXTRAID_BLACKDYE  Then Return True
	If $lModelID == $ITEM_EXTRAID_WHITEDYE  Then Return True
	If $lModelID == $ITEM_ID_IRON		    Then Return True
	If $lModelID == $ITEM_ID_DUST		    Then Return True
	If $lModelID == $ITEM_ID_BONES		    Then Return True
	If $lModelID == $ITEM_ID_FIBERS		    Then Return True
	If $lModelID == $ITEM_ID_STONES		    Then Return True
	If $lModelID == $ITEM_ID_SCALES		    Then Return True
	If $lModelID == $ITEM_ID_WOOD	    	Then Return True	
	; ==== Pcons ====
	If $lModelID == $ITEM_ID_TOTS 			Then Return True
	If $lModelID == $ITEM_ID_GOLDEN_EGGS 	Then Return True
	If $lModelID == $ITEM_ID_BUNNIES 		Then Return True
	If $lModelID == $ITEM_ID_GROG 			Then Return True
	If $lModelID == $ITEM_ID_CLOVER 		Then Return True
	If $lModelID == $ITEM_ID_PIE			Then Return True
	If $lModelID == $ITEM_ID_CIDER			Then Return True
	If $lModelID == $ITEM_ID_POPPERS		Then Return True
	If $lModelID == $ITEM_ID_ROCKETS		Then Return True
	If $lModelID == $ITEM_ID_CUPCAKES		Then Return True
	If $lModelID == $ITEM_ID_SPARKLER		Then Return True
	If $lModelID == $ITEM_ID_HONEYCOMB		Then Return True
	If $lModelID == $ITEM_ID_VICTORY_TOKEN	Then Return True
	If $lModelID == $ITEM_ID_LUNAR_TOKEN	Then Return True
	If $lModelID == $ITEM_ID_HUNTERS_ALE	Then Return True
	If $lModelID == $ITEM_ID_LUNAR_TOKENS	Then Return True
	If $lModelID == $ITEM_ID_KRYTAN_BRANDY	Then Return True
	; If $lModelID == $ITEM_ID_BLUE_DRINK		Then Return True
	; ==== Armes ====
;	If $lModelID == $CeleStr				Then Return True
;	If $lModelID == $CeleSword				Then Return True
EndFunc   ;==>Sell

Func SellItemToMerchant() ;Sell authorized items in authorized bags
	If (GUICtrlRead($AuthBag1) == $GUI_CHECKED) Then ;Check if bag1 is authorized to be sold
		Sell(1)
	EndIf
	If (GUICtrlRead($AuthBag2) == $GUI_CHECKED) Then ;Check if bag2 is authorized to be sold
		Sell(2)
	EndIf
	If (GUICtrlRead($AuthBag3) == $GUI_CHECKED) Then ;Check if bag3 is authorized to be sold
		Sell(3)
	EndIf
	If (GUICtrlRead($AuthBag4) == $GUI_CHECKED) Then ;Check if bag4 is authorized to be sold
		Sell(4)
	EndIf
EndFunc
	#EndRegion Sell Functions

    #Region Identification Function
Func CheckAndIdent($bagIndex) ;Check if the player has an IDKit, if not go buy one, then Identify unID (blue, purple, gold) items in a bag
	If (FindIDKit() == 0) Then
		If (GetGoldCharacter() >= 100) Then
            BuyIDKit()
        ElseIf (GetGoldStorage() >= 100) Then
            WithdrawGold(100)
            BuyIDKit()
        EndIf
		RndSleep(500)
	Else
		IdentifyBag_CoF($bagIndex)
	EndIf
EndFunc   ;==>IDENT

Func CanIdent($aitem) ;Lists the unauthorized items to be sold and check if the item input can be sold
    Local $lItemID = DllStructGetData($aItem, 'ID')
    Local $iRarity = GetRarity($lItemID)
	If $iRarity == $RARITY_Gold Then
		If GUICtrlRead($GoldIdent) ==$GUI_CHECKED Then
			Return False
		Else
			Return True
		EndIf
	EndIf
	Switch DllStructGetData($aItem, "iRarity")
		Case $RARITY_Purple, $RARITY_Blue, $RARITY_White
			Return False
		Case Else
			Return True
	EndSwitch
EndFunc   ;==>CanSell

Func IdentifyBag_CoF($aBag) ;Identifies all authorized items in a bag.
	Local $aItem
	If Not IsDllStruct($aBag) Then $aBag = GetBag($aBag)

	For $i = 1 To DllStructGetData($aBag, 'Slots')
		$aItem = GetItemBySlot($aBag, $i)
		If DllStructGetData($aItem, 'ID') = 0 Then ContinueLoop
		If CanIdent($aItem) Then IdentifyItem($aItem)
		Sleep(GetPing())
	Next
EndFunc   ;==>IdentifyBag

Func IdentItemToMerchant() ;Ident items in authorized bags
	If (GUICtrlRead($AuthBag1) == $GUI_CHECKED) Then ;Check if bag1 is authorized to be sold
		CheckAndIdent(1)
	EndIf
	If (GUICtrlRead($AuthBag2) == $GUI_CHECKED) Then ;Check if bag2 is authorized to be sold
		CheckAndIdent(2)
	EndIf
	If (GUICtrlRead($AuthBag3) == $GUI_CHECKED) Then ;Check if bag3 is authorized to be sold
		CheckAndIdent(3)
	EndIf
	If (GUICtrlRead($AuthBag4) == $GUI_CHECKED) Then ;Check if bag4 is authorized to be sold
		CheckAndIdent(4)
	EndIf
EndFunc
	#EndRegion Identification Function
#EndRegion

FUNC Logfile($STRING)
		$FILE = FILEOPEN("log - " & GUICTRLREAD($CharInput) & ".txt", 1)
		FILEWRITE($FILE, $STRING & @CRLF)
		FILECLOSE($FILE)
ENDFUNC