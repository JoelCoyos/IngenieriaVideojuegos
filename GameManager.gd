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
	$UIClass/Node2D/MaxScoreText.text = str("MAXIMA PUNTUACION: ", GLOBAL.maxScore)
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
	if(GLOBAL.maxScore < session.currentScore):
		GLOBAL.maxScore = session.currentScore
	GLOBAL.seenIntro = true
	GLOBAL.guardar_partida(0)
	session.queue_free()
	$UIClass.visible= true
	pass # Replace with function body.

func _on_IniciarJuegoButton_pressed():
	$UIMenu.visible = false
	$UIClass.visible = true
	GLOBAL.cargar_partida(0)
	pass # Replace with function body.
