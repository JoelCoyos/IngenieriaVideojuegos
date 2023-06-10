extends Node2D

var escenas = []
var actualScene

signal story_over

func _ready():
	escenas.append($"1")
	escenas.append($"2")
	escenas.append($"3")
	escenas.append($"4")
	actualScene=0
	escenas[0].visible = true
	pass



func _process(delta):
	if(Input.is_action_just_pressed("game_select")):
		if(actualScene < 3):
			actualScene+=1
			escenas[actualScene-1].visible = false
			escenas[actualScene].visible = true
		else:
			emit_signal("story_over")
	pass
