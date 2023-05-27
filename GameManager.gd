extends Node2D

var coins
var notaPromedio

var sessionScene



func _ready():
	coins = 0 
	sessionScene = load("res://Session.tscn")
	GLOBAL.camara = $Camera2D
	$Camera2D.current = true
	pass

func _process(delta):
	pass


func _on_Button_pressed():
	$UI/AnimationPlayer.play("startClass")
	yield($UI/AnimationPlayer,"animation_finished")
	var session = sessionScene.instance()
	session.gameManager = self
	$UI/AnimationPlayer.play("RESET")
	$UI.visible=false
	add_child(session)
	pass # Replace with function body.
