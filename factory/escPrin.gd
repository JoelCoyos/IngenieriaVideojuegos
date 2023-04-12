extends Node2D

export (PackedScene) var elemento
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var con = -1
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
#hacer un array de tipos valCaja
#guardarle valores aleatorios 
#mostrar en label 
#avanzar un contador para validar
#en caso de que no llegues a respondes setear las respuestas en 0
#en validacion, compara y suma
#ver number Attack para la dificultad


func salida_buscada():
	get_tree().get_nodes_in_group("elemento")[0].valPretendido.caja1 = 1
	get_tree().get_nodes_in_group("elemento")[0].valPretendido.caja2 = 2
	get_tree().get_nodes_in_group("elemento")[0].valPretendido.caja3 = 3
	#$HBoxContainer/Label2.text=str(get_tree().get_nodes_in_group("elemento")[con].valPretendido.caja1)
	
	

func _on_elementTimer_timeout():
	get_node("Path2D/PathFollow2D").set_offset(randi())#toma posicion en un pto aleatorio
	var elem = elemento.instance()#guardamos la referencia a nuestra escena enem6
	add_child(elem)#instanciamos la escena
	elem.position = get_node("Path2D/PathFollow2D").position
	salida_buscada()
	$elementTimer.wait_time = 30#10+random(1,15)
	$elementTimer.start()
	
	con = con+1


func random(min_number, max_number ):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)# 
	return random
	

func _on_Area2D1_area_entered(area):
	if area.is_in_group("elemento"):
		
			get_tree().get_nodes_in_group("elemento")[0].valAdquirido.caja1 = valorCaja.caja1
			#print(get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1)
			valorCaja.caja1=0
			$Button1.visible = false
			$Button2.visible = false
			$Button3.visible = false
		#print(get_tree().get_nodes_in_group("elemento")[con])
		#get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1 = 1
		#print(get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1)


func _on_Area2D2_area_entered(area):
	if area.is_in_group("elemento"):
		
			get_tree().get_nodes_in_group("elemento")[0].valAdquirido.caja2 = valorCaja.caja2
			valorCaja.caja2=0
			#print(get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1)
			$Button4.visible = false
			$Button5.visible = false
			$Button6.visible = false


func _on_Area2D3_area_entered(area):
	if area.is_in_group("elemento"):
			get_tree().get_nodes_in_group("elemento")[0].valAdquirido.caja3 = valorCaja.caja3
			valorCaja.caja3=0
			#print(get_tree().get_nodes_in_group("elemento")[con].valCaja.caja1)
			$Button7.visible = false
			$Button8.visible = false
			$Button9.visible = false


func _on_InicioC1_area_entered(area):
	if area.is_in_group("elemento"):
		$Button1.visible = true
		$Button2.visible = true
		$Button3.visible = true


func _on_InicioC2_area_entered(area):
	if area.is_in_group("elemento"):
		$Button4.visible = true
		$Button5.visible = true
		$Button6.visible = true


func _on_InicioC3_area_entered(area):
	if area.is_in_group("elemento"):
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
	var pos = 0
	if (get_tree().get_nodes_in_group("elemento")[pos].valPretendido.caja1 == get_tree().get_nodes_in_group("elemento")[pos].valAdquirido.caja1
	and get_tree().get_nodes_in_group("elemento")[pos].valPretendido.caja2 == get_tree().get_nodes_in_group("elemento")[pos].valAdquirido.caja2
		):
		score += 10
		print("coincide")
	else:
		score -= 10
		print("fallo")


