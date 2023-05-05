extends RigidBody2D

export (int , 1, 10000) var vida = 30 #podria ser el parametro de dificultad se generee entre rango como la posicion

var codActual =0

var velocidad_danio : Vector2
var velocidad_angular : float

func _integrate_forces(state):#lee y modifica el estado de simulacion del opvjeto
	var cantidad_contactos = {}
	for i in range (0,state.get_contact_count()):
		var id_contacto = state.get_contact_collider_id(i)
		if !cantidad_contactos.has(id_contacto):
			cantidad_contactos[id_contacto]=1
		else:
			cantidad_contactos[id_contacto] +=1
	
	for i in range(0, state.get_contact_count()):
		var contacto = state.get_contact_collider_object(i)
		var velocidad_contacto = state.get_contact_collider_velocity_at_position(i)
		var L = global_position - state.get_contact_local_position(i)
		var slef_velocity = velocidad_danio - velocidad_angular * Vector2(-L.y , L.x)
		var V = velocidad_contacto - slef_velocity
		var massa = self.mass
		var massa_cuerpo = contacto.mass if contacto is RigidBody2D else 1000000000#guardo la masa del cuerpo si el contacto que nos choco es un rigid body
		var P = V.dot(state.get_contact_local_normal(i)) * (massa_cuerpo / (massa + massa_cuerpo))  / cantidad_contactos[contacto.get_instance_id()] # devuelve el punto en que choco en un vector2
		recibir_danio(P*0.06)




func _physics_process(delta):
	velocidad_danio = linear_velocity
	velocidad_angular = angular_velocity
	act()
	
func act():
	if codActual == 0:
		$AnimatedSprite.play("uno")
	elif codActual ==1:
		$AnimatedSprite.play("dos")
	else:
		$AnimatedSprite.play("tres")
		
#func _on_daniable_body_entered(body):
#	recibir_danio(velocidad_danio.length())


func recibir_danio(canti : float):
	canti = round(canti)
	if canti > 0 :
		vida -= canti
		if vida <= 0:
			queue_free()


func _on_Area2D_area_entered(area):
		if area.is_in_group("player"):
			if codActual == get_tree().get_nodes_in_group("player")[0].codActual :
				print("iguales")
			else:
				print("distintod")





