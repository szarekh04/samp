extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_play_again_pressed():
	get_tree().change_scene("res://world samp.tscn")
	Global.health = 100
	Global.inDamage = false
	Global.coin = 0

func _on_quit_pressed():
	get_tree().change_scene("res://world samp.tscn")
	Global.health = 100
	Global.inDamage = false
	Global.coin = 0

