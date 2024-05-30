extends KinematicBody2D


var speed = 90 
var chase = false
var player = null
var slice = false 
var hit = false
var life = 5
var motion = Vector2()
var enemy_damage = 10


func _ready():
	pass


func _physics_process(delta):
	if hit:
		$damageindicator.text = String(life)
		$AnimationPlayer.play("life")
		if $AnimatedSprite.flip_h:
			motion.x = +speed
		else:
			motion.x = -speed
		if life == 0:
			$DetectionArea/CollisionShape2D.disabled = true
			$Attack/CollisionShape2D.disabled = true
			$Hit/CollisionShape2D.disabled = true
			$AnimatedSprite.play("die")
		else:
			$AnimatedSprite.play("hit")
			move_and_slide(motion)
	elif slice:
		$AnimatedSprite.play("attack")
	elif chase:
		position.x += (player.position.x - position.x)/speed
		$AnimatedSprite.play("walk")
		if (player.position.x - position.x) < 0:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")


func _on_DetectionArea_body_entered(body):
	chase = true
	player = body
	


func _on_Attack_body_entered(body):
	slice = true
	Global.health -= enemy_damage
	Global.inDamage = true
	print("Enemy Attacked")
	print("Damaged took: ", enemy_damage)
	print("Health remaining: ", Global.health)


func _on_AnimatedSprite_animation_finished():
	slice = false
	hit = false
	if $AnimatedSprite.animation == "die":
		print("enemy died")
		queue_free()


func _on_Hit_area_entered(area):
	hit = true
	life -= 1
	print("Enemy hit")
	print("Remaining life: ",life)



func _on_Attack_body_exited(body):
	Global.inDamage = false




func _on_secret_hitpoint_body_entered(body):
	if body.get_name() == "Charac":
		$DetectionArea/CollisionShape2D.disabled = true
		$Attack/CollisionShape2D.disabled = true
		$Hit/CollisionShape2D.disabled = true
		$AnimatedSprite.play("die")
