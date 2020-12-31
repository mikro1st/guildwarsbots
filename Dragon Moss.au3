
;TODO
;	-Salvage for iron
; 	- store stuff




#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>
#include "config/GWA2.au3"
#include "config/GWA2_Headers.au3"
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <ComboConstants.au3>
#include <ScrollBarsConstants.au3>
#include <Misc.au3>
#include <EditConstants.au3>
#include <GuiEdit.au3>
#Region ### START Koda GUI section ### Form=C:\Users\ADMIN\Desktop\Textdukumente\Form4.kxf
$Form1 = GUICreate("Dragon Moss New By やェねちもオ©", 362, 186, 303, 293)
$START = GUICtrlCreateButton("Start", 16, 16, 115, 89)
;$charname = GUICtrlCreateInput("YOUR CHAR NAME HERE!!", 16, 112, 121, 21)
$Combo1 = GUICtrlCreateCombo("", 16, 112, 121, 21, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, GetLoggedCharNames())
$Edit1 = GUICtrlCreateEdit("", 136, 16, 193, 89)
$render = GUICtrlCreateCheckbox("Render", 152, 112, 97, 17)
GUICtrlSetOnEvent(-1, "ToggleRendering")
$sellAtGHbox = GUICtrlCreateCheckbox("Sell at GH", 280, 112, 97, 17)
GUICtrlSetOnEvent(-1, "ChangeSellAtGH")
$Timer = GUICtrlCreateLabel("00:00:00", 280, 144, 79, 17)
GUICtrlSetColor($Timer, 0x0078D7)
$Label1 = GUICtrlCreateLabel("Wins :", 16, 144, 34, 17)
$Winupdater = GUICtrlCreateLabel("0", 56, 144, 82, 17)
GUICtrlSetColor(-1, 0x00FF00)
$Label3 = GUICtrlCreateLabel("Lose: ", 152, 144, 33, 17)
$LoseCount = GUICtrlCreateLabel("0", 184, 144, 82, 17)
GUICtrlSetColor(-1, 0xFF0000)
$ln0futur3 = GUICtrlCreateLabel("updated by n0futur3", 259, 169)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###















Opt("GUIOnEventMode", 1)
;==> Rarity
Global Const $RARITY_White = 2621
Global Const $RARITY_Blue = 2623
Global Const $RARITY_Purple = 2626
Global Const $RARITY_Gold = 2624
Global Const $RARITY_Green = 2627
Global Const $RARITY_Red = 33026

;==> "Normal" Itmes
Global Const $ID_Goldcoins = 2511
Global Const $ID_Lockpicks = 22751
Global Const $ID_SalvageKit = 2992
Global Const $ID_IdentKit = 2989
Global $TotalSeconds = 0
;==> Trophys
Global Const $ID_DragonRoots = 819
Global Const $GlacialStones = 27047

;==> Rare Materials
Global Const $ID_SpiritWoodPlanks = 956

;==> Materials
Global Const $ID_PlantFibers = 934

;==> Dyes
Global Const $ID_Dyes = 146
Global Const $ExtraID_Green = 3
Global Const $ExtraID_Purple = 4
Global Const $ExtraID_Red = 5
Global Const $ExtraID_Yellow = 6
Global Const $ExtraID_Brown = 7
Global Const $ExtraID_Orange = 8
Global Const $ExtraID_Silver = 9
Global Const $ExtraID_Blue = 2
Global Const $ExtraID_Black = 10
Global Const $ExtraID_Grey = 11
Global Const $ExtraID_White = 12
Global Const $ExtraID_Pink = 13

;==> Weapons
Global Const $ID_BrambleLongbow = 968
Global Const $ID_BrambleFlatbow = 904
Global Const $ID_BrambleHornbow = 906
Global Const $ID_BrambleRecurvebow = 934
Global Const $ID_BrambleShortbow = 957
Global Const $ID_WickedBlade = 792
Global Const $ID_GothicSword = 793
Global Const $ID_GothicAxe = 748
Global Const $ID_KrisDaggers = 764
Global Const $ID_RuneAxe = 753
Global Const $ID_GothicDefender = 950
Global Const $ID_GothicDoubleAxe = 749
Global Const $ID_OrnateShield = 955


;==> Weapon Types
Global Const $Type_Shields = 24
Global Const $Type_Swords = 27
Global Const $Type_Axes = 2

;==> Sweets
Global Const $ID_Cupcake = 22269
Global Const $ID_DeliciousCake = 36681
Global Const $ID_SugarBlueDrink = 21812
Global Const $ID_GoldenEgg = 22752
Global Const $ID_ChocolateBunny = 22644
Global Const $ID_PumpkinPie = 28436
Global Const $ID_Fruitcake = 21492
Global $Seconds = 0
;==> Alcohol
Global Const $ID_KrytanBrandy = 35124
Global Const $ID_BattleIsleIcedTea = 36682
Global Const $ID_HuntersAle = 910
Global Const $ID_Eggnong = 6375
Global Const $ID_SharmrockAle = 22190
Global Const $ID_HardAppleCider = 28435
Global Const $ID_Grog = 30855

