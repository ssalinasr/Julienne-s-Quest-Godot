extends Node

var curr_loot : int = 0
var curr_treasures : int = 0
var curr_notes : int = 0
var curr_qnotes : int = 0

signal GotTreasure()
signal GotLoot()
signal GotNote()
signal GotQuestNote()

func gotObject(type_of : String) -> void:
		match (type_of):
			"loot":
				curr_loot += 1
				emit_signal("GotLoot")
				print("Loot: "+ str(curr_loot))
			"treasure":
				curr_treasures += 1
				emit_signal("GotTreasure")
				print("Treasures: "+ str(curr_treasures))
			"note":
				curr_notes += 1
				emit_signal("GotNote")
				print("Notes: "+ str(curr_notes))
			"quest_note":
				curr_qnotes += 1
				emit_signal("GotQuestNote")
				print("Quest Notes: "+ str(curr_qnotes))
