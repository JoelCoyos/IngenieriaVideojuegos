extends Node2D

var rng
var levels = ["Decorator","Factory","Iterator","MVC","Observer","Singleton","State","Templete"]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	pass # Replace with function body.

func SelectMinigame():
	return levels[rng.randi_range(0,levels.size()-1)]
	pass

func SelectRoundMinigames():
	rng.randomize()
	for i in range(levels.size()):
		var auxint = rng.randi() % levels.size()
		var aux = levels[auxint]
		levels[auxint] = levels[i]
		levels[i] = aux
	return levels.slice(0,4)