;==> Party
Global Const $ID_PartyBeacon = 36683
Global Const $ID_MischievousTonic = 31020
Global Const $ID_FrostyTonic = 30648
Global Const $ID_BottleRocket = 21809
Global Const $ID_SnowmandSummoner = 6376
Global Const $ID_ChampagnePoper = 21810
Global Const $ID_Sparkler = 21813

;==> All Other Event Items
Global Const $ID_LunarToken = 21833
Global Const $ID_VictoryToken = 18345
Global Const $ID_FourLeafClover = 22191
Global Const $ID_Honeycomb = 26784
Global Const $ID_TrickOrTreatBag = 28434
Global Const $ID_WayfarersMark = 37765
Global Const $ID_CandyCaneShards = 556

;==> Normal Tomes
Global Const $ID_RitualistTome = 21804
Global Const $ID_MesmerTome = 21797
Global Const $ID_MonkTome = 21800
Global Const $ID_RangerTome = 21802
Global Const $ID_WarriorTome = 21801
Global Const $ID_ParagonTome = 21805
Global Const $ID_DervishTome = 21803
Global Const $ID_ElementalistTome = 21799
Global Const $ID_NecromancerTome = 21798
Global Const $ID_AssasinTome = 21796

;==> Elite Tomes
Global Const $ID_EliteMonkTome = 21790
Global Const $ID_EliteRangerTome = 21792
Global Const $ID_EliteDervishTome = 21793
Global Const $ID_EliteAssasinTome = 21786
Global Const $ID_EliteNecromancerTome = 21788
Global Const $ID_EliteParagonTome = 21795
Global Const $ID_EliteMesmerTome = 21787
Global Const $ID_EliteWarriorTome = 21791
Global Const $ID_EliteElementalistTome = 21789
Global Const $ID_EliteRitualistTome = 21794
Global $boolRun = False
Global $SR = 14
Global $intStarted = -1
Global $Seconds = 0
Global $Minutes = 0
Global $Hours = 0
Global $Chests = 0
Global $Runs = 0
Global $NoChest = 0
Global $Retained = 0
Global $Broken = 0
Global $Golds = 0
Global $Outcast = 0
Global $PickedUpGold = 0
Global $PickedUpPurple = 0
Global $Map_Sea = 289
Global $Map_RheasCrater = 202
Global $Map_DragonsThroat = 274
Global $distance = GetDistance(GetNearestEnemyToAgent(-2))
Global $Skill_BloodIsPower = 1
Global $Skill_AwakenTheBlood = 2
Global $Skill_EbonEscape = 3
Global $Skill_ShroudofDistress = 4
Global $Skill_IamUnstoppable = 5
Global $Skill_FeelNoPain = 6
Global $Skill_HeartOfShadow = 7
Global $skill8 = 8
Global $Firstrun = True
Global $NewSetup = False
Global $Loserun = 0
Global $Winrun = 0
Global $bSellAtGH = False

;~ General Items
Global $General_Items_Array[6] = [2989, 2991, 2992, 5899, 5900, 22751]
Global Const $ITEM_ID_Lockpicks = 22751

;~ Dyes
Global Const $ITEM_ID_Dyes = 146
Global Const $ITEM_ExtraID_BlackDye = 10
Global Const $ITEM_ExtraID_WhiteDye = 12
Global $Weapon_Mod_Array[25] = [893, 894, 895, 896, 897, 905, 906, 907, 908, 909, 6323, 6331, 15540, 15541, 15542, 15543, 15544, 15551, 15552, 15553, 15554, 15555, 17059, 19122, 19123]


;~ Alcohol
Global $Alcohol_Array[19] = [910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 19172, 19173, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682]
Global $OnePoint_Alcohol_Array[11] = [910, 5585, 6049, 6367, 6375, 15477, 19171, 19172, 19173, 22190, 28435]
Global $ThreePoint_Alcohol_Array[7] = [2513, 6366, 24593, 30855, 31145, 31146, 35124]
Global $FiftyPoint_Alcohol_Array[1] = [36682]

;~ Party
Global $Spam_Party_Array[5] = [6376, 21809, 21810, 21813, 36683]

;~ Sweets
Global $Spam_Sweet_Array[6] = [21492, 21812, 22269, 22644, 22752, 28436]

;~ Tonics
Global $Tonic_Party_Array[4] = [15837, 21490, 30648, 31020]

;~ DR Removal
Global $DPRemoval_Sweets[6] = [6370, 21488, 21489, 22191, 26784, 28433]

;~ Special Drops
Global $Special_Drops[7] = [5656, 18345, 21491, 37765, 21833, 28433, 28434]

;~ Stupid Drops that I am not using, but in here in case you want these to add these to the CanPickUp and collect in your chest
Global $Map_Piece_Array[4] = [24629, 24630, 24631, 24632]

