extends Minigame

export (PackedScene) var Objetivo
onready var camara = get_node("Camera2D")
onready var limitR = 3000#dependiendo la dificultad que tan grandde sea el mapa
onready var limitD = 1000
var cantEnemi
var t

	
func _ready():
	cantEnemi = 5
	camara.limit_right = limitR
	for i in range(cantEnemi):
		createEnemy()
	t = Timer.new()
	self.add_child(t)



func StartMinigame():
	print("Starting minigame")
	objectiveCount=3
	objectiveCleared=0
	time = 20
	t.set_wait_time(time)
	t.start()
	yield(t, "timeout")
	emit_signal("minigame_ended")
	pass
	

func createEnemy():
	var obs = Objetivo.instance()
	var pos=Vector2(GLOBAL.random(100,limitR)-100,GLOBAL.random(100,limitD)-100)
	add_child(obs)
	obs.position = pos
