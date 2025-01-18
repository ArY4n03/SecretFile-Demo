extends "res://Scripts/enemy_template.gd"

@onready var clone = preload("res://Scenes/Enemy/WormClone.tscn")
@onready var pos_ = $Marker2D

func _ready() -> void:
	health = 300
	state = enemy_state.idle
	is_boss = true
	$Gun.target = find_parent("Main").get_node("Player")
	set_healthbarValues()

func active():
	state = enemy_state.active
	
func spawn_clone():
	if get_parent().get_child_count() <=15:
		var worm_clone = clone.instantiate()
		worm_clone.global_position = pos_.global_position
		get_parent().add_child(worm_clone)
	
func handle_states():
	match state:
		enemy_state.dead:
			dead()
			find_parent("Main").boss_fight_finished()
			 
func _on_timer_timeout() -> void:
	if state == enemy_state.active:
		spawn_clone()

func _on_gun_cooldown_timeout() -> void:
	if state == enemy_state.active:
		gun.shoot()
