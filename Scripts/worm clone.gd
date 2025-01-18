extends "res://Scripts/malware(gun).gd"


func _ready():
	health = 50
	state = enemy_state.active
	gun.target = find_parent("Main").get_node("Player")
	randomize_speed(250)

func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
