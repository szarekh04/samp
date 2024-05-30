extends Area2D


var hits = 0 
var speed = 700
var velocity = Vector2()
var direction = 1
var damage_amount = 1
var isDied = false 

func _ready():
	pass

func _set_dir(dir):
	direction = dir
	if dir == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true


func _process(delta):
	velocity.x = direction * speed * delta 
	translate(velocity)
	velocity = Vector2(1, 0).rotated(rotation)
	

func _on_bullet_body_entered(body):
	if body is KinematicBody2D:
		var target_health = Global.enemy_health
		target_health -= damage_amount
		emit_signal("bullet_hit", body)
		queue_free()
