extends Area2D

@export var damage : int = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.has_method('handle_hit'):
		body.handle_hit(self.damage)

func _on_body_exited(body: Node2D) -> void:
	if body.has_method('stopped_hit'):
		body.stopped_hit()
