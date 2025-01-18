extends Node2D

enum enemy_type {flying,gun,explosive}
var enemy = null
@onready var flying_enemy = preload("res://Scenes/Enemy/Malware(Flying).tscn")
@onready var markers = [$Marker2D,$Marker2D2]
@export var wait_time : int

func _ready() -> void:
	$Timer.wait_time = wait_time
func spwan():
	if find_parent("Main").get_node("Enemy Container").get_child_count() <= 10:
		randomize()

		var marker = markers[randi_range(0,1)]
		enemy = flying_enemy.instantiate()
		enemy.global_position = marker.global_position
		find_parent("Main").get_node("Enemy Container").add_child(enemy)


func _on_timer_timeout() -> void:
	spwan()
