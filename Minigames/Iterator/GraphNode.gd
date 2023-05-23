extends Area2D
signal selectStartingNode(x)

var connection
var edge
var x
var y
var hasBeenSelected
var tween

func _ready():
	connection=null
	hasBeenSelected=false
	pass

func _input_event(viewport, event, shape_idx):
	if(Input.is_action_just_pressed("game_select") and y == 0 and !hasBeenSelected):
		emit_signal("selectStartingNode",x)
		hasBeenSelected=true
		if(y==0):
			$ArrowHead.queue_free()
			$AnimationPlayer.stop()

	pass
	
func AddNode():
	if(y!=0):
		$ArrowHead.queue_free()
	else:
		$AnimationPlayer.play("arrow")

func TweenScale():
	tween = create_tween().set_loops()
	tween.tween_property(self,"scale",Vector2.ONE,0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"scale",Vector2.ONE*0.4,0.5).set_trans(Tween.TRANS_SINE)
	pass

func StopTween():
	tween.stop()
	tween = create_tween()
	tween.tween_property(self,"scale",Vector2.ONE*0.5,0.5)
	tween.tween_interval(1)
	pass
