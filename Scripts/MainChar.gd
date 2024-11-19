extends CharacterBody2D

const SPEED = 250
const MAX_SPEED = 500
const JUMP_VELOCITY = -400.0
const GRAVITY = 10

@onready var sprite : AnimatedSprite2D = $MainSprite
@onready var sword_sprite: AnimationPlayer = $SwordPlayer
@onready var sword_element: Area2D = $SwordArea
@onready var die_timer : Timer = $DieTimer
@onready var hurt_timer : Timer = $HurtTimer
@onready var hp_bar : ProgressBar = $HealthBar
@onready var coyote_timer : Timer = $CoyoteTimer
@onready var walk_sound : AudioStreamPlayer2D = $WalkSound
@onready var walk_timer : Timer = $WalkTimer
@onready var attack_sound : AudioStreamPlayer2D = $AttackSound
@onready var attack_timer : Timer = $AttackTimer
@onready var jump_sound : AudioStreamPlayer2D = $JumpSound
@onready var jump_timer : Timer = $JumpTimer
@onready var hit_sound : AudioStreamPlayer2D = $HitSound
@onready var hit_timer : Timer = $HitTimer
@onready var die_sound : AudioStreamPlayer2D = $DieSound
@onready var die_timer_sound : Timer = $DieTimerSound
@onready var interact_sound : AudioStreamPlayer2D = $InteractSound
@onready var interact_timer : Timer = $InteractTimer


var motion = Vector2()
var is_attacking = false
var is_hurt = false
var is_dead = false
var is_dialog_near = false
var can_jump = true

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
	
func _ready() -> void:
	hp_bar.value = hp_max

func update_animations(direction) -> void:
	if is_on_floor():
		if direction == 0:
			if is_attacking:
				sprite.play('attack')
				sword_sprite.play('sword_attack')
				if attack_timer.time_left <= 0:
					attack_sound.play()
					attack_timer.start(0.75)
			elif is_hurt:
				sprite.play('hit')
				if hit_timer.time_left <= 0:
					hit_sound.play()
					hit_timer.start(0.75)
			elif is_dead:
				sprite.play("die")
				if die_timer_sound.time_left <= 0:
					die_sound.play()
					die_timer_sound.start(0.75)
			else:
				sprite.play('idle')
		else:
			if is_attacking:
				sprite.play('attack')
				sword_sprite.play('sword_attack')
				if attack_timer.time_left <= 0:
					attack_sound.play()
					attack_timer.start(0.75)
			elif is_hurt:
				sprite.play('hit')
				if hit_timer.time_left <= 0:
					hit_sound.play()
					hit_timer.start(0.75)
			elif is_dead:
				sprite.play("die")
				if die_timer_sound.time_left <= 0:
					die_sound.play()
					die_timer_sound.start(0.75)
			else:
				sprite.play('walk')
				if walk_timer.time_left <= 0:
					walk_sound.play()
					walk_timer.start(0.3)
					
	else:
		if velocity.y < 0:
			sprite.play('jump')
			if jump_timer.time_left <= 0:
				jump_sound.play()
				jump_timer.start(0.75)
		
			
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if can_jump == false and is_on_floor():
		can_jump = true
		
	if (is_on_floor() == false) and can_jump and coyote_timer.is_stopped():
		coyote_timer.start() 
		
	if Input.is_action_pressed("interact") and is_dialog_near:
		DialogSignals.callDialog()
		if interact_timer.time_left <= 0:
			interact_sound.play()
			interact_timer.start(0.75)
		is_dialog_near = false
		
	if Input.is_action_pressed("left"):
		sprite.flip_h = true
		sword_element.position.x = -57
	if Input.is_action_pressed("right"):
		sword_element.position.x = 0
		sprite.flip_h = false
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
	
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		can_jump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	update_animations(direction)
	
func _on_main_sprite_animation_finished() -> void:
	if sprite.animation == "attack":
		is_attacking = false	
	
func _on_main_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		is_hurt = true
		hurt_timer.start()
		print("char is getting hurt")
		self.set_hp(10)
		print(self.get_hp())
		
	if area.is_in_group("dialogable"):
		is_dialog_near = true
		
func die() -> void:
	is_dead = true
	die_timer.start()
	
func pick_object(type_of: String):
	print("objeto recogido")
	CountableVars.gotObject(type_of)

func _on_died() -> void:
	print("char is dead")
	self.die()

func _on_die_timer_timeout() -> void:
	queue_free()
	SceneChange._deferred_switch_scene("res://Scenes/IntLvel.tscn")
	CountableVars.resetCounters()
	
func _on_hurt_timer_timeout() -> void:
	is_hurt = false

func _on_main_area_area_exited(area: Area2D) -> void:
	is_dialog_near = false

func deactivate_dialog() -> void:
	is_dialog_near = false

func _on_hp_changed(new_hp: Variant) -> void:
	hp_bar.value = new_hp
	
func _on_coyote_timer_timeout() -> void:
	can_jump = false