;~ Stackable Trophies
Global $Stackable_Trophies_Array[1] = [27047]
Global Const $ITEM_ID_Glacial_Stones = 27047

;~ Materials
Global $All_Materials_Array[36] = [921, 922, 923, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 948, 949, 950, 951, 952, 953, 954, 955, 956, 6532, 6533]
Global $Common_Materials_Array[11] = [921, 925, 929, 933, 934, 940, 946, 948, 953, 954, 955]
Global $Rare_Materials_Array[25] = [922, 923, 926, 927, 928, 930, 931, 932, 935, 936, 937, 938, 939, 941, 942, 943, 944, 945, 949, 950, 951, 952, 956, 6532, 6533]

;~ Tomes
Global $All_Tomes_Array[20] = [21796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 21805, 21786, 21787, 21788, 21789, 21790, 21791, 21792, 21793, 21794, 21795]
Global Const $ITEM_ID_Mesmer_Tome = 21797

;~ Arrays for the title spamming (Not inside this version of the bot, but at least the arrays are made for you)
Global $ModelsAlcohol[100] = [910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682]
Global $ModelSweetOutpost[100] = [15528, 15479, 19170, 21492, 21812, 22644, 31150, 35125, 36681]
Global $ModelsSweetPve[100] = [22269, 22644, 28431, 28432, 28436]
Global $ModelsParty[100] = [6368, 6369, 6376, 21809, 21810, 21813]
Global $boolRun = false
Global $Array_pscon[39]=[910, 5585, 6366, 6375, 22190, 24593, 28435, 30855, 31145, 35124, 36682, 6376, 21809, 21810, 21813, 36683, 21492, 21812, 22269, 22644, 22752, 28436,15837, 21490, 30648, 31020, 6370, 21488, 21489, 22191, 26784, 28433, 5656, 18345, 21491, 37765, 21833, 28433, 28434]

#Region Global MatsPic´s And ModelID´Select
Global $PIC_MATS[26][2] = [["Fur Square", 941],["Bolt of Linen", 926],["Bolt of Damask", 927],["Bolt of Silk", 928],["Glob of Ectoplasm", 930],["Steel of Ignot", 949],["Deldrimor Steel Ingot", 950],["Monstrous Claws", 923],["Monstrous Eye", 931],["Monstrous Fangs", 932],["Rubies", 937],["Sapphires", 938],["Diamonds", 935],["Onyx Gemstones", 936],["Lumps of Charcoal", 922],["Obsidian Shard", 945],["Tempered Glass Vial", 939],["Leather Squares", 942],["Elonian Leather Square", 943],["Vial of Ink", 944],["Rolls of Parchment", 951],["Rolls of Vellum", 952],["Spiritwood Planks", 956],["Amber Chunk", 6532],["Jadeite Shard", 6533]]
#EndRegion Global MatsPic´s And ModelID´Select

Global $Array_Store_ModelIDs460[147] = [474, 476, 486, 522, 525, 811, 819, 822, 835, 610, 2994, 19185, 22751, 4629, 24630, 4631, 24632, 27033, 27035, 27044, 27046, 27047, 7052, 5123 _
		, 1796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 1805, 910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682 _
		, 6376 , 6368 , 6369 , 21809 , 21810, 21813, 29436, 29543, 36683, 4730, 15837, 21490, 22192, 30626, 30630, 30638, 30642, 30646, 30648, 31020, 31141, 31142, 31144, 1172, 15528 _
		, 15479, 19170, 21492, 21812, 22269, 22644, 22752, 28431, 28432, 28436, 1150, 35125, 36681, 3256, 3746, 5594, 5595, 5611, 5853, 5975, 5976, 21233, 22279, 22280, 6370, 21488 _
		, 21489, 22191, 35127, 26784, 28433, 18345, 21491, 28434, 35121, 921, 922, 923, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943 _
		, 944, 945, 946, 948, 949, 950, 951, 952, 953, 954, 955, 956, 6532, 6533]


GUICtrlSetOnEvent($START, "EventHandler")
GUISetOnEvent($GUI_EVENT_CLOSE, "EventHandler")
Initialize(WinGetProcess("Guild Wars"))
While 1

While 1
   If Not $boolRun Then
	  AdlibUnRegister("TimeUpdater")
	  Out("Bot is Paused.")
	  GUICtrlSetOnEvent($START, "EventHandler")
	  While Not $boolRun
		 Sleep(500)
	  WEnd
	  AdlibRegister("TimeUpdater", 1000)
   EndIf
   Main()
WEnd
WEnd


