extends StaticBody2D

var can_shoot = true
var _scale = 5
var target = null
var rotation_speed = 2
@onready var Bullet = preload("res://Scenes/Bullet/bullet.tscn")
@export var gun_sprite: Texture
@export var is_playergun = true

func _ready() -> void:
	$GunSprite.texture = gun_sprite
	$GunSprite.scale = Vector2(_scale,_scale)
	
func shoot():
	if can_shoot:
		can_shoot = false
		var bullet = Bullet.instantiate()
		bullet.isplayerbullet = is_playergun
		
		
		bullet.dmg = get_parent().stat.atk
		bullet.global_position = $GunSprite/Marker2D.global_position
		bullet.scale = Vector2(2,2)
		
		bullet.start($GunSprite/Marker2D.global_position,Vector2(1,0).rotated($GunSprite.global_rotation))
		get_parent().get_parent().add_child((bullet))
		$Cooldown.start()


func _on_timer_timeout() -> void:
	can_shoot = true

func _process(delta: float) -> void:
	if target:
		rotate_towards_target(delta)

func rotate_towards_target(delta):
	var direction = (target.global_position - global_position).normalized()
	var target_angle = direction.angle()
	rotation = lerp_angle(rotation,target_angle,rotation_speed * delta)
