extends Node2D

export (PackedScene) var Objetivo
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()


func _ready():
	$personaje.agregar_a($gomera)
	for i in range(10):
		createEnemy()
	$Area2D.asignarVal(1)
	$Area2D2.asignarVal(2)
	$Area2D3.asignarVal(3)
	


func random(min_number, max_number ):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)# 
	return random


func createEnemy():
	var obs = Objetivo.instance()
	var pos=Vector2(random(10,2000),random(800,900))# si cordena y la pongo por debajo del suelo del tile se caen os objetis
	add_child(obs)
	obs.position = pos
	obs.codActual=rng.randi()%3