Func EventHandler()
	Switch (@GUI_CtrlId)
		Case $START
			$boolRun = Not $boolRun
			If $boolRun Then
				GUICtrlSetData($START, "NOOB MODUS")
				GUICtrlSetState($START, $GUI_DISABLE)
				GUICtrlSetState($Combo1, $GUI_DISABLE)
				If GUICtrlRead($Combo1) = "" Then
					If Initialize(ProcessExists("gw.exe")) = False Then
						MsgBox(0, "Error", "Guild Wars it not running.")
						Exit
					EndIf
				Else
					If Initialize(GUICtrlRead($Combo1), True, True) = False Then
						MsgBox(0, "Error", "Can't find a Guild Wars client with that character name.")
						Exit
					EndIf
				EndIf
				GUICtrlSetState($START, $GUI_ENABLE)
				EndIf
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
 EndFunc


#Region Main
Func Main()
Out("Noob modus on")
If $FirstRun Then

   If GetMapID() <> 349 Then travelTo(349)



    LoadSkillTemplate("OgcTcZ88ZC5Qn5A6usB64A3R4AA")
Out("Load Skills ")
    GoOutside()

    MoveTo(-11097, 19483)
    MoveTo(-11220, 19839)
   Do
	   Move(-11343, 20195)
	   Sleep(100)
   Until WaitMapLoading(349)

   $FirstRun = False
EndIf

If $NewSetup Then

    If GetMapID() <> 349 Then travelTo(349)


    GoOutside()
    MoveTo(-11097, 19483)
    MoveTo(-11220, 19839)
   Do
	   Move(-11343, 20195)
	   Sleep(100)
   Until WaitMapLoading(349)

   $NewSetup = False
EndIf

GoOutside()

If GetMapID() = 195 Then
    UseSkillEx(4,-2)
    UseSkillEx(5,-2)
    MoveTo(-8477, 18580)
    MoveTo(-7878, 18196)
    MoveTo(-6908, 17541)

    Do
	   Move(-4900, 15647)
	   Sleep(100)
    Until GetNumberOfFoesInRangeOfAgent(-2,1300) > 0


    UseSkillEx(1,-2)
    UseSkillEx(2,-2)
    UseSkillEx(3,-2)


    Do
	   Move(-4900, 15647)
	   Sleep(100)
    Until GetNumberOfFoesInRangeOfAgent(-2,1050) > 8
EndIf


If GetIsLiving(-2) Then
    Do
	   UseSkill(6,-2)
	   Sleep(100)
    Until GetSkillbarSkillRecharge(6) <> 0
EndIf
If GetIsLiving(-2) Then MoveTo(-6091, 17961)
If GetIsLiving(-2) Then TolSleep(1000)
If GetIsLiving(-2) Then MoveTo(-6528, 18439)
If GetIsLiving(-2) Then TolSleep(1000)

If (GetIsLiving(-2)) and (GetSkillbarSkillRecharge(2) = 0) Then
    UseSkillEx(2,-2)
EndIf


If GetIsLiving(-2) Then UseSkillEx(7,GetNearestAgentToCoords(-6036, 17064))
Do
	Sleep(100)
Until GetDistance(-2,GetNearestAgentToCoords(-6036, 17064)) < 160 or GetIsDead(-2)
If GetIsLiving(-2) Then UseSkillEx(8,-2)
If GetIsDead(-2) Then OmgTheyKilledKennyYouBastards()

Do
   Sleep(100)
Until (GetSkillbarSkillRecharge(2) = 0) or (GetNumberOfFoesInRangeOfAgent(-2,160) < 3) or GetIsDead(-2)
If GetIsLiving(-2) Then UseSkillEx(2,-2)

Do
	Sleep(250)
Until GetNumberOfFoesInRangeOfAgent(-2,160) < 3 or GetIsDead(-2)
If GetIsDead(-2) Then OmgTheyKilledKennyYouBastards()


If GetIsLiving(-2) Then
    Sleep(100)
    PickUpLoot2()
    ReturnOutpost()
	ClearMemory()
	AfterRun()
EndIf
EndFunc	;=>Main
#endRegion Main



Func AfterRun($aBags = 4)
	Local $slots = CountSlots()
	Sleep(2000)
	storegold()
	If $slots < 6 Then
		Sleep(2000)
		Merchant()
		RndSleep(1000)
		Ident(1)
		Ident(2)
		Ident(3)
			For $i = 1 to $aBags
				Salvage($i)
			Next
		RndSleep(1000)
		Sell(1)
		Sell(2)
		Sell(3)
		RndSleep(1000)
		If GetMapID() <> 349 Then travelTo(349)
	Else
		RndSleep(2000)
		Main()
	EndIf
	Main()
	Sleep(1000)
EndFunc

Func Merchant()
	Out("Go to merch")
	If $bSellAtGH = True Then
		TravelGH()
		$aGHmerch = GetGHMerch()
		GoToNPC($aGHmerch)
	Else
		GoNearestNPCToCoords(-10607.00, -20517.00)
	EndIf

	If GetGoldCharacter() > 80000 Then

		DepositGold(70000)
		Sleep(GetPing()+500)
	EndIf

	$i = 0;
	Do
		If FindIDKit() = 0 Then
			If GetGoldCharacter() < 100 And GetGoldStorage() > 99 Then
				WithdrawGold(100)
				Sleep(GetPIng()+250)
			EndIf
			BuyIDKit()
			Do
				Sleep(200)
			Until FindIDKit() <> 0
		EndIf
		Sleep(GetPing())
		$i += 1
	Until FindIDKit() <> 0 Or $i > 4
