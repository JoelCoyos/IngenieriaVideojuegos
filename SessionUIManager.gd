extends Node2D

var BetweenMinigamesUI
var OnMinigamesUI

var onMinigame

var minigameTime

var t
# Called when the node enters the scene tree for the first time.
func _ready():
	t = Timer.new()
	self.add_child(t)
	
	BetweenMinigamesUI = $BetweenMinigames
	OnMinigamesUI = $OnMinigame
	pass # Replace with function body.


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
	$BetweenMinigames/Score.text = str("Puntuacion: ", newScore) 
func ChangeTimeLeft():
	while(onMinigame):
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		$OnMinigame/TimeLeft.text = str("Faltan:",minigameTime)
		minigameTime-=1
	pass
