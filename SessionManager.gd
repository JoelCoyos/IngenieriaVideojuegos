extends Node2D


# Declare member variables here. Examples:

var LevelSelection
var minigame
var SessionUI
var currentScore=0

var rng
var t

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelSelection = $"../LevelSelection"
	SessionUI = $SessionUI
	t = Timer.new()
	self.add_child(t)
	rng = RandomNumberGenerator.new()
	rng.randomize()
	SessionRoutine()
	pass # Replace with function body.

func SessionRoutine():
	var next = LevelSelection.SelectMinigame()
	SessionUI.LeaveGame(next)
	t.set_wait_time(3)
	t.start()
	yield(t, "timeout")
	var minigameScene = load("res://Minigames//"+next+"//"+next+".tscn")
	minigame = minigameScene.instance()
	add_child(minigame)
	minigame.StartMinigame()
	SessionUI.EnterGame(minigame)
	minigame.connect("minigame_ended", self, "NextMinigame")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func NextMinigame():
	print("Seleccionando el siguiente minijuego")
	minigame.queue_free()
	var gainedScore = minigame.objectiveCleared
	currentScore+=gainedScore
	SessionUI.ChangeScore(currentScore)
	SessionRoutine()
	pass