EndFunc

;==>Returns the Merchant at GH
Func GetGHMerch()
	For $i = 0 to GetMaxAgents()
		$aAgent = GetAgentByID($i)
		If DllStructGetData($aAgent, 'PlayerNumber') = 196 Then
			Return $aAgent
		EndIf
	Next
EndFunc


;==> Salvage if you want to.
Func Salvage($lBag)
	  Local $aBag
	  If Not IsDllStruct($lBag) Then $aBag = GetBag($lBag)
	  Local $lItem
	  Local $lSalvageType
	  Local $lSalvageCount
	  For $i = 1 To DllStructGetData($aBag, 'Slots')

			   $lItem = GetItemBySlot($aBag, $i)

			   SalvageKit()

			$q = DllStructGetData($lItem, 'Quantity')
			$t = DllStructGetData($lItem, 'Type')
			$m = DllStructGetData($lItem, 'ModelID')
			$r = DllStructGetData($lItem, 'Rarity')

			   If (DllStructGetData($lItem, 'ID') == 0) Then ContinueLoop
		If $r = $RARITY_Gold Then ContinueLoop
		 If $m = 819 Or $m = 868  Or $m = 904 Or $m = 906 Or ($t = 5 and $m = 934) Or $m = 957 Or $m = $ID_WickedBlade Or $m = $ID_GothicSword Or $m = $ID_GothicAxe Or $m = $ID_KrisDaggers Or $m = $ID_RuneAxe Or $m = $ID_RuneAxe Or $m = $ID_GothicDoubleAxe Or $m = $ID_OrnateShield Then
			   If $q >= 1 Then
						For $j = 1 To $q

							  SalvageKit()

							  StartSalvage($lItem)
							  Sleep(GetPing() + Random(1000, 1500, 1))

							  SalvageMaterials()

							  While (GetPing() > 1250)
									   RndSleep(250)
							  WEnd

							  Local $lDeadlock = TimerInit()
							  Local $bItem
							  Do
									   Sleep(300)
									   $bItem = GetItemBySlot($aBag, $i)
									   If (TimerDiff($lDeadlock) > 20000) Then ExitLoop
							  Until (DllStructGetData($bItem, 'Quantity') = $q - $j)
						Next
			   EndIf
			   EndIf
	  Next
	  Return True
EndFunc

Func SalvageKit()
   If FindSalvageKit() = 0 Then
	  If GetGoldCharacter() < 100 Then
		 WithdrawGold(100)
		 RndSleep(2000)
	  EndIf
	  BuyItem(2, 1, 100)
	  RndSleep(1000)
   EndIf
EndFunc	;=> SalvageKit

Func CountSlots()
	Local $FreeSlots = 0, $lBag, $aBag
	For $aBag = 1 To 4
		$lBag = GetBag($aBag)
		$FreeSlots += DllStructGetData($lBag, 'slots') - DllStructGetData($lBag, 'ItemsCount')
	Next
	Return $FreeSlots
EndFunc ; Counts open slots in your Imventory


Func GoOutside()
	Out("Run to farm")
	SwitchMode(1)
    Do
		Move(-11172, -23105)
		Sleep(100)
	Until WaitMapLoading(195)
EndFunc	;=> GoOutside

Func storegold()
	If GetGoldCharacter() > 80000 Then
		out("Store Gold")
		DepositGold(80000)
	EndIf
EndFunc

Func Ident($BAGINDEX)
	Out("Ident")
	Local $bag
	Local $I
	Local $AITEM
	$BAG = GETBAG($BAGINDEX)
	For $I = 1 To DllStructGetData($BAG, "slots")
		If FINDIDKIT() = 0 Then
			If GETGOLDCHARACTER() < 500 And GETGOLDSTORAGE() > 499 Then
				WITHDRAWGOLD(500)
				Sleep(GetPing()+500)
			EndIf
			Local $J = 0
			Do
				BuyItem(6, 1, 500)
				Sleep(GetPing()+500)
				$J = $J + 1
			Until FINDIDKIT() <> 0 Or $J = 3
			If $J = 3 Then ExitLoop
			Sleep(GetPing()+500)
		EndIf
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "Id") = 0 Then ContinueLoop
		IDENTIFYITEM($AITEM)
		Sleep(GetPing()+500)
	Next
EndFunc

Func Sell($BAGINDEX)
	Out("Sell")
	Local $AITEM
	Local $BAG = GETBAG($BAGINDEX)
	Local $NUMOFSLOTS = DllStructGetData($BAG, "slots")
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "Id") == 0 Then ContinueLoop
		If CANSELL($AITEM) Then
			SELLITEM($AITEM)
		EndIf
		Sleep(GetPing()+250)
	Next
