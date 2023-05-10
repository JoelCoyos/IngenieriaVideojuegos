extends Node2D


# Declare member variables here. Examples:

var LevelSelection
var minigame
var SessionUI
var currentScore=0
var cantidadAplazos=0
var maxAplazos
var difficulty

var currentRound = 1
var countInRound = 0 #cantidad de minijuegos que se dieron en esta ronda
var roundMinigames

var rng
var t

func _ready():
	LevelSelection = $LevelSelection
	SessionUI = $SessionUI
	SessionUI.session = self
	t = Timer.new()
	self.add_child(t)
	cantidadAplazos=0
	maxAplazos=5
	difficulty=1
	rng = RandomNumberGenerator.new()
	rng.randomize()
	SessionRoutine()
	pass

func SessionRoutine():
	countInRound+=1
	if(countInRound == 1):
		roundMinigames = LevelSelection.SelectRoundMinigames()
	if(countInRound == 5):
		roundMinigames = LevelSelection.SelectRoundMinigames()
		countInRound = 0
		currentRound+=1
		difficulty+=1
		#Entre medio de rondas
	var next = roundMinigames[countInRound]
	SessionUI.LeaveGame(next)
	t.set_wait_time(3)
	t.start()
	yield(t, "timeout")
	var minigameScene = load("res://Minigames//"+next+"//"+next+".tscn")
	minigame = minigameScene.instance()
	add_child(minigame)
	minigame.difficulty = difficulty
	minigame.StartMinigame()
	var transitionScene = load("res://TransitionBlur.tscn")
	var transition = transitionScene.instance()
	add_child(transition)
	transition.MinigameTransition()
	SessionUI.EnterGame(minigame)
	minigame.connect("minigame_ended", self, "NextMinigame")
	pass

func NextMinigame():
	print("Seleccionando el siguiente minijuego")
	var total = minigame.objectiveCount
	var cant = minigame.objectiveCleared
	print(total)
	print(cant)
	var gainedScore = (float(cant)/float(total))*difficulty
	if((float(cant)/float(total))*10<=3):
		cantidadAplazos+=1
	currentScore+=gainedScore
	minigame.queue_free()
	SessionUI.ChangeScore(currentScore)
	SessionRoutine()
	pass
