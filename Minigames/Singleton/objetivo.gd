extends Node2D

var estado
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if estado==0:
		$AnimatedSprite.play("aliado")
	else:
		$AnimatedSprite.play("enemigo")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if estado == 0:
			print("aliado")
		else:
			print("enemigo")
		queue_free()

