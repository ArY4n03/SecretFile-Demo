extends CanvasLayer

func start():
	var tween = create_tween()
	tween.tween_property($Control,"modulate",Color(1,1,1,1),0.5)
	
func _on_retry_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(AutoLoad.current_level_scene)
	$Control.modulate = Color(1,1,1,0)
	AutoLoad.playerhealth = 100


func _on_main_menu_button_up() -> void:
	$Control.modulate = Color(1,1,1,0)
	AutoLoad.playerhealth = 100
	
