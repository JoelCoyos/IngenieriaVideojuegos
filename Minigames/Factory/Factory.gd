extends Minigame
# al integra hacer un auto load para los aleatorios
export (PackedScene) var elemento
export (PackedScene) var sprResultado

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var inicio = 0
var posArea1 = 0
var posArea2 = 0
var posArea3 = 0
var validacion = -1

var valCajaACT = 0
var arrayResultados = []
var score = 0

var valorCaja = {
	caja1 = 0,
	caja2 = 0,
	caja3 = 0
}


func _ready():
	randomize()
	$elementTimer.start()

func _physics_process(delta):
	$Label2.text=str(score)



func StartMinigame():
	print("Starting minigame")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	objectiveCount=1
	objectiveCleared=0
	emit_signal("minigame_ended")
	pass
#con el timer no puede haber mas de un elemto por area
#guardarle valores aleatorios 

#avanzar un contador para validar

#ver number Attack para la dificultad

##pierdo la referencia del array de nodos
func random(min_number, max_number ):
	rng.randomize()
	var random = rng.randi_range(min_number, max_number)# 
	return random
	
func salida_buscada(pos):
	var salUno = random(1,3)
	var salDos = random(1,3)
	var salTres = random(1,3)
	get_tree().get_nodes_in_group("elemento")[pos].valPretendido.caja1 = salUno
	get_tree().get_nodes_in_group("elemento")[pos].valPretendido.caja2 = salDos
	get_tree().get_nodes_in_group("elemento")[pos].valPretendido.caja3 = salTres
	
	get_tree().get_nodes_in_group("resBuscado")[pos].valBuscado.caja1 = salUno
	get_tree().get_nodes_in_group("resBuscado")[pos].valBuscado.caja2 = salDos
	get_tree().get_nodes_in_group("resBuscado")[pos].valBuscado.caja3 = salTres
	
	#$HBoxContainer/Label2.text=str(get_tree().get_nodes_in_group("elemento")[con].valPretendido.caja1)
	


func _on_elementTimer_timeout():
	get_node("Path2D/PathFollow2D").set_offset(randi())#toma posicion en un pto aleatorio
	var elem = elemento.instance()#guardamos la referencia a nuestra escena enem6
	add_child(elem)#instanciamos la escena
	elem.position = get_node("Path2D/PathFollow2D").position
	#var myGroup = get_tree().get_nodes_in_group("elemento")
	#print(myGroup.size())
	
	var resBus = sprResultado.instance()#guardamos la referencia a nuestra escena enem6
	add_child(resBus)#instanciamos la escena
	var posComie = Vector2(-160,0)
	resBus.position=posComie
	
	salida_buscada(inicio)
	inicio = inicio+1
	$elementTimer.wait_time = 20#10+random(1,15)
	$elementTimer.start()
	




##con esas modificaciones deberia poder ver la forma de tener varios elementos
func _on_Area2D1_area_entered(area):
	if area.is_in_group("elemento"):
			#var myGroup = get_tree().get_nodes_in_group("elemento")[].get_index()
			#print("****")
			#print(myGroup)
			#	for i in range(miChild.size()):
			#	var child = miChild[i]
			#	var position = myGroup.get_child_index(child)
			#	print("El elemento en la posición", position, "es", child)
			
			#print(" pos area 1 ",posArea1)
			var posAmorfo = get_tree().get_nodes_in_group("elemento").size()
			print(posAmorfo," positioin ")
			get_tree().get_nodes_in_group("elemento")[posArea1].valAdquirido.caja1 = valorCaja.caja1
			get_tree().get_nodes_in_group("elemento")[posArea1].areaActual= 1
			#print(" *area 1* ",get_tree().get_nodes_in_group("elemento")[posArea1].valAdquirido.caja1)
			#print(get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1)
			valorCaja.caja1=0
			posArea1+=1
			$Button1.visible = false
			$Button2.visible = false
			$Button3.visible = false
		#print(get_tree().get_nodes_in_group("elemento")[con])
		#get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1 = 1
		#print(get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1)


func _on_Area2D2_area_entered(area):
	if area.is_in_group("elemento"):
		
			get_tree().get_nodes_in_group("elemento")[posArea2].valAdquirido.caja2 = valorCaja.caja2
			get_tree().get_nodes_in_group("elemento")[posArea2].areaActual= 2
			
			valorCaja.caja2=0
			posArea2+=1
			#print(get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1)
			$Button4.visible = false
			$Button5.visible = false
			$Button6.visible = false


func _on_Area2D3_area_entered(area):
	if area.is_in_group("elemento"):
			get_tree().get_nodes_in_group("elemento")[posArea3].valAdquirido.caja3 = valorCaja.caja3
			get_tree().get_nodes_in_group("elemento")[posArea3].areaActual= 3
			valorCaja.caja3=0
			posArea3+=1
			#print(get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1)
			$Button7.visible = false
			$Button8.visible = false
			$Button9.visible = false


func _on_InicioC1_area_entered(area):
	if area.is_in_group("elemento"):
		
		print("area 1",area.get_index())
		$Button1.visible = true
		$Button2.visible = true
		$Button3.visible = true


func _on_InicioC2_area_entered(area):
	if area.is_in_group("elemento"):
		print("area 2",area.get_index())
		$Button4.visible = true
		$Button5.visible = true
		$Button6.visible = true


func _on_InicioC3_area_entered(area):
	if area.is_in_group("elemento"):
		print("area 3",area.get_index())
		$Button7.visible = true
		$Button8.visible = true
		$Button9.visible = true



func _on_Button1_pressed():
	valorCaja.caja1 = 1


func _on_Button2_pressed():
	valorCaja.caja1 = 2


func _on_Button3_pressed():
	valorCaja.caja1 = 3


func _on_Button4_pressed():
	valorCaja.caja2 = 1


func _on_Button5_pressed():
	valorCaja.caja2 = 2


func _on_Button6_pressed():
	valorCaja.caja2 = 3


func _on_Button7_pressed():
	valorCaja.caja3 = 1


func _on_Button8_pressed():
	valorCaja.caja3 = 2


func _on_Button9_pressed():
	valorCaja.caja3 = 3




func _on_Area2D_area_entered(area):
	print(" *pretendido* ",get_tree().get_nodes_in_group("elemento")[validacion].valPretendido)
	
	print(" *adquiridoo* ",get_tree().get_nodes_in_group("elemento")[validacion].valAdquirido)
	validacion+=1
	if (get_tree().get_nodes_in_group("elemento")[validacion].valPretendido.caja1 == get_tree().get_nodes_in_group("elemento")[validacion].valAdquirido.caja1
	and get_tree().get_nodes_in_group("elemento")[validacion].valPretendido.caja2 == get_tree().get_nodes_in_group("elemento")[validacion].valAdquirido.caja2
	and get_tree().get_nodes_in_group("elemento")[validacion].valPretendido.caja3 == get_tree().get_nodes_in_group("elemento")[validacion].valAdquirido.caja3):
		score += 10
		print("coincide")
	else:
		score -= 10
		print("fallo")
	




