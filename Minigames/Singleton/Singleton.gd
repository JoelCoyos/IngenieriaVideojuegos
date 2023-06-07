extends Minigame

export (PackedScene) var Objetivo
export (Array,Texture) var Shapes
var possibleColors = [Color8(255,0,0),Color8(0,255,0),Color8(0,0,255),Color8(255,255,255)]
var singletonShape
var singletonColor
var rng

onready var camara
onready var limitR = 2500
onready var limitD =1000
var t
var enemigos = 6
var aliados = 6

#los limites de la camara no me deja crearlos/modificarlos luego de instanciar
	
func _ready():
	controls = "Mouse"
	t = Timer.new()
	rng = RandomNumberGenerator.new()
	rng.randomize()
	objectiveCleared=0
	camara = GLOBAL.camara
	camara.current = true
	self.add_child(t)

	
func _process(delta):
	if(camara.position.distance_to($Character.position) > 150 ):
		camara.position = lerp(camara.position,$Character.position,1*delta)
	pass

func elemenScene():
	for i in range(enemigos):
		createElement(0)
	for i in range(aliados):
		createElement(1)
 
func StartMinigame():
	print("Starting minigame")
	SetDifficulty()
	singletonShape = Shapes[rng.randi_range(0,Shapes.size()-1)]
	singletonColor =  possibleColors[rng.randi_range(0,possibleColors.size()-1)]
	Shapes.erase(singletonShape)
	elemenScene()
	camara.limit_right = limitR
	camara.limit_left = -100
	camara.limit_bottom = limitD
	camara.limit_top = -100
	$Character.SetTexture(singletonShape)
	$Character.SetColor(singletonColor)
	t.set_wait_time(time)
	t.start()
	yield(t, "timeout")
	emit_signal("minigame_ended")
	pass

func createElement(est):
	var obs = Objetivo.instance()
	obs.connect("GetAliado",self,"GetAliado")
	obs.connect("GetEnemigo",self,"GetEnemigo")
	if(est == 0 ):
		obs.SetTexture(Shapes[rng.randi_range(0,Shapes.size()-1)])
		obs.SetColor(possibleColors[rng.randi_range(0,possibleColors.size()-1)])
	if(est == 1 ):
		obs.SetTexture(singletonShape)
		obs.SetColor(singletonColor)
	var pos=Vector2(GLOBAL.random(100,limitR)-100,GLOBAL.random(100,limitD)-100)
	add_child(obs)
	obs.position = pos
	obs.estado = est
	
func GetAliado():
	objectiveCleared+=1
	if(objectiveCleared==objectiveCount):
		emit_signal("minigame_ended")
	pass

func GetEnemigo():
	emit_signal("minigame_ended")

func SetDifficulty():
	if(difficulty ==1):
		objectiveCount = 3
		time = 20
		aliados = objectiveCount
		enemigos = objectiveCount

	elif(difficulty == 2):
		objectiveCount = 4
		time = 20
		aliados = objectiveCount
		enemigos = objectiveCount +5

	elif(difficulty == 3):
		objectiveCount= 5
		time = 25
		aliados = objectiveCount
		enemigos = objectiveCount

	elif(difficulty == 4):
		objectiveCount = 6
		time = 25
		aliados = objectiveCount
		enemigos = objectiveCount+5

	elif(difficulty == 5):
		objectiveCount = 7
		time = 30
		aliados = objectiveCount
		enemigos = objectiveCount+6

	pass
