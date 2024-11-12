extends Node2D

@onready var icon_sprite: AnimationPlayer = $IconAnimator
@export var pickable_type = ""
	
func _process(delta: float) -> void:
	icon_sprite.call_deferred("play", "idle")
	
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("pick_object"):
		body.pick_object(pickable_type)
	queue_free()
