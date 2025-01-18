extends Node2D


@onready var door1 =  $StaticBody2D
@onready var door2 =  $StaticBody2D2
var fight_started = false

func _ready():
	update_door_state(false)
	
func update_door_state(state): 
#state = false means doors are not active and they will keep remain hidden
#and vice versa for state = true
	door1.visible = state
	door2.visible = state
	door1.get_node("CollisionShape2D").disabled = not state
	door2.get_node("CollisionShape2D").disabled = not state
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if not fight_started:
		$AnimationPlayer.play('warning')
		call_deferred("update_door_state",true)
		find_parent("Main").get_node("Enemy Container").get_node("EnemyTemplate").active()
