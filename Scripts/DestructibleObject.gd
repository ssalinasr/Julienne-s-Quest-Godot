extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = $DestructibleSprite
@onready var treasure = preload("res://Scenes/TreasurePickable.tscn")
@onready var die_timer : Timer = $DieTimer
@onready var hurt_timer : Timer = $HurtTimer

var is_hurt = false
var is_dead = false

@export var hp_max : int = 50 : set = set_hp, get = get_hp
@export var hp : int = hp_max
signal hp_changed(new_hp)
signal died()

func set_hp (dam : int) -> void:
	self.hp -= dam
	if self.hp < 0:
		self.hp = 0
	if self.hp == 0:
		emit_signal("died")
	emit_signal("hp_changed",self.get_hp())

func get_hp ()-> int:
	return self.hp
	
func _process(_delta: float) -> void:
	update_animations()

func update_animations() -> void:
	if is_hurt:
		sprite.play('hit')
	elif is_dead:
		sprite.play("die")
	else:
		sprite.play('idle')
			
func handle_hit(damage: int) -> void:
	print('Box got hit')
	hurt_timer.start()
	self.set_hp(damage)
	print(self.get_hp())
	is_hurt = true

func die() -> void:
	is_dead = true
	die_timer.start()
	
func treasure_gen() -> void:
	var curr_treasure = treasure.instantiate()
	curr_treasure.global_position = global_position
	get_tree().get_root().call_deferred("add_child", curr_treasure)

func _on_died() -> void:
	print("box is dead")
	self.die()

func _on_die_timer_timeout() -> void:
	treasure_gen()
	queue_free()
	
func _on_hurt_timer_timeout() -> void:
	is_hurt = false
