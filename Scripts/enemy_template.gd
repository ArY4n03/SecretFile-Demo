extends CharacterBody2D

const JUMP_VELOCITY = -400.0
var dir = Vector2(1,0)
var dead_anim = false
var hit_effect_tween
var is_boss = false
@onready var player = find_parent("Main").get_node("Player")
@onready var explostion_effect = preload("res://Scenes/Effects/explosion_effect.tscn")
@onready var gun = $Gun
@export var can_fly = false
@export var stat : entity_stat
@export var health = 100
var speed = 250
enum enemy_state{idle , active , dead}
var state: enemy_state
@onready var healthbar =$"Health bar"

func _ready():
	healthbar.value = health
	randomize_speed(250)
	
func randomize_speed(from_):
	randomize()
	speed = randi_range(from_,stat.speed)
func get_damaged(dmg):
	if not can_fly:
		velocity.y -= 200
	
	get_damaged_effect()
	healthbar.visible = true
	health -= dmg
	#updating enemy health
	var tween = get_tree().create_tween()
	tween.tween_property(healthbar,"value",health,0.3)
	$TimerToHideHealthBar.start()

func get_damaged_effect():
	if hit_effect_tween:
		hit_effect_tween.kill()
		
	hit_effect_tween = get_tree().create_tween()
	hit_effect_tween.tween_property(self,"modulate",Color(1,0,0,1),0.2)
	hit_effect_tween.tween_property(self,"modulate",Color(1,1,1,1),0.2)
	
func _physics_process(delta: float) -> void:
	handle_states()
	
	if state  != enemy_state.dead:
		# Add the gravity
		if not is_on_floor() and not can_fly:
			velocity += get_gravity() * delta
			
		if state == enemy_state.active:
			handling_movement()
			velocity.x = dir.x * speed
			if can_fly:
				velocity.y = dir.y * speed
			if not dir.x: #only be true if dir=0
				velocity.x = move_toward(velocity.x, 0, speed)
		
			$RayCast2D.target_position.x = 50 * dir.x
			if $RayCast2D.is_colliding(): #if there is something in the way enemy will jump
				velocity.y = -250
		
		if health <= 0:
			state = enemy_state.dead
				
		move_and_slide()
	

func handling_movement():
	if state == enemy_state.active:
		if player.global_position.x - 150 > global_position.x:
			dir.x = 1
		elif player.global_position.x + 150 < global_position.x:
			dir.x = -1
		else:
			dir.x = 0
		
		if can_fly and not is_boss:
			if player.global_position.y - 150 > global_position.y:
				dir.y = 1
			elif player.global_position.y + 150 < global_position.y:
				dir.y = -1
			else:
				dir.y = 0

func handle_states():
	pass

func dead():
	if not dead_anim:
		dead_anim = true
		var explostion_effect_ = explostion_effect.instantiate()
		get_parent().add_child(explostion_effect_)
		explostion_effect_.global_position = global_position
		var scale_tween = get_tree().create_tween()
		
		scale_tween.tween_property(self,"scale",Vector2.ZERO,0.2)
		scale_tween.tween_callback(queue_free)
		


func _on_timer_to_hide_health_bar_timeout() -> void:
	healthbar.visible = false
