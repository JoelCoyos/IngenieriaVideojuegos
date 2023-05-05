extends Camera2D

export var VELOCIDAD = 2

export (float , 0.5 ,5) var minimo_zoom = 1
export (float , 1 ,10) var maximo_zoom = 5#por aca y camara maximo/minimo zoom controlo que tanto permito ahcer zoom
export (int,1,10) var vel_zoom = 2

var drag_cam : bool
var ult_pos : Vector2



func _process(delta):
	
	var mouse_pos = get_local_mouse_position()
	
	if Input.is_action_just_pressed("mover_camara"):
		drag_cam = true
		ult_pos = mouse_pos
	
	if Input.is_action_just_released("mover_camara"):
		drag_cam = false
		
	if drag_cam:
		var posicion_raton = ult_pos - mouse_pos
		position= clamp_position(position + posicion_raton)
		ult_pos = mouse_pos

func clamp_position(pos : Vector2):
	var radio_viewport = get_viewport_rect().size / 2 *zoom #tamanio total pantalla /2 -> punto medio
	pos.x = clamp (pos.x, limit_left + radio_viewport.x, limit_right-radio_viewport.x)
	pos.y = clamp (pos.y, limit_top + radio_viewport.y, limit_bottom-radio_viewport.y)
	return pos

func _input(event):
	var z = zoom.x
	if event.is_action("zoom_in"):
		z -= 0.02 * vel_zoom
		
	if event.is_action("zoom_out"):
		z+= 0.02 * vel_zoom
		

	z = clamp (z,minimo_zoom,maximo_zoom) #para no poder acercarte mucho ni alejarte.
	zoom = Vector2(z,z)
