extends Node2D

var posX = 100
var posY = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		print("encontrado")
		queue_free()

