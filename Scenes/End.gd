extends Node2D

var goodScene
var badScene

signal end_over

func _ready():
	pass


func PlayGoodScene():
	$Good.visible = true
	pass

func PlayBadScene():
	$Bad.visible = true
	pass
	

func _process(delta):
	if(Input.is_action_just_pressed("game_select")):
		emit_signal("end_over")
	pass
