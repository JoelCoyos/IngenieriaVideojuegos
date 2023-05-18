extends Minigame

export (PackedScene) var Objetivo
onready var camara = get_node("Camera2D")
onready var limitR 
onready var limitD 
var t

	
func _ready():
	for i in range( 2):
		createElement(0)
	t = Timer.new()
	self.add_child(t)



func StartMinigame():
	print("Starting minigame")
	objectiveCleared=0
	SetDifficulty()
	print(difficulty)
	camara.limit_right = limitR
	for i in range(objectiveCount * 2):
		createElement(0)
	for i in range(objectiveCount ):
		createElement(1)
	
	t.set_wait_time(time)
	t.start()
	yield(t, "timeout")
	emit_signal("minigame_ended")
	pass
	

func createElement(est):
	var obs = Objetivo.instance()
	var pos=Vector2(GLOBAL.random(100,limitR)-100,GLOBAL.random(100,limitD)-100)
	add_child(obs)
	obs.position = pos
	obs.estado=est
	

func SetDifficulty():
	if(difficulty ==1):
		objectiveCount = 2
		limitR = 1500
		limitD = 600
		time = 20
	elif(difficulty == 2):
		objectiveCount = 3
		time = 20
		limitR = 1800
		limitD = 700
	elif(difficulty == 3):
		objectiveCount= 4
		time = 25
		limitR = 2400
		limitD = 800
	elif(difficulty == 4):
		objectiveCount = 4
		time = 30
		limitR = 2600
		limitD = 900
	elif(difficulty == 5):
		objectiveCount = 5
		time = 30
		limitR = 3000
		limitD = 1000
	pass

