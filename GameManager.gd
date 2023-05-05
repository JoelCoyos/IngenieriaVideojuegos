extends Node2D

var monedas
var notaPromedio

var sessionScene

func _ready():
	sessionScene = load("res://Session.tscn")
	pass



func _on_Button_pressed():
	$UI/AnimationPlayer.play("startClass")
	yield($UI/AnimationPlayer,"animation_finished")
	var session = sessionScene.instance()
	$UI/AnimationPlayer.play("RESET")
	$UI.visible=false
	add_child(session)
	pass # Replace with function body.
