extends Minigame

var t
var rng

var clothesDic = {}
var statesDic = {}
var weather = ["sunny","rain","school","sports","party"]
var clothes = ["shirt","sunglasses","umbrella","jeans","gloves","book","laptop","pencil","ball","soccershoes","hockey","confetti","beer"]
var clothesArray

var currentWeather


func _init():
	pass

func _ready():
	t = Timer.new()
	self.add_child(t)
	clothesDic["sunglasses"] = "head"
	clothesDic["shirt"] ="body"
	clothesDic["umbrella"] = "body"
	clothesDic["jeans"] ="legs"
	clothesDic["gloves"] = "body"
	clothesDic["book"] = "body"
	clothesDic["laptop"] = "body"
	clothesDic["pencil"] = "body"
	clothesDic["ball"] = "legs"
	clothesDic["soccershoes"] = "legs"
	clothesDic["hockey"] = "body"
	clothesDic["confetti"] = "body"
	clothesDic["beer"] = "body"
	statesDic["sunny"] = ["sunglasses","shirt"]
	statesDic["rain"] = ["umbrella","jeans","gloves"]
	statesDic["school"] = ["laptop","pencil"]
	statesDic["sports"] = ["ball","soccershoes","hockey"]
	statesDic["party"] = ["confetti","beer"]
	clothesArray = []
	pass

func _process(delta):
	pass

func StartMinigame():
	print("Starting minigame")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	SetDifficulty()
	objectiveCleared=0
	time = 10
	t.set_wait_time(time)
	t.start()
	SetWeather()
	AddSelectionClothes()
	yield(t, "timeout")
	CheckClothes()
	emit_signal("minigame_ended")
	pass
	
func SetWeather():
	currentWeather = weather[rng.randi_range(0,weather.size())-1]
	var stateScene = load("res://Minigames/Decorator/States/"+currentWeather+".tscn")
	var state = stateScene.instance()
	add_child(state)
	state.position = $Man.position + Vector2(500,-200)
	pass

func AddSelectionClothes():
	var selectedClothes = []
	var obligatoryClothe = statesDic[currentWeather][rng.randi_range(0,statesDic[currentWeather].size()-1)]
	selectedClothes.append(obligatoryClothe)
	var auxClothes = clothes
	auxClothes.erase(obligatoryClothe)
	auxClothes.shuffle()
	auxClothes = auxClothes.slice(0,objectiveCount-2)
	selectedClothes.append_array(auxClothes)
	selectedClothes.shuffle()
	for i in range(objectiveCount):
		var clotheScene = load("res://Minigames/Decorator/Clothes/"+selectedClothes[i]+".tscn")
		var clothe = clotheScene.instance()
		clothe.position.x = GLOBAL.SuperAlgoritmoJoel(i,objectiveCount,150)
		clothe.position.y = 600
		clothe.clotheType = selectedClothes[i]
		clothesArray.append(clothe)
		add_child(clothe)
	pass


func CheckClothes():
	for clothe in clothesArray:
		if(clothe.currentBodyPart.has(clothesDic[clothe.clotheType]) and statesDic[currentWeather].has(clothe.clotheType)):
			objectiveCleared+=1
		elif(clothe.currentBodyPart == [] and !statesDic[currentWeather].has(clothe.clotheType)):
			objectiveCleared+=1
	pass
	
func SetDifficulty():
	if(difficulty ==1):
		objectiveCount = 3
		time = 10
	elif(difficulty == 2):
		objectiveCount = 4
		time = 10
	elif(difficulty == 3):
		objectiveCount= 5
		time = 10
	elif(difficulty == 4):
		objectiveCount = 5
		time = 15
	elif(difficulty == 5):
		objectiveCount = 5
		time = 15
	pass
