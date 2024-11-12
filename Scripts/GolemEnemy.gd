extends CharacterBody2D

const MAX_SPEED = 45.2
const SPEED = 45.0
const JUMP_VELOCITY = -400.0

@onready var sprite : AnimatedSprite2D = $WarriorSprite
@onready var timer : Timer = $Timer
@onready var die_timer : Timer = $DieTimer

var randint = 0
var curr_direction = 0
var is_hurt = false
var is_dead = false

@export var hp_max : int = 100 : set = set_hp, get = get_hp
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

func movement() -> void:
	var rng = RandomNumberGenerator.new()
	var list = [-1, 0 , 1]
	randint = rng.randi_range(0, 4)
	if randint == 0:
		curr_direction = list[0]
	elif randint == 1:
		curr_direction = list[2]
	else:
		curr_direction = list[1]
		
func update_animations(direction) -> void:
	if is_on_floor():
		if direction == 0:
			if is_hurt:
				sprite.play('hit')
			elif is_dead:
				sprite.play('die')
			else:
				sprite.play('idle')
		else:
			if is_hurt:
				sprite.play('hit')
			elif is_dead:
				sprite.play('die')
			else:
				sprite.play('walk')
	else:
		if velocity.y < 0:
			sprite.play('jump')

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = curr_direction
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = false
		if velocity.x == MAX_SPEED:
			velocity.x = 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.flip_h = true
		if velocity.x == -MAX_SPEED:
			velocity.x = 0

	move_and_slide()
	update_animations(direction)

func _on_timer_timeout() -> void:
	movement()
	timer.start()
	
func handle_hit(damage: int) -> void:
	print('Warrior got hit')
	self.set_hp(damage)
	print(self.get_hp())
	is_hurt = true
	
func stopped_hit() -> void:
	is_hurt = false
	
func die() -> void:
	is_dead = true
	die_timer.start()
	
func _on_died() -> void:
	print("warrior is died")
	self.die()
	
func _on_die_timer_timeout() -> void:
	queue_free()
