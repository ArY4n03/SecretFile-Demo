extends Control

func _on_start_button_up() -> void:
	$AnimationPlayer.play("transition")

func _on_exit_button_up() -> void:
	get_tree().quit()

func transition_to_level1():
	get_tree().change_scene_to_file("res://Scenes/Levels/local_drive_d_(area_1).tscn")
