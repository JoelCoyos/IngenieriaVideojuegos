extends Area2D

var tween

func _ready():
	StartTween()
	pass 


func _on_Objective_area_entered(area):
	if(area.get_groups().size()>0 and area.get_groups()[0]=="Cone"):
		area.queue_free()
	pass

func StartTween():
	if(tween!=null):
		tween.stop()
	tween = create_tween().set_loops()
	tween.tween_property(self,"scale",Vector2.ONE*0.6,0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"scale",Vector2.ONE*1.2,0.5).set_trans(Tween.TRANS_SINE)
	pass
