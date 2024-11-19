extends Area2D

@onready var icon_sprite: AnimationPlayer = $IconAnimator
@export var pickable_type = ""
@onready var got_sound : AudioStreamPlayer2D = $GotSound
@onready var got_timer : Timer = $GotTimer

func _process(delta: float) -> void:
	icon_sprite.call_deferred("play", "idle")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("pick_object"):
		body.pick_object(pickable_type)
		if got_timer.time_left <= 0:
			got_sound.play()
			got_timer.start(0.75)
	queue_free()
