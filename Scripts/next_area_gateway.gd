extends Area2D

@export var next_area : PackedScene

func _process(delta: float) -> void:
	if $ProgressBar.value < 100:
		
		var overlapping_bodies = get_overlapping_bodies()
		
		if len(overlapping_bodies) > 0:
			update_progress(delta)
		else:
			$ProgressBar.hide()
	else:
		find_parent("Main").next_area = next_area
		find_parent("Main").get_node("AnimationPlayer").play("next_area")
		set_process(false)
			
func update_progress(delta):
	$ProgressBar.visible = true
	$ProgressBar.value += 20 * delta
