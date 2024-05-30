extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_life_potion_body_entered(body):
	if Global.health < 100:
		Global.health += 20
		Global.bullet_limiter += 2
		queue_free() 
		print("Health Regenerated")
		print("Current Health: ", Global.health)
