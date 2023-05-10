extends Camera2D


var drag_cam : bool = false
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
