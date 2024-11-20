extends Node

var current_level = null
var curr_level_key = "level 0"

func _ready() -> void:
	var root = get_tree().root
	current_level = root.get_child(root.get_child_count() - 1)
	
func switch_scene(res_path) -> void:
	call_deferred("_deferred_switch_scene", res_path)
	
func _deferred_switch_scene(res_path) -> void:
	current_level.free()
	var s = load(res_path)
	current_level = s.instantiate()
	get_tree().root.add_child(current_level)
	get_tree().current_scene = current_level
	CountableVars.updateCounters()
	
	
func scene_to_switch(level) -> void:
	match level:
		"Level 0":
			switch_scene("res://Scenes/IntLvel.tscn")
			print("Ingresa a nivel 0")
			curr_level_key = "level 0"	
		"Level 1":
			switch_scene("res://Scenes/LevelOne.tscn")
			print("Ingresa a nivel 1")
			curr_level_key = "level 1"
		"Level 2":
			switch_scene("res://Scenes/LevelTwo.tscn")
			print("Ingresa a nivel 2")
			curr_level_key = "level 2"
		"Level 3":
			switch_scene("res://Scenes/LevelThree.tscn")
			print("Ingresa a nivel 3")
			curr_level_key = "level 3"
		"Level 4":
			switch_scene("res://Scenes/LevelFour.tscn")
			print("Ingresa a nivel 4")
			curr_level_key = "level 4"
		"Level 5":
			switch_scene("res://Scenes/FinalLevel.tscn")
			print("Ingresa a nivel 5")
			curr_level_key = "level 5"
		"Level 6":
			switch_scene("res://Scenes/FinalWindow.tscn")
			print("Ingresa a nivel 6")
			curr_level_key = "level 6"
	
