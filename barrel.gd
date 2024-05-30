extends Area2D


var barrel_damage = 15




func _on_Area2D_body_entered(body):
	Global.health -= barrel_damage
	
	Global.inDamage = true 
	print("Damage took:",barrel_damage)
	print("Health remaining:",Global.health)


func _on_Area2D_body_exited(body):
	Global.inDamage = false
