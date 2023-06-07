extends Minigame


var t
var rng

var street_width
var street_height
var street = []
var car
var carPath
var carSpeed
var carStarted =false

var lastCarPosition
var carPosition
var carDirection

var crossScene
var canCross
var forcedContinue

var distanceCross = 240
var xStartingStreet = 125
var yStartingStreet = 50

var objetiveScene
var coneScene

var coneCount


func _init():
	pass

func _ready():
	controls = "Key"
	t = Timer.new()
	self.add_child(t)
	car = $CarPath/Car
	car.connect("getObjetive",self,"CarGetObjective")
	car.connect("crash",self,"CarCrash")
	carPath = $CarPath.curve
	rng = RandomNumberGenerator.new()
	crossScene = load("res://Minigames//State/Cross.tscn")
	objetiveScene = load("res://Minigames//State/Objective.tscn")
	coneScene = load("res://Minigames//State/Cone.tscn")
	pass

func _draw():
	#draw_polyline(carPath.get_points(),Color.red, 2.0)
	pass
	
func _process(delta):
	CarInput()
	if(car.position.distance_to(GetStreetPosition(carPosition))< 20 and car.on):
		forcedContinue = true
		canCross=false
		AddCarDirection(carDirection,false)
	elif(car.position.distance_to(GetStreetPosition(carPosition))< 150 and car.on):
		canCross = true
	else:
		canCross = false
	pass

func StartMinigame():
	print("Starting minigame")
	rng.randomize()
	SetDifficulty()
	t.set_wait_time(time)
	t.start()
	objectiveCleared=0
	car.speed = carSpeed
	SetStreet()
	AddObjetives()
	yield(t, "timeout")
	print("Minigame ended")
	emit_signal("minigame_ended")
	pass

func SetStreet():
	street_width=6
	street_height=4
	for x in street_width:
		street.append([])
		for y in street_height:
			street[x].append(null)
	for y in street_height:
		for x in street_width:
			var cross =  crossScene.instance()
			cross.position = Vector2(xStartingStreet + x*distanceCross,yStartingStreet+ y*distanceCross)
			add_child(cross)
			street[x][y] = cross
	carPosition = Vector2(2,2)
	car.position =  street[carPosition.x][carPosition.y].position
	carDirection= Vector2(0,-1)
	carPath.add_point(GetStreetPosition(carPosition))

	pass
	
func CarInput():
	var hasInput
	var turn=true
	if(carStarted == false):
		if(Input.is_action_just_pressed("ui_up")):
			hasInput=true
			carStarted = true
			turn = false
			carDirection = Vector2(0,-1)
		if(Input.is_action_just_pressed("ui_down")):
			hasInput=true
			carStarted = true
			turn = false
			carDirection = Vector2(0,1)
		if(Input.is_action_just_pressed("ui_left")):
			hasInput=true
			carStarted = true
			turn = false
			carDirection = Vector2(-1,0)
		if(Input.is_action_just_pressed("ui_right")):
			hasInput=true
			carStarted = true
			turn = false
			carDirection = Vector2(1,0)
	else:
		if(Input.is_action_just_pressed("ui_up")):
			hasInput=true
			turn = false
		elif(Input.is_action_just_pressed("ui_left") and canCross):
			hasInput=true
			if(carDirection == Vector2(0,-1)): #Up
				carDirection = Vector2(-1,0)
			elif(carDirection == Vector2(0,1)): #Down
				carDirection = Vector2(1,0)
			elif(carDirection == Vector2(1,0)): #Right
				carDirection = Vector2(0,-1)
			elif(carDirection == Vector2(-1,0)): #Left
				carDirection = Vector2(0,1)
		elif(Input.is_action_just_pressed("ui_right") and canCross):
			hasInput=true
			if(carDirection == Vector2(0,-1)): #Up
				carDirection = Vector2(1,0)
			elif(carDirection == Vector2(0,1)): #Down
				carDirection = Vector2(-1,0)
			elif(carDirection == Vector2(1,0)): #Right
				carDirection = Vector2(0,1)
			elif(carDirection == Vector2(-1,0)): #Left
				carDirection = Vector2(0,-1)
	if(hasInput):
		AddCarDirection(carDirection,turn)
		hasInput=false
		turn = false
	pass
	
func AddCarDirection(direction,turn):
	if(turn):
		car.newPath()
		lastCarPosition = carPosition
		carPosition = carPosition + direction
		carPath.clear_points()
		var P0 = car.position
		var P1 = GetStreetPosition(lastCarPosition)
		var P2 = P1
		var P3 = GetStreetPosition(carPosition)
		var control0 = P1 - P0
		var control1 = P2 - P3
		carPath.add_point(P0, Vector2.ZERO, control0)
		carPath.add_point(P3, control1, Vector2.ZERO)
	else:
		#carPath.clear_points()
		car.on = true
		lastCarPosition = carPosition
		var pos = carPosition+carDirection
		if(pos.x >= 0 and pos.y >= 0 and pos.x < street_width and pos.y < street_height):
			carPosition+= carDirection
		else:
			carPosition-= carDirection
			carDirection = -carDirection
		carPath.add_point(GetStreetPosition(carPosition))
	pass

func AddObjetives():
	for i in range(0,objectiveCount):
		rng.randomize()
		var xPosition = (rng.randi_range(0,street_width-3))*distanceCross + xStartingStreet
		var yPosition = rng.randi_range(0,street_height-3)*distanceCross + yStartingStreet
		if(rng.randi_range(0,1)==0):
			xPosition+= distanceCross/2
		else:
			yPosition+=distanceCross/2
		var objetive = objetiveScene.instance()
		objetive.position = Vector2(xPosition,yPosition)
		add_child(objetive)
	for i in range(0,coneCount):
		rng.randomize()
		var xPosition = (rng.randi_range(0,street_width-2))*distanceCross + xStartingStreet
		var yPosition = rng.randi_range(0,street_height-2)*distanceCross + yStartingStreet
		if(rng.randi_range(0,1)==0):
			xPosition+= distanceCross/2
		else:
			yPosition+=distanceCross/2
		var cone = coneScene.instance()
		cone.position = Vector2(xPosition,yPosition)
		add_child(cone)
	pass

func GetStreetPosition(pos):
	return street[pos.x][pos.y].position
	pass

func CarGetObjective():
	objectiveCleared+=1
	if(objectiveCleared==objectiveCount):
		emit_signal("minigame_ended")
	pass

func CarCrash():
	print("Crash")
	emit_signal("minigame_ended")
	pass
	
func SetDifficulty():
	if(difficulty ==1):
		objectiveCount = 2
		coneCount = 1
		time = 20
		carSpeed = 200
	elif(difficulty == 2):
		objectiveCount = 3
		coneCount = 2
		time = 15
		carSpeed = 250
	elif(difficulty == 3):
		objectiveCount= 4
		coneCount = 3
		time = 20
		carSpeed = 300
	elif(difficulty == 4):
		objectiveCount = 4
		coneCount = 4
		time = 15
		carSpeed = 400
	elif(difficulty == 5):
		objectiveCount = 5
		coneCount = 5
		time = 10
		carSpeed = 500
	pass
