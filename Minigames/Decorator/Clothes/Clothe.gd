extends Area2D


var can_grab = false
var grabbed_offset = Vector2()
var currentBodyPart = []
var hasGrabbed=false
var clotheType

func _ready():
	connect("area_entered",self,"_area_entered")
	connect("area_exited",self,"_area_exited")
	pass

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

func _area_entered(other):
	currentBodyPart.append(other.get_groups()[0])
	pass


func _area_exited(area):
	currentBodyPart.erase(area.get_groups()[0])
	pass

