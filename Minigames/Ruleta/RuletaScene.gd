extends Node2D

#agregar aletoriedad en velo
#ver por que tarda tanto en la primer tirada
#vector con preguntas 


var rondaRuleta = 10
var rondaActual = 0
var velRuleta = 60# porcentaje
var dispLanzarRuleta = false
var _rate = 40
var _selected_area = null
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var ptj = 0
var arrayPreguntas = []

func random(min_number, max_number ):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)# 
	return random
	
#array.size
func _ready():
		arrayPreguntas=leer()


func leer():
	var file = File.new()
	file.open("res://Minigames/Ruleta/preg.txt", File.READ)
	var preguntasTXT = []
	var totalPreguntas = file.get_line()
	for i in range(totalPreguntas):
		preguntasTXT.append(file.get_line())
	file.close()
	return preguntasTXT

func _process(delta: float):
	if dispLanzarRuleta:
		if velRuleta > 0 and $Timer.is_stopped():
			velRuleta -= 2
		if velRuleta > 0:
			_speed_up_roullete(delta)


func desRespuesta():
	if _selected_area != null:
		if str(_selected_area.name) == 'Area2D'  || _selected_area.name == 'Area2D5' || _selected_area.name == 'Area2D7' || _selected_area.name == 'Area2D9' || _selected_area.name == 'Area2D11' :
			ptj +=10
		else:
			ptj -=5
		print(ptj)
		print(str(_selected_area.name))#el txt deberia tener verdad en lo par y falso en lo impar
		

func _speed_up_roullete(delta: float):
	$SpriteRuleta.rotation_degrees += velRuleta #* delta


func _on_Button_pressed():
	velRuleta = random(80,120)
	$Button.text='tirar de nuevo'
	_start_roullete()



func _start_roullete():
	
	for node in $SpriteRuleta.get_children():
		for child in node.get_children():
			child.disabled = false
		#node.CollisionPolygon2D.disabled = false
		
	dispLanzarRuleta = true
	$Button.visible = false
	$ButtonAceptar.visible = false
	$Timer.start()
	$Label.text=str(arrayPreguntas[random(1,arrayPreguntas.size())])


func _on_Timer_timeout():
	rondaActual += 1
	velRuleta = velRuleta - (_rate * velRuleta) / 100
	if rondaActual >= rondaRuleta:
		$Timer.stop()
		print("Area ganadora: ", _selected_area.name)
		$Button.visible = true
		$ButtonAceptar.visible = true




func _on_AreaManecilla_area_entered(area: Area2D):
	_selected_area = area


func _on_ButtonAceptar_pressed():
	desRespuesta()
	$ButtonAceptar.visible = false#cambio de escena
