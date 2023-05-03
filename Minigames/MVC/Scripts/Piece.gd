extends Area2D

signal selectPiece

var x
var y
var number

func SetText(text):
	$Text.text = text
	pass


func _input_event(viewport, event, shape_idx):
	if(Input.is_action_just_pressed("game_select") and event.is_pressed() and not event.is_echo()):
		print("click")
		emit_signal("selectPiece",x,y)
	pass
