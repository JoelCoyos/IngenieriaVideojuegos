#tool
extends Node2D

export  (PackedScene ) var punto_trajectoria
export (int, 1,10) var impulso = 4

export (int, 5, 15) var cantidad_puntos_trajector = 5
export (float, 0.2 , 1, 0.1) var separacion = .5
export (int, 10 ,100) var impulso_trajectoria = 70
export (int, -90 , 90) var angulo_trajectoria = 45
export var trajectoria_visible : bool = true


var script_personaje = preload ("res://Minigames/Templete/daniable/personajes/personaje.gd")
var Personaje


func _ready():
	$trajectoria.position = $pos_salida.position


func _process(delta):
	for sp in $trajectoria.get_children():
		sp.queue_free()

	if Engine.is_editor_hint() && trajectoria_visible:
		dibujar_trajectoria_a_impulso(Vector2(impulso_trajectoria  * impulso, 0).rotated(deg2rad(-angulo_trajectoria)))#impulso_trajectoria  * impulso
	
	else:
		var impul = obtener_impulso()
		if  Personaje && Personaje.estado ==script_personaje.ESTADO_ARRASTRADO :#&& impul.x > 0:
			dibujar_trajectoria_a_impulso(impul)
	

func dibujar_trajectoria_a_impulso (impulso):
	var gravedad = ProjectSettings.get("physics/2d/default_gravity")
	
	for i in range(0,cantidad_puntos_trajector):
		var t = i * separacion
		var x = impulso.x * t
		var y = gravedad * t * t / 2 + impulso.y * t
		dibujar_puntos(Vector2(x,y))
		
func dibujar_puntos (lugar):
	var sp = punto_trajectoria.instance()
	sp.position = lugar
	$trajectoria.add_child(sp)
	
	
func tomar_personaje(personake):
	Personaje = personake

func soltar_personaje ():
	Personaje = null

func obtener_impulso ():
	if Personaje == null :
		return
	else:
		return ($pos_salida.global_position - Personaje.global_position)* impulso

func act ():
	var pos = Personaje.get_node("pos").get_global_position() if Personaje else $pos_salida.get_global_position()
	
	
func agregar_a (persona):#al mover el pj a la gomera
	self.person = persona
	
