extends StaticBody2D



func _on_area_2d_body_exited(body: Node2D) -> void:
	body.set_collision_mask_value(6,true)
