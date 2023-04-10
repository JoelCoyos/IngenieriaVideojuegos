extends Minigame


var t
var rng

var street_width
var street_height
var street = []
var car
var carPath

var lastCarPosition
var carPosition
var carDirection

var crossScene
var canCross
var forcedContinue

func _init():
	pass

func _ready():
	t = Timer.new()
	self.add_child(t)
	car = $CarPath/Car
	carPath = $CarPath.curve
	rng = RandomNumberGenerator.new()
	crossScene = load("res://Minigames//State/Cross.tscn")
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
	t.set_wait_time(100)
	t.start()
	SetStreet()
	yield(t, "timeout")
	print("Minigame ended")
	emit_signal("minigame_ended")
	pass

func SetStreet():
	street_width=10
	street_height=10
	for y in street_width:
		street.append([])
		for x in street_height:
			street[y].append(null)
	for y in street_width:
		for x in street_height:
			var cross =  crossScene.instance()
			cross.position = Vector2(300+x*200,50+y*200)
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
		carPosition+= carDirection
		print(lastCarPosition)
		print(carPosition)
		carPath.add_point(GetStreetPosition(carPosition))
	
	pass

func GetStreetPosition(pos):
	return street[pos.x][pos.y].position
	pass

