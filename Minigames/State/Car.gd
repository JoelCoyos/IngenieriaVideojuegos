extends PathFollow2D

var t = 0
var on
var speed

signal getObjetive
signal crash

func _ready():
	on = false
	pass

func _process(delta):
	if(on):
		t+=delta
		offset = t*speed
	pass

func newPath():
	t=0
	pass


func _on_Area2D_area_entered(area):
	if(area.get_groups()[0]=="Objetive"):
		emit_signal("getObjetive")
	elif(area.get_groups()[0]=="Cone"):
		emit_signal("crash")
		
	area.queue_free()
	pass
