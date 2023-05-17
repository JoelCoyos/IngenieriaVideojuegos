extends Node2D

var ruleta
var selectedNumber
var rng

signal endRoulette

enum RotationDirections {
	CLOCKWISE = 1,
	COUNTERCLOCKWISE = -1
}

enum TiposBeneficios {MONEDAS,NOTA,APLAZO}

var BeneficiosLista = [[TiposBeneficios.MONEDAS,0.5],[TiposBeneficios.MONEDAS,1.5],
[TiposBeneficios.MONEDAS,2],[TiposBeneficios.NOTA,0.5],[TiposBeneficios.NOTA,1.5]
,[TiposBeneficios.NOTA,2],[TiposBeneficios.APLAZO,-1],[TiposBeneficios.APLAZO,-2]]

var Beneficios = []
var textosRuleta = []
var beneficio

var tween

var distance
 
export(RotationDirections) var rotation_direction = RotationDirections.CLOCKWISE
export(int) var revolutions = 10
export(float) var spin_time = 5
export(float) var target_rotation = 15

func _ready():
	ruleta = $SpriteRuleta
	tween = create_tween()
	rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(0,12):
		Beneficios.append(get_random(BeneficiosLista))
		var text
		if(Beneficios[i][0]==TiposBeneficios.MONEDAS):
			text = "MONEDAS"
		if(Beneficios[i][0]==TiposBeneficios.NOTA):
			text = "NOTA"
		if(Beneficios[i][0]==TiposBeneficios.APLAZO):
			text = "APLAZO"
		text = str(text," x ",Beneficios[i][1])
		get_node(str("SpriteRuleta/",i+1,"/RichTextLabel")).text = text
	pass

func create_tween():
	var t = Tween.new()
	add_child(t)
	return t

func spinRoulette(target_rotation):
	tween.interpolate_property(
		ruleta,
		"rotation_degrees",
		ruleta.rotation,
		target_rotation + revolutions * rotation_direction*360,
		spin_time,
		Tween.TRANS_QUART,
		Tween.EASE_OUT
	)
	tween.start()
	#yield(tween,"finished")
	var timer = $Timer
	timer.set_wait_time(spin_time +2)
	timer.start()
	yield(timer,"timeout")
	emit_signal("endRoulette")



func _on_Button_pressed():
	var number = rng.randi_range(0,12)
	beneficio = Beneficios[number]
	print(number+1)
	spinRoulette(-15-30*number)
	pass # Replace with function body.

func get_random(a):
   a = a[randi() % a.size()]
   return a
