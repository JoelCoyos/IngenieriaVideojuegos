extends Control

func _on_start_pressed():
	get_tree().change_scene("res://assets/level/nivel.tscn")

func _on_close_pressed():
	get_tree().quit() #accedemos al arbol de escena

func _on_Button_pressed():
	get_tree().change_scene("res://Ruleta/RuletaScene.tscn")



func _on_Button2_pressed():
	get_tree().change_scene("res://factory/scenePrin.tscn")