EndFunc




;==> Sleep Function with Ping
Func PingSleep($time)
	Sleep($time + GetPing())
EndFunc	;=> PingSleep


;==> Returns to outpost
Func ReturnOutpost()
	Out("Run Finish")
	 $Winrun = $Winrun + 1
	GUICtrlSetData($Winupdater, $Winrun)
	Resign()
	pingSleep(3000)
	ReturnToOutpost()
	Do
	   Sleep(100)
	Until WaitMapLoading(349)
 EndFunc

func OmgTheyKilledKennyYouBastards()
	Out("FAIL")
		$Loserun = $Loserun + 1
		GUICtrlSetData($LoseCount, $Loserun)
		$NewSetup = True
		ReturnOutpost()
		ClearMemory()
		Main()
EndFunc	;=> OmgTheyKilledKennyYouBastards



;==> Get the number of foes in range of the agent
Func GetNumberOfFoesInRangeOfAgent($aAgent, $aRange)
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
		If $lDistance > $aRange Then ContinueLoop
		$lCount += 1
	Next

	Return $lCount
EndFunc



;==> Pick up the loot.
Func PickUpLoot2()
	Out("Pick up lood dud")
	Local $lMe
	Local $lBlockedTimer
	Local $lBlockedCount = 0
	Local $lItemExists = True
	Local $Distance

	For $i = 1 To GetMaxAgents()
		If GetIsDead(-2) Then Return False
		$lAgent = GetAgentByID($i)
		If Not GetIsMovable($lAgent) Then ContinueLoop
		$lDistance = GetDistance($lAgent)
		If $lDistance > 2000 Then ContinueLoop
		$lItem = GetItemByAgentID($i)
		If CanPickup($lItem) Then
			Do
				If GetDistance($lAgent) > 150 Then Move(DllStructGetData($lAgent, 'X'), DllStructGetData($lAgent, 'Y'), 100)
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
				Until Not $lItemExists Or TimerDiff($lBlockedTimer) > Random(500, 1000, 1)
				If $lItemExists Then $lBlockedCount += 1
			Until Not $lItemExists Or $lBlockedCount > 5
		EndIf
	Next
EndFunc


 Func GoNearestNPCToCoords($x, $y)
	Do
		RndSleep(250)
		$guy = GetNearestNPCToCoords($x, $y)
	Until DllStructGetData($guy, 'Id') <> 0
	ChangeTarget($guy)
	RndSleep(250)
	MoveTo(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 0)
	RndSleep(500)
	GoNPC($guy)
	RndSleep(250)
	Do
		RndSleep(500)
		MoveTo(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 0)
		RndSleep(500)
		GoNPC($guy)
		RndSleep(250)
		$Me = GetAgentByID(-2)
	Until ComputeDistance(DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'), DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y')) < 250
	RndSleep(1000)
 EndFunc   ;==>GoNearestNPCToCoords

Func CanSell($aItem)
	Local $LMODELID = DllStructGetData($aitem, "ModelId")
	Local $LRARITY = GetRarity($aitem)
	Local $Requirement = GetItemReq($aItem)
	Local $fiber = 934
	Local $plant = 956
	Local $aber = 940
	Local $aber2 = 941
	Local $echo = 944
	Local $echo2 = 945
	Local $gothic = 950
	Local $gothic2 = 951
	Local $ornateshild = 955
	Local $wickedblade = 792
	Local $gothicsword = 793
	If $LRARITY == $RARITY_Gold Then
		Switch DllStructGetData($aitem, "ModelId")
			Case $gothic, $fiber, $plant, $aber, $echo, $gothic2, $aber2, $ornateshild
				Return False
			Case Else
				Return True
		EndSwitch
	EndIf
	If $LRARITY == $RARITY_Purple Then
		Return True
	EndIf
;~ Leaving Blues and Whites as false for now. Going to make it salvage them at some point in the future. It does not currently pick up whites or blues
	If $LRARITY == $RARITY_Blue Then
		Return True
	EndIf
	If $LMODELID == $ITEM_ID_Dyes Then
		Switch DllStructGetData($aitem, "ExtraId")
			Case $ITEM_ExtraID_BlackDye, $ITEM_ExtraID_WhiteDye
				Return False
			Case Else
				Return True
		EndSwitch
	EndIf
	If CheckArrayTomes($lModelID)					Then Return False
	If CheckArrayMaterials($lModelID)				Then Return False
	; All weapon mods
	If CheckArrayWeaponMods($lModelID)				Then Return False
	; ==== General ====
	If CheckArrayGeneralItems($lModelID)			Then Return False ; Lockpicks, Kits
	If $lModelID == $ITEM_ID_Glacial_Stones 		Then Return False
	If CheckArrayPscon($lModelID)					Then Return False
	; ==== Stupid Drops =
	If CheckArrayMapPieces($lModelID)				Then Return False
	;DONT SELL CANDY CANE SHARDS!!!
	If $lModelID == 556 							Then Return False
	If $LRARITY == $RARITY_White 					Then Return True
	Return True
