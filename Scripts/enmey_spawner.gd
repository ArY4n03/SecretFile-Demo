extends Node2D

enum enemy_type {flying,gun,explosive}
var enemy = null
@onready var flying_enemy = preload("res://Scenes/Enemy/Malware(Flying).tscn")
@export var type : enemy_type

func spwan():
	if type == 0:
		enemy = flying_enemy.instantiate()
	enemy.global_position = $Marker2D.global_position
	get_parent().get_node("Enemy Container").add_child(enemy)
