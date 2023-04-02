extends Area2D
signal selectStartingNode(x)

var connection
var edge
var x
var y

func _ready():
	connection=null
	pass

func _input_event(viewport, event, shape_idx):
	if(Input.is_action_just_pressed("game_select") and y == 0):
		emit_signal("selectStartingNode",x)
	pass
