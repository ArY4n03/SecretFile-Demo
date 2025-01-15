extends "res://Scripts/enemy_template.gd"

@onready var clone = preload("res://Scenes/Enemy/Worm.tscn")
func spwan_clone():
	pass
	

func handle_states():
	match state:
		enemy_state.dead:
			dead()
			 
func _on_timer_timeout() -> void:
	pass # Replace with function body.
