extends Node2D

var ruleta
var selectedNumber
var rng

enum RotationDirections {
	CLOCKWISE = 1,
	COUNTERCLOCKWISE = -1
}

var tween

var distance
 
export(RotationDirections) var rotation_direction = RotationDirections.CLOCKWISE
export(int) var revolutions = 2
export(float) var spin_time = 1
export(float) var target_rotation = 15

func _ready():
	ruleta = $SpriteRuleta
	tween = create_tween()
	rng = RandomNumberGenerator.new()
	rng.randomize()
	pass

func create_tween():
	var t = Tween.new()
	add_child(t)
	return t
	
func spin_the_wheel(target_rotation):
	tween.interpolate_property(
		ruleta,
		"rotation_degrees",
		ruleta.rotation,
		target_rotation + revolutions * rotation_direction*360,
		spin_time,
		Tween.TRANS_QUART,
		Tween.EASE_OUT
	)
	tween.start()


func _on_Button_pressed():
	var number = rng.randi_range(0,11)
	print(number+1)
	spin_the_wheel(-15-30*number)
	pass # Replace with function body.
