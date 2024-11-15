extends Node2D
@onready var icon_sprite: AnimationPlayer = $ArrowAnimator

@export var dialog_key = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	icon_sprite.play("idle")

func _on_left_visible_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		show()

func _on_left_visible_box_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hide()
	
func _on_right_visible_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		show()

func _on_right_visible_box_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hide()
