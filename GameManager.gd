extends Node2D

var coins
var notaPromedio

var sessionScene

func _ready():
	coins = 0 
	sessionScene = load("res://Session.tscn")
	GLOBAL.cargar_partida(0)
	GLOBAL.camara = $Camera2D
	$Camera2D.current = true
	pass

func _process(delta):
	pass


func _on_Button_pressed():
	$UIClass/AnimationPlayer.play("startClass")
	yield($UIClass/AnimationPlayer,"animation_finished")
	var session = sessionScene.instance()
	session.gameManager = self
	$UIClass/AnimationPlayer.play("RESET")
	$UIClass.visible=false
	add_child(session)
	yield(session,"end_session")
	session.queue_free()
	$UIClass.visible= true
	pass # Replace with function body.
