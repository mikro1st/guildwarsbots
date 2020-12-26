;###########################
;#  by rheek               #
;#  modified by mhaendler  #
;###########################
; v1.6, source: github.com/rheek123/GwBotApiPatcher
;
; This file contains all headers that gwa2 uses to communicate with the gameservers directly.
;
; The headers are named variables. The names should indicate what the header is about.
; The comments give a litte more detail about what the header does.
;
; This makes the source code of gwa2 a little better readable. Also it allows to update headers more easily, as they
; are all now in a small separate place as a list to work yourself through.
; If you need to update the headers, the comments give hints about what action to trigger while recording CtoGS packets.

#include-once

#Region Headers
Global Const $HEADER_QUEST_ACCEPT = 0x42
Global Const $HEADER_QUEST_REWARD = 0x42
Global Const $HEADER_QUEST_ABANDON = 0x10 ;done
Global Const $HEADER_HERO_AGGRESSION = 0x14 ;done
Global Const $HEADER_HERO_LOCK = 0x15 ;done
Global Const $HEADER_HERO_TOGGLE_SKILL = 0x18 ;done
Global Const $HEADER_HERO_CLEAR_FLAG = 0x19 ;done
Global Const $HEADER_HERO_PLACE_FLAG = 0x19 ;done
Global Const $HEADER_HERO_ADD = 0x1D ;done
Global Const $HEADER_HERO_KICK = 0x1E ;done
Global Const $HEADER_HEROES_KICK = 0x24
Global Const $HEADER_PARTY_PLACE_FLAG = 0x1A ;done
Global Const $HEADER_PARTY_CLEAR_FLAG = 0x1A ;done
Global Const $HEADER_HENCHMAN_ADD = 0x9E ;done
Global Const $HEADER_PARTY_LEAVE = 0xA1 ;done
Global Const $HEADER_HENCHMAN_KICK = 0xA7 ;done
Global Const $HEADER_CALL_TARGET = 0x22 ;done
Global Const $HEADER_ATTACK_AGENT = 0x25 ;done
Global Const $HEADER_CANCEL_ACTION = 0x27 ;done
Global Const $HEADER_GO_PLAYER = 0x32 ;done
Global Const $HEADER_NPC_TALK = 0x38 ;done
Global Const $HEADER_SIGNPOST_RUN = 0x50
Global Const $HEADER_ITEM_DROP = 0x2B ;done
Global Const $HEADER_GOLD_DROP = 0x2E ;done
Global Const $HEADER_STOP_MAINTAIN_ENCH = 0x2F
Global Const $HEADER_ITEM_EQUIP = 0x2F ;done
Global Const $HEADER_ITEM_PICKUP = 0x3E  ;done
Global Const $HEADER_ITEM_DESTROY = 0x68 ;done
Global Const $HEADER_ITEM_ID = 0x6B ;done
Global Const $HEADER_ITEM_MOVE = 0x71 ;done
Global Const $HEADER_ITEMS_ACCEPT_UNCLAIMED = 0x72 ;done
Global Const $HEADER_SALVAGE_MATS = 0x79 ;done
Global Const $HEADER_SALVAGE_MODS = 0x7A ;done
Global Const $HEADER_ITEM_USE = 0x7D ;done
Global Const $HEADER_UPGRADE = 0x84
Global Const $HEADER_UPGRADE_ARMOR_1 = 0x81
Global Const $HEADER_UPGRADE_ARMOR_2 = 0x84
Global Const $HEADER_TRADE_PLAYER = 0x4F
Global Const $HEADER_TRADE_OFFER_ITEM = 0x02
Global Const $HEADER_TRADE_SUBMIT_OFFER = 0x03
Global Const $HEADER_TRADE_CHANGE_OFFER = 0x06
Global Const $HEADER_TRADE_CANCEL = 0x01
Global Const $HEADER_TRADE_ACCEPT = 0x07
Global Const $HEADER_MAP_TRAVEL = 0xB0 ;done
Global Const $HEADER_GUILDHALL_TRAVEL = 0xAF ;done
Global Const $HEADER_GUILDHALL_LEAVE = 0xB1 ;done
Global Const $HEADER_OPEN_GB_WINDOW = 0x9F
Global Const $HEADER_CLOSE_GB_WINDOW = 0xA0
Global Const $HEADER_START_RATING_GVG = 0xA9
Global Const $HEADER_FACTION_DONATE = 0x34 ;done
Global Const $HEADER_TITLE_DISPLAY = 0x57 ;done
Global Const $HEADER_TITLE_CLEAR = 0x58 ;done
Global Const $HEADER_DIALOG = 0x3A ;done
Global Const $HEADER_CINEMATIC_SKIP = 0x62 ;done
Global Const $HEADER_SET_SKILLBAR_SKILL = 0x5B ;done
Global Const $HEADER_LOAD_SKILLBAR = 0x5C ;done
Global Const $HEADER_CHANGE_SECONDARY = 0x40  ;done
Global Const $HEADER_SKILL_USE_ALLY = 0x49
Global Const $HEADER_SKILL_USE_FOE = 0x49
Global Const $HEADER_SKILL_USE_ID = 0x49
Global Const $HEADER_SET_ATTRIBUTES = 0x0F
Global Const $HEADER_CHEST_OPEN = 0x52 ;done
Global Const $HEADER_CHANGE_GOLD = 0x7B ;done
Global Const $HEADER_MODE_SWITCH = 0x9A
Global Const $HEADER_MISSION_ENTER = 0xAC
Global Const $HEADER_MISSION_FOREIGN_ENTER = 0xA8
Global Const $HEADER_OUTPOST_RETURN = 0xA6 ;done
Global Const $HEADER_SEND_CHAT = 0x63 ;done
Global Const $HEADER_OPEN_SKILLS = 0x41
Global Const $HEADER_EQUIP_BAG = 0x71
Global Const $HEADER_USE_ITEM = 0x7D ;done
Global Const $HEADER_USE_SKILL = 0x45 ;done
Global Const $HEADER_HOM_DIALOG = 0x59
Global Const $HEADER_PROFESSION_ULOCK = 0x41
#EndRegion Headers
