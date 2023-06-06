extends Area2D
export (int) var estadoActual

var tween

signal change_state(state)

func _ready():
	asignarVal(estadoActual)
	StartTween()
	pass

func asignarVal(valor):
	estadoActual = valor
	if valor == 0 :
		$AnimatedSprite.play("animatUNO")
	elif valor == 1:
		$AnimatedSprite.play("animtaDOS")
	elif valor == 2:
		$AnimatedSprite.play("animtaTRES")

func _input_event(viewport, event, shape_idx):
	if(Input.is_action_just_pressed("game_select")):
		emit_signal("change_state",estadoActual)
	pass
	
func StartTween():
	if(tween!=null):
		tween.stop()
	tween = create_tween().set_loops()
	tween.tween_property($AnimatedSprite,"scale",Vector2.ONE*0.6,0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite,"scale",Vector2.ONE*1.2,0.5).set_trans(Tween.TRANS_SINE)
	pass
