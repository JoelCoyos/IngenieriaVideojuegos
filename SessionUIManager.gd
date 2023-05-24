extends Node2D

var BetweenMinigamesUI
var OnMinigamesUI

var onMinigame

var minigameTime

var session

var t
func _ready():
	t = Timer.new()
	self.add_child(t)
	
	BetweenMinigamesUI = $BetweenMinigames
	OnMinigamesUI = $OnMinigame
	pass

func EnterGame(minigame):
	BetweenMinigamesUI.visible = false
	OnMinigamesUI.visible = true
	onMinigame=true
	minigameTime = minigame.time
	ChangeTimeLeft()
	
func LeaveGame(nextMinigame):
	BetweenMinigamesUI.visible = true
	OnMinigamesUI.visible = false
	$BetweenMinigames/NextMinigame.text = str("Siguiente minijuego: ",nextMinigame)
	onMinigame=false

func ChangeScore(newScore):
	$BetweenMinigames/Score.text = str("Nota: ", newScore) 
	$BetweenMinigames/Aplazo.text = str("Aplazos\n",session.cantidadAplazos,"/",session.maxAplazos)

func ChangeTimeLeft():
	while(onMinigame):
		$OnMinigame/TimeLeft.text = str("Faltan:",minigameTime)
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		minigameTime-=1
	pass
