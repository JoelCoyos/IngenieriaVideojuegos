extends Node2D
 
const pos1Sup = 250
const pos1Inf = 300
const pos2Sup = 350
const pos2Inf = 400
const pos3Sup = 450
const pos3Inf = 500
const pos4Sup = 550
const pos4Inf = 600

var score = 10
var posiciones={

	
}
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var datosArch={
	pos_rta_correc=0,
	cantPregunt=2}

var datPregunta={
	 pregunta="txt",
	 cantRTA=4,
	 rta1="rta1",
	 rta2="rta2",
	 rta3="rta3",
	 rta4="rta4"}



func _ready():
	cargar_pregunta("SINGLETON")


func cargar_pregunta(var patron):
	#var random = RandomNumberGenerator.new()
	var totP = 0 
	var cargar = File.new()
	if (!cargar.file_exists("res://Minigames/multipleChooise/preguntas/"+patron+".sav")):
		return #print de no hay partidas
	cargar.open("res://Minigames/multipleChooise/preguntas/"+patron+".sav", File.READ)
	datosArch=parse_json(cargar.get_line())
	
	print(datosArch)
	var value = datosArch.get("cantPreguntas")#de dictionary a integer
	if value != null:
		  totP = int(value)
	
	rng.randomize()
	var nroPregAzar = rng.randi_range(1,totP) 

	for i in range(nroPregAzar):
		cargar.get_line()
	
	var datoProvisorio = parse_json(cargar.get_line())
	if (datoProvisorio != null):
		datPregunta=datoProvisorio
	
	
	print(datPregunta)
	habButton(int(datoProvisorio.get("cantRTA")))
	cargaSCR(datPregunta)
	cargar.close()

func posAleator(vec,cantButton):
	var i=1
	var control 
	var aux
	while  i != cantButton+1 :
		control = 0
		aux = rng.randi_range(1,cantButton)#%cantButton
		for j in range (1,i):
			if vec[j] == aux: #//o sea que repite numero
				control = 1# y salgo del for
		if control == 0:
			vec[i]=aux
			i = i+1

func cargaSCR (datos):
	
	var vecPos=[1,2,3,4,5]
	
	$Label.text= datos.pregunta
	$Button1.text = datos.rta1
	$Button2.text = datos.rta2
	if int(datos.get("cantRTA")) == 2:

		posAleator(vecPos,2)
		changePositio("button1",vecPos[1])
		changePositio("button2",vecPos[2])
		
	elif int(datos.get("cantRTA")) == 3:

		$Button3.text = datos.rta3
		
		posAleator(vecPos,3)
		changePositio("button1",vecPos[1])
		changePositio("button2",vecPos[2])
		changePositio("button3",vecPos[3])
	elif int(datos.get("cantRTA")) == 4:

		$Button3.text = datos.rta3
		$Button4.text = datos.rta4
		
		posAleator(vecPos,4)
		changePositio("button1",vecPos[1])
		changePositio("button2",vecPos[2])	
		changePositio("button3",vecPos[3])
		changePositio("button4",vecPos[4])


func habButton(cant):
	if cant == 3:
		$Button3.visible = true
	elif cant == 4:
		$Button3.visible = true
		$Button4.visible = true
		

func changePositio(bott,pos):
	if bott == "button1":
		match (pos):
			1:
				$Button1.margin_top = pos1Sup
				$Button1.margin_bottom = pos1Inf
			2:
				$Button1.margin_top = pos2Sup
				$Button1.margin_bottom = pos2Inf
			3:
				$Button1.margin_top = pos3Sup
				$Button1.margin_bottom = pos3Inf
			4:
				$Button1.margin_top = pos4Sup
				$Button1.margin_bottom = pos4Inf
	elif bott == "button2":
		match (pos):
			1:
				$Button2.margin_top = pos1Sup
				$Button2.margin_bottom = pos1Inf
			2:
				$Button2.margin_top = pos2Sup
				$Button2.margin_bottom = pos2Inf
			3:
				$Button2.margin_top = pos3Sup
				$Button2.margin_bottom = pos3Inf
			4:
				$Button2.margin_top = pos4Sup
				$Button2.margin_bottom = pos4Inf
	elif bott == "button3":
		match (pos):
			1:
				$Button3.margin_top = pos1Sup
				$Button3.margin_bottom = pos1Inf
			2:
				$Button3.margin_top = pos2Sup
				$Button3.margin_bottom = pos2Inf
			3:
				$Button3.margin_top = pos3Sup
				$Button3.margin_bottom = pos3Inf
			4:
				$Button3.margin_top = pos4Sup
				$Button3.margin_bottom = pos4Inf
	elif bott == "button4":
		match (pos):
			1:
				$Button4.margin_top = pos1Sup
				$Button4.margin_bottom = pos1Inf
			2:
				$Button4.margin_top = pos2Sup
				$Button4.margin_bottom = pos2Inf
			3:
				$Button4.margin_top = pos3Sup
				$Button4.margin_bottom = pos3Inf
			4:
				$Button4.margin_top = pos4Sup
				$Button4.margin_bottom = pos4Inf


func _on_Button1_pressed(datos):
	if datos.pos_rta_correc == 1:
		score += 10


func _on_Button2_pressed(datos):
	if datos.pos_rta_correc == 2:
		score += 10


func _on_Button3_pressed(datos):
	if datos.pos_rta_correc == 3:
		score += 10


func _on_Button4_pressed(datos):
	if datos.pos_rta_correc == 4:
		score += 10
