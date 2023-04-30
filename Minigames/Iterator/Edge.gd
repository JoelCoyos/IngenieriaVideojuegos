extends Node2D

var t
var animation

func _ready():
	t = Timer.new()
	self.add_child(t)
	animation = $AnimationPlayer
	animation.playback_speed = 4;
	pass


func FillEdge(position):
	if(position == "down"):
		$AnimationPlayer.play("fillEdge")
	elif(position == "left"):
		$AnimationPlayer.play("fillEdge")
	elif(position == "right"):
		$AnimationPlayer.play("fillEdgeReverse")
	pass

