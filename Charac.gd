extends KinematicBody2D

const bullet = preload("res://bullet.tscn")

var Floor = Vector2(0,-1)
var motion = Vector2()
var player 
var Speed = 200
var gravity = 35
var jump = 750
var firehit = 5
var movex = false
var movey = false
var slice = false
var isDeath = false
var isAttacking = false

func _ready():
	player = get_node("AnimatedSprite")
	$AnimatedSprite.play("idle")
	set_process_input(true)

func shoot():
	var bullets = bullet.instance()
	if sign($bullet_position.position.x) == 1:
		bullets._set_dir(1)
	else:
		bullets._set_dir(-1)
	get_parent().add_child(bullets)
	bullets.global_position = $bullet_position.global_position

func _physics_process(delta):
	if Global.isDie == false:
		if Input.is_action_pressed("ui_left"):
			motion.x = -Speed
			$AnimatedSprite.play("walking")
			$AnimatedSprite.flip_h = true
			movex = true
			if sign($bullet_position.position.x) == 1:
				$bullet_position.position.x *= -1 
		elif Input.is_action_pressed("ui_right"):
			motion.x = Speed
			$AnimatedSprite.play("walking")
			$AnimatedSprite.flip_h = false
			movex = true
			if sign($bullet_position.position.x) == -1:
				$bullet_position.position.x *= -1
		else:
			motion.x = 0
			movex = false
		if isAttacking == false:
			$AnimatedSprite.play("idle")
			isAttacking = false
		
		if Input.is_action_just_pressed("attack"):
			$AnimatedSprite.play("slicer")
			isAttacking = true
			$attackArea/CollisionShape2D.disabled = false
			$attackArea/CollisionShape2D2.disabled = false
			
		if isDeath:
			$AnimatedSprite.play("death")
		elif Global.health <= 0:
			isDeath = true
			$attackArea/CollisionShape2D.disabled = true
			$attackArea/CollisionShape2D2.disabled = true
			$Hit_life/CollisionShape2D.disabled = true
			$collected/CollisionShape2D.disabled = true

		if Input.is_action_just_pressed("ui_up"):
			if is_on_floor():
				motion.y = -jump
				$AnimatedSprite.play("jump")
			motion.y += gravity
		if not is_on_floor():
			$AnimatedSprite.play("jump")
			motion.y += gravity
			
		if Input.is_action_just_pressed("fire"):
			$attackArea/CollisionShape2D.disabled = true
			$attackArea/CollisionShape2D2.disabled = true
			if Global.bullet_limiter > 0:
				$AnimatedSprite.play("fire")
				Global.bullet_limiter -= 1
				shoot()
		
		
		motion.y += gravity * delta
		move_and_slide(motion, Floor)



func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "slicer":
		$attackArea/CollisionShape2D.disabled = true
		$attackArea/CollisionShape2D2.disabled = true
		isAttacking = false
		
		Global.isDie = false
		if isDeath == true:
			visible = false
			
		if Global.inDamage == true:
			Global.inDamage == false
			
	if $AnimatedSprite.animation == "death":
		queue_free()
		get_tree().change_scene("res://gameover_samp.tscn")

func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)




func _on_Hit_life_area_entered(area):
	$damaged.text = String(Global.health)
	$player_damaged.play("life")
	Global.inDamage = true
