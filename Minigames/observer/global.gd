extends Node
#UNICA ESCENA ,SINGLETORN

onready var score : int
onready var controlPtos : int
onready var minVel : int
onready var maxVel : int
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func random(min_number, max_number ):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)# 
	return random
