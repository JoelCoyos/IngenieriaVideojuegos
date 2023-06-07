extends Node2D

var LevelSelection
var minigame
var SessionUI
var currentScore=0
var cantidadAplazos=0
var maxAplazos
export (int) var difficulty
export (PackedScene) var mcScene
export (PackedScene) var storyScene
export (PackedScene) var endScene
var gameManager

var currentRound = 1
var countInRound = 0 #cantidad de minijuegos que se dieron en esta ronda
var roundMinigames

var beneficio
var rng
var t

var rouletteScene

enum TiposBeneficios {MONEDAS,NOTA,APLAZO} #eh, funciona

signal end_session

func _ready():
	LevelSelection = $LevelSelection
	SessionUI = $SessionUI
	rouletteScene = load("res://Ruleta//RuletaScene.tscn")
	SessionUI.session = self
	t = Timer.new()
	self.add_child(t)
	cantidadAplazos=0
	maxAplazos=5
	rng = RandomNumberGenerator.new()
	rng.randomize()
	if(GLOBAL.seenIntro == false):
		var story
		story = storyScene.instance()
		add_child(story)
		yield(story,"story_over")
		story.queue_free()
	SessionRoutine()
	pass

func SessionRoutine():
	$SessionUI/OnMinigame.visible = false #hack feo
	$SessionUI/BetweenMinigames/Controls.visible = false
	countInRound+=1
	if(countInRound == 1):
		roundMinigames = LevelSelection.SelectRoundMinigames()
	if(countInRound == 6):
		var mc = mcScene.instance()
		add_child(mc)
		mc.cargar_pregunta("Iterator")
		yield(mc,"answer")
		mc.queue_free()
		roundMinigames = LevelSelection.SelectRoundMinigames()
		countInRound = 0
		currentRound+=1
		if(difficulty<=5):
			difficulty+=1
	var next
	if(LevelSelection.testing):
		next = LevelSelection.levelToTest
	else: next = roundMinigames[countInRound]
	SessionUI.LeaveGame(next)
	if(rng.randi_range(0,10)==1 and countInRound>1):
		yield(SpawnRoulette(), "completed") #Horrible
	t.set_wait_time(3)
	t.start()
	$SessionUI/BetweenMinigames/Controls.visible = true
	$SessionUI/BetweenMinigames/Controls/TextureRect/AnimationPlayer.play(LevelSelection.gameControls[next])
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
	var gainedScore = (float(cant)/float(total))*difficulty
	var gainedCoins = 10
	GLOBAL.camara.position = Vector2(640,360) #No se muy bien porque hay que poner 640 en vez de 540
	if((float(cant)/float(total))*10<=3):
		cantidadAplazos+=1
	if(beneficio!=null):
		if(beneficio[0] == TiposBeneficios.NOTA):
			gainedScore*beneficio[1]
		elif(beneficio[0] == TiposBeneficios.APLAZO):
			cantidadAplazos += beneficio[1]
			if(cantidadAplazos < 0):
				cantidadAplazos = 0
		elif(beneficio[0] == TiposBeneficios.MONEDAS):
			gainedCoins*beneficio[1]
	currentScore+= stepify(gainedScore,0.1)
	gameManager.coins+=gainedCoins
	minigame.queue_free()
	SessionUI.ChangeScore(currentScore)
	beneficio = null
	if(cantidadAplazos == 5 or currentScore >= 100):
		yield(EndGameRoutine(), "completed") #Horrible, otra vez
	SessionRoutine()
	pass

func EndGameRoutine():
	$SessionUI.visible = false
	$SessionUI/OnMinigame.visible = false
	var end = endScene.instance()
	add_child(end)
	if(currentScore >= 7):
		end.PlayGoodScene()
	else:
		end.PlayBadScene()
	yield(end,"end_over")
	emit_signal("end_session")
	pass

func SpawnRoulette():
	print("Instance ruleta")
	var roulette = rouletteScene.instance()
	add_child(roulette)
	yield(roulette,"endRoulette")
	beneficio = roulette.beneficio
	roulette.queue_free()
	pass
