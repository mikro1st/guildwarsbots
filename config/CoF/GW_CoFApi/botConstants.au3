; ==== Constants ====
Global Const $MAP_ID_JOKANUR = 491
Global CONST $MAP_ID_FAHRANUR = 481
Global Const $ITEM_ID_SKALEFINS = 19184
Global Const $MAP_ID_NAHPUI = 216
Global Const $MAP_ID_WAJJUN = 239
Global Const $MAP_ID_KAINENG = 194

;RARITY
; Global Const $RARITY_GOLD = 2624
; Global Const $RARITY_PURPLE = 2626
; Global Const $RARITY_BLUE = 2623
; Global Const $RARITY_WHITE = 2621

;CONSUMABLES
Global Const $ITEM_ID_LOCKPICKS = 22751
; Global Const $ITEM_ID_SALVAGE_KIT = 2992
; Global Const $ITEM_ID_ID_KIT = 2989
; Global Const $ITEM_ID_ID_KITSUP = 5899

;DYES
; Global Const $ITEM_ID_DYES = 146
Global Const $ITEM_ExtraID_BlackDye = 10
Global Const $ITEM_ExtraID_WhiteDye = 12

;MATS
Global $ITEM_ID_MEYES = 931
Global $ITEM_ID_RUBY = 937
Global $ITEM_ID_AMBER = 6532
Global $ITEM_ID_CHITIN = 954
Global $ITEM_ID_IRON = 948
Global $ITEM_ID_DUST = 929
Global $ITEM_ID_BONES = 921
Global $ITEM_ID_FIBERS = 934
Global $ITEM_ID_STONES = 955
Global $ITEM_ID_SCALES = 953
Global $ITEM_ID_WOOD = 946

;PCONS
Global Const $ITEM_ID_TOTS = 28434
Global Const $ITEM_ID_GOLDEN_EGGS = 22752
Global Const $ITEM_ID_BUNNIES = 22644
Global Const $ITEM_ID_GROG = 30855
Global Const $ITEM_ID_CLOVER = 22191
Global Const $ITEM_ID_PIE = 28436
Global Const $ITEM_ID_CIDER = 28435
Global Const $ITEM_ID_POPPERS = 21810
Global Const $ITEM_ID_ROCKETS = 21809
Global Const $ITEM_ID_CUPCAKES = 22269
; Global Const $ITEM_ID_SPARKLER = 21813
; Global Const $ITEM_ID_HONEYCOMB = 26784
; Global Const $ITEM_ID_VICTORY_TOKEN = 18345
; Global Const $ITEM_ID_LUNAR_TOKEN = 21833
; Global Const $ITEM_ID_HUNTERS_ALE = 910
; Global Const $ITEM_ID_LUNAR_TOKENS = 28433
; Global Const $ITEM_ID_KRYTAN_BRANDY = 35124
; Global Const $ITEM_ID_BLUE_DRINK = 21812

;GOODSKINS
Global $CeleStr = 942
Global $CeleTact = 943
Global $BladedShieldStr = 777
Global $BladedShieldTact = 778
Global $FanFastCast = 775
Global $FanSoulReap = 776
Global $FanEnergyStorage = 789
Global $FanDivine = 858
Global $FanSpawning = 866
Global $JugDivine = 1022
Global $JugSoul = 874
Global $JugES = 875
Global $CeleStaff = 785
Global $CockaStaff = 786
Global $EternalFlameW = 729
Global $KoiScepterAir = 929
Global $WailingStaff = 883
Global $BanefulScepter = 730
Global $DarkTendrilStaff = 878
Global $EvilEyeStaff = 882
Global $CeleScepter = 926
Global $PaperLantern = 896
Global $DivineScroll = 905
Global $CanthanFireStaff = 887
Global $CanthanWaterStaff = 888
Global $CanthanAirStaff = 884
Global $EyeFlameArtifact = 181
Global $CanthanEarthStaff = 885
Global $DivineStaff = 889
Global $CeleSword = 790

; ================== CONFIGURATION ==================
; True or false to load the list of logged in characters or not
Global Const $doLoadLoggedChars = True
; ================ END CONFIGURATION ================

; ================== SKILL BAR STUFF ==================
Global Const $template = "OgCjkirMrSmXfbffqiAAAAAAAAA"

Global Const $SAND_SHARDS = 1
Global Const $VOW_OF_STRENGTH = 2
Global Const $FARMERS = 3
Global Const $DRUNKEN_MASTER = 4

Global Const $sq = 1
Global Const $sod = 2
Global Const $sf = 3
Global Const $dc = 4
Global Const $whirling = 5
Global Const $eoe = 6
Global Const $soh = 7
Global Const $dash = 8

; Store skills energy cost
; Global $skillCost[9]
; $skillCost[$SAND_SHARDS] = 5
; $skillCost[$VOW_OF_STRENGTH] = 5
; $skillCost[$FARMERS] = 5
; $skillCost[$DRUNKEN_MASTER] = 5
; $skillCost[5] = 0
; $skillCost[6] = 0
; $skillCost[7] = 0
; $skillCost[8] = 0
; ================== END SKILL BAR STUFF ==================

; ==== Bot global variables ====
; Global $RenderingEnabled = True
; Global $PickUpAll = True
; Global $PickUpMapPieces = False
; Global $PickUpTomes = False
; Global $RunCount = 0
; Global $FailCount = 0
; Global $FinCount = 0
; Global $BotRunning = False
; Global $BotInitialized = False
; Global $ChatStuckTimer = TimerInit()