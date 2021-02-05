#include "config/GWA2.au3"
#include "config/GWA2_Headers.au3"
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Lunar Bot", 179, 268, 408, 184)
$Label1 = GUICtrlCreateLabel("Charname", 16, 16, 52, 17)
$charactername = GUICtrlCreateInput("", 16, 32, 137, 21)
$Label2 = GUICtrlCreateLabel("Rounds Played:", 16, 136, 79, 17)
$Label3 = GUICtrlCreateLabel("Won:", 16, 160, 30, 17)
$Label4 = GUICtrlCreateLabel("Draw:", 16, 184, 32, 17)
$Label5 = GUICtrlCreateLabel("Lost:", 16, 208, 27, 17)
$lbl_roundsPlayed = GUICtrlCreateLabel("0", 144, 136, 11, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$lbl_wonCounter = GUICtrlCreateLabel("0", 144, 160, 11, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$lbl_drawCounter = GUICtrlCreateLabel("0", 144, 184, 11, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x808000)
$lbl_lostCounter = GUICtrlCreateLabel("0", 144, 208, 11, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x800000)
$Label6 = GUICtrlCreateLabel("Token Counter:", 16, 72, 78, 17)
$Label7 = GUICtrlCreateLabel("Lunar Counter:", 16, 96, 74, 17)
$lbl_fortuneCounter = GUICtrlCreateLabel("0", 144, 96, 11, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x800080)
$lbl_tokenCounter = GUICtrlCreateLabel("0", 144, 72, 11, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x000000)
$btn_start = GUICtrlCreateButton("Play", 88, 232, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
Opt("GUIOnEventMode", 1)
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseHandler")
GUICtrlSetOnEvent($btn_start, "Init")

Func CloseHandler()
	Exit
EndFunc

Func Init()
    GUICtrlSetState($btn_start, $GUI_DISABLE)
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
    $boolRun = Not $boolRun
EndFunc

Global $boolRun = false
Global $lostCounter = 0
Global $drawCounter = 0
Global $winCounter = 0
Global $roundsPlayed = 0

Global $FortuneID = 29426
Global $TokenID = 21833

While 1
    if($boolRun) Then
        Main()
        $boolRun = false
        if(Not InventoryCheck()) Then
            MsgBox(0,"Ups","Inventory full")
        elseif(CountItemInBagsByModelID($TokenID)=0) Then
            MsgBox(0,"Done","No Tokens left")
        Else
            MsgBox(0,"Error","Something strange happened")
        EndIf

        GUICtrlSetState($btn_start, $GUI_ENABLE)
        GUICtrlSetState($charactername, $GUI_ENABLE)
    EndIf
    sleep(500)
wend

Func Main()
    TravelTo(810)
    MoveTo(4700,10100)
    While(InventoryCheck() and CountItemInBagsByModelID($TokenID)>0)
        Play()
    WEnd
EndFunc

Func Play()
    Local $timer = TimerInit()
    PayFee()
    SendChat("paper", "/")
    WaitForReward()
    $roundsPlayed = $roundsPlayed + 1
    while TimerDiff($timer)< 25000
        sleep(100)
    WEnd
EndFunc

Func PayFee()
    Local $aAgent = GetNearestAgentToCoords(4890,10280)
    Local $OldAmount = CountItemInBagsByModelID($TokenID)
    GoToNPC($aAgent)
    Dialog(0x84)
EndFunc

Func WaitForReward()
    Local $waitingForReward = True
    Local $qTokens = CountItemInBagsByModelID($TokenID)
    Local $qFortunes = CountItemInBagsByModelID($FortuneID)
    While($waitingForReward)
        if(CheckRewards($qTokens, $qFortunes)) Then
            UpdateGUI()
            $waitingForReward = False
            sleep(200)
        EndIf
    WEnd
EndFunc

Func CheckRewards($qTokens, $qFortunes)
    if GetIsKnocked(-2) Then
        $lostCounter = $lostCounter + 1
        return true
    EndIf

    if(CountItemInBagsByModelID($TokenID) > $qTokens) Then
        $drawCounter = $drawCounter + 1
        return true
    EndIf

    if(CountItemInBagsByModelID($FortuneID) > $qFortunes) Then
        $winCounter = $winCounter + 1
        return true
    EndIf
EndFunc

Func UpdateGUI()
    GUICtrlSetData($lbl_lostCounter, $lostCounter)
    GUICtrlSetData($lbl_drawCounter, $drawCounter)
    GUICtrlSetData($lbl_wonCounter, $winCounter)
    GUICtrlSetData($lbl_roundsPlayed, $roundsPlayed)
    GUICtrlSetData($lbl_tokenCounter, CountItemInBagsByModelID($TokenID))
    GUICtrlSetData($lbl_fortuneCounter, CountItemInBagsByModelID($FortuneID))
EndFunc

Func InventoryCheck()
    Local $slotsLeft = CountSlots()
	If $slotsLeft > 0 or ($slotsLeft = 0 and Mod(CountItemInBagsByModelID($FortuneID),250) <> 0) Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>InventoryCheck

Func CountSlots()
	Local $FreeSlots = 0, $lBag, $aBag
    $lBag = GetBag(1)
    $FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
    $lBag = GetBag(2)
    $FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
    $lBag = GetBag(3)
    $FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
    $lBag = GetBag(4)
    $FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	Return $FreeSlots
EndFunc   ;==>CountSlots