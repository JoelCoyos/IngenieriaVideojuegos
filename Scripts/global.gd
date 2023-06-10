extends Node
#UNICA ESCENA ,SINGLETORN

onready var coins : int
onready var maxScore : int
onready var seenIntro : bool
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var camara


var datosPartida = {
	coins = 0,
	maxScore = 0,
	seenIntro = false
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
	datos_guardar.coins = coins
	datos_guardar.maxScore = maxScore
	datos_guardar.seenIntro = seenIntro
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
	
	coins = datos_cargar.coins
	maxScore = datos_cargar.maxScore
	seenIntro = datos_cargar.seenIntro
	
func SuperAlgoritmoJoel(var position,var totalCant,distance):
	var aux
	if(totalCant%2 == 0):
		aux = 640 - ((totalCant)/2-0.5)*distance
	else:
		aux = 640 - ((totalCant-1)/2)*distance
	return aux + distance*position
	pass
	
