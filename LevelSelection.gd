extends Node2D

var rng
var levels = ["Templete"]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	pass # Replace with function body.

func SelectMinigame():
	return levels[rng.randi_range(0,levels.size()-1)]
	pass
