extends PathFollow2D

var t = 0
var on
var speed = 500

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