EndFunc   ;==>CanSell,








Func CheckArrayWeaponMods($lModelID)
	For $p = 0 To (UBound($Weapon_Mod_Array) -1)
		If ($lModelID == $Weapon_Mod_Array[$p]) Then Return True
	Next
EndFunc
#Region Arrays
Func CheckArrayPscon($lModelID)
	For $p = 0 To (UBound($Array_pscon) -1)
		If ($lModelID == $Array_pscon[$p]) Then Return True
	Next
EndFunc

Func CheckArrayGeneralItems($lModelID)
	For $p = 0 To (UBound($General_Items_Array) -1)
		If ($lModelID == $General_Items_Array[$p]) Then Return True
	Next
EndFunc


Func CheckArrayTomes($lModelID)
	For $p = 0 To (UBound($All_Tomes_Array) -1)
		If ($lModelID == $All_Tomes_Array[$p]) Then Return True
	Next
EndFunc

Func CheckArrayMaterials($lModelID)
	For $p = 0 To (UBound($All_Materials_Array) -1)
		If ($lModelID == $All_Materials_Array[$p]) Then Return True
	Next
EndFunc

Func CheckArrayMapPieces($lModelID)
	For $p = 0 To (UBound($Map_Piece_Array) -1)
		If ($lModelID == $Map_Piece_Array[$p]) Then Return True
	Next
EndFunc
#EndRegion Arrays

