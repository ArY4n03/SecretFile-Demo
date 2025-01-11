extends Area2D


var velocity = Vector2()
var speed = 530
var isplayerbullet = true
var dmg = 8
func _ready() -> void:
	if isplayerbullet:
		$Sprite2D.texture = preload("res://Sprites/Bullet/bullet (player).png")
	else:
		$Sprite2D.texture = preload("res://Sprites/Bullet/bullet (malware).png")
		
func start(_pos,_dir) -> void:
	global_position = _pos
	rotation = _dir.angle()
	velocity = _dir * speed
	
func _process(delta: float) -> void:
	position += velocity * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if isplayerbullet:
		if body.stat.char_type == 1:
			body.get_damaged(dmg)
			queue_free()
	else:
		if body.stat.char_type == 0:
			body.get_damaged(dmg)
			queue_free()
		
	
