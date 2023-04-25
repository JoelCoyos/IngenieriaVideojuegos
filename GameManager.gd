extends Node2D

var monedas
var notaPromedio

var sessionScene

func _ready():
	sessionScene = load("res://Session.tscn")
	pass


func _on_JugarButton_pressed():
	$UI.visible=false
	var session = sessionScene.instance()
	add_child(session)
	pass # Replace with function body.
