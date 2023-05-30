extends Area2D

var speed 
var rotationLaser

func _ready():
	rotation_degrees = rotationLaser
	print("laser")
	pass

func _process(delta):
	var direction = Vector2(cos(deg2rad(rotationLaser)), sin(deg2rad(rotationLaser)))
	position += direction * speed * delta
	pass
