extends Node2D
var next_area = null
@export var current_level : String

func _ready() -> void:
	AutoLoad.current_level_scene = current_level
	
func change_area():
	get_tree().change_scene_to_packed(next_area)
	AutoLoad.playerhealth = get_node("Player").health
	
func _game_over():
	AutoLoad.playerhealth = AutoLoad.max_playerhealth
	GameOverScreen.start()
	get_tree().paused = true

func boss_fight_finished():
	get_node("BossFightDoors").update_door_state(false)
	
	if get_node("Enemy Container").get_child_count() > 0:
		for child in get_node("Enemy Container").get_children():
			if child.has_method("dead"):
				child.dead()
