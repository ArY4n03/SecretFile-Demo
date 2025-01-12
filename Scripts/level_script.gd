extends Node2D
var next_area = null

func change_area():
	get_tree().change_scene_to_packed(next_area)
	
