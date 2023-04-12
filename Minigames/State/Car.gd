extends PathFollow2D

var t = 0
var on
var speed = 200

signal getObjetive

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
	emit_signal("getObjetive")
	area.queue_free()
	pass
