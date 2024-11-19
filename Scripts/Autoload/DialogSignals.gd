extends Node
var current_dialog_key = ""

var array_dialogs_lv0 = [false, false]
var array_dialogs_lv1 = [false, false]
var array_dialogs_lv2 = [false, false]
var array_dialogs_lv3 = [false, false, false]
var array_dialogs_lv4 = [false, false, false]
var array_dialogs_lv5 = [false, false]

var level1_int_sucess = [false, false]
var level2_int_sucess = [false, false, false]
var level3_int_sucess = [false, false, false]
var level4_int_sucess = [false, false, false]
var level5_int_sucess = [false, false]

func setViewedDialog(array_dialog, index) -> void:
	array_dialog[index] = true
	print(array_dialog)

func setDialogKey(dialog_key) -> void:
	current_dialog_key = dialog_key

func callDialog() -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogues/main.dialogue"), current_dialog_key)
