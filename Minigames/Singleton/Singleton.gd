extends Minigame

export (PackedScene) var Objetivo
onready var camara
onready var limitR = 2500
onready var limitD =1000
var t
var enemigos = 6
var aliados = 6

#los limites de la camara no me deja crearlos/modificarlos luego de instanciar
	
func _ready():
	t = Timer.new()
	objectiveCleared=0
	camara = GLOBAL.camara
	camara.current = true
	self.add_child(t)
	SetDifficulty()
	elemenScene()
	
func _process(delta):
	if(camara.position.distance_to($Character.position) > 150 ):
		camara.position = lerp(camara.position,$Character.position,1*delta)
	pass

func elemenScene():
	for i in range(enemigos):
		createElement(0)
		print("dd00")
	for i in range(aliados -1):
		createElement(1)
		print("d11d")
 
func StartMinigame():
	print("Starting minigame")
	SetDifficulty()
	camara.limit_right = limitR
	camara.limit_left = -100
	camara.limit_bottom = limitD
	camara.limit_top = -100
	t.set_wait_time(time)
	t.start()
	yield(t, "timeout")
	emit_signal("minigame_ended")
	pass
	

func createElement(est):
	var obs = Objetivo.instance()
	obs.connect("GetAliado",self,"GetAliado")
	obs.connect("GetEnemigo",self,"GetEnemigo")
	var pos=Vector2(GLOBAL.random(100,limitR)-100,GLOBAL.random(100,limitD)-100)
	add_child(obs)
	obs.position = pos
	obs.definirIMG(est)
	
func GetAliado():
	objectiveCleared+=1
	if(objectiveCleared==objectiveCount):
		emit_signal("minigame_ended")
	pass

func GetEnemigo():
	emit_signal("minigame_ended")

func SetDifficulty():
	if(difficulty ==1):
		objectiveCount = 5
		time = 20
		aliados = objectiveCount
		enemigos = objectiveCount

	elif(difficulty == 2):
		objectiveCount = 8
		time = 20
		aliados = objectiveCount
		enemigos = objectiveCount +5

	elif(difficulty == 3):
		objectiveCount= 10
		time = 25
		aliados = objectiveCount
		enemigos = objectiveCount

	elif(difficulty == 4):
		objectiveCount = 13
		time = 25
		aliados = objectiveCount
		enemigos = objectiveCount+5

	elif(difficulty == 5):
		objectiveCount = 15
		time = 30
		aliados = objectiveCount
		enemigos = objectiveCount+6

	pass
