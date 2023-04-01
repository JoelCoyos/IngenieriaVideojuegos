extends Node2D


# Declare member variables here. Examples:

var LevelSelection
var minigame


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelSelection = $"../LevelSelection"
	SessionRoutine()
	pass # Replace with function body.

func SessionRoutine():
	var next = LevelSelection.SelectMinigame()
	print(next)
	var minigameScene = load("res://"+next+".tscn")
	minigame = minigameScene.instance()
	add_child(minigame)
	minigame.StartMinigame()
	minigame.connect("minigame_ended", self, "NextMinigame")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func NextMinigame():
	print("Seleccionando el siguiente minijuego")
	minigame.queue_free()
	SessionRoutine()
	pass
