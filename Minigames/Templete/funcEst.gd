extends Area2D
var estadoActual

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func asignarVal(valor):
	estadoActual = valor
	if valor == 1 :
		$AnimatedSprite.play("animatUNO")
	elif valor == 2:
		$AnimatedSprite.play("animatDOS")
	else:
		$AnimatedSprite.play("default")
