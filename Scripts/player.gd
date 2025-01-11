extends CharacterBody2D

const JUMP_VELOCITY = -400.0
enum states{idle,run,jump,shoot}

var state: states
var direction = Vector2.ZERO
var can_shoot = true
var jump_count = 0
var gravity = 790
var jump_force = -600
@export var stat : entity_stat
@export var health = 100
@onready var gun = get_node("Gun")
@onready var healthbar = $CanvasLayer/HealthBar
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	gun.look_at(get_global_mouse_position())

	input_handling(delta)
	
	velocity.x = direction.x * stat.speed if direction else move_toward(velocity.x, 0, stat.speed)
	state = states.run if direction else states.idle
	
	state_manager()
	move_and_slide()

func input_handling(delta):
	if Input.is_action_pressed("Left"):
		direction = Vector2(-1,0)
	elif Input.is_action_pressed("Right"):
		direction = Vector2(1,0)
	else:
		direction = Vector2.ZERO
		
	if Input.is_action_just_pressed("jump") and not Input.is_action_pressed("Down"):
		if is_on_floor():
			jump_count = 0 if jump_count > 3 else jump_count
			state = states.jump
			velocity.y = jump_force
			jump_count += 1
		else:
			if jump_count < 3:
				state = states.jump
				velocity.y = jump_force
				jump_count += 1
			
	if Input.is_action_pressed("shoot"):
		gun.shoot()
	
	if Input.is_action_pressed('Down') and Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = 90
			set_collision_mask_value(6,false)
	
func state_manager():
	match state:
		states.idle:
			$AnimationPlayer.play("idle")
		states.run:
			if is_on_floor():
				$AnimationPlayer.play("run")
			else:
				#player is moving but not on floor
				$AnimationPlayer.play("jump")
		states.jump:
			$AnimationPlayer.play("jump")


func _on_cooldown_timeout() -> void:
	can_shoot = true

func get_damaged(dmg):
	healthbar.visible = true
	health -= dmg
	#updating enemy health
	var tween = get_tree().create_tween()
	tween.tween_property(healthbar,"value",health,0.3)
	
