extends Node2D

@onready var icon_sprite: AnimationPlayer = $SceneAnimator
@export var level_key = ""
@onready var charge_timer : Timer = $ChargeTimer
@onready var changer_area : Area2D = $ChangerCollision
@onready var scene_change_sound : AudioStreamPlayer2D = $SceneChangeSound
@onready var sound_timer : Timer = $SoundTimer
var flag = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	icon_sprite.play("idle")
	match level_key:
		"Level 1":
			if DialogSignals.array_dialogs_lv0.all(func allTrue(element): return element == true):
				flag = 1
		"Level 2":
			if DialogSignals.array_dialogs_lv1.all(func allTrue(element): return element == true):
				flag = 1
		"Level 3":
			if DialogSignals.array_dialogs_lv2.all(func allTrue(element): return element == true):
				flag = 1
		"Level 4":
			if DialogSignals.array_dialogs_lv3.all(func allTrue(element): return element == true):
				flag = 1
		"Level 5":
			if DialogSignals.array_dialogs_lv4.all(func allTrue(element): return element == true):
				flag = 1		
		"Level 6":
			if DialogSignals.array_dialogs_lv5.all(func allTrue(element): return element == true):
				flag = 1			
	
func _on_left_visible_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and flag == 1:
		show()

func _on_left_visible_box_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and flag == 1:
		hide()

func _on_charge_timer_timeout() -> void:
	SceneChange.scene_to_switch(level_key)
	
func _on_charge_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and flag == 1:
		if sound_timer.time_left <= 0:
			scene_change_sound.play()
			sound_timer.start(1)
		print("Inicia cambio de escena")
		charge_timer.start()
		flag = 0
		
