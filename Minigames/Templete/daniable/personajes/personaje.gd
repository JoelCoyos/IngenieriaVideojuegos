extends "res://Minigames/Templete/script/daniable.gd"

var ptj = 100

export (int, 100 ,500) var vel_transferencia = 300
enum {
	ESTADO_QUIETO,
	ESTADO_TRANSFERIR,
	ESTADO_TOMADO,
	ESTADO_ARRASTRADO,
	ESTADO_RELEASED,
	ESTADO_LANZADO
}



# para el efecto que pase por detras de la gomera -> dividirla en 2 una parte queda atras el personaje por delante
#la segunda parte de la gomera por delante del personaje con el inspector->node2d->z index = 2 (parte delantera gomera)

#podria ser que no vuelva a la gomera y se pueda cambiar el estado en movimiento para darle dinamismo
#el grupo player en el nodo puede que estee d e mas
var estado = ESTADO_QUIETO
var impulso = null
var gomera = null

func _physics_process(delta):
	actPj()
	
func _integrate_forces(state):
	._integrate_forces(state)
	if state.get_contact_count() > 0 && estado == ESTADO_LANZADO:
		estado =ESTADO_QUIETO
	
	var vl = state.linear_velocity
	var va = state.angular_velocity
	var delta = 1 / state.step
	var pos_lanzado = gomera.get_node("pos_salida").get_global_position()
	var diff_pos = pos_lanzado - get_global_position()
	

	if Input.is_action_just_released("mover_personaje") && estado == ESTADO_ARRASTRADO:#estado concatenario (el if)
		impulso = gomera.obtener_impulso() #diff_pos * 0.06
		estado = ESTADO_RELEASED #if impulso.x > 0 else  ESTADO_TOMADO#para que solo se pueda apuntar en +x
		
	#if Input.is_action_just_released("touch") && estado == ESTADO_LANZADO:#estado concatenario (el if)
		#estado = ESTADO_TOMADO 
	
	
	match estado: #en ves de usar if
		ESTADO_TRANSFERIR:
			#print("transfer")
			if diff_pos.length() < vel_transferencia: #/delta:#evita el temblequeo al subir a la gomera
				vl = diff_pos * delta
				estado = ESTADO_TOMADO
				gomera.tomar_personaje(self)#referencia a gomeraTrayectori del personaj
			else:
				vl = diff_pos.normalized() * vel_transferencia * delta
		ESTADO_TOMADO:
			#print("tomado")
			vl = diff_pos *20#* delta * 0.3
			va = -rotation * delta
		ESTADO_ARRASTRADO:
			#print("arrastrado")
			var fuerza = get_global_mouse_position() - pos_lanzado
			fuerza = fuerza.clamped(100)#este en un radio fijo para no arrastra mas lejos de la gomera
			vl = (fuerza + diff_pos) *20# 0.03* delta
		ESTADO_RELEASED:
			#print("release")
			if diff_pos.length() < impulso.length() / delta:
				estado = ESTADO_LANZADO
				#gomera.soltar_personaje()
			else:
				vl = diff_pos.normalized() * impulso.length()# * delta
		ESTADO_LANZADO:
			#print("lanzado")
			pass
			
	state.linear_velocity = vl
	state.angular_velocity = va
	


func agregar_a (gomera):#al mover el pj a la gomera
	self.gomera = gomera
	estado = ESTADO_TRANSFERIR
	
	
func _input(event):
	if event.is_action_pressed("mover_personaje"):# && estado ==ESTADO_TOMADO :
		estado = ESTADO_ARRASTRADO
		

func actPj():	#ver si se puede usar el de daniable
	if codActual == 0:
		$camPJ.play("uno")
	elif codActual ==1:
		$camPJ.play("dos")
	else:
		$camPJ.play("tres")



func _on_Area2D_area_entered(area):
	if area.is_in_group("cambio"):
		codActual = area.get_index()
		
		print(codActual)
		
