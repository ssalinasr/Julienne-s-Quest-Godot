extends Node
var current_dialog_key = ""

var array_dialogs_lv0 = [false, false]
var array_dialogs_lv1 = [false, false]
var array_dialogs_lv2 = [false, false]
var array_dialogs_lv3 = [false, false, false]
var array_dialogs_lv4 = [false, false, false]
var array_dialogs_lv5 = [false, false]

func setViewedDialog(array_dialog, index) -> void:
	array_dialog[index] = true
	print(array_dialog)

func setDialogKey(dialog_key) -> void:
	current_dialog_key = dialog_key

func callDialog() -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogues/main.dialogue"), current_dialog_key)
