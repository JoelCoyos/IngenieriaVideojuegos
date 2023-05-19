extends Minigame

export (PackedScene) var Objetivo
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var t
var cantiEnemigos = 5

func _ready():
	$personaje.agregar_a($gomera)
	for i in range(cantiEnemigos):
		createEnemy()
	$Area2D.asignarVal(1)
	$Area2D2.asignarVal(2)
	$Area2D3.asignarVal(3)
	t = Timer.new()
	self.add_child(t)



func random(min_number, max_number ):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)# 
	return random


func createEnemy():
	var obs = Objetivo.instance()
	var pos=Vector2(random(10,2000),random(800,900))# si cordena y la pongo por debajo del suelo del tile se caen os objetis
	add_child(obs)
	obs.position = pos
	obs.codActual=rng.randi()%3


func StartMinigame():
	print("Starting minigame")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	objectiveCleared=0

	t.set_wait_time(time)
	t.start()
	SetDifficulty()
	yield(t, "timeout")
	emit_signal("minigame_ended")
	pass
	

func SetDifficulty():#el objetivos logrados incrementa si coincide la bala con el objeto
	if(difficulty ==1):
		objectiveCount = 5
		time = 20
		cantiEnemigos = objectiveCount + 5

	elif(difficulty == 2):
		objectiveCount = 8
		cantiEnemigos = objectiveCount +2
		time = 20

	elif(difficulty == 3):
		objectiveCount= 8
		time = 25
		cantiEnemigos = objectiveCount + 8

	elif(difficulty == 4):
		objectiveCount = 10
		time = 25
		cantiEnemigos = objectiveCount +2

	elif(difficulty == 5):
		objectiveCount = 15
		time = 30
		cantiEnemigos = objectiveCount +2

	pass
