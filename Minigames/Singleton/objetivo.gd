extends Node2D
var estado

signal GetAliado
signal GetEnemigo

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func SetTexture(texture):
	$Sprite.texture = texture
	
func SetColor(color):
	$Sprite.modulate = color
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if estado == 1:
			emit_signal("GetAliado")
		else:
			emit_signal("GetEnemigo")
		queue_free()

