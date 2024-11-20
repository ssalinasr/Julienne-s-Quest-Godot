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
var level4_int_sucess = [false, false, false, false]
var level5_int_sucess = [false, false]

func setViewedDialog(array_dialog, index) -> void:
	array_dialog[index] = true
	print(array_dialog)

func setDialogKey(dialog_key) -> void:
	current_dialog_key = dialog_key

func callDialog() -> void:
	var viewed = false
	match current_dialog_key:
		"level0_1":
			if array_dialogs_lv0[0] == true:
				viewed = true
		"level0_2":
			if array_dialogs_lv0[1] == true:
				viewed = true				
		"level1_1":
			if array_dialogs_lv1[0] == true:
				viewed = true		
		"level1_2":
			if array_dialogs_lv1[1] == true:
				viewed = true
		"level2_1":
			if array_dialogs_lv2[0] == true:
				viewed = true
		"level2_2":
			if array_dialogs_lv2[1] == true:
				viewed = true	
		"level3_1":
			if array_dialogs_lv3[0] == true:
				viewed = true
		"level3_2":
			if array_dialogs_lv3[1] == true:
				viewed = true
		"level3_3":
			if array_dialogs_lv3[2] == true:
				viewed = true
		"level4_1":
			if array_dialogs_lv4[0] == true:
				viewed = true
		"level4_2":
			if array_dialogs_lv4[1] == true:
				viewed = true
		"level4_3":
			if array_dialogs_lv4[2] == true:
				viewed = true
		"level5_1":
			if array_dialogs_lv5[0] == true:
				viewed = true
		"level5_2":
			if array_dialogs_lv5[1] == true:
				viewed = true
				
	if viewed == false:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogues/main.dialogue"), current_dialog_key)
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogues/main.dialogue"), "viewed_dialog")