Func CanPickUp($aitem)
	$m = DllStructGetData($aitem, 'ModelID')
	$t = DllStructGetData($aitem, 'Type')
	$e = DllStructGetData($aItem, 'ExtraID')
	$r = GetRarity($aitem)

	If $m = $ID_Goldcoins And (GetGoldCharacter() < 98980)  Then	; all Goldcoins
		Return True
	EndIf

	If $t = $Type_Shields And $r = $RARITY_Gold  Then	; all Gold Shields
		Return True
	EndIf

	If $t = $Type_Swords And $r = $RARITY_Gold  Then	; all Gold Swords
		Return True
	EndIf

	If $t = $Type_Axes And $r = $RARITY_Gold  Then  ; all Gold Axes
		Return True
	EndIf

	If $r = $RARITY_Gold  Then  ; all Gold Weapons
		Return True
	EndIf

	If $m = $ID_Lockpicks   Then   ; all Lockpicks
		Return True
	EndIf

	If $m > 21785 And $m < 21806 Then   ; all Tomes

		;=========> Normal Tomes

		If $m = $ID_MonkTome Then ; all Normal Monk Tomes
			Return True
		EndIf

		If $m = $ID_RangerTome  Then ;all Normal Ranger Tomes
			Return True
		EndIf

		If $m = $ID_WarriorTome  Then ; all Normal Warrior Tomes
			Return True
		EndIf

		If $m = $ID_NecromancerTome Then
			Return True
		EndIf

		If $m = $ID_ElementalistTome Then ; all Normal Elementalist Tomes
			Return True
		EndIf

		If $m = $ID_MesmerTome  Then ; all Normal Mesmer Tomes
			Return True
		EndIf

		If $m = $ID_AssasinTome  Then ; all Normal Assasin Tomes
			Return True
		EndIf

		If $m = $ID_RitualistTome  Then ; all Normal Ritualist Tomes
			Return True
		EndIf

		If $m = $ID_DervishTome  Then ; all Normal Dervish Tomes
			Return True
		EndIf

		If $m = $ID_ParagonTome Then ; all Normal Paragon Tomes
			Return True
		EndIf

		;=========> Elite Tomes

		If $m = $ID_EliteMonkTome Then ; all Elite Monk Tomes
			Return True
		EndIf

		If $m = $ID_EliteRangerTome  Then ;all Elite Ranger Tomes
			Return True
		EndIf

		If $m = $ID_EliteWarriorTome Then ; all Elite Warrior Tomes
			Return True
		EndIf

		If $m = $ID_EliteNecromancerTome Then ; all Elite Necromancer Tomes
		Return True
		EndIf

		If $m = $ID_EliteElementalistTome Then ; all Elite Elementalist Tomes
			Return True
		EndIf

		If $m = $ID_EliteMesmerTome Then ; all Elite Mesmer Tomes
			Return True
		EndIf

		If $m = $ID_EliteAssasinTome Then ; all Elite Assasin Tomes
			Return True
		EndIf

		If $m = $ID_EliteRitualistTome  Then ; all Elite Ritualist Tomes
			Return True
		EndIf

		If $m = $ID_EliteDervishTome Then ; all Elite Dervish Tomes
			Return True
		EndIf

		If $m = $ID_EliteParagonTome  Then ; all Elite Paragon Tomes
			Return True
		EndIf

	EndIf

	If $m = $ID_SpiritWoodPlanks  Then ; all Spirit Wood Planks
		Return True
	EndIf

	If $m = $ID_DragonRoots Then ; all Dragon Roots
	   Return True
	EndIf

	If $m = $ID_PlantFibers Then ;  all Plant Fibers
	   Return True
	EndIf

	If $m = $ID_BrambleLongbow Or $m = $ID_BrambleFlatbow Or $m = $ID_BrambleHornbow Or $m = $ID_BrambleRecurvebow Or $m = $ID_BrambleShortbow Or $m = $ID_RuneAxe  Or $m = $ID_GothicDoubleAxe Or $m = $ID_OrnateShield Then ; all Bramble Longbow/Flatbow/Hornbow/Recurvebow/Shortbow
	   Return True
	EndIf

	If $m = $ID_WickedBlade OR $m = $ID_GothicSword Or $m = $ID_GothicAxe Or $m = $ID_KrisDaggers Or $m = $ID_RuneAxe Then ;stuff for salvage to iron
		Return True
	EndIf




	If $m = $ID_Dyes Then ; all Black and White
		If $e = $ExtraID_Black Or $e = $ExtraID_White Then
			Return True
		EndIf

	EndIf

	;All Sweets
	If $m = $ID_Cupcake Then ; all Cupcakes
		Return True
	EndIf

	If $m = $ID_DeliciousCake  Then ; all Delicious Cakes
		Return True
	EndIf

	If $m = $ID_SugarBlueDrink Then ; all Sugar Blue Drinks
		Return True
	EndIf

	If $m = $ID_ChocolateBunny  Then ; all Chocolate Bunnys
		Return True
	EndIf

	If $m = $ID_GoldenEgg  Then ; all Golden Eggs
		Return True
	EndIf

	If $m = $ID_PumpkinPie  Then ; all Pumpkin Pie

		Return True
	EndIf

	If $m = $ID_Fruitcake  Then ; all Fruitcakes
		Return True
	EndIf

	;All Alc
	If $m = $ID_KrytanBrandy Then ; all Krytan Brandy
		Return True
	EndIf

	If $m = $ID_BattleIsleIcedTea  Then ; all Battle Isle Iced Tea

		Return True
	EndIf

	If $m = $ID_HuntersAle  Then ; all Hunters Ale

		Return True
	EndIf

	If $m = $ID_Eggnong Then; all Eggnong

		Return True
	EndIf

	If $m = $ID_SharmrockAle  Then ; all Sharmrock Ale

		Return True
	EndIf

	If $m = $ID_HardAppleCider  Then ; all Hard Apple Cider
		Return True
	EndIf

	If $m = $ID_Grog Then ; all Grog

		Return True
	EndIf

	;All Party
	If $m = $ID_PartyBeacon Then ; all party beacon

		Return True
	EndIf

	If $m = $ID_MischievousTonic  Then ; all mischievous tonics

		Return True
	EndIf

	If $m = $ID_FrostyTonic  Then ; all frosty tonics

		Return True
	EndIf

	If $m = $ID_BottleRocket  Then ; all bottle rockets

		Return True
	EndIf

	If $m = $ID_CandyCaneShards  Then ; all Candy Cane Shards

	   Return True
	EndIf

	If $m = $ID_SnowmandSummoner  Then ; all snowman summoner

		Return True
	EndIf

	If $m = $ID_ChampagnePoper  Then ; all Champagne Poper

		Return True
	EndIf

	If $m = $ID_Sparkler  Then ; all Spaklers

		Return True
	EndIf

	;All other EventItems
	If $m = $ID_LunarToken  Then ; all Lunar Tokens

		Return True
	EndIf

	If $m = $ID_VictoryToken Then ; all Victory Tokens

		Return True
	EndIf

	If $m = $ID_FourLeafClover Then ; all Four-Leaf Clovers

		Return True
	EndIf

	If $m = $ID_Honeycomb  Then ; all Honeycombs

		Return True
	EndIf

	If $m = $ID_TrickOrTreatBag Then ; all Trick or Treat Bags

		Return True
	EndIf

	If $m = $ID_WayfarersMark  Then ; all Wayfarers Marks

		Return True
	EndIf

Return False

EndFunc

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
   Local $AvgSeconds = Floor($TotalSeconds)
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
Func Out($aString)
	ConsoleWrite(@HOUR & ":" & @MIN & " - " & $aString & @CRLF)
	GUICtrlSetData($Edit1, GUICtrlRead($Edit1) & @HOUR & ":" & @MIN & " - " & $aString & @CRLF)
	_GUICtrlEdit_Scroll($Edit1, $SB_SCROLLCARET)
	_GUICtrlEdit_Scroll($Edit1, $SB_LINEUP)
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
	GUICtrlSetData($Timer, $L_Hour & ":" & $L_Min & ":" & $L_Sec)
EndFunc

Func ChangeSellAtGH()
	$bSellAtGH = Not $bSellAtGH
	Out("Use Merch at GH: " & $bSellAtGH)
EndFunc