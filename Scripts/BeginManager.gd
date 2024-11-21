extends Node2D

@onready var interact_timer : Timer = $InteractTimer
@onready var interact_sound : AudioStreamPlayer2D = $InteractSound
@onready var charge_timer : Timer = $ChargeTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("start"):
		if interact_timer.time_left <= 0:
			interact_sound.play()
			interact_timer.start(0.75)
		charge_timer.start()
	

func _on_charge_timer_timeout() -> void:
	SceneChange.scene_to_switch("Level 0")
