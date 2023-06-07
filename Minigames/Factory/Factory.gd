extends Minigame
var t
var timerElements


var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var speed
var numberElements
var elementsValidated

var changeShapeElements = []
var changeColorElements = []
var changeBkgElements = []

export(Texture) var circleGray
export(Texture) var helmetGray
export(Texture) var mannedGray

export(Texture) var background1
export(Texture) var background2
export(Texture) var background3

export(PackedScene) var elementScene

enum Colors {blue,green,yellow}
enum Shapes {circle,helmet,manned}
enum Background {desert,jungle,factory}

func _ready():
	controls = "Mouse"
	randomize()
	t = Timer.new()
	timerElements = Timer.new()
	add_child(t)
	add_child(timerElements)
	objectiveCleared=0
	elementsValidated = 0
	pass

func StartMinigame():
	print("Starting minigame")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	SetDifficulty()
	SpawnElements()
	t.set_wait_time(time)
	t.start()
	yield(t, "timeout")
	emit_signal("minigame_ended")
	pass

func SpawnElements():
	var xPositions = []
	for i in range(0,numberElements):
		xPositions.append(GLOBAL.SuperAlgoritmoJoel(i,numberElements,800/numberElements)-300)
	xPositions.shuffle()
	for i in range(0,numberElements):
		var expectedColor = rng.randi_range(0,Colors.size()-1)
		var expectedShape = rng.randi_range(0,Shapes.size()-1)
		var expectedBackground = rng.randi_range(0,Background.size()-1)
		var element = elementScene.instance()
		element.position = Vector2(xPositions[i],0)
		element.speed = speed
		element.expectedColor = expectedColor
		element.expectedShape = expectedShape
		element.expectedBackground = expectedBackground
		add_child(element)
		var expectedElement = elementScene.instance()
		expectedElement.position = Vector2(-100,0)
		expectedElement.speed = speed
		expectedElement.ChangeColor(GetColor(expectedColor))
		expectedElement.ChangeShape(GetShapeTexture(expectedShape))
		expectedElement.ChangeBackground(GetBackgroundTexture(expectedBackground))
		add_child(expectedElement)
		timerElements.set_wait_time(rng.randi_range(3,5))
		timerElements.start()
		yield(timerElements,"timeout")
	pass

func SetDifficulty():
	if(difficulty ==1):
		numberElements = 1
		time = 20
		speed = 50

	elif(difficulty == 2):
		numberElements = 2
		time = 20
		speed = 70

	elif(difficulty == 3):
		numberElements= 3
		time = 25
		speed = 80

	elif(difficulty == 4):
		numberElements = 4
		time = 25
		speed = 80

	elif(difficulty == 5):
		numberElements = 5
		time = 30
		speed = 80
	objectiveCount = numberElements*3
	pass

func ChangeColor_body_entered(body):
	changeColorElements.append(body)
	pass # Replace with function body.


func ChangeColorArea_body_exited(body):
	changeColorElements.erase(body)
	pass # Replace with function body.


func ChangeShapeArea_body_entered(body):
	changeShapeElements.append(body)
	pass # Replace with function body.


func ChangeShapeArea_body_exited(body):
	changeShapeElements.erase(body)
	pass # Replace with function body.


func _ChangeBkgArea_body_entered(body):
	changeBkgElements.append(body)
	pass


func _ChangeBkgArea_body_exited(body):
	changeBkgElements.erase(body)
	pass 

func _on_ChangeBlueButton_pressed():
	for element in changeColorElements:
		element.ChangeColor(GetColor(Colors.blue))
		element.color = Colors.blue
	pass

func _on_ChangeGreenButton_pressed():
	for element in changeColorElements:
		element.ChangeColor(GetColor(Colors.green))
		element.color = Colors.green
	pass

func _on_ChangeYellowButton_pressed():
	for element in changeColorElements:
		element.ChangeColor(GetColor(Colors.yellow))
		element.color = Colors.yellow
	pass

func _on_ChangeShape1Button_pressed():
	for element in changeShapeElements:
		element.ChangeShape(GetShapeTexture(Shapes.circle))
		element.shape = Shapes.circle
	pass

func _on_ChangeShape2Button_pressed():
	for element in changeShapeElements:
		element.ChangeShape(GetShapeTexture(Shapes.helmet))
		element.shape = Shapes.helmet
	pass

func _on_ChangeShape3Button_pressed():
	for element in changeShapeElements:
		element.ChangeShape(GetShapeTexture(Shapes.manned))
		element.shape = Shapes.manned
	pass

func _on_ChangeBkg1Button_pressed():
	for element in changeBkgElements:
		element.ChangeBackground(GetBackgroundTexture(Background.desert))
		element.background = Background.desert
	pass

func _on_ChangeBkg2Button_pressed():
	for element in changeBkgElements:
		element.ChangeBackground(GetBackgroundTexture(Background.jungle))
		element.background = Background.jungle
	pass

func _on_ChangeBkg3Button_pressed():
	for element in changeBkgElements:
		element.ChangeBackground(GetBackgroundTexture(Background.factory))
		element.background = Background.factory
	pass


func Validation_Area_body_entered(body):
	if(body.expectedColor == body.color):
		objectiveCleared+=1
	if(body.expectedShape == body.shape):
		objectiveCleared+=1
	if(body.expectedBackground == body.background):
		objectiveCleared+=1
	elementsValidated+=1
	if(elementsValidated == numberElements):
		timerElements.set_wait_time(2)
		timerElements.start()
		yield(timerElements,"timeout")
		emit_signal("minigame_ended")
	pass

func GetColor(color):
	if(color == Colors.blue):
		return "blue"
	elif(color == Colors.green):
		return "green"
	if(color == Colors.yellow):
		return "yellow"

func GetShapeTexture(shape):
	if(shape == Shapes.circle):
		return circleGray
	elif(shape == Shapes.manned):
		return mannedGray
	elif(shape == Shapes.helmet):
		return helmetGray

func GetBackgroundTexture(background):
	if(background == Background.desert):
		return background1
	elif(background == Background.jungle):
		return background2
	elif(background == Background.factory):
		return background3
