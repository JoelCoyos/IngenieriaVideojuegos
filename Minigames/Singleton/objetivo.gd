extends Node2D
var estado
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
	
func definirIMG(est):
	estado = est
	if est==1:
		$AnimatedSprite.play("aliado")
	elif est == 0:
		$AnimatedSprite.play("enemigo")

	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if estado == 1:
			print("aliado")
		else:
			print("enemigo")
		queue_free()

