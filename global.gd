extends Node
#UNICA ESCENA ,SINGLETORN

onready var score : int
onready var controlPtos : int
onready var minVel : int
onready var maxVel : int
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var camara


var datosPartida = {
	score = 0,
	controlPos = 0,
	pos_x = 0.0,
	pos_y=0.0
}


func _ready():
	var path = Directory.new()
	if (!path.dir_exists("res://assets/menu/savArch")):
		path.open("res://assets/menu")
		path.make_dir("res://assets/menu/savArch")
		
func random(min_number, max_number ):
	rng.randomize()
	var random = rng.randi_range(min_number, max_number)# 
	return random
#f5 y f7 para gurardar y cargar

func guardar_partida(var nro):#para tener varios arcjivos
	var save = File.new()
	save.open("res://assets/menu/savArch/"+String(nro)+".sav", File.WRITE)
	
	var datos_guardar = datosPartida
	datos_guardar.score = score
	datos_guardar.controlPos = controlPtos
	datos_guardar.pos_x = get_tree().get_nodes_in_group("player")[0].global_position.x#no puede con vector 2
	datos_guardar.pos_y = get_tree().get_nodes_in_group("player")[0].global_position.y
	
	save.store_line(to_json(datos_guardar))
	save.close()
	
func cargar_partida(var nro):
	var cargar = File.new()
	if (!cargar.file_exists("res://assets/menu/savArch/"+String(nro)+".sav")):
		return #print de no hay partidas
	cargar.open("res://assets/menu/savArch/"+String(nro)+".sav", File.READ)
	
	var datos_cargar = datosPartida
	
	while (!cargar.eof_reached()):
		var datoProvisorio = parse_json(cargar.get_line())
		if (datoProvisorio != null):
			datos_cargar=datoProvisorio
	cargar.close()
	
	score = datos_cargar.score
	controlPtos = datos_cargar.controlPos
	get_tree().get_nodes_in_group("player")[0].global_position.x = datos_cargar.pos_x
	get_tree().get_nodes_in_group("player")[0].global_position.y = datos_cargar.pos_y
	
	
func SuperAlgoritmoJoel(var position,var totalCant,distance):
	var aux
	if(totalCant%2 == 0):
		aux = 640 - ((totalCant)/2-0.5)*distance
	else:
		aux = 640 - ((totalCant-1)/2)*distance
	return aux + distance*position
	pass
	
