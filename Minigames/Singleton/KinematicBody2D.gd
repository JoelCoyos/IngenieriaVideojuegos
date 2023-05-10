extends KinematicBody2D


var press: bool = false

func _physics_process(delta):
	if press:
		mover_player()
	pass
func mover_player():
	self.global_position = get_global_mouse_position()
	pass



func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	#if event is InputEventScreenTouch:
	if Input.is_action_just_pressed("mover_personaje"):
		press = true
	if Input.is_action_just_released("mover_personaje"):
		press = false

