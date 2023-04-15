extends Minigame

var t
var rng

var clothesDic = {}
var weather = ["sunny","rain"]
var clothes = ["shirt","sunglasses","umbrella"]

var currentWeather

func _init():
	pass

func _ready():
	t = Timer.new()
	self.add_child(t)
	clothesDic["sunglasses"] = ["head","sunny"]
	clothesDic["shirt"] = ["body","sunny"]
	clothesDic["umbrella"] = ["body","rain"]
	pass

func _process(delta):
	pass

func StartMinigame():
	print("Starting minigame")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	objectiveCount=clothes.size()
	time = 10
	t.set_wait_time(time)
	t.start()
	SetWeather()
	AddSelectionClothes()
	yield(t, "timeout")
	print("Minigame ended")
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
		clothe.clothe = clothes[i]
		clothe.connect("putClothe",self,"HasSelectedClothe")
		add_child(clothe)
	pass

func HasSelectedClothe(clothe,bodyPart):
	if(clothesDic[clothe][0] ==bodyPart and clothesDic[clothe][1] == currentWeather):
		objectiveCleared+=1
	else:
		print("mal")
	pass
