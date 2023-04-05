extends Area2D

signal putClothe(clothe,bodyPart)

var can_grab = false
var grabbed_offset = Vector2()
var currentBodyPart
var hasGrabbed=false
var clothe

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()

func _process(delta):
	if Input.is_action_pressed("game_select") and can_grab:
		position = get_global_mouse_position() + grabbed_offset
		hasGrabbed=true
	if (Input.is_action_just_released("game_select") and hasGrabbed):
		can_grab = false
		emit_signal("putClothe",clothe,currentBodyPart)

func _on_shirt_area_entered(other):
	var node = other as Node2D
	currentBodyPart = node.get_groups()[0]
	pass # Replace with function body.
