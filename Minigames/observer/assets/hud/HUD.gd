extends CanvasLayer

signal game_over #creamos unestra propia senial

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.score = 0
	GLOBAL.controlPtos  = 30
	GLOBAL.maxVel = 20
	GLOBAL.minVel = 50


func _physics_process(delta):#lo que se ponga se actualiza automaticamente en cada fotograma
	$ScoreContainer/HBoxContainer/Score.text = str(GLOBAL.score)#convierto a string para no salte error


func game_over():
	emit_signal("game_over")
	$GameOverContainer.visible = true
	$AudioStreamPlayer.play()

func _on_restart_pressed():
	# get_tree().reload_current_scene()
	get_tree().call_deferred("reload_current_scene")#llamada segura


func _on_menu_pressed():
	#get_tree().change_scene(ruta path)
	get_tree().call_deferred("change_scene","res://assets/menu/menu.tscn")

func _on_Player_tree_exiting():
	game_over()


