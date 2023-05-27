extends Area2D


var can_grab = false
var grabbed_offset = Vector2()
var currentBodyPart = []
var hasGrabbed=false
var clotheType
var tween

func _ready():
	connect("area_entered",self,"_area_entered")
	connect("area_exited",self,"_area_exited")
	connect("mouse_entered",self,"mouse_entered")
	connect("mouse_exited",self,"mouse_exited")
	StartTween()
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()
		
func mouse_entered():
	Selecting()
	pass

func mouse_exited():
	if(currentBodyPart.size()>0):
		StopTween()
	else:
		StartTween()
	pass
	
func _process(delta):
	if Input.is_action_pressed("game_select") and can_grab:
		position = get_global_mouse_position() + grabbed_offset
		hasGrabbed=true
		StopTween()
	if (Input.is_action_just_released("game_select") and hasGrabbed):
		can_grab = false
		#StartTween()

func _area_entered(other):
	currentBodyPart.append(other.get_groups()[0])
	pass


func _area_exited(area):
	currentBodyPart.erase(area.get_groups()[0])
	pass

func StartTween():
	if(tween!=null):
		tween.stop()
	tween = create_tween().set_loops()
	tween.tween_property(self,"scale",Vector2.ONE*0.6,0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"scale",Vector2.ONE,0.5).set_trans(Tween.TRANS_SINE)
	pass

func StopTween():
	tween.stop()
	tween = create_tween()
	tween.tween_property(self,"scale",Vector2.ONE,0)
	tween.tween_interval(1)
	pass

func Selecting():
	tween.stop()
	tween = create_tween()
	tween.tween_property(self,"scale",Vector2.ONE*1.5,0.2).set_trans(Tween.TRANS_SINE)
