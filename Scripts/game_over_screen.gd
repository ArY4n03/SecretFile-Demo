extends CanvasLayer

func _ready() -> void:
	visible = false
	$Control.modulate = Color(1,1,1,0)
	
func start():
	visible = true
	var tween = create_tween()
	tween.tween_property($Control,"modulate",Color(1,1,1,1),1.5)
	
func _on_retry_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(AutoLoad.current_level_scene)
	visible = false
	$Control.modulate = Color(1,1,1,0)
	AutoLoad.playerhealth = 100


func _on_main_menu_button_up() -> void:
	visible = false
	$Control.modulate = Color(1,1,1,0)
	AutoLoad.playerhealth = 100
	
