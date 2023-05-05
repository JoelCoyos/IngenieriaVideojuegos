extends Node2D

export (PackedScene) var Objetivo
onready var camara = get_node("Camera2D")
onready var limitR = 3000#dependiendo la dificultad que tan grandde sea el mapa
onready var limitD = 1000
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var cantEnemi

func random(min_number, max_number ):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)# 
	return random
	
func _ready():
	cantEnemi = 5
	camara.limit_right = limitR
	for i in range(cantEnemi):
		createEnemy()

func createEnemy():
	var obs = Objetivo.instance()
	var pos=Vector2(random(100,limitR)-100,random(100,limitD)-100)
	add_child(obs)
	obs.position = pos
