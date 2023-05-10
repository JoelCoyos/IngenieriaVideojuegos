extends Minigame

var t
var rng

var clothesDic = {}
var weather = ["sunny","rain","nieve","school","sports","party"]
var clothes = ["shirt","sunglasses","umbrella","jeans","capa","guantes","libro","computadora","lapiz","pelota","pesa","hockey","cotillon","lentes brillan","afro"]
var clothesArray

var currentWeather

func _init():
	pass

func _ready():
	t = Timer.new()
	self.add_child(t)
	clothesDic["sunglasses"] = ["head","sunny"]
	clothesDic["shirt"] = ["body","sunny"]
	clothesDic["umbrella"] = ["body","rain"]
	clothesArray = []
	pass

func _process(delta):
	pass

func StartMinigame():
	print("Starting minigame")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	objectiveCount=clothes.size()
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
	var weatherSprite = load("res://Minigames/Decorator/"+currentWeather+".png")
	$Weather.texture = weatherSprite
	pass

func AddSelectionClothes():
	var clothesShuffle = clothes.shuffle()
	for i in range(clothes.size()):
		var clotheScene = load("res://Minigames/Decorator/Clothes/"+clothes[i]+".tscn")
		var clothe = clotheScene.instance()
		clothe.position.x = 300 + 150*i
		clothe.position.y = 500
		clothe.clotheType = clothes[i]
		clothesArray.append(clothe)
		add_child(clothe)
	pass

func CheckClothes():
	for clothe in clothesArray:
		if(clothe.currentBodyPart.has(clothesDic[clothe.clotheType][0]) and clothesDic[clothe.clotheType][1] == currentWeather):
			objectiveCleared+=1
		elif(clothe.currentBodyPart == [] and clothesDic[clothe.clotheType][1]!=currentWeather):
			objectiveCleared+=1
	pass
	
func SetDifficulty():
	if(difficulty ==1):
		objectiveCount = 3
		time = 25
	elif(difficulty == 2):
		objectiveCount = 4
		time = 20
	elif(difficulty == 3):
		objectiveCount= 5
		time = 25
	elif(difficulty == 4):
		objectiveCount = 5
		time = 20
	elif(difficulty == 5):
		objectiveCount = 5
		time = 15
	pass
