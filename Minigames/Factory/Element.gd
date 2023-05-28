extends Node2D

var color
var shape
var background

var expectedColor
var expectedShape
var expectedBackground

var speed = 10

func _process(delta):
	position= position + Vector2(0,speed*delta)
	pass

func ChangeShape(texture):
	$shapeSprite.texture = texture
	pass
	
func ChangeColor(color):
	var aux
	if(color == "blue"):
		aux = Color8(141,181,231)
	elif(color == "green"):
		aux = Color8(111,196,169)
	elif(color == "yellow"):
		aux = Color8(255,204,0)
	$shapeSprite.modulate = aux
	
func ChangeBackground(texture):
	$backgroundSprite.texture = texture
	
